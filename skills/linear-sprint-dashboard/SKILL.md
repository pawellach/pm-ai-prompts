---
name: linear-sprint-dashboard
description: Pull current sprint state from Linear and produce a status dashboard with health indicators and blockers
---

# Linear Sprint Dashboard

Read the current cycle (sprint) from Linear and produce a structured status dashboard suitable for a standup, sprint review, or async Slack update.

## When to use this skill

Use this skill when the user says:
- "Give me the sprint status"
- "What's the current cycle looking like?"
- "Prepare the standup dashboard"
- "What's blocked / what's at risk in Linear?"
- "Sprint health check"

## Prerequisites

- Linear MCP connected (`mcp__linear__*` tools available)
- Team ID or team name known (ask if not)

## Step 1 — Find the active cycle

```
Use: mcp__linear__list_cycles
Parameters: { teamId: "<team_id>", filter: { isActive: true } }
```

If multiple active cycles exist, ask the user which one to report on.

If no active cycle: check for the most recently completed cycle and note that the sprint has ended.

## Step 2 — Pull all issues in the cycle

```
Use: mcp__linear__list_issues
Parameters: { 
  filter: { 
    cycle: { id: { eq: "<cycle_id>" } }
  },
  includeArchived: false
}
```

For each issue, capture:
- ID, title, status, assignee, priority, labels
- Whether it has any blockers (blocked_by relations)
- Estimate (story points or time)
- Updated date (to detect stale issues)

## Step 3 — Compute cycle health metrics

Calculate:

| Metric | Formula |
|--------|---------|
| **Completion rate** | Done issues / Total issues × 100% |
| **In-progress** | Count of issues in "In Progress" / "In Review" |
| **Not started** | Count of issues in "Todo" / "Backlog" |
| **Blocked** | Count of issues with blockers or "Blocked" status |
| **Stale** | Issues not updated in >3 working days |
| **Unassigned** | Issues with no assignee |
| **Overdue** | Issues past their due date (if due dates set) |

**Health score:**
- 🟢 Green: Completion rate on track for cycle end (>= expected % complete given days elapsed)
- 🟡 Yellow: 10-20pp behind expected pace, or 1+ blocked issues
- 🔴 Red: >20pp behind, or 2+ blocked issues, or unresolved blockers with no owner

## Step 4 — Identify risks and highlights

**Blockers:** List all blocked issues with:
- Issue ID and title
- Who is blocked (assignee)
- What is blocking them (if captured in Linear)
- Days blocked

**At-risk items:** Issues that are In Progress but have not been updated in >2 working days.

**Completed highlights:** List up to 5 recently completed issues (most impactful first, based on priority label or estimate).

## Step 5 — Generate dashboard output

Produce a structured report in this format:

---

## Sprint Dashboard — [Team Name] — [Cycle Name]
**Date:** [Today] | **Cycle end:** [End date] | **Days remaining:** [N]

### Health: 🟢 / 🟡 / 🔴 [status]

| Metric | Value |
|--------|-------|
| Total issues | N |
| ✅ Done | N (XX%) |
| 🔄 In Progress | N |
| 📋 Todo / Not started | N |
| 🚫 Blocked | N |
| ⚠️ Stale (>3 days) | N |
| 👤 Unassigned | N |

**Expected completion at this point in cycle:** XX% | **Actual:** XX%

---

### 🚫 Blockers

| Issue | Title | Assignee | Blocked Since | Blocker |
|-------|-------|---------|--------------|---------|
| [ID] | [Title] | [Name] | [N days] | [Description or "Unknown"] |

*No blockers* if none.

---

### ⚠️ At Risk

| Issue | Title | Assignee | Last Updated |
|-------|-------|---------|-------------|

*No at-risk items* if none.

---

### ✅ Recently Completed (last 3 days)

- [ID] [Title] — [Assignee]

---

### 📋 Not Started (by priority)

List unstarted issues grouped by priority: Urgent → High → Medium → Low.

---

### Recommendation

[1-3 sentences: what does the team need to focus on for the rest of the cycle? Any escalations needed?]

---

## Formatting variants

**Standup format (shorter):** Skip the full "Not Started" list. Focus on Blockers + At Risk + Completed Yesterday.

**Async Slack format:** Produce a text-only version without markdown tables — use emoji + bullet points instead.

**Weekly executive summary:** Drop issue-level detail. Show only health status, completion %, blocker count, and recommendation.

Ask the user which format they want, or default to the full dashboard if not specified.

## Common issues

**No cycle configured:** If the team does not use cycles, offer to generate a dashboard based on label + status filter instead (e.g., "show all In Progress issues in project X").

**Large cycle (50+ issues):** Summarize by assignee or label group — do not list all 50 issues.

**Multiple teams:** Run the dashboard for each team separately and produce a roll-up summary at the top.
