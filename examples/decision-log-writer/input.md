# Sample Input — decision-log-writer

**Project:** Cloud Migration — CoreBank S.A. (mid-size Polish bank, 2,400 employees)
**Period:** September 2026 (decisions made in the last 30 days)
**Documenting from:** Meeting notes + email threads + Slack conversations

**Decisions to document:**

1. **Cloud provider selection:** After a 3-month evaluation, Azure was chosen over AWS. AWS had slightly lower storage costs but Azure won on: Polish data residency SLA, existing Microsoft licensing (E5), and stronger relationship with Polish KNF (financial regulator). Decision made by CTO + IT Director on 2026-09-02.

2. **Migration strategy — lift-and-shift vs re-architect:** Decision to use lift-and-shift for Tier 2 and Tier 3 applications (non-critical). Critical banking systems (Tier 1) will be re-architected during migration. This is a phased approach — Tier 2/3 go first to build team competency. Decided by Technical Steering Committee on 2026-09-08. CTO had originally pushed for full re-architect — backed down after risk analysis.

3. **Data residency — EU only:** All production data (customer, transaction, audit logs) must remain in EU (Poland or Germany Azure regions). Dev/test environments may use any Azure region. This was a legal/compliance requirement confirmed by the Legal team on 2026-09-10. Not optional.

4. **Security review timeline:** Independent penetration test required before any Tier 1 system goes to production in the cloud. External vendor (Securitum) selected. Security review takes 6 weeks — this is now on the critical path. Decided 2026-09-14, sponsor: CISO.

5. **Naming convention for cloud resources:** Using `[ENV]-[REGION]-[SYSTEM]-[TYPE]` format (e.g., `prod-pl-corebanking-vm`). IT standards document to be updated. Decided by IT Architect on 2026-09-16. Low stakes but important to document before provisioning starts.
