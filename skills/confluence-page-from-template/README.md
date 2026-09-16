# confluence-page-from-template — Create Confluence pages from templates

Generates structured Confluence pages from pre-defined templates with AI-filled content. Select a template, provide inputs, and the skill creates a ready-to-use page in your Confluence space.

## What it does

1. Lists available templates (Meeting Notes, Project Kickoff, Feature Spec, ADR, Retrospective, Onboarding Guide, Incident Report)
2. Collects required inputs for the selected template in a single message
3. Generates full page content using AI — fills in structure, suggests agenda items, generates acceptance criteria, etc.
4. Shows a preview and asks for confirmation
5. Publishes the page directly to Confluence

## Available templates

| Template | Use case |
|----------|----------|
| Meeting Notes | Agenda, attendees, action items |
| Project Kickoff | Goals, scope, stakeholders, timeline |
| Feature Specification | Problem, solution, requirements, AC |
| Architecture Decision Record (ADR) | Context, decision, consequences |
| Retrospective | What went well, delta, actions |
| Onboarding Guide | Role overview, tools, key contacts |
| Incident Report | Timeline, impact, root cause, remediation |

## Usage

```
/confluence-page-from-template
```

The skill will ask which template to use and collect the inputs in an interactive flow.

## Installation

**Step 1** — Copy the `confluence-page-from-template` folder to your Claude Code skills directory:
- macOS/Linux: `~/.claude/skills/confluence-page-from-template/`
- Windows: `C:\Users\<you>\.claude\skills\confluence-page-from-template\`

**Step 2** — Enable the Atlassian plugin in Claude Code:
1. Claude Code → Settings → Plugins → enable **Atlassian**
2. Sign in with your Atlassian account
3. Restart Claude Code

**Step 3** — Run it:
```
/confluence-page-from-template
```

On first use the skill asks for your default Confluence space key and parent page. Config is saved and reused automatically.

## Requirements

- Claude Code
- Atlassian plugin (official, free)
- Confluence account with permission to create pages in the target space
