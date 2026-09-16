# Sample Input — sprint-retrospective-facilitator

**Sprint:** Sprint 23
**Sprint dates:** 2026-09-01 — 2026-09-12
**Team:** Platform Integration Team (6 people: 3 backend devs, 1 QA, 1 PM, 1 DevOps)
**Sprint goal:** Complete API v2 integration with partner portal — was it achieved? Partially (3 of 5 endpoints done; 2 blocked by partner documentation)
**Velocity:** 34 / 42 story points completed
**Format:** Start/Stop/Continue

**Team input (from Slack retrospective poll):**

**STOP:**
- Piotrek: Stop starting work without checking if partner API docs are final — we wasted 3 days on endpoint that changed twice
- Anna: Stop skipping the acceptance criteria review in backlog refinement — it caused a 2-day rework cycle on the orders endpoint
- DevOps (Rafał): Stop deploying on Fridays — last Friday's deployment caused a Saturday incident

**START:**
- Piotrek: Start doing a 15-min API contract review before starting any integration ticket
- Anna: Start involving QA in backlog refinement, not just sprint review
- Kasia (PM): Start tracking external blockers (partner delays) separately from our velocity — they're not the same thing

**CONTINUE:**
- Everyone: Continue the daily 15-min sync — it's working
- Anna: Continue the pair-programming sessions Piotrek and Bartek did this sprint — helped unblock the payments issue faster
- Rafał: Continue using feature flags for deployments — saved us twice already

**Additional context from PM:**
Oliwia was sick for 3 days (backend) — affected velocity. Also, Q3 metrics show this is the 3rd consecutive sprint with partner integration delays. The team is starting to feel demotivated by external blockers.
