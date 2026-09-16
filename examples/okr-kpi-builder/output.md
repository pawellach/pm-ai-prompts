# Sample Output — okr-kpi-builder

# Q4 2026 OKRs — Data Platform Team
**Team:** Data Platform | GrowthBase
**Period:** October–December 2026
**Owner:** [PM name]
**Version:** 1.0

---

## Alignment: Company OKR → Team OKRs

| Company OKR | Data Platform contribution |
|---|---|
| "Become the most trusted data platform for our customers" | Data reliability = 0 stale dashboard incidents; self-service adoption means customers trust the data themselves |

---

## OKR 1 — Data Reliability

**Objective:** Our data pipelines are reliable enough that customers never have to wonder if their dashboard is up to date.

| Key Result | Baseline | Q4 Target | How measured |
|---|---|---|---|
| KR1.1: Daily pipeline failure rate | 8% | ≤ 1% | Datadog alerts; weekly pipeline report |
| KR1.2: Dashboard freshness SLA compliance | 73% | ≥ 95% | % of dashboards refreshed within SLA window |
| KR1.3: Mean Time to Recovery (MTTR) for pipeline failures | Unknown (establish baseline) | < 30 minutes | Incident log |
| KR1.4: Customer-reported stale data incidents | ~3×/week | 0 per month by Dec 31 | Support ticket category "stale data" |

**Why this matters:** KR1.4 is the direct customer signal — if internal metrics improve but customers still complain, we haven't actually delivered. KR1.3 establishes a baseline for a metric we've never measured.

---

## OKR 2 — Time to Insight

**Objective:** An analyst or business user can get from a question to an answer in hours, not days.

| Key Result | Baseline | Q4 Target | How measured |
|---|---|---|---|
| KR2.1: Analyst ticket queue time (avg fulfillment) | 4.5 days | ≤ 1.5 days | Jira ticket cycle time |
| KR2.2: Time for new analyst to produce first meaningful query | Not measured | < 2 days (establish process and measure) | Onboarding log (next new hire) |
| KR2.3: Data documentation coverage | ~20% of datasets (estimated) | 60% of core datasets documented in data catalog | Catalog coverage report |

**Why this matters:** KR2.3 (documentation) is the enabler for KR2.1 and self-service. Without it, every analyst starts from zero. Documentation is boring but this is the quarter to invest in it.

---

## OKR 3 — Self-Service Reporting

**Objective:** Business users can answer their own standard questions without waiting for an analyst.

| Key Result | Baseline | Q4 Target | How measured |
|---|---|---|---|
| KR3.1: % of standard reports accessed without analyst assistance | 12% | 40% | BI tool access log (analyst-assisted vs self-initiated sessions) |
| KR3.2: Self-service report library size | 8 reports | 25 reports | Count of published self-service reports |
| KR3.3: Business user satisfaction with self-service (survey) | No baseline | ≥ 3.5 / 5 | End-of-quarter pulse survey (n ≥ 20) |
| KR3.4: Analyst ticket volume (demand reduction) | 45 tickets/month | 30 tickets/month | Jira |

**Why KR3.1 target is 40%, not 80%:** 80% was the aspirational goal, but getting from 12% → 40% in one quarter requires both building the reports (KR3.2) AND training business users AND changing their habits. 40% is ambitious and achievable. 80% is Q1 2027.

---

## Supporting KPIs (Health Metrics — Not OKR Targets)

These are tracked weekly but are not OKR targets this quarter. Decline in any of these triggers a conversation.

| KPI | Current | Watch threshold | Owner |
|---|---|---|---|
| Pipeline jobs total | ~480/day | — | Data Engineering |
| Spark 2.x pipeline share | 100% | N/A (migration starts Q1) | DevOps |
| Data governance tasks contributed | 0 | Track from Oct | PM |
| Team morale (1-5 pulse) | Not tracked | < 3.5 = action | PM |
| On-call incidents per week | ~3 | > 5 = escalate | Data Engineering |

---

## OKR Scoring Guide

| Score | Meaning |
|---|---|
| 0.7–1.0 | Exceptional — stretch achieved |
| 0.5–0.7 | Good progress — most key results moving |
| 0.3–0.5 | Learning quarter — significant blockers encountered |
| < 0.3 | Reset required — OKR was wrong or blocking issue not addressed |

**Ambition calibration:** OKRs are set to be hard. 0.7 is success. Scoring 1.0 on all KRs means the targets were too easy.

---

## Dependencies and Risks

| Item | Impact | Mitigation |
|---|---|---|
| Data governance initiative (parallel) | Takes ~20% of team time; may compress reliability work | Negotiate contribution scope before October 15 |
| Spark 2.x EOL migration (Q1) | Prep work may start bleeding into Q4 | Limit Q4 prep to planning only; no migration changes to prod |
| No new headcount | KR3.2 (25 reports) is ambitious with 8 people; documentation + reliability work compete for time | Prioritize reliability (OKR1) first; self-service (OKR3) is secondary if capacity is tight |

---

## Q4 Milestones

| Month | Focus | Key milestone |
|---|---|---|
| October | Reliability foundation | Pipeline failure rate < 3% by Oct 31; monitoring dashboards live |
| November | Self-service launch | 15 self-service reports published; analyst queue < 2.5 days |
| December | Close the loop | Full Q4 targets; MTTR baseline established; governance contribution delivered |

---

*OKRs Q4 2026 | Data Platform Team | GrowthBase | Version 1.0 | 2026-09-16*
*Review: Weekly KR check-in every Monday; OKR mid-point review October 31.*
