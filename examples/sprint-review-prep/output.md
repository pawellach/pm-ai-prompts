# Sample Output — sprint-review-prep

# Sprint 18 Review — Preparation Pack
**Date:** 2026-09-15
**Team:** Product Team (B2B SaaS)
**Attendees:** CPO, 2 enterprise customers (Nexco, Orbis), product team, Sales

---

## 1. Opening (2 min) — PM

**Sprint goal:** "Complete Customer Portal redesign and ship API v2 foundation"
**Outcome:** Goal partially achieved — portal redesign delivered in full; API v2 foundation delivered; API v2 documentation carried to Sprint 19.

| | Planned | Delivered |
|---|---|---|
| Story points | 44 | 38 (86%) |
| Stories | 8 | 7 |
| Bugs (in-sprint) | — | 3 found, 3 fixed |
| Tech debt | — | 2 items addressed |
| Carried over | — | 1 story (API docs) |

---

## 2. Demos (20 min total)

### Demo 1 — Customer Portal redesign (12 min)
*Presenter: Lead Designer / PM | Audience: All*

**Context to set before demo:**
> "Over the last two sprints, our customers — including people in this call — told us the portal felt cluttered and that notifications were unreliable. Here's what we built."

**Demo script:**

| Step | What to show | Talking point |
|---|---|---|
| 1 | New dashboard (before/after comparison) | "Cleaner layout; most-used sections now front and center. 3 clicks reduced to 1 for common tasks." |
| 2 | New navigation menu | "Restructured based on actual usage data — most-visited pages moved to top-level." |
| 3 | Notification center | "Real-time notifications, filterable by type. **Janusz — this was built directly from your feedback.** Mark as read, clear all, deep-link to the relevant item." |
| 4 | Mobile view | "Same experience on a phone. No separate mobile version to maintain — one codebase." |
| 5 | Critical bug fix | "Briefly: accounts with 500+ users weren't loading notifications at all. This was silently broken. It's fixed." |

**Expected questions:**
- *Can I customize the dashboard widgets?* → "Not in this release — it's on the roadmap for Q4."
- *When does this go live?* → "Staging now, production release October 1."

---

### Demo 2 — API v2 foundation (8 min)
*Presenter: Backend Lead | Audience: Janusz (Nexco), CPO, developers*

*Note: Maria (Orbis, non-technical) — introduce this section as "For those who build integrations with our platform." Maria doesn't need to engage here.*

**Context:**
> "API v2 is the new integration layer we're building for partners and technical customers. Sprint 18 delivered the foundation — authentication and rate limiting."

**Demo script:**

| Step | What to show | Talking point |
|---|---|---|
| 1 | New auth endpoint (Postman or docs) | "OAuth2, standard flow. Your dev team should find it familiar." |
| 2 | Rate limiting in action | "429 response with Retry-After header. Clean degradation, no silent failures." |
| 3 | Versioning header | "All v2 calls use `API-Version: 2026-09` — you won't be surprised by breaking changes." |

**Janusz-specific note:** If he asks about specific endpoints his team needs — take note for backlog. Don't commit in the meeting.

---

## 3. What Didn't Ship (2 min)

**API v2 Documentation** — 1 story carried to Sprint 19.

**Framing:**
> "Documentation for API v2 was scoped for this sprint but one of our developers was out sick the last 3 days. We're carrying it to Sprint 19 and it will be ready before any customer starts integrating. It won't block Janusz's team."

---

## 4. What's Coming Next (3 min) — CPO

Sprint 19 highlights for customers:
- API v2 documentation published (+ interactive sandbox)
- First batch of Customer Portal performance improvements (load time)
- Start of Data Export feature (Nexco requested)

→ Ask: *"Any priorities we should re-evaluate based on what you've seen today?"*

---

## 5. Q&A and Feedback (5 min)

**Questions to ask customers explicitly:**
- Janusz: "Does the notification center cover your team's use case, or is anything missing?"
- Maria: "Is the new portal layout matching what your team expects?"
- CPO: "Any gaps between what we shipped and what you needed from this sprint?"

---

## 6. After the Meeting — Checklist

- [ ] Share recording with attendees (if recorded)
- [ ] Log Janusz's API v2 endpoint requests in backlog
- [ ] Send Maria a follow-up with go-live date for portal redesign
- [ ] Confirm Marcin (Sales) has staging access for demo use
- [ ] Update sprint velocity chart in team dashboard
- [ ] Retrospective: tomorrow, same team

---

*Sprint 18 Review Prep | 2026-09-15 | Total meeting time: 45 minutes*
