# Sample Output — uat-scenario-generator

# UAT Test Scenarios — Expense Management Module v1.0
**System:** Microsoft Dynamics 365 — Expense Management
**UAT version:** 1.0
**Prepared:** 2026-09-16

---

## Test Coverage Map

| Area | # Scenarios | Priority |
|---|---|---|
| Expense submission (happy path) | 4 | Critical |
| Receipt upload | 3 | Critical |
| Approval flow — single level | 4 | Critical |
| Approval flow — dual level (>2,000 PLN) | 3 | Critical |
| Rejection flow | 3 | High |
| Multi-currency | 3 | High |
| Payroll export | 2 | High |
| Permissions / data visibility | 3 | High |
| Edge cases | 4 | Medium |
| **Total** | **29** | |

---

## Critical Path Scenarios (must pass before UAT sign-off)

---

### SC-001 — Submit expense report: standard domestic
**Role:** Employee
**Precondition:** Logged-in employee; at least 1 approved direct manager in system

**Steps:**
1. Navigate to "New Expense Report"
2. Enter report title "Business trip Warsaw–Kraków 2026-09-10"
3. Add line item: Category=Travel, Amount=PLN 85, Date=2026-09-10, Description="Train ticket"
4. Add line item: Category=Meals, Amount=PLN 45, Date=2026-09-10, Description="Team lunch"
5. Submit report

**Expected result:**
- Report saved with status "Submitted"
- Line items saved correctly with entered values
- Direct manager receives notification
- No receipt required (both items ≤ PLN 100)
- Employee sees report in "My submissions" list

---

### SC-002 — Submit expense: receipt required above threshold
**Role:** Employee
**Precondition:** Receipt file available (PDF or JPG)

**Steps:**
1. Add expense line item: Category=Accommodation, Amount=PLN 350, Date=2026-09-11
2. Attempt to submit WITHOUT attaching a receipt
3. Attach receipt file (valid PDF, 2MB)
4. Submit report

**Expected result:**
- Step 2: System blocks submission with message "Receipt required for amounts over PLN 100"
- Step 3: Receipt accepted; attached to line item
- Step 4: Report submitted successfully
- Receipt accessible from the line item in manager's approval view

---

### SC-003 — Manager approves single-level expense (≤ PLN 2,000)
**Role:** Line manager
**Precondition:** SC-001 or SC-002 report in "Submitted" state; actor is submitter's direct manager

**Steps:**
1. Open notification or navigate to "Approval queue"
2. View expense report details (all line items, receipts)
3. Click "Approve"
4. Confirm approval

**Expected result:**
- Report status changes to "Approved"
- Employee receives approval notification
- Report does NOT go to Finance controller (total < PLN 2,000)
- Audit log: manager approval recorded with timestamp
- Report appears in Finance's payroll export queue

---

### SC-004 — Dual-level approval required (total > PLN 2,000)
**Role:** Employee → Line manager → Finance controller
**Precondition:** Expense report with total PLN 2,400

**Steps:**
1. Employee submits report with total PLN 2,400
2. Manager approves
3. Finance controller receives notification
4. Finance controller reviews and approves

**Expected result:**
- After manager approval: status = "Pending Finance Review" (not "Approved")
- Finance controller sees report in their queue
- Final status = "Approved" only after Finance sign-off
- Both approvals recorded in audit trail

---

## Approval Flow Scenarios

---

### SC-005 — Manager rejects with mandatory comment
**Role:** Line manager

**Steps:**
1. Open expense report in approval queue
2. Click "Reject"
3. Attempt to submit rejection WITHOUT entering a comment
4. Enter comment "Receipt for meal expense is not legible — please re-upload"
5. Submit rejection

**Expected result:**
- Step 3: System blocks rejection with "Comment is required"
- Step 5: Rejection accepted; status = "Rejected"
- Employee notification includes manager's comment
- Employee can correct and resubmit the report

---

### SC-006 — Finance controller rejects after manager approval
**Role:** Finance controller
**Precondition:** Report approved by manager, awaiting Finance review

**Steps:**
1. Finance controller opens report
2. Rejects with comment "Accommodation receipt dated outside policy (>30 days old)"

**Expected result:**
- Status returns to "Rejected"
- Both employee AND manager notified
- Audit trail shows: submitted → manager approved → finance rejected

---

## Multi-Currency Scenarios

---

### SC-007 — Submit expense in EUR; view PLN conversion
**Role:** Employee

**Steps:**
1. Add line item: Amount=€120, Currency=EUR, Date=2026-09-10
2. Save and view line item

**Expected result:**
- PLN equivalent displayed using ECB rate for 2026-09-10
- Original currency (EUR) and amount shown alongside PLN
- Rate used is visible (e.g., "Rate: 4.28 PLN/EUR — ECB 2026-09-10")
- Total on report shows sum in PLN

---

### SC-008 — Multi-currency report: total calculated correctly in PLN
**Role:** Employee

**Steps:**
1. Submit report with 3 line items: PLN 200, EUR 80, USD 50
2. View report total

**Expected result:**
- Total shown in PLN = PLN 200 + (EUR 80 × ECB rate) + (USD 50 × ECB rate)
- If approval threshold (PLN 2,000) is triggered: system uses PLN total after conversion

---

## Payroll Export Scenarios

---

### SC-009 — Finance month-end export to payroll
**Role:** Finance controller
**Precondition:** At least 3 approved expense reports in current month

**Steps:**
1. Navigate to Payroll Export
2. Select month: September 2026
3. Review report list
4. Export CSV

**Expected result:**
- CSV contains: employee ID, total amount (PLN), expense period, approval date
- Only "Approved" reports included (not Submitted, Rejected, Pending)
- Re-running the export for the same month produces identical CSV (idempotent)
- Export action logged in audit trail with Finance controller's user ID

---

## Permissions and Data Visibility Scenarios

---

### SC-010 — Employee cannot see another employee's expenses
**Role:** Employee A

**Steps:**
1. Log in as Employee A
2. Navigate to expense reports
3. Attempt to access Employee B's report (via direct URL if possible)

**Expected result:**
- Employee A cannot see Employee B's reports in the list
- Direct URL attempt returns "Access denied" or 404
- No Employee B data visible in any report view

---

### SC-011 — Manager sees only their direct reports' expenses
**Role:** Manager
**Precondition:** Manager has 5 direct reports; 2 other employees exist who report to different managers

**Steps:**
1. Log in as manager
2. Navigate to "Approval queue" and "Team expenses"

**Expected result:**
- Only 5 direct reports' submissions visible
- Other employees' reports not visible

---

## Edge Case Scenarios

---

### SC-012 — Manager is also a submitter (self-approve prevention)
**Role:** Manager (who is also submitting expenses)
**Precondition:** Manager has submitted their own expense report

**Steps:**
1. Log in as the manager
2. Navigate to Approval queue
3. Check if own expense report appears for self-approval

**Expected result:**
- Manager's own report does NOT appear in their approval queue
- Own report escalates to manager's manager (or Finance, per configuration)
- System does NOT allow self-approval under any circumstance

---

### SC-013 — Expense date before employee's start date
**Role:** Employee

**Steps:**
1. Add line item with Date = one year before employee's system start date
2. Save

**Expected result:**
- System shows validation warning: "Expense date is before your employment start date. Please verify."
- Report can still be saved (warning, not block — edge cases exist)
- Finance reviewer sees the warning in the approval view

---

### SC-014 — Employee submits report then is deactivated before approval
**Role:** Admin (deactivates account) → Manager (approves)
**Precondition:** Employee has submitted a report; not yet approved

**Steps:**
1. Admin deactivates employee account
2. Manager attempts to approve the report

**Expected result:**
- Report remains in the approval queue after account deactivation
- Manager can approve/reject normally
- Approved report is included in payroll export with deactivated employee's ID
- System note: "Employee account deactivated on [date]"

---

### SC-015 — Multiple receipts for a single line item
**Role:** Employee

**Steps:**
1. Add line item: Category=Travel, Amount=PLN 280
2. Attach first receipt (PDF)
3. Attach second receipt (JPG) to the same line item
4. Submit

**Expected result:**
- Both receipts attached to the same line item
- Both visible in manager's approval view
- Report submitted successfully

---

## UAT Sign-off Criteria

| Criterion | Threshold |
|---|---|
| All Critical Path scenarios (SC-001 to SC-004) | 100% pass required |
| SC-005 to SC-011 (High priority) | ≥ 90% pass (max 1 minor deviation) |
| SC-012 to SC-015 (Edge cases) | ≥ 75% pass; deviations documented |
| No blocker (P1) defects open at sign-off | Hard requirement |
| No more than 3 major (P2) defects open at sign-off | Must have mitigation plan |

---

*UAT Scenarios v1.0 | Expense Management | Dynamics 365 | 2026-09-16*
