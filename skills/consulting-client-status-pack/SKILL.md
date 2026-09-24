---
name: consulting-client-status-pack
description: |
  Generates a weekly client status pack for a consulting engagement. Use when — (1) user writes `/consulting-client-status-pack` or `/status-pack`, (2) user says "prepare client status", "prepare weekly pack", "generate status report for client", "zrób pack statusowy". Reads Jira project data via MCP and/or raw meeting notes, then produces a polished HTML or Markdown status pack ready to send or paste. Do NOT use for internal project retrospectives or internal team standups.
---

# consulting-client-status-pack — Weekly Client Status Pack

Role: Delivery Manager / Project Manager / Consulting Engagement Manager.

Produces a professional, client-ready weekly status pack combining Jira progress data and meeting notes.

---

## Step 0 — Check inputs and MCP

### 0a. Determine what inputs are available

Ask the user:

> "To generate the status pack I need two things:
> 1. **Jira project data** — I can pull this automatically if you have the Atlassian MCP connected. What is the Jira project key?
> 2. **Notes from this week** — paste any meeting notes, decisions, or context that should appear in the pack (or type 'none' if the Jira data is enough).
>
> If MCP is not available, paste a summary of what was completed this week, what is in progress, and what is blocked."

### 0b. Check Atlassian MCP availability

Call `atlassianUserInfo`. If unavailable:

```
Atlassian MCP plugin is not active. To use consulting-client-status-pack with live Jira data:

1. Open Claude Code → Settings (⚙) → Plugins
2. Enable: "Atlassian" (official plugin)
3. Sign in with your Atlassian account
4. Restart Claude Code
5. Run /consulting-client-status-pack again

To continue without live Jira data: paste a summary of this week's completed items, in-progress items, blockers, and decisions.
```

If MCP is unavailable but the user provides text input, proceed with that — do not stop.

---

## Step 1 — Gather engagement context

If this is the first time running for this project, ask:

- Client name (can be anonymized as "[Client]")
- Project name and brief description
- Reporting period (week of [DATE])
- What "RAG status" scale to use? (Red / Amber / Green — or 🔴🟡🟢 if HTML output)
- Is there a budget/financial section to include?
- Is there a section for upcoming week's focus?
- Any topics that are sensitive and should NOT appear in the client-facing pack?

If the user has provided this before in the same session, skip this step.

---

## Step 2 — Pull Jira data (if MCP available)

Call `searchJiraIssuesUsingJql` with:

```
project = [PROJECT_KEY] 
AND updated >= -7d 
ORDER BY updated DESC
```

Then call separately for:
- **Completed this week:** `status changed to "Done" after -7d`
- **In progress:** `status = "In Progress" AND updated >= -14d`
- **Blocked / At risk:** `labels = "blocked" OR priority = "Highest" OR status = "Blocked"`
- **Upcoming milestones:** `due >= now() AND due <= 30d AND type = Epic`

For each issue collected, extract: key, summary, status, assignee, due date, priority.

Do not surface more than 15 items per section — filter to the most relevant by recency and priority.

---

## Step 3 — Process meeting notes

If the user provided meeting notes, extract:
- **Decisions made** (anything phrased as "we agreed", "decision:", "approved", "decided")
- **Actions and owners** (anything with a person's name and a verb, or "[ACTION]")
- **Risks or blockers mentioned** (anything prefaced with "risk", "concern", "blocker", "issue", "problem")
- **Topics for escalation** (anything the user flagged as "needs client input", "pending approval", "waiting on client")

Do not invent decisions or actions not present in the input.

---

## Step 4 — Determine output format

Ask or infer from context:
- **HTML** (default for email delivery — clean, styled, no code visible to client)
- **Markdown** (default for Confluence, Notion, or chat delivery)

If in doubt, default to HTML.

---

## Step 5 — Generate the status pack

### If HTML output: produce a complete, self-contained HTML file

Use inline CSS only (no external dependencies). Design requirements:
- Clean, professional appearance suitable for client delivery
- Symfonia / consulting neutral color scheme (white background, dark text, accent in deep blue or slate)
- Mobile-readable (single-column, max-width 700px)
- RAG status as colored badges (🔴 = `#e53e3e`, 🟡 = `#d69e2e`, 🟢 = `#38a169`)
- Printable (avoid backgrounds that waste ink)

**HTML structure:**

```html
<!-- Subject line suggestion at top (hidden on print) -->
<!-- Engagement header with client name, project name, period, overall RAG -->
<!-- Section 1: Executive Summary (2–4 sentences, overall health) -->
<!-- Section 2: Progress This Week (completed items + brief annotation) -->
<!-- Section 3: In Progress (what's active, expected completion) -->
<!-- Section 4: Decisions Made This Week (from meeting notes) -->
<!-- Section 5: Risks & Issues (current, with owner and mitigation) -->
<!-- Section 6: Needs From Client (actions or approvals pending from client side) -->
<!-- Section 7: Upcoming This Week (next 7 days focus) -->
<!-- Section 8: Financials (if applicable, redact if sensitive) -->
<!-- Footer: prepared by, date, confidentiality notice -->
```

### If Markdown output: use this structure

```markdown
# Weekly Status Pack — [Project Name]
**Client:** [Name] | **Period:** [DATE] – [DATE] | **Status:** 🟢 On Track

---

## Summary
[2–4 sentence narrative of overall engagement health]

## ✅ Completed This Week
| Item | Notes |
|---|---|

## 🔄 In Progress
| Item | Owner | Target |
|---|---|---|

## 📋 Decisions Made
- [Decision] — [Date]

## ⚠️ Risks & Issues
| # | Description | Owner | Mitigation | Status |
|---|---|---|---|---|

## 🔴 Needs From Client
| # | Item | Needed by |
|---|---|---|

## 📅 Focus Next Week
- [Item]

---
*Prepared by [Consultant Name] · [Date] · Confidential*
```

---

## Step 6 — Quality check before output

Before producing the final pack, verify:
- [ ] Overall RAG status is justified by the content (do not mark Green if there are open blockers)
- [ ] "Needs From Client" section is not empty unless truly nothing is pending
- [ ] No internal team information appears that the client should not see
- [ ] Decisions section cites only decisions confirmed in the notes, not inferred ones
- [ ] No sensitive financial or personnel information appears without user confirmation

---

## Step 7 — Deliver output

Produce the status pack.

After the output, ask:
> "Would you like me to adjust the RAG status, add or remove any section, or change the wording on any item before you send it?"

If the user confirms it is ready, optionally offer:
> "Should I save this as a file? (e.g. `status-pack-[CLIENT]-[DATE].html`)"

---

## Notes for the presenter

- The **Executive Summary** is the only section most senior clients will read. Make it count.
- **Needs From Client** is the most actionable section. Never leave it empty if there are pending approvals.
- **Red status** does not mean the project is failing — it means there is a problem that the client needs to help resolve. Be honest.
- Strip all Jira internal IDs and assignee usernames before sending to clients unless the client also uses Jira and would recognize them.
