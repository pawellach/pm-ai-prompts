# jira-intake — Analytical ticket intake skill for Claude Code

Prepares Jira tickets for developer handoff. Reads the ticket, searches Confluence for context, writes an analytical comment with implementation scope, and reassigns the ticket to the right person.

## What it does

1. Reads the Jira ticket (description, comments, priority)
2. Searches Confluence for related documentation
3. Writes an analytical comment — business context, affected areas, concrete implementation scope, complexity estimate
4. Transitions ticket to a "Waiting" status (configurable)
5. Asks who to assign to → reassigns and moves to In Progress

## Batch mode

Analyse multiple tickets in one command:

```
/jira-intake PROJ-1 PROJ-2 PROJ-3
```

Analyses run in parallel (max 5). Afterwards shows a combined summary table and asks for assignment once for all tickets.

## Installation

**Step 1** — Copy the `jira-intake` folder to your Claude Code skills directory:
- macOS/Linux: `~/.claude/skills/jira-intake/`
- Windows: `C:\Users\<you>\.claude\skills\jira-intake\`

**Step 2** — Enable the Atlassian plugin in Claude Code:
1. Claude Code → Settings → Plugins → enable **Atlassian**
2. Sign in with your Atlassian account
3. Restart Claude Code

**Step 3** — Run it:
```
/jira-intake PROJ-123
```

On first use the skill auto-detects your Jira instance and asks for your status names (In Progress, Waiting) in a single message. Config is saved and reused automatically.

## Requirements

- Claude Code
- Atlassian plugin (official, free)
- Jira account with permission to comment and transition tickets
