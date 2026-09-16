# Sample Output — executive-status-report

# Digital Transformation Programme — Executive Status Report
**Period:** September 2026 | Month 4 of 12
**Prepared by:** Programme Manager
**Distribution:** CEO, CFO, CTO, Board Observer

---

## Overall Programme Status: 🟡 AMBER

The programme is executing on budget across all workstreams. The Data Platform workstream is on track and performing well. However, CRM Transformation has slipped 3 weeks on a critical milestone, and Process Automation is approaching a budget overrun. **Two decisions are required from the steering committee this month** (see Section 4).

---

## 1. Workstream Dashboard

| Workstream | Schedule | Budget | Quality | Overall | Key message |
|---|---|---|---|---|---|
| CRM Transformation | 🔴 Red | 🟢 Green | 🟡 Amber | 🔴 **Red** | 3-week milestone slip; go-live risk if not addressed |
| Data Platform | 🟢 Green | 🟢 Green | 🟢 Green | 🟢 **Green** | On track; 3/7 departments onboarded |
| Process Automation | 🟡 Amber | 🔴 Red | 🟢 Green | 🟡 **Amber** | HR bot delayed; budget overrun risk |

---

## 2. Workstream Details

### 2.1 CRM Transformation — 🔴 Red

**Budget:** €480k spent / €1,200k total (40% consumed, on budget)
**Timeline:** 🔴 3-week milestone delay

| Milestone | Planned | Latest estimate | Variance |
|---|---|---|---|
| Data migration design doc sign-off | 30 Sep 2026 | 21 Oct 2026 | **-3 weeks** |
| Go-live (projected impact if no recovery) | April 2027 | May 2027 | **At risk** |

**Root cause:** Salesforce implementation partner required 6 weeks to produce field mapping templates — original scope assumed 2 weeks. Delay was not flagged until week 5.

**Impact:** The project has zero schedule buffer remaining after the data migration phase. Any further delay to the Oct 21 milestone will directly push go-live from April to May.

**Recovery options (decision required — see Section 4):**
- Option A: Add a 2-week buffer → push go-live to late April (low risk)
- Option B: Compress UAT from 6 to 4 weeks → maintain April go-live (higher quality risk)

---

### 2.2 Data Platform — 🟢 Green

**Budget:** €180k spent / €400k total (45% consumed, on track)
**Timeline:** 🟢 On schedule

3 of 7 departments onboarded (Finance, Sales, Operations). Power BI dashboards live. Azure infrastructure performing within cost projections.

No issues. Next milestone: HR and Marketing onboarding by end of October.

---

### 2.3 Process Automation — 🟡 Amber

**Budget:** €220k spent / €280k total (79% consumed — ⚠️ at risk of overrun)
**Timeline:** 🟡 HR bot delayed 4 weeks

| Bot | Status | Notes |
|---|---|---|
| Finance — invoice processing | ✅ Live | Running; processing ~800 invoices/week |
| Finance — expense approval | ✅ Live | Running; average approval time reduced 70% |
| HR — onboarding automation | 🔴 Delayed | IT security review added 3 approval steps not in original plan |

**Root cause of HR delay:** IT security review scope was underestimated. The added steps are legitimate (RPA accessing HR data requires additional access controls) but were not factored into the original estimate.

**Budget risk:** HR bot consumed 30% more dev hours than estimated. At current burn rate, the workstream will exhaust the €280k budget before HR bot is fully deployed. Contingency of €25k is required to complete without descoping.

---

## 3. Risk Register (Top 3)

| # | Risk | Status | Impact | Action |
|---|---|---|---|---|
| R1 | CRM go-live slips to May due to migration delay | 🔴 Active | High — 60% of programme value in CRM | Steering committee decision required this week |
| R2 | Process Automation budget overrun | 🔴 Active | Medium — €25k; programme contingency available | Approve contingency or descope HR payroll notifications |
| R3 | Partner (Salesforce SI) quality of delivery | 🟡 Monitoring | High — CRM depends entirely on partner | Performance review meeting scheduled Oct 1; SLA discussion |

---

## 4. Decisions Required

### Decision 1 — CRM Schedule Recovery (Due: 30 September 2026)

**Context:** Data migration design doc is 3 weeks late. No buffer remains in the schedule.

**Options:**

| Option | Impact on Go-live | Quality Risk | Recommendation |
|---|---|---|---|
| A: Add 2-week buffer | Late April (2 weeks later) | Low | ✅ Recommended |
| B: Compress UAT 6→4 weeks | April (on time) | High — UAT is the last quality gate | Not recommended |

**Programme manager recommends Option A.** The 2-week slip is recoverable and preserves UAT quality. Compressing UAT on a CRM migration of this size risks go-live defects that would cost significantly more than 2 weeks.

---

### Decision 2 — Process Automation Budget Contingency (Due: 15 October 2026)

**Context:** HR bot overran by ~€25k due to IT security review additions.

**Options:**

| Option | Budget impact | Scope impact |
|---|---|---|
| A: Approve €25k contingency | +€25k (within programme contingency reserve) | Full scope delivered | ✅ Recommended |
| B: Descope payroll notifications | No additional budget | HR bot delivered without automated payroll notifications feature |

**Programme manager recommends Option A.** The payroll notifications feature was committed to HR leadership as part of the scope. Descoping now would reduce confidence in the programme and the remaining HR bot deliverables.

---

## 5. Programme Financials

| Workstream | Budget | Spent to date | Remaining | Forecast at completion | Variance |
|---|---|---|---|---|---|
| CRM Transformation | €1,200k | €480k (40%) | €720k | €1,200k | 🟢 On budget |
| Data Platform | €400k | €180k (45%) | €220k | €400k | 🟢 On budget |
| Process Automation | €280k | €220k (79%) | €60k | €305k (+€25k) | 🔴 Overrun risk |
| Programme management | €120k | €44k (37%) | €76k | €120k | 🟢 On budget |
| **Total** | **€2,000k** | **€924k (46%)** | **€1,076k** | **€2,025k** | 🟡 **+€25k risk** |

---

## 6. Next Month Focus

| Workstream | Key activities | Key milestone |
|---|---|---|
| CRM | Steering decision on recovery plan; Salesforce partner performance review | Data migration design doc by Oct 21 |
| Data Platform | HR + Marketing onboarding | 5/7 departments by end of October |
| Process Automation | Complete HR bot; security sign-off | HR bot go-live November 2026 |

---

*Programme Status Report | Digital Transformation | NoraCorp | September 2026*
