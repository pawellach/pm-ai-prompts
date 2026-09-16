# Sample Output — decision-log-writer

# Decision Log — Cloud Migration
**Project:** Cloud Migration | CoreBank S.A.
**Period covered:** September 2026
**Last updated:** 2026-09-16
**Maintained by:** PM / IT Architect

---

## Decision Register

| ID | Decision | Date | Decision maker | Status | Impact |
|---|---|---|---|---|---|
| DEC-001 | Cloud provider: Azure selected | 2026-09-02 | CTO + IT Director | ✅ Final | High |
| DEC-002 | Migration strategy: lift-and-shift (Tier 2/3) + re-architect (Tier 1) | 2026-09-08 | Technical Steering Committee | ✅ Final | High |
| DEC-003 | Data residency: EU only (PL/DE Azure regions) | 2026-09-10 | Legal + Compliance | ✅ Final — Not revisable | Critical |
| DEC-004 | Security review required before Tier 1 production | 2026-09-14 | CISO | ✅ Final | High |
| DEC-005 | Cloud resource naming convention established | 2026-09-16 | IT Architect | ✅ Final | Low |

---

## Decision Detail

---

### DEC-001 — Cloud Provider: Azure Selected
**Date:** 2026-09-02
**Decision maker:** CTO (Piotr Kowalczyk) + IT Director (Marcin Wiśniewski)
**Status:** Final

**Decision:**
Microsoft Azure selected as the primary cloud provider for the CoreBank migration. AWS was the primary alternative evaluated.

**Rationale:**
| Factor | Azure | AWS | Weight |
|---|---|---|---|
| Polish data residency SLA | ✅ Guaranteed | ⚠️ Best-effort | High |
| Existing Microsoft licensing (E5) | ✅ Full discount | ❌ Additional cost | High |
| KNF regulatory familiarity | ✅ Established | ⚠️ Limited track record in PL | High |
| Storage cost | ⚠️ Slightly higher | ✅ Lower | Medium |
| Engineering team familiarity | Azure: 60% / AWS: 40% | — | Medium |

**Alternatives considered:** AWS (ruled out — data residency SLA insufficient for KNF); Private cloud (ruled out — 3× cost, 2× timeline).

**Implications:**
- All infrastructure provisioning uses Azure services (AKS, Azure SQL, Blob Storage, Azure Monitor)
- IT team to complete Azure Fundamentals certification by Nov 30
- Azure Enterprise Agreement to be negotiated by Procurement; target: savings of 15–20% vs list price

**Dependencies:** DEC-003 (data residency) confirms Azure EU region selection.

---

### DEC-002 — Migration Strategy: Phased Lift-and-Shift + Re-Architect
**Date:** 2026-09-08
**Decision maker:** Technical Steering Committee (CTO, IT Director, CISO, Head of Dev)
**Status:** Final

**Decision:**
- **Tier 2 and Tier 3 applications** (non-critical, <20 systems): lift-and-shift to Azure IaaS. Migrate first to build team competency and establish patterns.
- **Tier 1 applications** (core banking, payments, customer data): re-architected as cloud-native during migration. Not lift-and-shifted.

**Rationale:**
Full re-architecture of all systems simultaneously would require 18+ months and expose the bank to risk. Phased approach: Tier 2/3 migration builds Azure confidence; re-architecture of Tier 1 uses lessons learned. Reduces risk while still delivering Tier 1 cloud-native benefits.

**History:** CTO initially proposed full re-architecture of all tiers. Backed down after risk analysis showed 3 critical systems would be unavailable during re-architecture without significant parallel build effort.

**Implications:**
- Tier 2/3 migration to start Oct 2026; estimated completion March 2027
- Tier 1 re-architecture estimated start: Q2 2027 (separate project phase)
- Technical debt introduced by lift-and-shift must be tracked and addressed in Tier 1 phase

**Open item:** Tier 1 system list to be finalized by IT Architect by Oct 15.

---

### DEC-003 — Data Residency: EU Only (Non-Revisable)
**Date:** 2026-09-10
**Decision maker:** Legal team (confirmed) + Compliance (validated against KNF guidelines)
**Status:** Final — **This decision is not revisable without Legal + Compliance sign-off**

**Decision:**
All production data (customer records, transaction logs, audit trails, PII) must remain within EU data centers. Approved Azure regions: Poland Central (primary), Germany West Central (DR).

Dev and test environments may use any Azure region (no PII in dev/test — policy to be enforced).

**Rationale:** KNF (Komisja Nadzoru Finansowego) requires financial institutions to store Polish customer data within the EU. Legal confirmed this is a hard regulatory requirement, not a preference.

**Implications:**
- All cloud architecture must enforce `Poland Central` or `Germany West Central` regions for production workloads
- Any future SaaS vendor integration must confirm EU data residency before approval
- Dev/test data must be anonymized or synthetic — no production data copies outside EU

**Action required:** IT Architect to add data residency check to the cloud architecture review checklist by Oct 7.

---

### DEC-004 — Independent Security Review Required Before Tier 1 Production
**Date:** 2026-09-14
**Decision maker:** CISO (Katarzyna Nowak)
**Status:** Final

**Decision:**
An independent penetration test and security architecture review is required and must be passed before any Tier 1 system goes live in the cloud environment. Vendor selected: Securitum (preferred bank security partner).

**Rationale:** KNF requirements + internal risk policy for systems handling payments and customer data. The bank's information security policy mandates an external review for any new production environment handling Tier 1 systems.

**Timeline impact:**
- Securitum engagement: 6 weeks from kickoff
- **This is now on the critical path.** Securitum must be engaged by Oct 15 to complete before Tier 1 go-live in Q2 2027.
- Review scope: network architecture, identity and access management, data encryption at rest and in transit, incident response runbook

**Action required:** Procurement to issue PO to Securitum by Oct 10. CISO to share scope document by Oct 7.

---

### DEC-005 — Cloud Resource Naming Convention Established
**Date:** 2026-09-16
**Decision maker:** IT Architect (Tomasz Bielak)
**Status:** Final

**Decision:**
All Azure resources follow the naming convention: `[ENV]-[REGION]-[SYSTEM]-[TYPE]`

Examples:
- `prod-pl-corebanking-vm` — production VM for core banking in Poland region
- `dev-eu-payments-sql` — development SQL database for payments
- `stg-pl-reporting-sa` — staging storage account for reporting

**Rationale:** Consistent naming prevents confusion during provisioning and simplifies cost allocation by environment/system. Aligns with Azure naming best practices.

**Environment prefixes:** `prod`, `stg`, `dev`, `dr`
**Region codes:** `pl` (Poland Central), `de` (Germany West Central), `eu` (any EU region)

**IT Standards document** (`/internal/it-standards/cloud-naming-v1.0.md`) to be updated by Oct 7.

---

## Pending / Open Questions

| # | Question | Owner | Due |
|---|---|---|---|
| OQ-1 | Tier 1 system list finalization | IT Architect | Oct 15 |
| OQ-2 | Azure Enterprise Agreement negotiation (pricing) | Procurement | Oct 30 |
| OQ-3 | Securitum PO issued | Procurement + CISO | Oct 10 |
| OQ-4 | IT standards document updated with naming convention | IT Architect | Oct 7 |

---

*Decision Log v1.0 | Cloud Migration | CoreBank S.A. | September 2026*
*Next update: After October Technical Steering Committee meeting (Oct 14)*
