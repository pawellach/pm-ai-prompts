---
name: stakeholder-update-generator
description: |
  Generates audience-calibrated project updates from Jira data and/or a commit log. Use when — (1) user writes `/stakeholder-update-generator` or `/stakeholder-update`, (2) user says "generate update for exec", "write team update", "prepare client update", "zrób update dla stakeholderów", "napisz raport dla sponsora". Reads Jira issues and/or raw git log, then generates 2–3 audience-specific versions (exec / team / client) with calibrated depth, tone, and length. Do NOT use for full project status packs — use `consulting-client-status-pack` for those. This skill is for fast, targeted updates, not weekly reports.
---

# stakeholder-update-generator — Audience-Calibrated Project Updates

Role: PM / Delivery Lead / Tech Lead / Scrum Master.

Takes raw project data (Jira sprint, commit log, or paste) and produces ready-to-send updates for different audiences. Each audience version has a different tone, depth, and format — executives get 3 sentences and a RAG status; the team gets a bulleted list with context; the client gets a professional, no-jargon narrative.

---

## Step 0 — Gather inputs

Ask the user:

> "To generate stakeholder updates I need:
> 1. **Project or sprint scope** — Jira project key, sprint name, or paste a summary of what happened this week.
> 2. **Commit log** (optional) — paste the output of `git log --oneline -20` or similar if you want technical changes included.
> 3. **Which audiences?** Choose from: Exec/Sponsor · Team/Dev · Client/External · All three
> 4. **Any context not in Jira or git** — decisions made, blockers cleared, changes in scope, team changes.
> 5. **Tone preference** — should the exec update be formal (board-level) or internal (casual senior leadership)?

If the user says 'all', generate all three. If a specific audience is named, generate only that one.

---

## Step 1 — Pull Jira data (if MCP available)

Call `atlassianUserInfo` to check availability.

If MCP available, pull with `searchJiraIssuesUsingJql`:

**Progress this period:**
```
project = [PROJECT_KEY] AND updated >= -7d ORDER BY updated DESC
```

**Completed:**
```
project = [PROJECT_KEY] AND status changed to "Done" after -7d
```

**Blocked or at risk:**
```
project = [PROJECT_KEY] AND (labels = "blocked" OR priority = "Highest") AND status != "Done"
```

Extract per issue: key, summary, status, assignee, epic, priority, any blocker comments.

If MCP unavailable, proceed with user-provided text.

---

## Step 2 — Parse commit log (if provided)

From the raw `git log` output:

- Identify commit types: feat / fix / refactor / chore / docs / test (from conventional commits or inferred)
- Group by feature/component if prefix pattern is visible
- Filter out merge commits, bumps, and housekeeping unless they're significant
- Map commits to Jira keys if present in commit messages (e.g. `SAL-1234`)

Do NOT surface individual commit hashes to non-technical audiences.

---

## Step 3 — Determine update content

Before writing, synthesize:

**What happened this period?**
- Features/stories completed (business-meaningful phrasing)
- Bugs fixed (user-visible impact, not code location)
- Blockers resolved
- New blockers or risks

**What is in progress?**
- Active work and expected completion
- Dependencies being waited on

**What needs attention?**
- Decisions needed from stakeholders
- Risks that could affect timeline or scope
- Scope changes proposed or accepted

---

## Step 4 — Generate audience versions

### Version A: Executive / Sponsor Update

**Audience:** C-suite, VP, project sponsor, steering committee.

**Rules:**
- Max 150 words total (they read email on mobile)
- Lead with overall RAG status (🟢 On Track / 🟡 At Risk / 🔴 Off Track)
- One sentence per theme: what's done, what's next, what needs them
- No technical terms, Jira keys, or commit hashes
- "We" framing — team language, not "the developers"
- End with one specific ask (decision, approval, or information) — or explicitly state "no action needed"

**Format:**
```
[RAG badge] PROJECT NAME — Week of [DATE]

[2–3 sentences: this week's headline progress]

[1 sentence: what's coming next]

[1 sentence: what we need from you — OR "No action needed this week."]
```

---

### Version B: Team / Internal Update

**Audience:** Engineering team, scrum team, internal delivery team.

**Rules:**
- Conversational but informative
- Bullet points, not paragraphs
- Include Jira keys (team uses them)
- Call out individuals' work (with attribution) when relevant
- Be honest about blockers and carryover — the team knows anyway
- End with "this week's focus" as a brief list

**Format:**
```markdown
## Team Update — [Sprint/Period Name]

**Shipped this week:**
- [JIRA-123] [Feature/fix summary] (owner: @name)
- ...

**In progress:**
- [JIRA-456] [Summary] — target: [date/sprint end] (owner: @name)
- ...

**Blocked / needs attention:**
- [JIRA-789] Blocked by [X]. [Who is resolving / what's the plan]

**This week's focus:**
- [Item 1]
- [Item 2]

[Optional: 1 sentence of team recognition or context]
```

---

### Version C: Client / External Update

**Audience:** External client, partner, customer-facing stakeholder.

**Rules:**
- Professional, clear, no internal jargon
- Do NOT include internal ticket keys unless the client also uses Jira and would recognize them
- Do NOT include assignee names unless the client knows the team
- Frame everything in terms of business value and outcomes, not technical tasks
- Acknowledge problems honestly but with mitigation framing
- End with "what we need from you" if anything is pending

**Format:**
```markdown
## Project Update — [Project Name]
**Period:** [DATE] – [DATE] | **Status:** [On Track / At Risk / Off Track]

### Summary
[2–3 sentences: where we are overall, business-language]

### Completed This Week
- [Business-readable description of what was delivered]
- ...

### In Progress
| Item | Expected completion |
|---|---|
| [Description] | [Date] |

### Issues & Risks
| Description | Mitigation | Status |
|---|---|---|
| [Risk/Issue] | [What we're doing] | [Open/Resolved] |

### What We Need From You
| Item | Needed by | Owner |
|---|---|---|
| [Decision / info / approval] | [Date] | [Client contact] |

*— [Your name], [Date]*
```

---

## Step 5 — Quality check before output

For each version:
- [ ] Executive: under 150 words, leads with RAG, ends with clear ask or explicit "no action needed"
- [ ] Team: includes Jira keys, carryover flagged, blockers named honestly
- [ ] Client: no internal jargon, ticket keys, or unfiltered technical language
- [ ] All versions: do not contradict each other on project status
- [ ] All versions: risks are present (do not omit issues to look good)

---

## Step 6 — Deliver and offer refinements

Output all requested versions.

Then ask:
> "Would you like me to adjust any version? Common tweaks:
> - Change the RAG status with a different justification
> - Shorten or lengthen the executive version
> - Add or remove specific items from the client update
> - Format as an email with subject line"

---

## Notes

- **One source of truth, three voices.** The underlying facts should be consistent — only the vocabulary, depth, and framing differ across versions.
- **Clients and executives often get the same update with different wording.** If both are requested, check for contradictions before sending.
- **The "needs from you" section is the most important.** Every update should have either a specific ask or explicit confirmation that nothing is needed. Ambiguous updates cause stakeholders to wait.
- **Negative news travels fast.** If there is a risk or delay, name it in all versions with the mitigation plan. Stakeholders who discover bad news without having been told feel betrayed, not surprised.
