# pm-ai-prompts

Enterprise-grade AI prompts and Claude Code skills for Project Managers, Business Analysts, Delivery Leads, Transformation Teams — and anyone building a career in the age of AI.

## Career AI Tools (`career/`)

End-to-end toolkit for knowledge workers who want AI-assisted career building.

| File | Use case |
|---|---|
| `career-profile-builder.md` | Full career profile from scratch — inventory → interview → Master Profile → CV → LinkedIn → job fit |
| `job-fit-analyzer.md` | Paste CV + job description → match score, gap table, talking points |
| `cv-tailoring-engine.md` | Tailor any CV to a specific role — keywords, emphasis, summary rewrite |

> These prompts work as standalone system prompts (ChatGPT, Claude, Gemini) or as Claude Code skills.

## Prompts (`prompts/`)

| File | Use case |
|---|---|
| `salesforce-newsletter-editor.md` | Internal Salesforce team newsletter |
| `sharepoint-ai-writer.md` | SharePoint internal article (HTML) |
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
| `roadmap-planner.md` | Product / program roadmap: Now/Next/Later, RICE prioritization, timeline output |
| `okr-kpi-builder.md` | OKR Coach — defines Objectives, Key Results, and lead KPIs with vanity metric detection |
| `project-kickoff-facilitator.md` | Team Charter + RACI + Kickoff Agenda from raw project context |
| `decision-log-writer.md` | ADR-style decision record — options comparison, rationale, consequences |
| `release-notes-writer.md` | Transforms commit lists / PR titles into 3 audience formats (technical, product, executive) |
| `raid-board-automator.md` | Continuous RAID board updates from meeting notes and status updates |
| `vendor-evaluation.md` | Structured vendor scorecard — functional + commercial + strategic fit, recommendation memo |

## Claude Code skills (`skills/`)

Ready-to-use skill files for Claude Code (`.claude/skills/`).

> **Note:** Skills marked "requires Atlassian plugin" need the official Atlassian Claude Code plugin installed (`/plugins → atlassian`). Generic skills work without any plugin.

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
| `jira-sync/` | Automatic Jira lifecycle — transitions (In Progress → In Test → Done) + auto-comments on task completion. Self-configuring setup wizard. (requires Atlassian plugin) |
| `jira-intake/` | Analyst ticket intake — reads Jira + Confluence, writes analytical comment with dev scope, reassigns to developer. Batch mode: up to 5 tickets in parallel. (requires Atlassian plugin) |
| `requirements-analyst/` | Requirements-to-dev-spec pipeline: Gate A→D, stable REQ-*/Q-* IDs, traceability, email draft for stakeholder Q&A, DOCX/PDF/Confluence ingestion. (requires Atlassian plugin + docx/pdf skills) |
| `github-pr-to-release-notes/` | Read merged PRs via `gh` CLI → categorize by label → generate 3-format release notes |
| `linear-sprint-dashboard/` | Pull active Linear cycle → compute health metrics → produce standup/Slack/exec dashboard |
| `release-manager/` | End-to-end release coordination: pre-release gate, go/no-go, deployment tracking, rollback plan, retrospective |

## Examples (`examples/`)

Worked examples showing real input → output pairs for selected prompts.

| Directory | Prompt | Scenario |
|-----------|--------|----------|
| `examples/risk-register-analyst/` | `risk-register-analyst.md` | CRM migration — RAID table (Polish output) |
| `examples/user-story-writer/` | `user-story-writer.md` | B2B invoice module — 3 user stories with Given/When/Then |
| `examples/roadmap-planner/` | `roadmap-planner.md` | ERP replacement — H1/H2/H3 roadmap with RICE scores |

## How to use

**Prompts** — paste the file content as a system prompt in Claude, ChatGPT, or any LLM chat. The prompt will guide an interactive workflow before generating output.

**Skills** — copy the file to `.claude/skills/<name>/SKILL.md` in your project to use as a slash command in Claude Code.
