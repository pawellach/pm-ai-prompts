# Sample Output — sprint-retrospective-facilitator

---

## A. Sprint Summary

Sprint 23 (2026-09-01 — 2026-09-12) delivered 34 of 42 planned story points. The sprint goal — completing API v2 integration with the partner portal — was partially achieved: 3 of 5 endpoints were completed, with 2 blocked by late-changing partner documentation. One team member was sick for 3 days, contributing to the velocity gap. This is the third consecutive sprint affected by partner integration delays, which is beginning to impact team morale.

---

## B. Retrospective Findings

### STOP

| # | Item | Raised by | Root cause | Pattern? |
|---|---|---|---|---|
| S1 | Starting integration work before partner API docs are finalized | Piotrek | No API contract validation step in the Definition of Ready | Yes — 3 sprints |
| S2 | Skipping acceptance criteria review in backlog refinement | Anna | Refinement sessions are rushed; QA not present | Recurring |
| S3 | Friday deployments | Rafał | No deployment calendar / policy exists | Recurring |

### START

| # | Item | Raised by | Expected benefit |
|---|---|---|---|
| A1 | 15-minute API contract review before starting any integration ticket | Piotrek | Catch unstable partner docs before work starts; avoid mid-sprint rework |
| A2 | QA involvement in backlog refinement (not just sprint review) | Anna | Acceptance criteria defined before sprint; fewer rework cycles |
| A3 | Track partner delays as a separate metric (not subtracted from team velocity) | Kasia | Accurate team performance picture; supports escalation to management |

### CONTINUE

| # | Item | Raised by | Why it works |
|---|---|---|---|
| C1 | Daily 15-minute sync | Everyone | Keeps integration blockers visible early |
| C2 | Pair-programming for complex integration tickets | Anna | Unblocked payments issue faster than individual work would have |
| C3 | Feature flags for deployments | Rafał | Enabled safe rollback twice this sprint |

---

## C. Themes and Patterns

**Theme 1 — External dependency management (critical):** Three STOP items and one START item connect to the same root: the team has no process for managing risk from unstable external dependencies (partner API). This is not a people problem — it's a process gap. The team has now experienced this for 3 consecutive sprints.

**Theme 2 — QA integration timing:** QA is entering the process too late (sprint review) instead of at backlog refinement. This creates a predictable rework loop that costs 1–2 days per sprint.

**Theme 3 — Deployment policy absent:** No formal policy for deployment timing. Rafał has the right instinct (feature flags help) but the no-Friday-deployment rule needs to be formalized.

---

## D. Improvement Actions

| # | Action | Owner | Due date | Success metric |
|---|---|---|---|---|
| IA-1 | Add "API contract review (15 min)" as a mandatory step in the Definition of Ready for all integration tickets | Kasia | Before Sprint 24 planning | 100% of integration tickets reviewed before sprint start |
| IA-2 | QA (Anna) attends every backlog refinement session | Kasia + Anna | From Sprint 24 | Acceptance criteria present on all tickets before sprint planning |
| IA-3 | No-deployment-on-Friday rule formalized — add to team working agreement | Rafał | Before Sprint 24 | Zero Friday deployments in Sprint 24 |
| IA-4 | Create "External Blockers" tag in Jira; exclude from team velocity; track separately | Kasia | Sprint 24 | Separate metrics for team velocity vs. external-caused delay |
| IA-5 | Escalate partner API instability pattern to Product/Management (3rd sprint) | Kasia | This week | Escalation email sent; response from product/management within 5 days |

---

## E. Team Health Note

Three consecutive sprints with partner delays are a morale risk. The team is delivering well internally (34 points, pair-programming working, feature flags effective) but the external dependency creates the perception of low achievement. **Action IA-5 is the highest-leverage item** — management visibility into the pattern may unlock resources to address the root cause (better partner SLA, dedicated integration environment, or dedicated liaison).

---

*Retrospective: Sprint 23 | Platform Integration Team | 2026-09-12*
