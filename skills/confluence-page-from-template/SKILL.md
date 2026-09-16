---
name: confluence-page-from-template
description: |
  Creates a Confluence page based on a selected template. Use when — (1) user writes `/confluence-page-from-template` (interactive mode), (2) user says "create Confluence page", "utwórz stronę w Confluence", "stwórz dokumentację w Confluence". The skill lists available templates, collects required input, generates page content using AI, and publishes to Confluence. Supports custom templates stored in config. Do NOT use for editing existing pages.
---

# confluence-page-from-template — Create Confluence page from template

Role: BA / PM / Tech Writer. Generates structured documentation pages in Confluence from predefined templates.

---

## Step 0 — Check MCP and config

### 0a. Check Atlassian MCP

Call `getAccessibleAtlassianResources`. If unavailable:

```
Atlassian MCP plugin is not active. To use confluence-page-from-template:

1. Open Claude Code → Settings (⚙) → Plugins
2. Enable: "Atlassian" (official plugin)
3. Sign in with your Atlassian account
4. Restart Claude Code
5. Run /confluence-page-from-template again
```

Stop — do not continue without MCP.

### 0b. Check config

Check for `~/.claude/skills/confluence-page-from-template/config.json`.

- Exists and complete → use it.
- Missing or incomplete → run **Setup** below.

### Setup (first use or `/confluence-page-from-template setup`)

1. `getAccessibleAtlassianResources` → if one instance, use its `url` as `cloudId`; if multiple, ask which to use.
2. Ask in one message:
   ```
   I need to configure Confluence defaults.

   1. What is the default Confluence space key where new pages should be created?
      (e.g. "TEAM", "PROJ", "DOC")
   2. What is the parent page title or ID for new pages?
      (e.g. "Documentation", "Team Home", or leave blank for space root)
   ```
3. Save to `~/.claude/skills/confluence-page-from-template/config.json`:
   ```json
   {
     "cloudId": "<url>",
     "defaultSpaceKey": "<key>",
     "defaultParentTitle": "<title or null>",
     "customTemplates": []
   }
   ```
4. Confirm: "Config saved. You can now use `/confluence-page-from-template`."

---

## Built-in templates

| ID | Name | Purpose |
|----|------|---------|
| `meeting-notes` | Meeting Notes | Structured meeting agenda + action items |
| `project-kickoff` | Project Kickoff | Goals, scope, stakeholders, timeline |
| `feature-spec` | Feature Specification | Problem, solution, requirements, acceptance criteria |
| `adr` | Architecture Decision Record | Context, decision, consequences |
| `retrospective` | Retrospective | What went well, delta, actions |
| `onboarding` | Onboarding Guide | Role overview, tools, first steps |
| `incident-report` | Incident Report | Timeline, impact, root cause, remediation |

---

## Step 1 — Select template

Show template list and ask:

```
Which template would you like to use?

Built-in:
1. Meeting Notes
2. Project Kickoff
3. Feature Specification
4. Architecture Decision Record (ADR)
5. Retrospective
6. Onboarding Guide
7. Incident Report

[custom templates from config, if any]

Type the number or name:
```

---

## Step 2 — Collect inputs

Based on selected template, ask for required fields in one message.

### meeting-notes inputs
```
Meeting Notes — please provide:
1. Meeting title:
2. Date (YYYY-MM-DD) [default: today]:
3. Attendees (names or emails, comma-separated):
4. Agenda items (one per line):
5. Space key [default: from config]:
6. Parent page title [default: from config]:
```

### project-kickoff inputs
```
Project Kickoff — please provide:
1. Project name:
2. Problem statement (1-3 sentences):
3. Key stakeholders (names and roles):
4. Target delivery date:
5. Space key [default: from config]:
6. Parent page title [default: from config]:
```

### feature-spec inputs
```
Feature Specification — please provide:
1. Feature name:
2. Problem to solve (1-3 sentences):
3. Target users:
4. Key requirements (bullet list or free text):
5. Linked Jira ticket(s) [optional]:
6. Space key [default: from config]:
7. Parent page title [default: from config]:
```

### adr inputs
```
Architecture Decision Record — please provide:
1. Decision title (short):
2. Context (what situation triggered this decision):
3. Decision made:
4. Alternatives considered [optional]:
5. Space key [default: from config]:
6. Parent page title [default: from config]:
```

### retrospective inputs
```
Retrospective — please provide:
1. Sprint / iteration name:
2. Date or period:
3. Team name:
4. Space key [default: from config]:
5. Parent page title [default: from config]:
```

### onboarding inputs
```
Onboarding Guide — please provide:
1. Role title:
2. Team / department:
3. Key tools and systems (comma-separated):
4. Key contacts (names and roles):
5. Space key [default: from config]:
6. Parent page title [default: from config]:
```

### incident-report inputs
```
Incident Report — please provide:
1. Incident title:
2. Date and time of incident:
3. Affected systems / services:
4. Impact summary (1-3 sentences):
5. Space key [default: from config]:
6. Parent page title [default: from config]:
```

---

## Step 3 — Generate page content

Using the collected inputs, generate full Confluence page content in Confluence Storage Format (HTML/XHTML subset) or structured Markdown. Apply the template structure:

### meeting-notes structure
```
h1. [Meeting Title] — [Date]

h2. Attendees
[bullet list of attendees]

h2. Agenda
[numbered agenda items]

h2. Discussion Notes
[placeholder — to be filled during/after meeting]

h2. Decisions
[placeholder]

h2. Action Items
|| Action || Owner || Due Date ||
| [action 1] | [owner] | [date] |
```

### project-kickoff structure
```
h1. [Project Name] — Kickoff

h2. Overview
[problem statement]

h2. Goals
[3-5 SMART goals — generated from problem statement]

h2. Scope
*In scope:* [generated suggestions]
*Out of scope:* [placeholder]

h2. Stakeholders
|| Name || Role || Responsibility ||
[rows from input]

h2. Timeline
[key milestones — generated with delivery date anchor]

h2. Risks & Open Questions
[placeholder]
```

### feature-spec structure
```
h1. Feature Spec: [Feature Name]

h2. Problem
[problem statement]

h2. Users Affected
[target users]

h2. Proposed Solution
[AI-generated solution outline based on requirements]

h2. Requirements
[bullet list from input]

h2. Acceptance Criteria
[AI-generated from requirements]

h2. Linked Resources
[Jira ticket links if provided]

h2. Open Questions
[placeholder]
```

### adr structure
```
h1. ADR: [Decision Title]

*Status:* Proposed
*Date:* [today]

h2. Context
[context from input]

h2. Decision
[decision from input]

h2. Alternatives Considered
[alternatives from input or "None documented"]

h2. Consequences
*Positive:* [AI-generated]
*Negative / Trade-offs:* [AI-generated]

h2. Related Decisions
[placeholder]
```

### retrospective structure
```
h1. Retrospective — [Sprint/Iteration Name]

*Team:* [team]  *Period:* [date]

h2. What Went Well
[placeholder — to be filled collaboratively]

h2. What Could Be Improved (Delta)
[placeholder]

h2. Action Items
|| Action || Owner || Due Date ||
| | | |
```

### onboarding structure
```
h1. Onboarding Guide — [Role Title]

*Team:* [team/department]

h2. Welcome
[AI-generated welcome paragraph]

h2. Your Role
[placeholder]

h2. Tools & Systems
[bullet list from input]

h2. Key Contacts
|| Name || Role || Contact ||
[rows from input]

h2. First Week Checklist
[AI-generated checklist for the role]

h2. Resources & Links
[placeholder]
```

### incident-report structure
```
h1. Incident Report: [Title]

*Date/Time:* [from input]  *Status:* Under Review

h2. Impact
[impact summary]

h2. Affected Systems
[bullet list from input]

h2. Timeline
|| Time || Event ||
| [time] | Incident detected |
| | [placeholder for further events] |

h2. Root Cause Analysis
[placeholder]

h2. Remediation
*Immediate actions taken:*
[placeholder]

*Long-term fixes:*
[placeholder]

h2. Lessons Learned
[placeholder]
```

---

## Step 4 — Confirm and publish

Show a preview summary:

```
Ready to create page:

Title: [page title]
Space: [space key]
Parent: [parent title or "space root"]
Template: [template name]

[First 5-10 lines of generated content]
...

Create page? (yes / edit first / cancel)
```

On **yes**: call `createConfluencePage` (or equivalent write operation discovered via MCP `discover`) with the generated content.

On **edit first**: show full content, ask what to change, apply changes, re-confirm.

On **cancel**: stop.

---

## Step 5 — Confirm

```
✅ Page created

Title: [title]
URL: [Confluence page URL]
Space: [space key]
```

If `editConfluencePage` / `createConfluencePage` returns a URL, include it directly.

---

## Error handling

- Space key not found → ask user to verify; list available spaces via `searchConfluenceUsingCql(type = "space")`.
- Parent page not found → offer to create at space root instead.
- Content too long for single call → split into sections and create with sections placeholder.
- MCP write operation unavailable → show generated content as markdown, ask user to paste manually.
- Config corrupted → re-run setup.
