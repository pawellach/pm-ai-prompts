# Sample Output — technical-discovery-facilitator

# Technical Discovery Summary
**Client:** Norda Retail S.A.
**Engagement:** Systems Integration & Data Consolidation
**Discovery period:** 2026-09-09 — 2026-09-13 (Week 1)
**Prepared by:** [FDM name]
**Version:** 1.0

---

## 1. Executive Summary

**Engagement context:** Norda Retail asked us to help create a unified view of inventory across 18 stores, a central warehouse, and e-commerce. The underlying goal is to move from manual, email-based replenishment to data-driven purchasing.

**Most important finding:** The engagement scope is significantly more complex than the pre-sales brief suggested. The 8 DOS-era POS systems ("the dinosaur") have no API, no database export capability, and no vendor support. Connecting them to any modern data layer is either impossible without replacing them or requires a manual physical process. **This is the single biggest risk to the "single source of truth" goal.**

**Top 3 quick wins:**
1. Connect Shopify Plus inventory to Symphony ERP via API — eliminates overselling within 3–4 weeks
2. Automate Comarch CDN CSV ingestion — replace manual email process for 10 stores; already produces CSV, just needs a scheduled pull + parser
3. Provide warehouse WMS visibility to store managers — expose a read-only view of the Excel-based WMS as a shared Google Sheet or Power BI report (0 integration, 1 week effort)

**Top 3 blockers:**
1. DOS-era POS (8 stores) — no digital export capability; any data from these stores will be manual until replaced
2. Warehouse WMS is an Excel file owned by one person — single point of failure for the most critical data source
3. Symphony ERP has no documentation and no living vendor — any integration requires reverse-engineering the database schema

**Recommended first 30 days:**
Start Shopify ↔ ERP sync (quick win with visible ROI); begin Symphony ERP schema reverse-engineering; present a scope decision to the CEO: "single source of truth" requires DOS-era POS replacement — do we include that in scope or accept a 3-tier solution?

---

## 2. System Landscape

| System | Category | Vendor / Custom | Purpose | Owner | Est. age | Status |
|---|---|---|---|---|---|---|
| Symphony ERP | ERP | Custom-built (no vendor) | Financials, central inventory, procurement | CTO | 12 years | Active / Problematic |
| Comarch CDN (10 stores) | POS | Comarch | Point of sale, store inventory | Store managers | 4 years | Active / Stable |
| DOS-era POS (8 stores) | POS | Unknown / legacy | Point of sale (basic) | Store managers | 20+ years | Active / At risk |
| Shopify Plus | E-commerce | Shopify | Online store, orders, customer data | Head of E-commerce | 2 years | Active / Stable |
| Excel WMS | Warehouse | Excel / manual | Warehouse inventory, pick lists, stock movements | Warehouse Director | 7 years | Active / Problematic |

**Architecture (current state):**
```
[Comarch CDN × 10 stores] ──── (CSV email, daily) ──── [Symphony ERP]
[DOS POS × 8 stores] ──── (paper report, weekly) ──── [Symphony ERP] (manual entry)
[Shopify Plus] ──── (NO connection) ──── [Symphony ERP]
[Excel WMS] ──── (NO connection) ──── [Symphony ERP or Shopify]
```

**Critical gap:** Shopify is an island. It has its own product/inventory records with no connection to any other system. E-commerce oversells because it cannot see warehouse stock.

---

## 3. Data Flow Map

| Flow | From | To | Method | Frequency | Volume | Known issues |
|---|---|---|---|---|---|---|
| Store sales → ERP | Comarch CDN (10 stores) | Symphony ERP | CSV via email attachment | Daily (manual send by store manager) | ~200 rows/store/day | Manual process; missed days when store managers forget; no validation |
| Store sales → ERP | DOS POS (8 stores) | Symphony ERP | Paper report → manual entry by HQ clerk | Weekly | ~500 rows/store/week | 1-week lag; transcription errors; no weekend data |
| Warehouse movements | Excel WMS | Symphony ERP | None — ERP and WMS are not connected | N/A | N/A | ERP central inventory ≠ actual warehouse stock |
| Online orders | Shopify | Symphony ERP | None — manual periodic export by e-comm team | Ad hoc (2–3×/week) | ~100 orders/day | Overselling occurs; returns not reconciled |
| Replenishment requests | Store managers | Warehouse | Email to Beata Wróbel | Ad hoc | 20–30 emails/day | No traceability; duplicates; Beata is the single point of failure |

---

## 4. Integration Gap Analysis

| Integration | Current state | Gap | Business impact | Priority |
|---|---|---|---|---|
| Shopify ↔ ERP inventory | None | No real-time stock sync | Overselling, customer refunds, lost trust | **Critical** |
| Comarch CDN ↔ ERP | Daily manual CSV | No automation; 24h lag; depends on human | Stock position always 1 day behind; errors from missed emails | High |
| Excel WMS ↔ ERP | None | ERP "inventory" does not reflect actual warehouse stock | Replenishment based on wrong data | **Critical** |
| DOS POS ↔ ERP | Weekly paper | 7-day data lag; 8 stores invisible in real time | Unable to include these stores in any real-time inventory view | High |
| Replenishment workflow | Email | No system; no traceability; human bottleneck | Stockouts and overstock in stores; Beata owns the process alone | High |

---

## 5. Pain Points

| # | Pain point | Type | Affected users | Severity | Root cause (if known) |
|---|---|---|---|---|---|
| P1 | Shopify oversells out-of-stock products | Integration failure | E-commerce customers; e-comm team | Critical | No Shopify ↔ warehouse connection |
| P2 | Store managers don't know warehouse stock level | Data quality | 18 store managers, customers | High | Excel WMS is not exposed outside warehouse |
| P3 | Replenishment requests lost or duplicated in email | Manual workaround | Store managers, Beata (warehouse) | High | No replenishment workflow system |
| P4 | 8 DOS-era stores provide data 1 week late | Integration failure | HQ planning team | High | Legacy system has no export capability |
| P5 | Symphony ERP inventory ≠ actual warehouse stock | Data quality | Purchasing team, CTO | High | Excel WMS and ERP are disconnected |
| P6 | No single person who "owns" the data problem | Governance | CTO | Medium | WMS owned by Beata, ERP owned by CTO, Shopify owned by Jan — no cross-system owner |

---

## 6. Stakeholder Map

| Name | Role | System ownership | Stance | Notes |
|---|---|---|---|---|
| Piotr Nowak | CTO | Symphony ERP, Comarch CDN | Champion | Technically understands the problem; wants to solve it; may underestimate ERP reverse-engineering effort |
| Beata Wróbel | Warehouse Director | Excel WMS | Skeptic | "Protective of her processes" — engagement risk; WMS is her domain; will need to be brought in as co-designer, not told what to change |
| Jan Kowalczyk | Head of E-commerce | Shopify Plus | Champion | Most frustrated by status quo; quick win (Shopify sync) will convert him to active advocate |
| [CEO — unnamed] | CEO / Sponsor | — | Champion | Strategic mandate clear; but may not understand the scope of the DOS-era problem |
| Store managers (18) | Store operations | Comarch CDN / DOS POS | Unknown | Currently in manual workaround mode; if solution reduces their email load → likely supporters |

---

## 7. Findings Summary

**The core problem is deeper than "systems need to be connected."** Norda Retail has three inventory realities that coexist without reconciliation: what Symphony ERP thinks is in the warehouse, what the Excel WMS actually shows, and what Shopify thinks is available online. These three numbers are never the same. Any "single source of truth" initiative must address which of these becomes authoritative — and that is a business decision, not a technical one.

**The DOS-era POS systems are the silent scope bomb.** Eight stores generate weekly paper reports. Until these systems are replaced (estimated cost: €80,000–120,000 for 8 modern POS terminals + installation), these stores will always be a week behind. The engagement cannot deliver a real-time unified inventory view while these systems exist. The CEO should be asked whether replacing the DOS POS is in scope — if not, the deliverable should be redefined as "real-time for 10 modern stores + Shopify, weekly batch for 8 legacy stores."

**Beata Wróbel is the most important stakeholder we haven't properly engaged yet.** The warehouse WMS is central to the entire initiative, and Beata owns it. She has been described as protective — which likely means she's seen past initiatives promise change and deliver chaos. The fastest path to her support is to include her as a co-designer of the new warehouse data layer, not a recipient of it. If she becomes an opponent, the initiative fails.

**The Shopify quick win is a confidence builder.** Jan Kowalczyk is ready to act, the technical path is clear (Shopify API → ERP REST or database insert), and the business impact is immediate (no more overselling). Delivering this in week 3–4 creates visible momentum and validates the team's ability to deliver before the harder work begins.

---

## 8. Recommended Roadmap

### Quick Wins — 0–30 days

| Initiative | Owner | Effort | Expected outcome |
|---|---|---|---|
| Shopify ↔ ERP inventory sync | Jan (e-comm) + FDM | Low (3 weeks) | Real-time stock visibility in Shopify; overselling eliminated |
| Comarch CDN CSV automation | CTO + FDM | Low (1 week) | 10-store data ingested automatically, daily; no manual emails |
| WMS visibility as read-only report | Beata (co-own) + FDM | Low (1 week) | Store managers see warehouse stock without calling Beata |

### Medium-term — 1–3 months

| Initiative | Dependency | Effort | Expected outcome |
|---|---|---|---|
| Symphony ERP schema mapping | CTO access to DB | Medium (3–4 weeks) | Documented API/DB layer for future integrations |
| Replenishment workflow system | WMS visibility done | Medium (4–6 weeks) | Store requests to warehouse via system; traceable; Beata not a bottleneck |
| ERP ↔ WMS reconciliation | ERP schema done | Medium (4 weeks) | Single authoritative inventory number for warehouse |

### Strategic — 3+ months

| Initiative | Prerequisite | Effort | Strategic value |
|---|---|---|---|
| DOS POS replacement (8 stores) | CEO budget decision | High (€80–120k hardware) | All 18 stores in real-time data; uniform POS platform |
| Demand forecasting / replenishment automation | Unified data layer | High (external analytics partner) | Data-driven purchasing; reduce overstock by est. 20% |
| Master data governance program | Replenishment workflow live | Medium (ongoing) | Prevent data drift back to siloed Excel state |

---

## 9. Open Questions and Next Steps

| # | Question | Owner | Due |
|---|---|---|---|
| OQ-1 | Is DOS POS replacement in scope? If not, what is the SLA for 8 legacy stores? | CEO / CTO | End of Week 2 |
| OQ-2 | What is Symphony ERP's database technology? Can we get read-only DB access? | CTO + ERP developer | End of Week 2 |
| OQ-3 | What is Beata's preferred path for WMS replacement? Is she open to a structured conversation? | Piotr Nowak | End of Week 1 |
| OQ-4 | Does Shopify Plus plan include REST Inventory API access? (Confirm with Jan) | Jan Kowalczyk | Immediately |
| OQ-5 | Who is the "data owner" once unified inventory exists — CTO, Beata, or a new role? | CEO | Month 1 |

---

## 10. Risk Register

| # | Risk | Probability | Impact | Mitigation |
|---|---|---|---|---|
| R1 | Beata Wróbel blocks WMS integration | Medium | Critical | Engage as co-designer; show her the quick win (visibility report) delivers value to her team first |
| R2 | Symphony ERP schema undocumented / no access | High | High | Begin DB mapping immediately; engage whichever developer originally built it |
| R3 | DOS POS excluded from scope → "single source of truth" undefined for 8 stores | High | Medium | Escalate to CEO in Week 2; define interim state explicitly in project scope |
| R4 | Shopify API rate limits or plan restrictions block inventory sync | Low | Medium | Confirm plan tier before build; upgrade to Shopify Plus API plan if needed |
| R5 | Scope grows beyond 3-month timeline once full complexity is understood | High | High | Scope-lock after OQ-1 and OQ-2 resolved; phased delivery contract |

---

*Discovery Summary v1.0 | Norda Retail S.A. | Week 1 Discovery | 2026-09-13*
*Next: Present findings to CTO + CEO in Week 2 kickoff. Resolve OQ-1 (DOS POS scope) before Week 2 ends.*
