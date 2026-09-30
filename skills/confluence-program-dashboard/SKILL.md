---
name: confluence-program-dashboard
description: |
  Generates a portfolio-level program health dashboard by combining live Jira epic data with Confluence context (decisions, risks, OKRs). Use when — (1) user writes `/confluence-program-dashboard` or `/program-dashboard`, (2) user says "prepare program health dashboard", "generate portfolio status", "zrób health dashboard programu", "portfolio dashboard z Jiry". Reads Jira epics + Confluence pages via MCP, computes RAG (Red/Amber/Green) per initiative, and produces a structured Markdown dashboard ready to paste into Confluence or send as an executive email. Do NOT use for single-sprint reviews or individual project status packs — use `consulting-client-status-pack` for those.
---

# confluence-program-dashboard — Portfolio Program Health Dashboard

Role: Program Manager / Portfolio Manager / PMO Lead.

Produces a portfolio-level health dashboard combining live Jira epic data with Confluence strategic context. One dashboard = one consolidated view of all active initiatives across the program.

---

## Step 0 — Check inputs and MCP availability

### 0a. Determine what inputs are available

Ask the user:

> "To generate the program dashboard I need:
> 1. **Program scope** — a list of Jira Epic IDs or a Jira project key (I'll pull all open epics). Alternatively, paste a program name and I'll search for it.
> 2. **Confluence context** — the name or URL of the program space or page where decisions, risks, and OKRs are documented (optional but recommended).
> 3. **Any known context** — blockers, decisions made this week, team changes — paste anything that won't be in Jira or Confluence.
>
> If Atlassian MCP is not connected, paste a summary of active initiatives (name, owner, status, key blockers) and I will structure it into a dashboard."

### 0b. Check Atlassian MCP availability

Call `atlassianUserInfo`. If unavailable:

```
Atlassian MCP plugin is not active. To use confluence-program-dashboard with live data:

1. Open Claude Code → Settings (⚙) → Plugins
2. Enable: "Atlassian" (official plugin)
3. Sign in with your Atlassian account
4. Restart Claude Code
5. Run /confluence-program-dashboard again

To continue without live data: paste a list of active initiatives with — name, owner, current status, due date, and key blockers.
```

If MCP is unavailable but the user provides text input, proceed with that input. Do not stop.

---

## Step 1 — Gather program context

If running for the first time, ask:

- Program or portfolio name (used in the dashboard header)
- Reporting period (e.g., "Week of 2026-09-30" or "Q3 2026")
- Who is the primary audience? (Program Steering Committee / CTO / Executive Sponsor / PMO team)
- Are there OKRs or strategic goals this program maps to? (If yes, link initiatives to them in the output)
- Any initiatives that should be excluded? (archived, on hold, not yet started)
- Are there budget or resource sections to include?

If the user has provided this before in the same session, skip.

---

## Step 2 — Pull Jira epic data

Call `searchJiraIssuesUsingJql` with:

```
issuetype = Epic AND project in ([PROJECT_KEYS]) AND statusCategory != Done ORDER BY priority DESC
```

If Epic IDs were provided instead of a project key:

```
issue in ([EPIC_ID_1], [EPIC_ID_2], ...) ORDER BY priority DESC
```

For each epic, extract:
- Key and summary (initiative name)
- Status and status category
- Assignee (initiative owner)
- Due date (if set)
- Priority
- Story point total vs. completed (if available via subtask query)
- Labels (look for `blocked`, `at-risk`, `on-hold`)

Also query for child issues to estimate % completion:

```
"Epic Link" = [EPIC_KEY] AND statusCategory = Done
```

vs.

```
"Epic Link" = [EPIC_KEY]
```

Compute: `% done = completed issues / total issues`. Flag if no child issues exist (cannot compute progress).

Do not surface more than 15 epics in a single dashboard — if more exist, ask which to include.

---

## Step 3 — Pull Confluence context

If a Confluence space or page was provided, call `searchConfluence` with:

```
space = "[SPACE_KEY]" AND (title ~ "risk" OR title ~ "decision" OR title ~ "OKR" OR title ~ "programme" OR title ~ "program")
```

Extract:
- **Decisions** — any items logged as decisions (look for "Decision Log", "ADR", or "Decisions Made" sections)
- **Risks** — items in risk registers or risk sections
- **OKRs / strategic goals** — if present, map each initiative to the relevant objective
- **Programme-level notes** — anything the PM or sponsor added in the last 14 days

If no Confluence context is available, proceed without it. Note in the dashboard that Confluence data was not available.

---

## Step 4 — Compute RAG status per initiative

Apply the following rules consistently. Do not assign Green to avoid difficult conversations.

### Green 🟢 — On Track
All of the following are true:
- Status is active (not blocked or on hold)
- Due date is in the future OR no due date set and velocity is positive
- No labels indicating `blocked` or `at-risk`
- % completion is tracking proportionally to elapsed time

### Amber 🟡 — At Risk
Any one of the following:
- Due date is within 14 days with less than 80% completion
- One or more child issues are blocked or assigned to nobody
- The initiative has not had any status change in 14+ days
- A risk is logged in Confluence with no mitigation owner
- Scope creep signals: significantly more open issues than at sprint start

### Red 🔴 — Off Track
Any one of the following:
- Status is explicitly `Blocked` or `On Hold`
- Due date has passed with open issues remaining
- No assignee on the epic itself
- Escalated risk with no resolution path
- The initiative has not moved in 21+ days

If data is insufficient to determine RAG, mark as ⚪ **Unknown** and note what data is missing.

---

## Step 5 — Generate the dashboard

Produce in Markdown (default) or plain text suitable for pasting into Confluence. Ask for format preference if unclear.

```markdown
# Program Health Dashboard — [Program Name]
**Period:** [DATE] | **Audience:** [Steering Committee / PMO / Exec] | **Prepared:** [DATE]

---

## Executive Summary

[2–3 sentences: overall program health, headline achievement this period, and the most critical issue requiring attention. Be honest — do not write "the program is on track" if two initiatives are Red.]

**Overall RAG: 🟢 / 🟡 / 🔴** — [one-line justification]

---

## Initiative Health Overview

| Initiative | Owner | Status | RAG | % Done | Due | Key Blocker / Note |
|---|---|---|---|---|---|---|
| [Epic summary] | [Assignee] | [Status] | 🟢🟡🔴 | [XX%] | [Date] | [Blocker or —] |

---

## Top 3 Risks

| # | Risk Description | Owner | Probability | Impact | Current Mitigation | Status |
|---|---|---|---|---|---|---|
| 1 | | | H/M/L | H/M/L | | 🔴 Open / 🟡 Mitigated / 🟢 Closed |

If no risks are logged: note explicitly — "No risks currently logged. Recommend reviewing at next steering meeting."

---

## Decisions Needed

Items requiring a decision or approval from the program steering group or executive sponsor.

| # | Decision or Approval Needed | Requested by | Needed by | Impact if delayed |
|---|---|---|---|---|

If nothing is pending: "No decisions currently required from steering."

---

## Completed This Period

Key milestones or epics closed since the last dashboard.

- [Initiative name] — [what was completed] — [owner]

---

## Focus Next Period

Top 3 priorities for the next reporting period.

1. [Initiative / action] — [owner] — [target date]
2.
3.

---

*Prepared by [PM name] · [Date] · Program: [Program name]*
```

---

## Step 6 — Quality check before output

Before producing the final dashboard, verify:

- [ ] RAG is applied consistently — no Green rating for initiatives with open blockers
- [ ] "Decisions Needed" section is not empty unless genuinely nothing is pending
- [ ] Executive Summary is 2–3 sentences and would make sense to someone reading only that section
- [ ] % Done is based on actual issue counts, not subjective estimates
- [ ] All Amber and Red initiatives have a named owner
- [ ] No internal developer notes or Jira internal identifiers appear in the stakeholder-facing view (unless audience is the PMO team)

---

## Step 7 — Deliver output and offer next steps

Produce the dashboard.

After the output, offer:

> "Would you like me to:
> - Adjust any RAG rating (override with your context)
> - Add or remove any initiative
> - Export this to a Confluence page directly (if MCP is connected)
> - Generate a one-paragraph executive email summarizing the dashboard for the sponsor?"

---

## Notes for the program manager

- **The Executive Summary is the only section most sponsors read in full.** Make the first sentence the headline — what is the state of the program in plain language?
- **Red does not mean failure.** It means the steering group needs to act. Suppressing a Red rating to avoid an uncomfortable conversation is the most common PMO failure mode.
- **Unknown is better than fabricated Green.** If data is missing, mark Unknown and say what information is needed.
- **"Decisions Needed" is the most actionable section.** If a steering group meeting produces no decisions, it was a status meeting, not a governance meeting.
- This dashboard operates at **portfolio level** — it shows initiative health, not sprint velocity. For sprint-level data, use `consulting-client-status-pack` or `jira-intake`.
