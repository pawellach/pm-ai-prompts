# jira-sprint-dashboard — Atlassian Claude Code skill

> **Source:** Official Atlassian plugin for Claude Code.
> **Requires:** Atlassian MCP plugin installed and connected to Jira/Confluence.
> **Install plugin:** Claude Code → /plugins → search "atlassian" → install.
>
> To use as a skill in your own project, copy this file to `.claude/skills/jira-sprint-dashboard-canvas/SKILL.md`.
> The skill activates via `/jira-sprint-dashboard-canvas` command in Claude Code.

---
---
name: jira-sprint-dashboard
description: >-
  Create a visual Jira sprint dashboard from Jira project, space, sprint, board,
  filter, JQL, work item keys, or Jira URL data. Use when the user asks for a
  Jira sprint dashboard, standup dashboard, sprint review, delivery review,
  engineering manager dashboard, WIP review, planning view, closeout view, or a
  visual snapshot of Jira work that is more useful than a flat report. Use the
  richest dashboard format supported by the current agent, such as Cursor
  Canvas, an interactive artifact, HTML, or Markdown.
---

# Jira Sprint Dashboard

Build a focused dashboard that helps an engineering manager, tech lead, or
senior engineer see current Jira work quickly enough to decide what needs
attention. The output is a dashboard, not a prose report and not a generic
health score.

This skill is read-only by default. Do not create, update, transition, assign,
or comment on Jira work items unless the user explicitly asks for a write action
after reviewing the dashboard.

## Output Mode

Use the richest dashboard renderer supported by the current environment. The
dashboard content, claims, counts, and source appendix must stay consistent
across renderers; only the presentation changes.

Choose the renderer in this order:

1. Cursor Canvas, if running in Cursor with Canvas support.
2. Interactive artifact, if the current agent supports HTML, React, or similar
   artifact output.
3. Static HTML file, if file creation is available and useful.
4. Markdown dashboard, if no richer visual renderer is available.
5. Structured JSON plus concise summary, only if visual rendering is impossible.

Do not mention that Cursor Canvas is unavailable unless the user specifically
asked for Cursor Canvas. If the user asked for a dashboard generally, use the
best available renderer without apologizing for the environment.

## Get The Scope

Do not guess the Jira scope. If the user does not provide a project key, space
key, board, sprint, filter, JQL, work item keys, or Jira URL, stop and ask for
one. A dashboard from a random visible project or guessed team context is worse
than no dashboard.

If the user gives a project or space key but no sprint, board, or filter, start
with the Jira JQL `project` field and the user's key:

```jql
project = "SPACE_KEY" AND sprint in openSprints() ORDER BY Rank ASC
```

If the open sprint result is empty, stale, or misleading, switch to snapshot
mode and say so in a compact caveat below the top bar:

```jql
project = "SPACE_KEY" AND statusCategory != Done ORDER BY priority DESC, updated ASC
project = "SPACE_KEY" AND updated >= -60d ORDER BY updated DESC
```

Use a 60-day recent movement window by default unless the user asks for another
period.

## Query Jira

Use read-only Jira search. Request only fields needed for the dashboard and
tolerate missing fields.

Useful fields: `key`, `summary`, `status`, `statusCategory`, `assignee`,
`priority`, `issuetype`, `created`, `updated`, `resolutiondate`, `duedate`,
`parent`, `issuelinks`, `labels`, `components`, `fixVersions`, `sprint`, and any
available estimate/story point field.

Start with `maxResults: 100`. For complete sprint, board, or filter dashboards,
paginate until the scope is complete or too large for useful work-item-level
rendering.

Default to one complete paginated scope query. Derive ordinary dashboard signals
locally from the returned work item set instead of issuing separate JQL calls for
each signal.

Derive these locally when the scope query returned the required fields:

- Recently completed from `statusCategory = Done` and `resolutiondate`.
- Aging unfinished from `statusCategory != Done` and `updated`.
- Unowned unfinished from `statusCategory != Done` and empty `assignee`.
- High-priority unfinished from `statusCategory != Done` and `priority`.
- Status or label blockers from `status`, `statusCategory`, and `labels`.
- Owner load, stale work, due date risk, and planning gaps from the normalized
  scope dataset.

Use targeted follow-up queries only when they are needed to support a visible
claim that cannot be derived safely from the scope data, when the scope is too
large for useful local processing, or when the user asks for an audit-style
dashboard with exact evidence per signal.

## Dashboard Model

Create a dashboard model before rendering. Every renderer should use this same
model.

Include:

- Context metadata: title, project or space, sprint, board, filter, JQL, window,
  query timestamp, and mode.
- Four top stats: committed or total scope, done or completed, active or in
  progress, and needs attention.
- Scope caveat, only when sprint data is missing, mixed, stale, or blended with
  recent project movement.
- Optional capacity or commitment segments, only when real data exists.
- Optional chart data, only when categories, values, units, and time ranges are
  available.
- Owner load and gaps.
- Risk and attention items.
- Highest-priority work item table.
- Recently completed work.
- Source appendix with exact JQL, field coverage, assumptions, and the
  composition of `Needs attention`.

Do not invent data to fill the model. Empty or unsupported sections should be
omitted.

## Dashboard Shape

Keep the visible dashboard simple and deterministic. When the data exists,
broadly follow this order:

1. **Compact context header** — title plus project, space, board, sprint, or window metadata.
2. **Four-stat top bar** — committed/total scope, done/completed, active/in progress, needs attention.
3. **Scope caveat** — only when sprint data is missing, mixed, stale, or blended.
4. **Capacity or commitment bar** — only when real data exists.
5. **Sprint charts** — remaining work over time, status distribution, resolved per day.
6. **Owner load and gaps** — active, stale, blocked counts by assignee.
7. **Risk and attention** — items most likely to need manager attention.
8. **Highest-priority work item table** — compact table of top sprint or attention items.
9. **Recently completed** — collapsed section or compact table.
10. **Source appendix** — exact JQL, query timestamps, field coverage, assumptions.

## Content And Style

- Use charts and tables where they beat paragraphs.
- Keep work item summaries short; avoid full descriptions unless a short excerpt
  is needed to explain impact.
- Tie every recommendation or next question to work item keys or aggregate counts.
- Separate Jira facts from derived or inferred signals.
- Use semantic tones: `success` for done, `warning` for stale/deadline risk,
  `danger` for blocked/overdue/severe risk, `info` for caveats/linked work,
  `neutral` for low-signal facts.
- Pair color with labels. Prefer work item key links over large buttons.

## Self-Check

Before returning:

- Scope came from the user or a provided URL; missing or ambiguous scope was
  clarified before querying.
- The selected renderer matches the current environment's capabilities.
- The top area is a compact context header followed by exactly four stats.
- There is no query list, field coverage, or executive summary above the top bar.
- Counts reconcile with the queried work item set.
- Empty sections are omitted.
- Charts are rendered only when their categories, values, units, and time ranges
  are available.
- Risk labels are explainable from visible Jira data.
- Source appendix includes exact JQL and field coverage for visible claims.
- No Jira write tools were used.
