---
name: azure-devops-work-item-triage
description: |
  Analytical triage of Azure DevOps work items before handoff to a developer. Use when — (1) user writes `/azure-devops-work-item-triage ITEM-123` (single item), (2) user writes `/azure-devops-work-item-triage ITEM-1 ITEM-2 ITEM-3` (up to 5 items at once), (3) user says "triage this ADO item", "analyse Azure DevOps ticket", "assign work item to dev". Reads work item details, gathers context from linked items and wiki, writes an analytical comment, transitions state, and reassigns to a team member. Batch mode: analyses in parallel, shows combined summary, asks for assignment once. Do NOT use for items already In Progress.
---

# azure-devops-work-item-triage — Analytical triage of Azure DevOps work items

Role: Analyst / PO. Prepares work item(s) for developer handoff with scoped analysis and assignment.

---

## Step 0 — Check connection and config

### 0a. Check Azure DevOps access

Verify that `AZURE_DEVOPS_PAT` env var is set (available in `~/.claude/settings.local.json`). If missing:

```
Azure DevOps PAT is not configured. To use azure-devops-work-item-triage:

1. Generate a PAT at: https://dev.azure.com/{org}/_usersSettings/tokens
   Required scopes: Work Items (Read & Write), Project and Team (Read)
2. Add to ~/.claude/settings.local.json:
   { "env": { "AZURE_DEVOPS_PAT": "<your-pat>" } }
3. Restart Claude Code
4. Run /azure-devops-work-item-triage again
```

Stop — do not continue without PAT.

### 0b. Check config

Check for `~/.claude/skills/azure-devops-work-item-triage/config.json`.

- Exists and complete → use it.
- Missing or incomplete → run **Setup** below.

### Setup (first use or `/azure-devops-work-item-triage setup`)

1. Ask in one message:
   ```
   I need to configure Azure DevOps connection.

   1. Organization URL (e.g. https://dev.azure.com/myorg):
   2. Project name (e.g. "Salesforce System"):
   3. What is the state name when a developer starts working?
      (e.g. "Active", "In Progress", "Committed")
   4. What is the state name for items waiting to be assigned / queued?
      (e.g. "New", "Approved", "Ready")
      Type "none" if not applicable.
   5. Provide a sample work item ID to verify connection (e.g. 1234):
   ```
2. Test connection via REST API: `GET {orgUrl}/{project}/_apis/wit/workitems/{id}?api-version=7.1`
   Auth header: `Authorization: Basic base64(:<PAT>)`
3. If successful, save to `~/.claude/skills/azure-devops-work-item-triage/config.json`:
   ```json
   {
     "orgUrl": "<url>",
     "project": "<project>",
     "apiVersion": "7.1",
     "states": {
       "active": "<name>",
       "waiting": "<name or null>"
     }
   }
   ```
4. Confirm: "Config saved. You can now use `/azure-devops-work-item-triage 1234`."

---

## Single vs. batch mode

- **Single item** (`/azure-devops-work-item-triage 1234`) → run full sequence (steps 1–6) for that item.
- **Multiple items** (`/azure-devops-work-item-triage 1234 1235 1236`) → run **steps 1–4 in parallel** for each item, then **step 5 combined** (one summary table + one assignment question for all).

Max 5 items at once. If more provided, inform and take the first 5.

---

## Step 1 — Read work item

Call:
```
GET {orgUrl}/{project}/_apis/wit/workitems/{id}?$expand=all&api-version=7.1
```

Extract:
- `System.Title`, `System.Description`, `System.WorkItemType`
- `System.State`, `System.AssignedTo`, `System.CreatedBy`
- `System.Tags`, `System.AreaPath`, `System.IterationPath`
- `System.Parent`, `System.TeamProject`
- `Microsoft.VSTS.Common.Priority`, `Microsoft.VSTS.Common.AcceptanceCriteria`
- `Microsoft.VSTS.Scheduling.StoryPoints` (if present)
- Relations: linked work items, PRs, commits, attachments

---

## Step 2 — Gather context (parallel per item)

#### 2a. Linked work items

For each relation of type `System.LinkTypes.Hierarchy-Reverse` (parent) or `System.LinkTypes.Hierarchy-Forward` (children):
```
GET {orgUrl}/{project}/_apis/wit/workitems/{linkedId}?api-version=7.1
```
Extract title + state for context.

#### 2b. ADO Wiki (optional)

Search ADO Wiki for keywords from item title/description:
```
GET {orgUrl}/{project}/_apis/wiki/wikis?api-version=7.1
```
If wiki exists:
```
GET {orgUrl}/{project}/_apis/wiki/wikis/{wikiId}/pages?path=/&recursionLevel=Full&api-version=7.1
```
Match page titles against keywords. Read up to 2 most relevant pages.

#### 2c. Local repository (optional)

If a local codebase is available: grep for class/component/service names mentioned in the work item description. If not available — skip silently.

#### 2d. Recent commits / PRs (optional)

```
GET {orgUrl}/{project}/_apis/git/pullrequests?searchCriteria.status=completed&$top=5&api-version=7.1
```
Filter for PRs mentioning the work item ID in title or description.

---

## Step 3 — Write analytical comment in ADO

Call:
```
POST {orgUrl}/{project}/_apis/wit/workitems/{id}/comments?api-version=7.1-preview.3
Content-Type: application/json
Body: { "text": "<html-comment>" }
```

Comment format (HTML-safe):
```html
<b>Pre-analysis</b>

<b>Business context</b>
[1-3 sentences — what the user/team wants to achieve]

<b>Affected areas</b>
<ul>
<li>[Area 1]: [relevant files/classes/modules found]</li>
<li>[Area 2]: [if applicable]</li>
<li>Wiki: [links to relevant pages found]</li>
</ul>

<b>Implementation scope</b>
[Concrete action items for the developer]

<b>Complexity estimate:</b> Simple / Medium / Complex
[1 sentence justification]

<b>Open questions / risks</b>
[Only if something requires a decision before dev starts]
```

No confirmation needed — add comment directly.

---

## Step 4 — Transition to waiting state

If `config.states.waiting` is not null:

```
PATCH {orgUrl}/{project}/_apis/wit/workitems/{id}?api-version=7.1
Content-Type: application/json-patch+json
Body: [{ "op": "add", "path": "/fields/System.State", "value": "<waitingState>" }]
```

If null or transition fails — skip this step.

---

## Step 5 — Assignment

### Single mode

Ask: **"Who should this be assigned to? (provide name, email, or ADO display name)"**

Take the answer → resolve identity:
```
GET {orgUrl}/_apis/identities?searchFilter=General&filterValue={name}&api-version=7.1-preview.1
```
→ update work item:
```
PATCH {orgUrl}/{project}/_apis/wit/workitems/{id}?api-version=7.1
Body: [
  { "op": "add", "path": "/fields/System.AssignedTo", "value": "<uniqueName>" },
  { "op": "add", "path": "/fields/System.State",     "value": "<activeState>" }
]
```

### Batch mode — combined summary

After all analyses (steps 1–4) show a table:

```
Triage complete.

| Item   | Title (short)                    | Type | Complexity | Notes                   |
|--------|----------------------------------|------|------------|-------------------------|
| #1234  | ...                              | Bug  | Simple     | Single service          |
| #1235  | ...                              | Story| Complex    | Multiple components     |
| #1236  | ...                              | Task | Medium     | Config change           |

Who should each item be assigned to?
(e.g. "#1234 → alice@company.com, #1235 → bob.smith, #1236 → alice")
```

After response: for each item → resolve identity → update AssignedTo + State — all **in parallel**.

---

## Step 6 — Confirm

```
✅ Triage complete

#1234 → Alice Smith (Active)
#1235 → Bob Smith (Active)
#1236 → Alice Smith (Active)
```

Include direct ADO links:
```
{orgUrl}/{project}/_workitems/edit/{id}
```

---

## Error handling

- Work item not found → check project name in config; suggest `/azure-devops-work-item-triage setup`.
- Identity resolve returns no results → ask for exact ADO email/UPN.
- State transition rejected (invalid transition) → log warning, skip state change, continue to assignment.
- Wiki unavailable → skip section, continue.
- PAT expired or 401 → prompt to regenerate PAT and update `settings.local.json`.
- Config corrupted → re-run setup.
