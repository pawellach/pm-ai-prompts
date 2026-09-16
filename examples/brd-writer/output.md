# Sample Output — brd-writer

# Business Requirements Document
**Project:** Customer Self-Service Portal — RetailMax
**Version:** 1.0 DRAFT
**Date:** 2026-09-16
**Status:** Under Review
**Owner:** Marta Kowalczyk (COO)

---

## 1. Executive Summary

RetailMax processes ~3,400 support tickets per month, 68% of which involve routine self-service tasks (order status, returns, invoices, loyalty). At €18/ticket, this represents ~€41,000/month in avoidable support cost. The Self-Service Portal will deflect at least 40% of these tickets by enabling customers to complete these tasks independently online, targeting a 6-month payback period on the €280,000 investment.

**Success criteria:**
- Support ticket volume reduction ≥ 40% (month-over-month, 6 months post-launch)
- CSAT self-service channel ≥ 4.2 / 5
- Portal adoption: ≥ 35% of active customers logged in within 90 days

---

## 2. Business Context

### 2.1 Problem Statement

| Problem | Current state | Business impact |
|---|---|---|
| Order status enquiries | Customers call support; agents query Magento manually | 40% of all tickets; avg 6 min handle time |
| Return requests | Paper/email process; 4-day processing lag | Customer dissatisfaction; CSAT 3.2 |
| Invoice downloads | Finance team emails PDFs on request | ~600 tickets/month; FTE time wasted |
| Loyalty balance checks | No self-service; call only | Drives unnecessary contact |

### 2.2 Root Cause
No authenticated digital channel exists for post-purchase customer interaction. The 2023 portal project failed due to lack of integration specification — SAP connectivity was scoped after development started, resulting in a product with no live data.

### 2.3 Strategic Alignment
Supports RetailMax FY2026 OKR: "Reduce cost-to-serve by 25% while improving NPS". Portal is Pillar 2 of the Digital Experience Programme.

---

## 3. Scope

### 3.1 In Scope — MVP (Month 1–5)

| Module | Capability | Source system |
|---|---|---|
| Authentication | SSO login via Azure AD B2C, account recovery | Azure AD B2C |
| Order Management | View order list, order detail, real-time status | Magento 2.4 |
| Returns | Initiate return, select reason, print label, track status | Magento + SAP |
| Invoices | View, download PDF, filter by date | SAP S/4HANA |
| Loyalty | View points balance, transaction history, upcoming expiry | Internal loyalty API |
| Support | Submit ticket from portal (pre-filled with account context), view history | Salesforce Service Cloud |

### 3.2 Out of Scope — v1.0
- Payments / instalment plans
- Live chat / AI chatbot
- Product recommendations
- B2B account management (separate programme)
- Mobile native app (PWA only)

### 3.3 Full Launch (Month 6)
- Notifications (email + SMS): order status changes, return updates, loyalty expiry warnings
- Multi-language: English UI (Polish is MVP)

---

## 4. Stakeholder Requirements

### 4.1 Customer (end user)
- I can log in using my existing RetailMax account (no new registration)
- I can see all my orders from the last 24 months with current status
- I can initiate a return within 30 days of delivery, without calling support
- I can download any invoice as PDF within 10 seconds
- I can check my loyalty balance and see when points expire
- The portal works correctly on my phone (iOS Safari, Android Chrome)
- My data is shown in Polish by default; I can switch to English

### 4.2 Customer Support Team (Tomasz Wierzbicki)
- Portal deflects routine queries — agents handle only complex/escalation cases
- When a customer submits a ticket via portal, Salesforce receives full order/return context automatically
- Support can see portal activity log when assisting a customer

### 4.3 Finance (invoice owners)
- No manual PDF emails — customers self-serve invoices directly from SAP
- Audit trail: every invoice download is logged with timestamp and user ID

### 4.4 CTO / Technical (Aneta Janik)
- Portal is a separate frontend service; does not modify existing Magento/SAP codebases
- All integrations via REST APIs; no direct database access to ERP
- GDPR: no customer PII stored in portal layer; fetched on-demand from source systems

---

## 5. Functional Requirements

### FR-001 — Authentication
| ID | Requirement | Priority |
|---|---|---|
| FR-001.1 | Customer authenticates via Azure AD B2C OIDC flow | Must |
| FR-001.2 | "Remember me" session valid for 30 days on trusted device | Should |
| FR-001.3 | Account recovery (forgot password) via email OTP | Must |
| FR-001.4 | After 5 failed login attempts, account locked for 15 minutes | Must |

### FR-002 — Order Management
| ID | Requirement | Priority |
|---|---|---|
| FR-002.1 | Display paginated order list (default: last 12 months, up to 24) | Must |
| FR-002.2 | Each order shows: order number, date, status, total, items (name, qty, price) | Must |
| FR-002.3 | Order status sourced real-time from Magento; latency < 3s | Must |
| FR-002.4 | Customer can filter orders by status, date range | Should |

### FR-003 — Returns
| ID | Requirement | Priority |
|---|---|---|
| FR-003.1 | Customer can initiate return for any order item within 30 days of delivery | Must |
| FR-003.2 | Return reasons picklist (damaged, wrong item, changed mind, other) | Must |
| FR-003.3 | System generates return label (PDF, DPD integration) | Must |
| FR-003.4 | Return status tracked and displayed; customer notified by email on each status change | Should |
| FR-003.5 | Refund estimated timeline shown (standard: 5 business days) | Should |

### FR-004 — Invoices
| ID | Requirement | Priority |
|---|---|---|
| FR-004.1 | All invoices linked to customer's NIP fetched from SAP S/4HANA | Must |
| FR-004.2 | Customer can download individual invoice as PDF | Must |
| FR-004.3 | Batch download: select multiple invoices → single ZIP | Should |
| FR-004.4 | Filter by date range and status (paid, pending, overdue) | Should |

### FR-005 — Loyalty
| ID | Requirement | Priority |
|---|---|---|
| FR-005.1 | Display current points balance | Must |
| FR-005.2 | Transaction history: date, event, points earned/spent | Must |
| FR-005.3 | Expiry warning: banner if points expire within 60 days | Should |

---

## 6. Non-Functional Requirements

| Category | Requirement |
|---|---|
| Performance | Page load < 2s (P95) on 4G connection; API response < 3s |
| Availability | 99.5% uptime; planned maintenance window Sunday 01:00–03:00 |
| Security | OWASP Top 10 compliance; penetration test before launch |
| GDPR | No PII cached in portal DB; right-to-erasure triggers deletion request to source systems |
| Accessibility | WCAG 2.1 AA |
| Browser support | Chrome 120+, Safari 17+, Firefox 120+, Edge 120+ |
| Mobile | Responsive PWA; tested on iOS 17 / Android 14 |
| Scalability | Handle 500 concurrent users without degradation |

---

## 7. Integration Architecture

```
Customer Browser
      │
      ▼
 Portal Frontend (React PWA)
      │
      ▼
 Portal BFF (Node.js / API Gateway)
      ├──── Azure AD B2C (auth)
      ├──── Magento 2.4 REST API (orders, returns)
      ├──── SAP S/4HANA OData API (invoices)
      ├──── Loyalty Engine REST API (points)
      └──── Salesforce Service Cloud API (tickets)
```

**Integration risk:** SAP S/4HANA OData endpoint for customer invoices is not currently exposed. Requires SAP Basis work (estimated 15 days). This is the critical path item identified from the 2023 failure — must be resolved in Sprint 1.

---

## 8. Assumptions & Constraints

| # | Assumption / Constraint |
|---|---|
| A1 | Magento REST API for orders/returns is available and documented (confirm with CTO) |
| A2 | Azure AD B2C tenant already configured for customer identities |
| A3 | SAP OData endpoint must be built — 15-day lead time, blocks invoice module |
| A4 | Loyalty API documentation available; rate limit ≥ 100 req/sec |
| C1 | No modification to Magento or SAP source code |
| C2 | GDPR DPA review required before launch — 3-week lead time |
| C3 | Budget €280,000 is fixed; scope cuts before budget increase |

---

## 9. Open Questions

| # | Question | Owner | Due |
|---|---|---|---|
| OQ-1 | Does Magento return API support bulk return (multiple items, one request)? | CTO | Sprint 1 |
| OQ-2 | What is the DPD label generation API? Is there an existing contract? | Logistics | Sprint 2 |
| OQ-3 | Loyalty: are points transferable between accounts? | Marketing | Sprint 1 |
| OQ-4 | GDPR: is portal a new data processor requiring DPA amendment? | Legal | Pre-sprint |

---

## 10. Timeline & Milestones

| Milestone | Date | Description |
|---|---|---|
| M1 — Integration specs signed off | Month 1 Week 2 | All API contracts defined |
| M2 — Auth + Order view live (Staging) | Month 2 | Core flow testable |
| M3 — Returns + Invoices live (Staging) | Month 3 | All MVP modules complete |
| M4 — UAT | Month 4–5 | Customer acceptance testing |
| M5 — MVP Launch | End of Month 5 | Go live, Polish only |
| M6 — Full Launch | End of Month 6 | English + notifications |

---

*BRD v1.0 | Author: [PM name] | Next review: after OQ-1 to OQ-4 resolved*
