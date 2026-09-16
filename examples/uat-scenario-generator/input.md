# Sample Input — uat-scenario-generator

**Module:** Expense Management — new module in company ERP (built on Microsoft Dynamics 365)
**Release scope:** v1.0 — core expense submission and approval flow

**Functional scope for testing:**
1. Employees submit expense reports with line items (category, amount, date, description)
2. Receipt upload required for expenses > PLN 100
3. Expense categories: travel, accommodation, meals, equipment, other
4. Multi-level approval: direct manager → finance controller (if > PLN 2,000 total)
5. Finance exports approved reports to payroll system (CSV) at month end
6. Multi-currency support: EUR, GBP, USD auto-converted to PLN (ECB rate)
7. Rejection flow: manager or finance controller can reject with mandatory comment

**Non-functional requirements:**
- GDPR: expense data visible only to submitter, their manager hierarchy, finance
- Mobile: must work on iOS and Android (responsive web, not native app)
- Audit trail: all status changes logged with timestamp and user

**Key user groups:**
- Employees (submitters) — ~1,200 users
- Line managers (~80) — approve/reject first level
- Finance controllers (3) — second-level approval, export to payroll
- HR/Admin — can view reports for their department

**Known edge cases to cover:**
- Employee submits report then leaves the company before approval
- Manager is also submitting employee (self-approve risk)
- Multiple receipts for one line item
- Expense date before employee's start date in system
