# Sample Input — process-gap-analysis

**Process:** Customer onboarding — new B2B customers for a fintech company (SME lending platform)
**Current state:** Average onboarding time = 14 business days
**Target state:** 3 business days
**Company:** CreditFlow Sp. z o.o., B2B lending, ~5,000 active clients

**Current process steps (from process map interview):**

1. Customer submits application form (PDF email) → lands in shared inbox
2. Account manager manually reviews application, checks for missing fields (avg 1.5 days)
3. Account manager emails KYC request to customer (ID documents, company registry extract)
4. Customer sends KYC documents (email) — avg 3 days wait
5. Compliance officer manually reviews documents, runs AML check in external tool (avg 2 days)
6. Credit analyst manually pulls financial data from GUS (company registry), prepares credit scoring in Excel (avg 3 days)
7. Credit committee review (weekly meeting — waits for next slot, avg 2 days wait)
8. If approved: account manager creates customer in CRM (Salesforce) manually (avg 0.5 days)
9. Account manager emails welcome package (bank details, portal link, credit terms)
10. Customer activates portal account (self-service)

**Known problems:**
- KYC request email gets lost / no reminder system — accounts for 3–4 day delays on top of customer wait
- Credit committee meets only once a week; 2-day average wait even for straightforward cases
- GUS data pull is manual and Excel model is not version controlled (errors found twice last year)
- AML tool is not integrated — compliance officer copy-pastes results into internal system
- New customers complain about waiting and lack of updates during the process

**Target capability investments planned:**
- E-signature / digital onboarding form (in procurement)
- API access to GUS for automatic company data pull (available, not yet used)
- New credit scoring engine being evaluated (3 vendors shortlisted)
