# Sample Output — vendor-evaluation

# CRM Platform Vendor Evaluation
**Organization:** GreenBuild S.A.
**Decision:** Select CRM platform for 200-person B2B sales operation
**Date:** 2026-09-16
**Decision needed by:** October 31, 2026
**Decision makers:** CEO + CFO

---

## 1. Executive Recommendation

**Recommended vendor: HubSpot CRM Enterprise**

HubSpot is the only vendor that meets all must-have criteria while staying within the €80,000 TCO budget and scoring highest on ease of use — the most heavily weighted criterion and the #1 risk factor given the team profile. Salesforce exceeds GreenBuild's budget and complexity tolerance. Microsoft Dynamics 365 has the best SAP Business One integration but falls short on ease of use and is borderline on budget.

---

## 2. Must-Have Criteria Check

| Criterion | Salesforce | HubSpot | MS Dynamics 365 |
|---|---|---|---|
| SAP Business One integration | ⚠️ Via third-party connector (DBSync, ~€5k/year) | ⚠️ Via Zapier or native SAP app (limited, ~€2k/year) | ✅ Native SAP connector (Microsoft partnership) |
| Mobile app (iOS/Android) | ✅ Full-featured | ✅ Full-featured | ✅ Full-featured |
| Polish language | ✅ Full PL UI | ✅ Full PL UI | ✅ Full PL UI |
| EU data residency / GDPR | ✅ EU datacenter available | ✅ EU datacenter available | ✅ EU datacenter (Azure PL) |

**Note:** All three pass must-have criteria technically, but SAP Business One integration quality varies significantly. MS Dynamics 365 has the strongest native integration; Salesforce and HubSpot require middleware.

---

## 3. Weighted Scoring

| Criterion | Weight | Salesforce | HubSpot | MS Dynamics |
|---|---|---|---|---|
| Ease of use | 30% | 2/5 (complex, requires training) | 4.5/5 (intuitive, fast onboarding) | 3/5 (moderate complexity) |
| 3-year TCO (score: 1=expensive, 5=affordable) | 25% | 1/5 (€140k+) | 4/5 (€62k) | 3/5 (€78k) |
| SAP integration quality | 20% | 3/5 (middleware required, reliable) | 2.5/5 (limited native, Zapier works but fragile) | 4.5/5 (native connector, robust) |
| Reporting & forecasting | 15% | 5/5 (best-in-class) | 3.5/5 (good standard reporting) | 4/5 (Power BI native) |
| Customer support quality | 10% | 4/5 (24/7, good docs) | 3.5/5 (good, slower enterprise response) | 3.5/5 (good via Microsoft partner) |
| **Weighted total** | 100% | **2.85** | **3.68** | **3.43** |

---

## 4. Total Cost of Ownership (3-Year)

| Cost item | Salesforce | HubSpot | MS Dynamics |
|---|---|---|---|
| Licenses (15 sales users + 3 admin) | €72,000 | €36,000 | €39,600 |
| SAP integration (middleware/connector) | €15,000 | €6,000 | €3,000 (native — lower) |
| Implementation & configuration | €35,000 | €12,000 | €22,000 |
| Training (non-technical team) | €12,000 | €4,000 | €8,000 |
| Annual admin / support (outsourced IT) | €6,000 | €4,000 | €6,000 |
| **3-year TCO** | **€140,000** | **€62,000** | **€78,600** |

**Budget threshold (CFO): €80,000**
- Salesforce: ❌ 75% over budget
- HubSpot: ✅ 22% below budget
- MS Dynamics: ✅ Marginally under budget (€78,600)

---

## 5. Risk Analysis

### Salesforce
| Risk | Severity |
|---|---|
| 75% over budget — CFO likely to veto | Critical |
| Complexity confirmed by Head of Sales from prior experience | High |
| Requires dedicated admin; GreenBuild has no IT staff | High |
| **Overall: Not recommended** | |

### HubSpot
| Risk | Severity |
|---|---|
| SAP Business One integration via Zapier is less robust than native | Medium |
| If SAP integration fails, manual workaround is required | Medium |
| Reporting less powerful than Salesforce or Dynamics for complex forecasting | Low (GreenBuild doesn't need complex forecasting today) |
| **Overall: Acceptable risk level** | |

### Microsoft Dynamics 365
| Risk | Severity |
|---|---|
| Borderline budget (€78.6k vs €80k limit) — leaves no contingency | Medium |
| Moderate complexity — not as intuitive as HubSpot for non-technical users | Medium |
| Microsoft partner required for implementation — adds vendor dependency | Low |
| **Overall: Viable fallback if SAP integration quality is prioritized** | |

---

## 6. Head-to-Head Summary

| Factor | Winner | Notes |
|---|---|---|
| Ease of use | HubSpot | Significant gap; critical for GreenBuild's team profile |
| Price | HubSpot | €62k vs €78k (Dynamics) vs €140k (Salesforce) |
| SAP Business One integration | MS Dynamics 365 | Native connector is a meaningful advantage |
| Reporting depth | Salesforce | Not needed at GreenBuild's scale today |
| Admin simplicity (no IT team) | HubSpot | Self-service, well-documented, lowest admin burden |

---

## 7. Recommendation and Decision Path

**Primary recommendation: HubSpot CRM Enterprise**

The decision comes down to whether the SAP integration quality gap is acceptable. HubSpot's Zapier-based SAP Business One connector works but is less robust than Dynamics' native connector. For GreenBuild's use case (sync customer records and order history — not real-time), Zapier's reliability is acceptable.

**If SAP integration is the #1 priority:** Choose Microsoft Dynamics 365 (marginally over budget — request €5k contingency from CFO).

**Decision process:**
1. Arrange a 1-hour product demo of HubSpot with Krzysztof (Head of Sales) and 2 reps — let them drive it
2. Test the SAP Business One ↔ HubSpot Zapier connector with a sample dataset
3. If the demo and integration test pass → proceed with HubSpot
4. If integration test fails → escalate to MS Dynamics 365 with CFO budget exception request

---

## 8. Next Steps

| Action | Owner | Due |
|---|---|---|
| Schedule HubSpot demo with sales team (Krzysztof + 2 reps) | PM | Sept 23 |
| Test SAP B1 ↔ HubSpot Zapier integration (sample data) | IT outsource partner | Sept 30 |
| Collect written pricing proposals from HubSpot and Dynamics | Procurement | Sept 25 |
| Final recommendation to CEO + CFO | PM | Oct 10 |
| Vendor selection decision | CEO + CFO | Oct 31 |

---

*CRM Vendor Evaluation v1.0 | GreenBuild S.A. | 2026-09-16*
