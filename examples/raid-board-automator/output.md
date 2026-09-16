# Sample Output — raid-board-automator

# RAID Board — NOVA ERP Implementation
**Project phase:** Month 3 of 8
**Updated:** 2026-09-16
**PM:** [Name]

---

## 🔴 RISKS

| ID | Risk | Probability | Impact | Score | Owner | Response |
|---|---|---|---|---|---|---|
| R1 | Production server order delayed past Sept 30 → go-live at risk | High | Critical | 🔴 9 | IT Director | **Immediate action:** Order servers by Sept 30 (6-week lead time). If missed, go-live slips by minimum 6 weeks. |
| R2 | GDPR data mapping for employee data not completed (was due Month 1) | High | High | 🔴 9 | Data Privacy Officer + PM | Escalate to Legal and DPO immediately; emergency data mapping session; risk of regulatory non-compliance |
| R3 | Training design not started in Month 3 — 3 months behind plan | High | High | 🔴 9 | Change Manager | Immediate: define training plan by Sept 30; compress design phase; may need external training resource |
| R4 | SAP payroll tax tables for Polish regulations — unverified | Medium | High | 🟡 6 | Payroll Consultant | Verify with payroll consultant by Oct 7; incorrect tax tables = payroll errors from go-live |
| R5 | Vendor toolkit 3-week delay compresses migration window | High | Medium | 🟡 6 | Vendor PM + Project PM | Re-plan migration workstream; assess buffer impact; escalate to vendor account manager |

---

## 🟡 ASSUMPTIONS

| ID | Assumption | Owner | Verify by | Confidence | Action if wrong |
|---|---|---|---|---|---|
| A1 | Procurement team (Joanna) available for 3 full days of UAT in November | PM | **Sept 20** | Low — not confirmed | UAT timeline shifts; procurement module testing at risk |
| A2 | SAP standard payroll tax tables are current for Polish 2026 regulations | Payroll Consultant | Oct 7 | Unknown | Custom tax configuration required (+2–4 weeks effort) |
| A3 | Finance module sign-off will unblock HR module as planned | Finance Director + PM | Oct 1 | Low — Finance 2 weeks late | HR module delayed minimum 2 weeks from current position |

---

## 🔴 ISSUES (Active Problems)

| ID | Issue | Raised | Severity | Owner | Status | Due |
|---|---|---|---|---|---|---|
| I1 | Testing environment down 4 days — firewall rules not provided by IT | 2026-09-10 | **Critical** | IT Director | 🔴 Open — escalated | Resolve by Sept 17 — 6 people blocked |
| I2 | HR module blocked — Finance sign-off 2 weeks late | 2026-09-10 | High | Finance Director | 🟡 In progress | Finance sign-off needed by Sept 30 |
| I3 | Vendor data migration toolkit 3 weeks late | 2026-09-10 | High | Vendor PM | 🟡 Monitoring | New vendor ETA: Oct 3 — confirm in writing |
| I4 | GDPR employee data mapping not started | 2026-09-12 | **Critical** | PM + DPO | 🔴 Open | Immediate — start this week |
| I5 | Board presentation: go-live risk assessment not prepared | 2026-09-10 | High | PM | 🟡 In progress | Needed by Oct Board meeting; start by Sept 30 |
| I6 | Warehouse team requested 3 additional custom reports (out of scope) | 2026-09-12 | Medium | PM + Sponsor | 🟡 Pending decision | Scope decision by Sept 25: approve, reject, or defer |

---

## 🔵 DEPENDENCIES

| ID | Dependency | From | To | Status | Risk if missed |
|---|---|---|---|---|---|
| D1 | Finance module sign-off → HR module can start | Finance Director | HR workstream | 🔴 Late (2 weeks) | HR timeline delays cascade to payroll go-live |
| D2 | Server provisioning order → production environment ready | IT Director (order) | Go-live | 🔴 **Critical path** | Order must be placed by Sept 30 or go-live slips 6 weeks |
| D3 | Vendor data migration toolkit delivery → migration workstream start | SAP Vendor | Data migration team | 🔴 3-week delay | New start date Oct 3; migration window compressed |
| D4 | GDPR data mapping sign-off → employee data migration can start | DPO + Legal | HR module | 🔴 Not started | No legal clearance = no migration; blocks HR module |
| D5 | Training design complete → training delivery (Month 6) | Change Manager | All end users | 🟡 At risk | Training compressed or inadequate; adoption risk |

---

## 🚨 Priority Actions This Week (Sept 16–20)

| Priority | Action | Owner | Deadline |
|---|---|---|---|
| 🔴 P1 | Order production servers — confirm decision and raise PO | IT Director | **Sept 18** |
| 🔴 P1 | Resolve testing environment firewall rules — unblock 6 people | IT Director | **Sept 17** |
| 🔴 P1 | Escalate GDPR data mapping gap to DPO + Legal; schedule emergency session | PM | **Sept 17** |
| 🔴 P1 | Confirm Joanna (procurement) availability for November UAT | PM | **Sept 20** |
| 🟡 P2 | Get vendor commitment for toolkit delivery date in writing | Vendor PM | Sept 20 |
| 🟡 P2 | Finance Director: confirm sign-off date for Finance module | PM | Sept 20 |
| 🟡 P2 | Start training design plan with Change Manager | Change Manager + PM | Sept 30 |
| 🟡 P2 | Scope decision on 3 warehouse custom reports | PM + Sponsor | Sept 25 |

---

## Summary: RAID Health

| Category | Status | Critical items |
|---|---|---|
| Risks | 🔴 Critical | 3 critical risks; 2 need immediate escalation |
| Assumptions | 🟡 Amber | 3 unvalidated; 2 blocking path-critical decisions |
| Issues | 🔴 Critical | 2 critical issues (firewall + GDPR); 4 high |
| Dependencies | 🔴 Critical | 3 dependencies on critical path behind schedule |

**Overall project health: 🔴 Red — requires steering committee attention this week**

---

*RAID Board v1.0 | NOVA ERP | 2026-09-16 | Next update: Sept 23 status call*
