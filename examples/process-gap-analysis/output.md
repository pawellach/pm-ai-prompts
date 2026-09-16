# Sample Output — process-gap-analysis

# Process Gap Analysis: Customer Onboarding
**Process:** B2B Customer Onboarding — CreditFlow Sp. z o.o.
**Current state lead time:** 14 business days
**Target lead time:** 3 business days
**Gap to close:** 11 business days (78% reduction)
**Analysis date:** 2026-09-16

---

## 1. Process Map: Current State (AS-IS)

| Step | Activity | Owner | Avg. time | Value-add? | Gap type |
|---|---|---|---|---|---|
| 1 | Customer submits PDF application | Customer | — | ✅ | — |
| 2 | Account manager reviews for completeness | AM | 1.5 days | ⚠️ Partial | Manual validation; should be automated |
| 3 | AM emails KYC request | AM | 0.5 days | ✅ | — |
| 4 | **Customer provides KYC documents (wait)** | Customer | 3 days wait | ✅ | No reminder; documents lost in email |
| 5 | Compliance officer reviews KYC + AML check | Compliance | 2 days | ✅ | AML tool not integrated; manual copy-paste |
| 6 | Credit analyst pulls GUS data + Excel scoring | Credit Analyst | 3 days | ⚠️ Partial | Manual GUS pull; Excel model (error-prone) |
| 7 | **Credit committee review (weekly meeting wait)** | Committee | 2 days avg wait | ✅ | Weekly cadence creates 0–4 day queue |
| 8 | AM creates customer in CRM | AM | 0.5 days | ❌ No value | Should be automated from approved application |
| 9 | AM emails welcome package | AM | 0.5 days | ❌ No value | Should be automated trigger |
| 10 | Customer activates portal | Customer | — | ✅ | — |

**Total: 14 business days (of which ~7.5 days are queue/wait time, not active work)**

---

## 2. Gap Analysis

### Gap 1: Application intake is manual and unstructured
**Current:** PDF form emailed to a shared inbox; account manager manually reviews completeness.
**Impact:** 1.5 days wasted on incomplete form corrections. No automated validation. Email gets lost.
**Gap size:** 1.5 days recoverable
**Required capability:** Digital onboarding form with mandatory fields, real-time validation, auto-routing to correct handler. (Planned: e-signature platform in procurement)

---

### Gap 2: KYC document collection has no follow-up mechanism
**Current:** Account manager sends one KYC request email. No reminder. Documents emailed back.
**Impact:** Average 3-day wait; often extended 2–4 extra days due to lost/forgotten emails.
**Gap size:** 2–4 days recoverable
**Required capability:** Customer portal with KYC upload interface, automatic reminders at 24h and 48h, status tracking visible to both AM and customer.

---

### Gap 3: AML tool is not integrated — manual copy-paste
**Current:** Compliance officer runs AML check in external tool, manually enters results into internal system.
**Impact:** 30–45 minutes per customer; error risk; audit trail incomplete.
**Gap size:** 0.5 days and audit risk recoverable
**Required capability:** AML tool API integration with automatic record creation in internal system. Most modern AML tools (e.g., ComplyAdvantage, Ondato) expose REST APIs.

---

### Gap 4: GUS data pull and credit scoring are manual
**Current:** Credit analyst manually accesses GUS (Polish company registry), downloads PDF, manually builds Excel credit score.
**Impact:** 3 days; two Excel model errors identified last year (risk of incorrect credit decisions).
**Gap size:** 2–2.5 days recoverable
**Required capability:** GUS API integration (available via data.gov.pl) for automatic company data pull; replace Excel model with a credit scoring engine. (Three vendors shortlisted — this is the highest-value gap to close.)

---

### Gap 5: Weekly credit committee creates queue bottleneck
**Current:** Committee meets once weekly. Straightforward applications wait up to 4 days for next slot.
**Impact:** Average 2-day wait; up to 4-day wait for unlucky timing.
**Gap size:** 1.5–2 days recoverable
**Required capability:** Either (a) introduce an async approval workflow for applications below a risk/amount threshold, or (b) increase committee cadence to 3×/week. Option (a) is recommended — the scoring engine (Gap 4) can automate pre-approval for standard profiles.

---

### Gap 6: Post-approval steps are fully manual
**Current:** Account manager manually creates customer in Salesforce, manually composes and sends welcome email.
**Impact:** 1 day of account manager time; no standardization.
**Gap size:** 1 day recoverable
**Required capability:** Automated CRM record creation and welcome communication triggered by approval decision. Salesforce process builder or Flow can handle this at zero incremental cost.

---

## 3. Gap Summary Table

| Gap | Description | Days recoverable | Complexity | Investment required | Priority |
|---|---|---|---|---|---|
| G1 | Manual application intake | 1.5 days | Low | Digital form (in procurement) | High |
| G2 | KYC follow-up missing | 2–4 days | Medium | Customer portal + reminder engine | High |
| G3 | AML tool not integrated | 0.5 days | Low | API integration (1 sprint) | Medium |
| G4 | Manual GUS + Excel scoring | 2.5 days | High | GUS API + credit scoring engine | **Critical** |
| G5 | Weekly committee bottleneck | 1.5–2 days | Medium | Async approval flow + scoring engine | High |
| G6 | Manual post-approval steps | 1 day | Low | Salesforce automation | Medium |
| **Total recoverable** | | **9–11.5 days** | | | |

---

## 4. Target State (TO-BE) — 3-Day Onboarding

| Step | Activity | Owner | Target time | Enabled by |
|---|---|---|---|---|
| 1 | Customer completes digital form with e-signature | Customer | Day 1, 30 min | Digital form (G1) |
| 2 | Auto-validation + KYC portal invitation triggered | System | Day 1, automated | Digital form + portal (G1, G2) |
| 3 | Customer uploads KYC documents via portal | Customer | Day 1–2 | Portal with reminders (G2) |
| 4 | Auto-AML check runs on submission | System | Day 2, 15 min | AML API integration (G3) |
| 5 | Auto-GUS pull + credit scoring engine runs | System | Day 2, automated | GUS API + scoring engine (G4) |
| 6 | Straightforward cases auto-approved; complex to async committee | System / Committee | Day 2–3 | Scoring engine + async flow (G5) |
| 7 | CRM record created + welcome email sent automatically | System | Day 3, automated | Salesforce automation (G6) |
| 8 | Customer activates portal | Customer | Day 3 | Existing |

**Projected lead time: 2–3 business days** (versus 14 today)

---

## 5. Implementation Roadmap

| Phase | Actions | Duration | Days recovered |
|---|---|---|---|
| **Phase 1 — Quick wins** | Salesforce post-approval automation (G6); AML API integration (G3); credit committee 3×/week (G5 interim) | 4–6 weeks | 3–4 days |
| **Phase 2 — Core automation** | Digital form + KYC portal + reminder engine (G1, G2) | 8–12 weeks | 4–5 days |
| **Phase 3 — Intelligence layer** | GUS API + credit scoring engine (G4); full async approval flow (G5) | 12–16 weeks | 2.5 days |

---

## 6. Business Impact of Closing Gaps

| Metric | Current | Target | Value |
|---|---|---|---|
| Onboarding time | 14 days | 3 days | Competitive differentiator; NPS improvement |
| Account manager time per onboarding | ~3h | ~0.5h | 83% reduction — capacity for more clients |
| Customer complaints (onboarding) | ~15% of new clients | <3% | Reduced churn at first touchpoint |
| Annual onboarding capacity (same headcount) | ~600 clients | ~2,400 clients | 4× throughput potential |

---

*Process Gap Analysis v1.0 | CreditFlow Sp. z o.o. | Customer Onboarding | 2026-09-16*
