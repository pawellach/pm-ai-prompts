# azure-devops-work-item-triage — Analytical triage of Azure DevOps work items

Prepares ADO work items for developer handoff. Reads the item, searches linked items and wiki for context, writes an analytical comment with implementation scope, and reassigns to the right person.

## What it does

1. Reads the work item (description, acceptance criteria, linked items, area/iteration path)
2. Searches ADO Wiki and linked work items for related context
3. Writes an analytical comment — business context, affected areas, concrete implementation scope, complexity estimate
4. Transitions item to a "waiting" state (configurable)
5. Asks who to assign to → reassigns and moves to Active

## Batch mode

Triage multiple items in one command:

```
/azure-devops-work-item-triage 1234 1235 1236
```

Analyses run in parallel (max 5). Afterwards shows a combined summary table and asks for assignment once for all items.

## Installation

**Step 1** — Copy the `azure-devops-work-item-triage` folder to your Claude Code skills directory:
- macOS/Linux: `~/.claude/skills/azure-devops-work-item-triage/`
- Windows: `C:\Users\<you>\.claude\skills\azure-devops-work-item-triage\`

**Step 2** — Add your Azure DevOps PAT to `~/.claude/settings.local.json`:
```json
{
  "env": {
    "AZURE_DEVOPS_PAT": "<your-personal-access-token>"
  }
}
```
Required PAT scopes: **Work Items (Read & Write)**, **Project and Team (Read)**

**Step 3** — Run it:
```
/azure-devops-work-item-triage 1234
```

On first use the skill asks for your organization URL, project name, and state names. Config is saved and reused automatically.

## Requirements

- Claude Code
- Azure DevOps Personal Access Token (PAT) with Work Items Read & Write
- Project membership with permission to comment and transition work items
