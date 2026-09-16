# Changelog

All notable changes to this project will be documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) — SemVer.

## [Unreleased]

## [1.5.0] - 2026-09-16

### Added
- `skills/confluence-page-from-template/` — Claude Code skill: interactive page creation from 7 built-in templates (Meeting Notes, Project Kickoff, Feature Spec, ADR, Retrospective, Onboarding Guide, Incident Report); AI-fills content from minimal inputs, previews before publish; self-configuring setup wizard
- `skills/azure-devops-work-item-triage/` — Claude Code skill: analytical triage of ADO work items; reads linked items and wiki for context, writes scoped comment with complexity estimate, transitions state, reassigns to dev; batch mode (up to 5 items in parallel); PAT-based auth via settings.local.json
- `career/interview-prep-coach.md` — company research + role-specific Q&A generation + STAR coaching per answer; separate versions for PM / AI Product / Salesforce roles; paths B+D
- `prompts/ai-readiness-assessment.md` — AI maturity audit: people, processes, data, technology axes → maturity matrix + prioritized roadmap + quick wins; paths C+A
- `prompts/business-case-writer.md` — opportunity to investment justification: problem framing, solution options, ROI model, risk register, executive ask; path A
- `prompts/technical-discovery-facilitator.md` — structured discovery facilitator: system mapping, data flows, pain points, integration gaps; FDM day 1–5 protocol; path D
- `examples/` — worked input→output pairs for all 21 prompts (18 new pairs added to cover all prompts without examples)

### Changed
- `DEVELOPMENT_BACKLOG.md` — updated to v1.5.0 current; Sprint 2 (v1.6.0) definition moved up

## [1.4.0] - 2026-09-14

### Added
- `prompts/roadmap-planner.md` — product/program roadmap prompt: Now/Next/Later framework, RICE prioritization, timeline and Gantt output, dependency mapping
- `prompts/okr-kpi-builder.md` — OKR Coach: 5-step workflow, blocks vanity metrics and tasks-as-KRs, requires numeric baseline before writing any Key Result
- `prompts/project-kickoff-facilitator.md` — Team Charter builder: RACI matrix, Kickoff Agenda (60 or 90 min), post-kickoff action list, Ways of Working section
- `prompts/decision-log-writer.md` — ADR-style decision records: options comparison table, rationale, consequences, stakeholder communication draft, Related Decisions index
- `prompts/release-notes-writer.md` — three-audience release notes from raw PR/commit/ticket input: Format A (technical), Format B (product), Format C (executive)
- `prompts/raid-board-automator.md` — continuous RAID board maintenance from meeting notes and status updates; escalation flags, Risk→Issue reclassification, append-only update log
- `prompts/vendor-evaluation.md` — structured vendor scorecard: functional + commercial + strategic criteria, weighted scoring, recommendation memo, negotiation checklist
- `skills/github-pr-to-release-notes/SKILL.md` — read merged PRs via `gh` CLI, categorize by label, generate 3-format release notes; handles milestone, date range, and tag comparison scopes
- `skills/linear-sprint-dashboard/SKILL.md` — pull active Linear cycle via MCP, compute health metrics (completion rate, blockers, stale, unassigned), produce standup/Slack/exec dashboard
- `skills/release-manager/SKILL.md` — end-to-end release coordination: pre-release gate checklist, go/no-go decision, deployment tracking, rollback plan, post-release verification, hotfix protocol
- `examples/` directory with worked input→output pairs for 3 prompts (risk-register-analyst, user-story-writer, roadmap-planner)

### Changed
- `prompts/sharepoint_ai_writer_prompt.md` → `prompts/sharepoint-ai-writer.md` (kebab-case rename for consistency)
- `README.md` — added 7 new prompts, 3 new skills, Examples section, updated skill table

## [1.3.0] - 2026-09-13

### Added
- `career/career-profile-builder.md` — flagship multi-phase prompt: guides any user through full career profile build (inventory → cross-check → interview → Master Profile → CV → LinkedIn → job fit → CV tailoring). Career Advocate approach: Strengthen, Don't Fabricate. FACT / REASONABLE ENHANCEMENT / ESTIMATION confidence levels.
- `career/job-fit-analyzer.md` — paste CV + job description → match score (1–10), requirements table (✅⚠️❌), gaps, talking points, salary estimate, honest red flags. Works as standalone prompt in any LLM.
- `career/cv-tailoring-engine.md` — paste base CV + job description → tailored CV with per-change log, keyword extraction, fair assessment of what tailoring can and cannot fix.

### Changed
- `README.md` — added Career AI Tools section, updated repo description to reflect multi-domain scope (PM + Career + AI Policy roadmap)

## [1.2.0] - 2026-08-29

### Added
- `skills/jira-sync/` — Claude Code skill for developers: automatic Jira lifecycle management (In Progress → In Test → Done). Generates technical commit summary + human-readable comment on task completion. Self-configuring setup wizard — zero manual config needed.
- `skills/jira-intake/` — Claude Code skill for analysts: reads Jira + Confluence, writes analytical comment with affected areas and dev scope estimate, reassigns ticket to developer. Batch mode: up to 5 tickets analysed in parallel, single assignment table at the end.
- `skills/requirements-analyst/` — Claude Code skill for Analyst / PO / PMO: drives a project from raw requirements to developer-ready specification. Pipeline SOURCE → REQUIREMENTS → Q&A → PROCESSES → UX → DEV SPEC with Gate A/B/C/D. Stable REQ-*/Q-* IDs, full traceability chain, conflict detection. Dual output for open questions: machine-readable `questions-register.md` + ready-to-send `questions-email-draft.md` grouped by addressee and topic. Supports DOCX, PDF, MD, EML, Confluence, Jira as source formats. Gate A posts a Jira summary comment; Gate C triggers `jira-intake` for dev handoff.
- `scripts/setup-git-credentials.sh` — one-time script to configure git credentials for the private GitHub account using `gh auth token`.

## [1.1.0] - 2026-08-27

### Added
- `skills/salesforce-create-internal-user.md` — Claude Code skill for creating Salesforce internal users: FederationIdentifier conflict detection and fix (sandbox refresh Community users), mandatory PSL → PSG → PS license assignment order, DocuSign activation, sandbox vs production differences, troubleshooting table.

## [1.0.0] - 2026-07-21

### Added
- Initial release: 14 PM/BA prompts (`prompts/`)
- `skills/humanizer.md` — remove AI writing patterns
- `skills/atlassian-*.md` — 6 Atlassian plugin skills (capture-tasks, status-report, sprint-dashboard, search-company-knowledge, spec-to-backlog, triage-issue)
