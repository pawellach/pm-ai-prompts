# jira-sync

Auto-manages Jira ticket status and writes comments as you move through your dev cycle. Self-configuring — no manual setup of IDs or tokens.

| Command | Action |
|---|---|
| `/jira-sync start PROJ-123` | → In Progress (no comment) |
| `/jira-sync testing PROJ-123` | → In Test (no comment) |
| `/jira-sync done PROJ-123` | Technical comment + plain-language comment → Done |
| `/jira-sync reopen PROJ-123` | → In Progress (optional comment) |

## Install

1. Copy `jira-sync/` folder to `~/.claude/skills/jira-sync/`
2. Enable **Atlassian plugin** in Claude Code (Settings → Plugins → Atlassian, sign in)
3. Run `/jira-sync start PROJ-123` — setup wizard auto-detects your Jira instance and status names

## Requirements

- Claude Code
- Atlassian plugin (official, free)
- Jira account with permission to transition tickets and comment
