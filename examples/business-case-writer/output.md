# Sample Output — business-case-writer

# Business Case — AI-Powered Customer Support Deflection
**Version:** 1.0 DRAFT
**Date:** 2026-09-16
**Sponsor:** Joanna Adamska, VP Product
**Decision needed:** 15 October 2026
**Prepared by:** [PM name]

---

## 1. Executive Summary

**The problem:** NovaSaaS support team handles 9,000 tickets/month at €22/ticket. 62% are tier-1 questions a machine can answer. Current growth trajectory requires 2 new support hires in Q1 at €90,000 fully-loaded cost per head.

**Proposed solution:** Build an AI-powered self-service portal with an intelligent chat layer trained on the company knowledge base. Customers self-serve before reaching an agent.

**Expected outcome at 12 months:** 40% ticket deflection (3,600 tickets/month). Support team handles higher-complexity tickets with same headcount. CSAT maintained above 4.0.

**Investment required:** €180,000 one-time + €40,000/year ongoing.

**Payback period: 11 months. 3-year ROI: 187%.**

**The ask:** Approve €180,000 build budget and €40,000 recurring. Avoid Q1 headcount addition (€180,000 savings over 2 years).

---

## 2. Problem Statement

### Current state
NovaSaaS support receives ~9,000 inbound tickets per month across email and live chat. 18 months of ticket data shows that 62% (5,580 tickets) are tier-1 requests: password resets (18%), billing questions (22%), basic product how-to (22%). These require no specialized knowledge and an average resolution time of 4 minutes.

The 38% tier-2 and above tickets (account issues, product bugs, onboarding blockers, escalations) require experienced agents and average 18 minutes to resolve.

### Quantified cost of the problem

| Metric | Value |
|---|---|
| Monthly ticket volume | 9,000 |
| Tier-1 share | 62% (5,580 tickets) |
| Cost per ticket (fully loaded) | €22 |
| Monthly tier-1 cost | €122,760 |
| Annual tier-1 cost | **€1,473,120** |

Support headcount: 45 agents. Capacity at current volume is at 94%. Two Q1 hires are planned at €90,000 fully-loaded cost per head = **€180,000 additional annual cost**.

### Cost of inaction

| Timeframe | Cost of inaction |
|---|---|
| Q1 2027 | €180,000 headcount addition required |
| 12 months | ~€200k additional hires as volume grows with ARR |
| 36 months | Support cost reaches ~€2.1M/year at current growth rate; CSAT risk if agents are overburdened |

Support headcount growth is not linear to ARR — but at current ARR/agent ratio, NovaSaaS is already adding support cost faster than revenue.

### Strategic alignment
Reducing cost-to-serve while maintaining CSAT is a stated FY2027 priority (OKR: "Reduce support cost per €1k ARR by 20%"). This initiative directly enables that OKR.

---

## 3. Proposed Solution

**High-level description:** Build an AI chat interface embedded in the product and help center, trained on the NovaSaaS knowledge base (documentation, FAQ, past resolved tickets). Customers interact with the AI before reaching an agent. The AI handles tier-1 queries autonomously; escalates to a live agent when it cannot resolve.

**What the solution delivers:**
- 24/7 self-service for tier-1 questions (password reset, billing, how-to)
- Natural language query against knowledge base
- Auto-escalation to agent queue with full context if unresolved
- Deflection reporting dashboard

**What it does NOT include:**
- Voice support
- Agent copilot features (separate initiative, different sponsor)
- Replacement of the human support team

### Options Analysis

| Option | Description | Pros | Cons | Estimated cost | Recommendation |
|---|---|---|---|---|---|
| Do nothing | Continue hiring agents | No change risk | €180k Q1 headcount; growing cost | €180k/year (forever) | ❌ |
| Intercom Fin (SaaS buy) | Third-party AI chat | Fast to deploy (6 weeks) | €60k/year, limited customization, vendor lock-in, avg 35% deflection ceiling | €60k/year | ⚠️ Consider if build fails |
| **Build in-house AI chat** | Train on company KB using LLM API | Customizable, scalable, no per-seat SaaS cost | 4-month build, higher upfront | €180k one-time + €40k/year | ✅ **Recommended** |

**Why build over buy:** At 3-year horizon, Intercom Fin = €180,000 in SaaS fees with no asset built. In-house build creates a product asset. Breakeven vs Intercom Fin: 3 years.

---

## 4. Financial Analysis

### 4.1 Investment Summary

| Cost category | One-time | Year 1 ongoing | Year 2 ongoing | Year 3 ongoing |
|---|---|---|---|---|
| Development (in-house + contractor) | €120,000 | — | — | — |
| LLM API costs (OpenAI/Anthropic) | — | €18,000 | €22,000 | €26,000 |
| Infrastructure (hosting, monitoring) | €15,000 | €8,000 | €8,000 | €8,000 |
| Knowledge base maintenance | — | €10,000 | €10,000 | €10,000 |
| Training + change management | €25,000 | €4,000 | €2,000 | €2,000 |
| Contingency (15%) | €20,000 | — | — | — |
| **Total** | **€180,000** | **€40,000** | **€42,000** | **€46,000** |

### 4.2 Expected Benefits

| Benefit | Type | Year 1 | Year 2 | Year 3 | Confidence | Source |
|---|---|---|---|---|---|---|
| Avoided ticket handling cost (40% deflection) | Cost reduction | €588,000 | €720,000 | €864,000 | Medium | Ticket cost model × 40% deflection |
| Avoided Q1 headcount | Cost avoidance | €180,000 | €180,000 | €180,000 | High | HR cost model |
| CSAT improvement (tier-2 agents less rushed) | Revenue protection | ~€50,000 | ~€70,000 | ~€90,000 | Low | Estimated 0.5% churn reduction |
| **Total benefits** | | **€818,000** | **€970,000** | **€1,134,000** | | |

*Year 1 reflects 6-month ramp (live from month 7). Year 2–3 at full 40% deflection.*

### 4.3 ROI Summary

| Metric | Value |
|---|---|
| Total investment (3-year) | €308,000 |
| Total benefits (3-year) | €2,922,000 |
| Net benefit (3-year) | **€2,614,000** |
| ROI (3-year) | **848%** |
| Payback period | **11 months** |
| Break-even point | Month 11 post-launch |

*Deflection benefit is the dominant driver. Even at 25% deflection (conservative), payback is 18 months and 3-year ROI remains positive.*

### 4.4 Sensitivity Analysis

| Scenario | Assumption | Impact on 3-year ROI | Still positive? |
|---|---|---|---|
| Conservative | 25% deflection (not 40%); €22 cost constant | ROI 420% / Payback 18 months | ✅ Yes |
| Base | 40% deflection as modelled | ROI 848% / Payback 11 months | ✅ Yes |
| Optimistic | 50% deflection; CSAT improves 0.3 → lower churn | ROI 1,100%+ | ✅ Yes |
| Bear case | 15% deflection; LLM costs 2× estimate | ROI 120% / Payback 28 months | ✅ Marginal |

**At any deflection rate above 12%, the investment pays back within 36 months.** This is the break-even condition.

---

## 5. Risk Register

| # | Risk | Category | Prob. | Impact | Score | Mitigation |
|---|---|---|---|---|---|---|
| R1 | AI gives wrong answers → customer frustration, CSAT drop | Technical | Medium | High | 9 | Extensive pre-launch testing; confidence threshold for escalation; human review of first 500 interactions |
| R2 | Knowledge base quality too poor to train effectively | Technical | Medium | High | 9 | KB audit before build; dedicated KB owner in scope |
| R3 | Low customer adoption of self-service | Organizational | Low | High | 6 | UX investment; A/B test portal placement; onboarding email campaign |
| R4 | LLM API cost spikes if volume > estimate | Financial | Low | Medium | 4 | Cost cap + fallback to FAQ search if API cost threshold exceeded |
| R5 | Key developer leaves during build | Organizational | Low | High | 6 | Contractor backup identified; documentation requirement in sprint |

---

## 6. Implementation Overview

**Phase 1 — Foundation (Weeks 1–4):** KB audit and enrichment, data pipeline from support ticket history, LLM API selection and POC.

**Phase 2 — Build (Weeks 5–12):** Chat UI, integration with product login, escalation routing to Zendesk, admin dashboard.

**Phase 3 — Pilot (Weeks 13–16):** Soft launch to 10% of users, CSAT monitoring, model refinement.

**Phase 4 — Full launch (Week 17+):** 100% rollout, deflection reporting live, headcount freeze confirmed.

**Key milestones:**
- Week 4: KB ready, LLM POC validates deflection rate
- Week 12: Beta ready for pilot
- Week 16: Pilot results confirm 35%+ deflection → go/no-go for full launch
- Week 17+: Full launch

**Business resource required:**
- 1 Support team lead: 30% time for 4 months (KB quality, UAT, escalation flow design)
- VP Product: steering decisions at Week 4 and 12 milestones

---

## 7. The Ask

| Item | Detail |
|---|---|
| **Budget requested** | €180,000 one-time + €40,000/year from Year 1 |
| **Business resources** | 1 support lead at 30% time for 4 months |
| **Decision required by** | 15 October 2026 |
| **What happens next (if approved)** | Kick off Week 1: KB audit + vendor selection. First milestone review at end of October. |
| **What happens next (if deferred)** | Q1 headcount addition proceeds (€180,000). Opportunity cost grows as ARR and volume scale. |

---

## 8. Assumptions and Constraints

| # | Type | Description | Impact if wrong |
|---|---|---|---|
| A1 | Assumption | 40% deflection rate achievable — based on Intercom Fin benchmarks (35–45%) | Lower deflection → longer payback; see sensitivity |
| A2 | Assumption | Knowledge base can be enriched in 4 weeks with 1 support lead at 30% | Delay → build start pushed; add 2 weeks contingency |
| A3 | Assumption | LLM API latency acceptable for real-time chat (< 2s) | Re-architecture required; +4 weeks risk |
| C1 | Constraint | GDPR — no customer PII sent to LLM API; only anonymized KB content | Must be designed in from day 1; legal review required |
| C2 | Constraint | Launch window: Q2 2027 (avoid Q4 holiday freeze and Q1 headcount decision) | Fixed by headcount timing |

---

*Business Case v1.0 | NovaSaaS | 2026-09-16 | Prepared for CFO + CEO decision meeting 15 October 2026*
