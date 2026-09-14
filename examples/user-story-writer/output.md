# Sample Output — user-story-writer

## User Story 1 — Generowanie faktury

**As a** Finance Manager,
**I want to** generate a PDF invoice from a completed order in the B2B portal with a single click,
**So that** I can eliminate 2 hours of daily manual work in Excel and reduce transcription errors.

### Kryteria akceptacji

- **Given** an order with status "Completed" exists in the portal,
  **When** the Finance Manager clicks "Generate Invoice",
  **Then** the system creates a PDF invoice within 10 seconds using data from the order (buyer details, line items, totals, VAT).

- **Given** the invoice has been generated,
  **When** the Finance Manager reviews it on screen,
  **Then** the invoice displays: invoice number (auto-incremented, format FV-YYYY-NNNN), issue date, seller and buyer data, line items with unit price, quantity, VAT rate, gross/net totals.

- **Given** an order is missing required buyer data (e.g. VAT number),
  **When** generation is triggered,
  **Then** the system shows a validation error listing the missing fields and does not generate the invoice.

### Edge cases
- Order with 0-value line items (discount = 100%) — invoice must still be valid
- Buyer from EU (non-Polish VAT) — reverse charge clause must appear on invoice
- Invoice generation failure (PDF engine timeout) — display error, allow retry, no partial file saved

---

## User Story 2 — Wyslanie faktury emailem

**As a** Finance Manager,
**I want to** send a generated invoice to the buyer's email address directly from the portal,
**So that** I don't need to download and manually attach it in my email client.

### Kryteria akceptacji

- **Given** an invoice has been generated,
  **When** the Finance Manager clicks "Send by Email",
  **Then** the system sends the PDF as an attachment to the email address stored on the buyer account, with a standard subject line ("Faktura FV-YYYY-NNNN — [Seller Name]") and body template.

- **Given** the email was sent successfully,
  **When** the Finance Manager views the invoice record,
  **Then** the invoice shows status "Sent" with timestamp and recipient address.

- **Given** the buyer account has no email address,
  **When** send is triggered,
  **Then** the system prompts the user to enter an email address manually before sending.

### Edge cases
- Email delivery failure (bounce) — log the failure, set status "Send Failed", allow retry
- Multiple buyer contacts with email — show a list and let FM select recipient
- Resend — allowed; each send event logged with timestamp

---

## User Story 3 — Archiwizacja faktury

**As a** Finance Manager,
**I want** every generated invoice to be automatically archived in the portal's document store,
**So that** I can retrieve any invoice by order number or date without searching email or local drives.

### Kryteria akceptacji

- **Given** an invoice has been generated (regardless of send status),
  **When** generation completes,
  **Then** the PDF is saved to the archive automatically — no manual action required.

- **Given** invoices are archived,
  **When** the Finance Manager opens the Archive view,
  **Then** they can filter by: date range, buyer name, invoice number, status (Draft / Sent / Cancelled).

- **Given** an invoice exists in the archive,
  **When** the Finance Manager clicks "Download",
  **Then** the original PDF is downloaded — identical byte-for-byte to the sent version.

### Edge cases
- Archive storage quota exceeded — alert system admin, block new invoice generation until resolved
- Invoice cancelled after sending — archived with status "Cancelled", not deleted; original PDF preserved

---

## Notatki dla PO

- User Story 3 (archiwizacja) jest technicznie prosta jesli PDF jest juz generowany — nie jest osobnym epikiem, moze byc w tym samym sprincie co US 1.
- Numeracja faktur (FV-YYYY-NNNN) wymaga osobnego wymagania dotyczacego unikalnosci i zachowania ciaglosci przy bledach — sugerowane jako US 0 (enabler).
- VAT EU reverse charge (US 1, edge case) — wymaga mapowania krajow EU i logiki w szablonie PDF. Warto ocenic czy to zakres MVP czy nastepnej wersji.
