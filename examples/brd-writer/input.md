# Sample Input — brd-writer

**Project name:** Customer Self-Service Portal — RetailMax
**Description:** Build a web portal where B2C customers can manage orders, returns, invoices, and loyalty points without calling customer support.

**Business problem:**
Currently 68% of inbound support calls are order status checks, return requests, and invoice downloads. Support team handles ~3,400 tickets/month at an avg cost of €18/ticket. CSAT for phone channel is 3.2/5.

**Business goal:**
Reduce support ticket volume by 40% within 6 months of launch. Increase CSAT to 4.2+.

**Project sponsor:** COO — Marta Kowalczyk
**Key stakeholders:** Head of Customer Support (Tomasz Wierzbicki), CTO (Aneta Janik), Marketing (loyalty programme owner)

**Existing systems:** Magento 2.4 (e-commerce), SAP S/4HANA (ERP/invoicing), Salesforce Service Cloud (CRM/ticketing), custom loyalty points engine (internal API)

**Timeline:** MVP in 5 months, full launch month 6
**Budget:** €280,000 approved

**Previous attempts:** 2023 attempt abandoned — vendor delivered wrong scope, no discovery phase, portal was never integrated with SAP.

**Known constraints:**
- Must support Polish and English (EU customers)
- GDPR compliance required
- SSO via existing Azure AD B2C
- Mobile-first (60% traffic is mobile)
