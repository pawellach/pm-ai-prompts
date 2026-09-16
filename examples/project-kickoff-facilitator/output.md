# Sample Output — project-kickoff-facilitator

# Project Kickoff Plan — AI-Powered Demand Forecasting
**Organization:** NordFood S.A.
**Date:** October 6, 2026 (09:00–13:00)
**Facilitator:** Agnieszka Wieczorek, PM
**Location:** HQ Warsaw, Conference Room Omega + video link

---

## Kickoff Goals

By the end of this session:
1. Every person in the room understands why this project matters, what we're building, and what success looks like
2. Scope boundaries are agreed (what's in MVP vs phase 2)
3. Team ways of working are established (sprint rhythm, escalation, communication)
4. Top 3 risks are named and owned
5. The Head of Supply Chain has spoken, been heard, and has a named role
6. Sprint 1 is planned

---

## Agenda

| Time | Activity | Format | Owner |
|---|---|---|---|
| 09:00–09:10 | Welcome + why we're here | Plenary | CEO (2 min) + PM (8 min) |
| 09:10–09:30 | Project context: the problem we're solving | Data story presentation | PM + Finance |
| 09:30–10:00 | Scope: what are we building? | Facilitated scope review | PM |
| 10:00–10:30 | The data foundation: what do we have? | Working session | IT Director + Data Engineering |
| 10:30–10:45 | **BREAK** | | |
| 10:45–11:15 | Ways of working: how we'll operate | Team exercise | PM |
| 11:15–11:45 | Risks: what could go wrong? | Brainstorm + prioritize | All |
| 11:45–12:15 | Stakeholder commitments: what we need from you | Structured conversation | PM + Sponsors |
| 12:15–12:45 | Sprint 1 planning: what we do first | Backlog walkthrough | PM + Data Scientists |
| 12:45–13:00 | Close + next steps | Plenary | PM |

---

## Section Scripts and Facilitation Notes

### 09:00 — Welcome (CEO, 2 min)

Brief the CEO beforehand:
> "Please open with: why AI forecasting matters for NordFood's competitive position (not just cost reduction). Mention that the Head of Supply Chain's experience is critical to the project's success — not being replaced by it."

This single framing sentence from the CEO will do more for supply chain buy-in than anything the PM can say.

---

### 09:10 — The Problem We're Solving (20 min)

**Story to tell (PM + Finance):**

> "Let's look at what we know. Last year, NordFood discarded €2.8 million in perishable goods that were over-ordered. We also turned away an estimated €1.1 million in sales because we were out of the right products at the wrong time. That's €3.9 million in cost or lost revenue — from forecasting.
>
> Our current forecasting process is based on experience, Excel, and gut feel — and it's been working well enough for 30 years. The question isn't whether the supply chain team is doing a bad job. They're not. The question is: can we give them a better tool?"

Show: current vs target forecast error (22% → <10%). What 10% means in money: estimated €1.5M annual improvement.

**Ask the Head of Supply Chain directly:** *"What would a 10% forecast error rate mean for your team's daily life?"*

This is not a rhetorical question. Wait for his answer. It's the most important input of the kickoff.

---

### 09:30 — Scope Definition (30 min)

**Scope card exercise:** Pre-print 20 feature cards. Team sorts into 3 buckets:

**MVP (Month 1–6):**
- Historical demand data cleaning and consolidation
- ML forecasting model (product category level)
- Forecast accuracy dashboard for supply chain team
- Weekly forecast output → ERP (SAP) integration (read-only first)

**Phase 2 (after MVP):**
- Real-time demand signal integration (promotions, weather, events)
- Automated PO generation from forecast
- Store-level granularity (currently warehouse-level only)

**Out of scope:**
- Customer-facing demand features
- Pricing optimization
- Supplier portal

**Facilitation note:** If scope debate starts — freeze it. Write it on a "parking lot" post-it. Scope decisions go to the PM + CEO only if genuinely unresolved after the session.

---

### 10:00 — Data Foundation (30 min)

The IT Director and Data Engineers lead this. Structure:

1. **What data we have:** ERP order history (3 years clean + 3 years with gaps from migration); warehouse movement data; seasonal sales data
2. **What's usable now:** 3 clean years is enough for an initial model — establish this expectation
3. **What needs work:** Identify the top 3 data quality tasks for Sprint 1
4. **Open question for the group:** "Are there data sources outside ERP that should feed the model?" — e.g., weather API, promotion calendar (ask Marketing)

Output: A whiteboard list of data sources, quality level (green/amber/red), and who owns fixing red items.

---

### 10:45 — Ways of Working (30 min)

**Team exercise — fill in the working agreement:**

| Topic | Agreed approach |
|---|---|
| Sprint length | 2 weeks |
| Sprint ceremony cadence | Planning Mon, Daily standup 9:15, Review + Retro Fri |
| Primary communication channel | Slack #demand-forecasting + Jira |
| Escalation path | PM → CEO (business) / IT Director (technical) |
| Decision authority | PM for scope; IT Director for architecture; PM + Head of Supply Chain for business requirements |
| Documentation | Confluence (auto-linked from Jira) |
| Model versioning | MLflow — every model version tracked |

Ask the team to add anything missing. Agree by show of hands.

---

### 11:15 — Risk Brainstorm (30 min)

**Format:** Each person writes risks on post-its (2 min silent). Read out. Cluster. Vote on top 5.

**Pre-seeded risks (PM to prime the discussion):**
- Data quality gaps from ERP migration
- Head of Supply Chain team doesn't trust AI output
- SAP integration more complex than scoped
- Contractor availability (2 contractors — mid-project risk)
- Model performs well in testing, poorly in production (distribution shift)

For each top risk: agree on **probability**, **impact**, and **owner**.

**Dedicated conversation:** For the supply chain adoption risk — ask the Head of Supply Chain directly:
> *"What would need to be true for your team to trust the AI forecast enough to act on it?"*

Write his answer verbatim on the board. That becomes the acceptance criterion for the model.

---

### 11:45 — Stakeholder Commitments (30 min)

Explicit asks from each stakeholder:

| Stakeholder | Ask | Time commitment | Due |
|---|---|---|---|
| Head of Supply Chain | Join bi-weekly model review; define "good enough" accuracy threshold; provide 5 edge-case scenarios for testing | 2h/month + 1 day data review | Oct 20 for scenarios |
| IT Director | Data access sign-off; SAP integration discovery by Oct 30 | 1 day (SAP discovery) | Oct 30 |
| Finance | Validate overstock/stockout cost model for ROI tracking | Half-day | Oct 20 |
| CEO | Monthly steering review; unblock any cross-functional issues | 1h/month | Monthly |

Ask each stakeholder to verbally confirm. PM records confirmation.

---

### 12:15 — Sprint 1 Planning (30 min)

Sprint 1 goal: *"Establish the data foundation and produce a baseline model."*

| Story | Owner | Points |
|---|---|---|
| Audit ERP order history (3-year clean dataset) | Data Engineer 1 | 5 |
| Define data schema + feature list for model | Data Scientist + BA | 3 |
| Fix top 3 data quality issues (null handling, outliers) | Data Engineer 2 | 8 |
| Baseline ARIMA model on 2 product categories | Data Scientist 1 | 8 |
| Set up MLflow experiment tracking | DevOps | 5 |
| SAP integration discovery (what's possible?) | IT Director + Data Engineer | 5 |
| **Sprint 1 total** | | **34 points** |

---

### 12:45 — Close

PM reads back:
1. Project purpose in one sentence
2. MVP scope (confirmed)
3. Top 3 risks and owners
4. Stakeholder commitments confirmed
5. Sprint 1 goal and start date

Final question to the room: *"Is there anything that wasn't said today that we need to hear before we start?"*

Pause. Wait 10 seconds. If silence — close.

---

## Post-Kickoff Checklist

- [ ] Kickoff notes distributed (same day) — PM
- [ ] Jira Sprint 1 board set up — PM by Oct 7
- [ ] Head of Supply Chain edge-case scenarios requested (email) — PM by Oct 7
- [ ] SAP discovery meeting scheduled — IT Director by Oct 9
- [ ] Working agreement posted to Confluence — PM by Oct 7

---

*Kickoff Plan | AI Demand Forecasting | NordFood S.A. | 2026-10-06*
