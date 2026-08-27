# pm-ai-prompts

Enterprise-grade AI prompts and Claude Code skills for Project Managers, Business Analysts, Delivery Leads and Transformation Teams.

## Prompts (`prompts/`)

| File | Use case |
|---|---|
| `salesforce-newsletter-editor.md` | Internal Salesforce team newsletter |
| `sharepoint_ai_writer_prompt.md` | SharePoint internal article (HTML) |
| `meeting-notes-to-actions.md` | Meeting notes → action items, decisions, RAID |
| `sprint-retrospective-facilitator.md` | Retrospective facilitation → structured output |
| `risk-register-analyst.md` | RAID log — risk analysis and mitigation |
| `user-story-writer.md` | Epics → user stories with Given/When/Then ACs |
| `stakeholder-comms-planner.md` | Stakeholder matrix + communication plan |
| `executive-status-report.md` | RAG status report for sponsors / C-level |
| `brd-writer.md` | Business Requirements Document (MoSCoW) |
| `process-gap-analysis.md` | AS-IS vs TO-BE gap analysis |
| `uat-scenario-generator.md` | Acceptance criteria → UAT test scenarios |
| `change-impact-assessment.md` | Business / IT change impact assessment |
| `sprint-review-prep.md` | Sprint demo agenda and script |
| `workshop-facilitator.md` | Requirements / discovery workshop design |

## Claude Code skills (`skills/`)

Ready-to-use skill files for Claude Code (`.claude/skills/`).

> **Note:** Skills marked "requires Atlassian plugin" need the official Atlassian Claude Code plugin installed (`/plugins → atlassian`). Generic skills (humanizer) work without any plugin.

| File | Description |
|---|---|
| `humanizer.md` | Remove AI writing patterns — MIT, based on Wikipedia |
| `salesforce-create-internal-user.md` | Create SF internal users — FedId conflict fix, PSL→PSG→PS order, DocuSign |
| `atlassian-capture-tasks-from-meeting-notes.md` | Meeting notes → Jira tasks (requires Atlassian plugin) |
| `atlassian-generate-status-report.md` | Jira → status report on Confluence (requires Atlassian plugin) |
| `atlassian-jira-sprint-dashboard.md` | Visual sprint dashboard from Jira data (requires Atlassian plugin) |
| `atlassian-search-company-knowledge.md` | Search Confluence + Jira in parallel (requires Atlassian plugin) |
| `atlassian-spec-to-backlog.md` | Confluence spec → Jira Epic + tickets (requires Atlassian plugin) |
| `atlassian-triage-issue.md` | Bug triage — find duplicates, create Jira issues (requires Atlassian plugin) |

## How to use

**Prompts** — paste the file content as a system prompt in Claude, ChatGPT, or any LLM chat. The prompt will guide an interactive workflow before generating output.

**Skills** — copy the file to `.claude/skills/<name>/SKILL.md` in your project to use as a slash command in Claude Code.
