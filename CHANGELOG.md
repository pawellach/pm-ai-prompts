# Changelog

All notable changes to this project will be documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) — SemVer.

## [Unreleased]

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
