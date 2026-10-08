---
name: jira-intake
description: |
  Analytical ticket intake before handing off to a developer. Use when — (1) user writes `/jira-intake PROJ-123` (single ticket), (2) user writes `/jira-intake PROJ-1 PROJ-2 PROJ-3` (up to 5 tickets at once), (3) user says "analyse this ticket", "do intake for PROJ-123", "assign ticket to dev", (4) user writes `/jira-intake stats` (registry summary). Gathers context from Jira and Confluence, writes an analytical comment with implementation scope, transitions to Waiting, and reassigns to chosen person. Batch mode: analyses in parallel, shows a combined summary, asks for assignment once for all. Do NOT use for tickets where a dev is already working (status In Progress).
---

# jira-intake — Analytical ticket intake (v2)

Role: Analyst / PO. Prepares ticket(s) for handoff to a developer.

---

## Step 0 — Check MCP, config, and state

### 0a. Check Atlassian MCP

Call `getAccessibleAtlassianResources`. If unavailable:

```
Atlassian MCP plugin is not active. To use jira-intake:

1. Open Claude Code → Settings (⚙) → Plugins
2. Enable: "Atlassian" (official plugin)
3. Sign in with your Atlassian account
4. Restart Claude Code
5. Run /jira-intake again
```

Stop — do not continue without MCP.

### 0b. Check config

Check for `~/.claude/skills/jira-intake/config.json`.

- Exists and complete → use it.
- Missing or incomplete → run **Setup** below.

### Setup (first use or `/jira-intake setup`)

1. `getAccessibleAtlassianResources` → if one instance, use its `url` as `cloudId`; if multiple, ask which to use.
2. Ask in one message:
   ```
   I need to know your Jira status names and a sample ticket number.

   What is the status name when:
   1. A developer starts working? (e.g. "In Progress", "In Development")
   2. A ticket is waiting to be assigned / queued? (e.g. "Waiting", "Ready for Dev", "Backlog")
      Type "none" if you don't have this status.
   3. Please also provide a sample ticket number (e.g. PROJ-123)
   ```
3. Call `getTransitionsForJiraIssue(cloudId, sampleTicket)` → match status names to transition IDs.
4. Save to `~/.claude/skills/jira-intake/config.json`:
   ```json
   {
     "cloudId": "<url>",
     "statuses": { "inProgress": "<name>", "waiting": "<name or null>" },
     "transitions": { "inProgress": "<id>", "waiting": "<id or null>" }
   }
   ```
5. Confirm: "Config saved. You can now use `/jira-intake PROJ-123`."

### 0c. Load state (registry + history)

Before every intake run (except `stats`):

1. **Registry** — read `~/.claude/skills/jira-intake/registry.json` if it exists. Parse into memory as `$registry`. If missing, treat as `{ "version": 1, "tickets": {} }`.

2. **History check** — for each ticket being processed, check if `~/.claude/skills/jira-intake/history/<TICKET>.md` exists. If yes, read it → attach as extra context in step 2 with header:
   ```
   [Re-run] Previous analysis from <date>: <summary from history file>
   ```

3. **Workload snapshot** — from registry, compute for each developer: count of tickets where `status != "Done"` and `lastRun` within last 7 days. Store as `$workload[name] = N`.

---

## Stats mode (`/jira-intake stats`)

If invoked as `/jira-intake stats`:

1. Read `~/.claude/skills/jira-intake/registry.json`.
2. If missing or empty → "No intake history yet. Run `/jira-intake PROJ-123` to start."
3. Otherwise, generate report:

```
📊 jira-intake registry stats

Total tickets processed: N
Last run: YYYY-MM-DD

Complexity breakdown:
  Simple:  N (XX%)
  Medium:  N (XX%)
  Complex: N (XX%)

Top assignees:
  1. Name — N tickets
  2. Name — N tickets
  3. Name — N tickets

Top epics:
  1. EPIC-XX — N tickets
  2. EPIC-XX — N tickets
  3. EPIC-XX — N tickets

Active (not Done, last 7 days): N tickets
```

Stop after showing report — do not continue to intake.

---

## Single vs. batch mode

- **Single ticket** (`/jira-intake PROJ-123`) → run full sequence (steps 1–6) for that ticket.
- **Multiple tickets** (`/jira-intake PROJ-1 PROJ-2 ...`) → run **steps 1–4 in parallel** for each ticket, then **step 5 combined** (one summary table + one assignment question for all).

Max 5 tickets at once. If more provided, inform and take the first 5.

---

## Step 1 — Read ticket

`getJiraIssue(fields: ["summary", "description", "comment", "reporter", "assignee", "issuetype", "priority", "status", "labels", "components"])` with `responseContentFormat: "markdown"`.

---

## Step 2 — Gather context (parallel per ticket)

#### 2a. History context

If history file found in step 0c → prepend to analysis:
```
[Re-run: poprzednia analiza z <date>]
Assignee: <name> | Complexity: <X> | Summary: <1-line>
```

#### 2b. Cross-ticket intelligence

Check `$registry.tickets` for other open tickets (status != "Done") that share:
- **Same epic** as the current ticket
- **Same assignee** (if already assigned)
- **Same component keywords** (match 2+ words from title/description)

If any found → add to comment (step 3):
```
**Kontekst: powiązane otwarte**
- PROJ-X: <title> (assignee: <name>, complexity: <X>)
```

#### 2c. Confluence

Extract keywords from ticket description. `searchConfluenceUsingCql`:
`text ~ "keywords"` — top 3 results.

For relevant results: `getConfluencePage` → extract relevant sections.

#### 2d. Local repository (optional)

If a local codebase is available: grep for class/object names mentioned in the ticket.
If not available — skip silently.

#### 2e. Other tools (optional)

Use any available MCP tools (database schema lookups, API docs, etc.) if relevant to the ticket domain.

---

## Step 3 — Write analytical comment in Jira

`addCommentToJiraIssue` — no confirmation needed.

```
**Pre-analysis**

**Business context**
[1-3 sentences — what the user wants to achieve]

**Affected areas**
- [Area 1]: [relevant files/classes/modules found]
- [Area 2]: [if applicable]
- Confluence: [links to relevant pages]

**Implementation scope**
[Concrete action items for the developer]

**Complexity estimate:** Simple / Medium / Complex
[1 sentence justification]

**Open questions / risks**
[Only if something requires a decision before dev starts]

[If cross-ticket context found:]
**Kontekst: powiązane otwarte**
- PROJ-X: <title> (assignee: <name>)
```

If complexity = **Complex**, append at the end of the comment:

```
💡 Ten ticket ma złożoność Complex. Chcesz pełną analizę wymagań?
Uruchom: /requirements-analyst <TICKET>
```

---

## Step 4 — Transition to Waiting

If `config.transitions.waiting` is set:
`transitionJiraIssue(cloudId, ticket, transition: { id: config.transitions.waiting })`

If null — skip this step.

---

## Step 5 — Assignment

### Workload warning

Before showing assignment options, check `$workload`:
- For each candidate assignee with `$workload[name] > 3` → annotate in the table:
  `⚠️ <name>: N otwartych`

### Single mode

Ask: **"Who should this be assigned to? (provide name or email)"**

Show workload warning inline if applicable.

Take the answer → `lookupJiraAccountId` by email or name → `editJiraIssue` (assignee) → `transitionJiraIssue(config.transitions.inProgress)`.

### Batch mode — combined summary

After all analyses (steps 1–4) show a table:

```
Analysis complete.

| Ticket   | Title (short)           | Complexity | Notes                        |
|----------|-------------------------|------------|------------------------------|
| PROJ-1   | ...                     | Simple     | UI change                    |
| PROJ-2   | ...                     | Complex    | Multiple service layers      |
| PROJ-3   | ...                     | Medium     | API integration              |

Workload (last 7 days, open tickets):
  Damian: 2 | Bartek: 1 | Marcin: 4 ⚠️

Who should each ticket be assigned to?
(e.g. "PROJ-1 → alice@company.com, PROJ-2 → bob, PROJ-3 → alice")
```

After response: for each ticket → `lookupJiraAccountId` → `editJiraIssue` → `transitionJiraIssue(inProgress)` — all **in parallel**.

---

## Step 6 — Update state (registry + history)

After assignment is confirmed:

### 6a. Update registry

Read current `~/.claude/skills/jira-intake/registry.json` (or start fresh).
Add/update entry for each processed ticket:

```json
{
  "SAL-XXXX": {
    "lastRun": "YYYY-MM-DD",
    "assignee": "<name>",
    "complexity": "Medium",
    "epic": "<epic key or null>",
    "status": "In Progress"
  }
}
```

Write back to `~/.claude/skills/jira-intake/registry.json`.

### 6b. Write history file

Write `~/.claude/skills/jira-intake/history/<TICKET>.md`:

```markdown
# <TICKET>
**Date:** YYYY-MM-DD
**Assignee:** <name>
**Complexity:** Simple / Medium / Complex
**Summary:** <1-sentence summary of what was analysed>
**Analysis:**
<full text of the Jira comment written in step 3>
```

If the file already exists, **append** a new dated section (don't overwrite):

```markdown
---

## Re-run: YYYY-MM-DD
**Assignee:** <name>
**Complexity:** <X>
**Summary:** <summary>
**Analysis:**
<full comment text>
```

---

## Step 7 — Confirm

```
✅ Intake complete

PROJ-1 → Alice Smith (In Progress)
PROJ-2 → Bob Jones (In Progress)
PROJ-3 → Alice Smith (In Progress)

Registry updated. History saved for: PROJ-1, PROJ-2, PROJ-3
```

---

## Error handling

- Confluence / repo unavailable → skip that section, continue.
- `lookupJiraAccountId` returns no results → ask for exact email.
- Transition fails → log error, continue to reassignment.
- Config corrupted → re-run setup.
- Registry write fails → log warning, continue (don't block intake).
- History dir missing → create `~/.claude/skills/jira-intake/history/` before writing.
