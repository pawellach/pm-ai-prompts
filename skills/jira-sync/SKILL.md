---
name: jira-sync
description: |
  Synchronizes Jira ticket status with your development cycle. Use when — (1) user writes `/jira-sync start PROJ-123` (start task → In Progress), (2) user writes `/jira-sync testing PROJ-123` (deployed to test env → In Test), (3) user writes `/jira-sync done PROJ-123` (merge → Done + 2 comments), (4) user writes `/jira-sync reopen PROJ-123` (bug found → back to In Progress), (5) user writes `/jira-sync setup` (first-time or re-configuration). Acts autonomously — no confirmation prompts.
---

# jira-sync — Jira lifecycle manager

Manages Jira ticket status throughout the development cycle.
Operates autonomously — self-configuring on first use.

---

## Step 0 — Check MCP and config (ALWAYS FIRST)

### 0a. Check Atlassian MCP

Call `getAccessibleAtlassianResources`. If the tool does not exist or returns an error:

```
Atlassian MCP plugin is not active. To enable jira-sync:

1. Open Claude Code → Settings (⚙) → Plugins
2. Enable: "Atlassian" (official plugin)
3. Sign in with your Atlassian account
4. Restart Claude Code
5. Run `/jira-sync setup`
```

Stop — do not continue without MCP.

### 0b. Check config

Check whether `~/.claude/skills/jira-sync/config.json` exists (Windows: `C:\Users\<user>\.claude\skills\jira-sync\config.json`).

- Exists and complete → use it, proceed to mode.
- Missing or incomplete → run **Setup Wizard**.

---

## Setup Wizard

Runs automatically on first call or via `/jira-sync setup`.

### Step 1 — Cloud ID

Call `getAccessibleAtlassianResources`.

- **One instance** → use its `url` as cloudId, inform user.
- **Multiple instances** → ask: "You have access to several Jira instances: [list]. Which one to use?" Wait for answer.

### Step 2 — Status names

Ask the user in **one message**:

```
jira-sync will configure itself automatically. I just need the status names in your project.

What is the status called when you:
1. Start working on a task? (e.g. "In Progress", "W toku", "In Development")
2. Deploy to test environment? (e.g. "In Test", "Testing", "Ready for QA")
   Type "none" if you don't have this status.
3. Task is complete? (e.g. "Done", "Gotowe", "Closed")

Also provide an example ticket number (e.g. PROJ-123) from your project.
```

Wait for answer.

### Step 3 — Auto-detect Transition IDs

Using the provided ticket, call `getTransitionsForJiraIssue(cloudId, ticket)`.

For each provided status name: find the transition in the returned list where `to.name` matches (case-insensitive, trimmed). Save its `id`.

If a name doesn't match any transition — show available transitions and ask which one corresponds.

### Step 4 — Save config

Save to `~/.claude/skills/jira-sync/config.json`:

```json
{
  "cloudId": "<detected url>",
  "statuses": {
    "start": "<user-provided name>",
    "testing": "<user-provided name or null>",
    "done": "<user-provided name>"
  },
  "transitions": {
    "start": "<id>",
    "testing": "<id or null>",
    "done": "<id>",
    "reopen": "<id — same as start>"
  }
}
```

Confirm: "Configuration saved. jira-sync is ready — use `/jira-sync start|testing|done|reopen`."

| Mode | Transition name | ID |
|---|---|---|
| `start` | In Progress (or local equivalent) | (detected by setup wizard) |
| `testing` | In Test (or local equivalent, optional) | (detected by setup wizard) |
| `done` | Done (or local equivalent) | (detected by setup wizard) |
| `reopen` | In Progress | (same as start) |

---

## Modes

Before each mode: load config from `config.json`. Use `cloudId` and `transitions` from file.

### `/jira-sync start PROJ-123`

1. `getJiraIssue(fields: ["status"])` — check current status
2. If status ≠ `statuses.start`: `transitionJiraIssue(transitions.start)`
3. **No comment.**

---

### `/jira-sync testing PROJ-123`

1. `getJiraIssue(fields: ["status"])`
2. If `transitions.testing` is null → skip (no test status configured)
3. If status ≠ `statuses.testing`: `transitionJiraIssue(transitions.testing)`
4. **No comment.**

---

### `/jira-sync done PROJ-123`

Write **two comments**, then change status.

#### Gather context

- `getJiraIssue(fields: ["summary", "reporter", "issuetype"])` — title, reporter
- `git log origin/main..HEAD --oneline` — commits on branch (if available)
- `git diff origin/main --stat` — changed files grouped by type (if available)

#### Comment 1 — technical

For developers / testers. May include class names, file paths, technical details.

Structure:
```
**Scope of changes**
[list of changed files/classes/objects, grouped by type]

**Tests**
[which test classes ran, result, coverage if known]

**Branch:** `<branch-name>`
```

UAT request directed to the person leading the topic, NOT to the ticket reporter.

#### Comment 2 — plain language

Mention `@reporter` + describe what the user will actually see / gain.

**Forbidden:**
- ticket number in body text
- class names, field names, technical file paths
- asking the reporter to test

Example:
> @Jane Smith this change will be deployed in the next release. After deployment [what specifically will change].

#### Transition

`transitionJiraIssue(transitions.done)` → Done

---

### `/jira-sync reopen PROJ-123 [reason]`

1. `transitionJiraIssue(transitions.reopen)` → In Progress
2. If reason provided: `addCommentToJiraIssue` with reason text.

---

## Integration with other skills

You can call jira-sync as a sub-step from other skills:
- On branch creation (start)
- After successful deploy to test environment (testing)
- After git push / task completion (done)

---

## Error handling

- Transition fails (workflow restriction): log error, **continue** remaining steps.
- Status already at target: skip transition, still add comments if planned.
- Config missing / corrupt: re-run Setup Wizard.
