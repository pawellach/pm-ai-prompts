---
name: sprint-close-synthesizer
description: |
  Synthesizes a completed sprint into a structured close report and seeds the next sprint planning. Use when — (1) user writes `/sprint-close-synthesizer` or `/sprint-close`, (2) user says "close this sprint", "synthesize sprint", "zamknij sprint", "sprint report", "sprint summary for planning". Reads closed Jira issues via Atlassian MCP, computes velocity and carryover, identifies patterns, and produces: (a) a sprint close report for stakeholders, (b) a planning seed document for the next sprint. Complements `jira-sync` (per-ticket transitions) — this skill operates at sprint level, not ticket level. Do NOT use for single-ticket updates or mid-sprint status.
---

# sprint-close-synthesizer — Sprint Close Report & Planning Seed

Role: Scrum Master / Delivery Lead / Engineering Manager / PM.

Synthesizes a completed sprint into a close report and hands off a structured seed for next sprint planning. Works with Jira via Atlassian MCP; degrades gracefully to text input if MCP unavailable.

---

## Step 0 — Check inputs and MCP availability

### 0a. Determine what inputs are available

Ask the user:

> "To synthesize the sprint close I need:
> 1. **Sprint identifier** — the sprint name or ID in Jira (e.g. 'Sprint 42' or 'SAL Sprint 14'). Or paste the Jira project key and I'll find the most recently closed sprint.
> 2. **Sprint goal** — what was the stated goal for this sprint? (check sprint description in Jira if available)
> 3. **Team capacity** — how many story points (or hours) were committed at the start?
> 4. **Any context outside Jira** — decisions made, unplanned work that appeared, external blockers.
>
> If Atlassian MCP is not connected, paste: a list of completed tickets (key + summary + points), a list of carried tickets, and any blockers or unplanned items that came up."

### 0b. Check Atlassian MCP availability

Call `atlassianUserInfo`. If unavailable:

```
Atlassian MCP plugin is not active. Continuing with text input mode.

To enable live Jira data for future sprints:
1. Open Claude Code → Settings (⚙) → Plugins → Atlassian (official plugin)
2. Sign in with your Atlassian account
3. Run /sprint-close-synthesizer again
```

If MCP unavailable but user provided text, proceed — do not stop.

---

## Step 1 — Pull sprint data (if MCP available)

### 1a. Find the sprint

Call `searchJiraIssuesUsingJql`:
```
project = [PROJECT_KEY] AND sprint = "[SPRINT_NAME]"
```

If sprint name not provided, find the last closed sprint:
```
project = [PROJECT_KEY] AND sprint in closedSprints() ORDER BY updated DESC
```
Take the most recently closed one.

### 1b. Pull issues by outcome

Run three queries:

**Completed:**
```
project = [PROJECT_KEY] AND sprint = "[SPRINT_NAME]" AND status = "Done"
```

**Carried over (not done):**
```
project = [PROJECT_KEY] AND sprint = "[SPRINT_NAME]" AND status != "Done"
```

**Unplanned work added during sprint:**
```
project = [PROJECT_KEY] AND sprint = "[SPRINT_NAME]" AND created >= [SPRINT_START_DATE]
```

For each issue, extract: key, summary, story points (or time estimate), type, assignee, labels, epic link.

---

## Step 2 — Compute sprint metrics

Calculate:

| Metric | Formula |
|---|---|
| **Committed points** | Sum of story points at sprint start (from user input or Jira sprint start snapshot) |
| **Completed points** | Sum of story points for Done tickets |
| **Velocity** | Completed points |
| **Completion rate** | Completed / Committed × 100% |
| **Carryover points** | Sum of story points for non-Done tickets |
| **Unplanned items** | Count and points of issues added after sprint start |
| **Unplanned ratio** | Unplanned points / Total completed points × 100% |

Flag patterns:
- Completion rate < 70%: low predictability — note it
- Unplanned ratio > 30%: sprint was significantly disrupted
- Any epic with 0 completed tickets: blocked epic
- Any ticket carried 2+ sprints: chronic carryover candidate

---

## Step 3 — Identify themes and risks

From the completed and carried tickets, group by:
- Epic (what themes were delivered?)
- Assignee (any individual who was blocked or overloaded?)
- Type (too many bugs vs. features?)

Look for:
- Tickets marked "blocked" or with blocker comments
- Tickets with late status changes (updated on last day of sprint)
- Any tickets missing story points (estimation gap)

---

## Step 4 — Generate Sprint Close Report

Produce a structured Markdown report:

```markdown
# Sprint Close — [Sprint Name]
**Project:** [Name] | **Period:** [START] – [END] | **Goal:** [Sprint Goal]

---

## 📊 Velocity Summary

| Metric | Value |
|---|---|
| Committed | XX pts |
| Completed | XX pts |
| Completion rate | XX% |
| Carryover | XX pts (N tickets) |
| Unplanned work added | XX pts (N tickets) |

**Overall:** [Green / Amber / Red]
- 🟢 Green: ≥ 85% completion, unplanned < 20%
- 🟡 Amber: 70–84% completion OR unplanned 20–35%
- 🔴 Red: < 70% completion OR unplanned > 35%

---

## ✅ Completed This Sprint

| Key | Summary | Points | Epic |
|---|---|---|---|
| [KEY] | [Summary] | [pts] | [Epic] |

---

## 🔄 Carried Over

| Key | Summary | Points | Carried from sprint(s) | Reason (if known) |
|---|---|---|---|---|
| [KEY] | [Summary] | [pts] | [N sprints] | [reason] |

> **Action:** Review carryover tickets before next sprint planning. Tickets carried 2+ sprints should be re-estimated or split.

---

## ⚡ Unplanned Work Added

| Key | Summary | Points | Added by |
|---|---|---|---|
| [KEY] | [Summary] | [pts] | [Who added / context] |

---

## 📋 Patterns & Observations

[2–4 bullet points derived from Step 3 analysis — factual, not editorializing]

---

## 🏆 Sprint Goal Assessment

**Goal was:** [Stated goal]
**Assessment:** [Met / Partially met / Not met]
**Explanation:** [1–2 sentences — what was delivered vs. the goal, not velocity math]

---

*Synthesized by sprint-close-synthesizer · [DATE] · [SPRINT_NAME]*
```

---

## Step 5 — Generate Planning Seed Document

Produce a separate, shorter document for the team to use in next sprint planning:

```markdown
# Planning Seed — [Next Sprint Name / "Sprint N+1"]

> Generated from [SPRINT_NAME] close. Use as input for planning, not as a fixed commitment.

## Carry-forward candidates (ordered by priority)

| Key | Summary | Points | Recommendation |
|---|---|---|---|
| [KEY] | [Summary] | [pts] | Carry as-is / Re-estimate / Split / Deprioritize |

## Unfinished epic work

For each epic with incomplete items, list:
- Epic name
- % done (completed tickets / total in epic)
- Remaining tickets and estimated points
- Blocking dependencies (if any)

## Suggested capacity adjustments

Based on last sprint's unplanned ratio of XX%:
- If the team plans XX points, expect ~XX% disruption buffer
- Recommended committed range for next sprint: [LOWER]–[UPPER] points

## Recurring risks to watch

[Any patterns from Step 3 that are likely to repeat — e.g. "late QA discovered issues", "external dependency on X team blocked 2 tickets"]

## Open questions for planning session

[List 2–4 specific questions the PM / Scrum Master should raise at planning based on this sprint's patterns]
```

---

## Step 6 — Offer distribution options

After generating both documents, ask:

> "Would you like me to:
> A. Save the close report as a Markdown file (`sprint-close-[SPRINT_NAME].md`)
> B. Post it to Confluence as a new page under the sprint space
> C. Format it as an email to send to stakeholders
> D. Just display it here
>
> For the planning seed: should I open a Jira sprint planning session, or is this for an in-person planning session?"

---

## Notes for the presenter

- **Velocity is a trailing indicator** — use it to set planning ranges, not hard targets.
- **Carryover is not always bad** — scope changes and deprioritization are valid. Flag chronic carryover (2+ sprints), not single-instance carryover.
- **Sprint goal assessment is more important than velocity** — a team that delivered the goal at 75% completion is in better shape than one that hit 95% completion but missed the goal.
- **Do not compare velocity across teams** — this report is for the same team over time, not cross-team benchmarking.
