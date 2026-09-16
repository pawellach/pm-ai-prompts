# Sample Output — change-impact-assessment

# Change Impact Assessment
**Change:** Migration to Salesforce Service Cloud
**Organization:** Meditech S.A.
**Sponsor:** Monika Zielińska, VP Operations
**Assessment date:** 2026-09-16
**Go-live:** Q1 2027

---

## 1. Executive Summary

This change replaces Meditech's email-based support operation with Salesforce Service Cloud. The business impact is significant and positive — better case tracking, SLA visibility, and customer experience measurement. The people impact is high: 20 people change how they work daily. The primary risk is not technical but organizational: resistance from agents worried about performance monitoring and one team leader with high influence who is actively opposed. Without a structured change management plan, adoption will be slow and the investment will underdeliver.

**Overall change complexity: HIGH**
**Primary risk: People resistance, not technical delivery**

---

## 2. Stakeholder Impact Analysis

| Stakeholder group | Size | Impact level | Nature of change | Current stance | Risk level |
|---|---|---|---|---|---|
| Support agents | 15 | High | New tool (daily); new workflows; SLA visibility | Concerned | 🔴 High |
| Team leaders | 3 | High | Role fundamentally changes (manual → dashboard-driven) | Mixed (1 resistant) | 🔴 High |
| Billing team | 5 | Medium | Moves to SF with support; smaller change | Neutral | 🟡 Medium |
| IT team | 2 | High | Owns SF admin; new technology; no prior SF experience | Supportive but anxious | 🟡 Medium |
| VP Ops / managers | 3 | Low | Reports/dashboards access; minimal daily change | Supportive | 🟢 Low |
| Customers | ~5,000 | Low | Receive confirmations and CSAT surveys — new but positive | Unknown | 🟢 Low |

---

## 3. Process Impact Analysis

| Process | Current state | Future state | Change type | Impact level |
|---|---|---|---|---|
| Case intake | Email received in shared inbox | Email auto-converts to SF case | Automated | Medium — agents stop "checking inbox" |
| Case assignment | Team leader reads emails, assigns manually | Routing rules + queues + Omni-Channel | Eliminated manual step | High for team leaders |
| Case tracking | Excel spreadsheet | SF case timeline, fields, status | Full replacement | High for all agents |
| SLA management | None | Automated SLA tracking, breach alerts | New capability | High — cultural shift |
| Knowledge management | None (tribal knowledge) | SF Knowledge articles | New capability | Medium — requires content creation |
| Customer feedback | None | Auto-CSAT after case close | New capability | Low operationally; high culturally |
| Escalation path | Email-based, informal | SF escalation rules | Formalized | Medium |

---

## 4. Technology Impact

| System / Tool | Status | Action needed |
|---|---|---|
| Email inboxes (shared) | Will remain as email source | Email-to-case connector to configure; inboxes become "feed," not workspace |
| Excel tracker (Artur's) | Replaced by SF | Migrate historical data to SF; decommission Excel; communication required |
| IT knowledge of SF | None | IT admin training + external SF partner for implementation and first 6 months |
| Customer-facing email template | Basic/none | New auto-confirmation email templates to create |

---

## 5. Resistance and Risk Analysis

### R1 — Agent performance anxiety (High risk)
**What:** Agents fear that SLA tracking = permanent performance surveillance. Common reaction in first SF deployments.
**Evidence:** Direct concern raised by agents in pre-change survey.
**Impact if unaddressed:** Passive non-adoption; agents work around SF; data quality poor; business case not realized.
**Mitigation:**
- Frame SLA tracking as "team visibility, not individual scoring" in initial communications
- Show agents what they gain: no more email chain archaeology; clear ownership; less ambiguity
- Manager/team leader comms: agree that SLA metrics will not be used for performance reviews in first 6 months
- Hold a "What does SF change for me?" Q&A session before training

---

### R2 — Artur (team leader) active resistance (High risk)
**What:** Artur built the Excel tracker; sees Salesforce as a threat to his relevance and expertise.
**Evidence:** Identified as resistant by sponsor.
**Impact if unaddressed:** Artur will passively undermine adoption with his team (he manages 5 agents); SF seen as "management project" not "our tool."
**Mitigation:**
- Engage Artur as a co-designer of the routing rules and team dashboard (give him something to own in SF)
- Acknowledge the Excel tracker: "What Artur built served us well; SF builds on that foundation"
- Consider making Artur the team's "SF champion" — public recognition, training, responsibility
- If Artur continues to resist after engagement: escalate to VP Ops for direct sponsor-level conversation

---

### R3 — IT team has no Salesforce admin experience (Medium risk)
**What:** 2-person IT team will own SF admin with no prior experience.
**Impact if unaddressed:** System misconfigured; support delays post-go-live; change requests pile up.
**Mitigation:**
- Contract an external Salesforce partner for implementation AND a 6-month handover period
- Enroll IT lead in Salesforce Admin certification training before go-live
- Document all configurations; no undocumented changes

---

### R4 — Historical data not migrated from Excel (Medium risk)
**What:** 3 years of case history in Excel; customers expect agents to know their history.
**Impact if unaddressed:** Agents lose case context; customer experience degrades at go-live.
**Mitigation:**
- Assess volume and structure of Excel data; determine what is worth migrating
- Minimum viable migration: open and recent cases (last 12 months); archive the rest
- Keep Excel as read-only reference for 90 days post-go-live

---

## 6. Change Impact by Phase

### Phase 1 — Pre-launch (now — Q1 2027)
| Activity | Owner | Timing |
|---|---|---|
| Stakeholder engagement: agents + Artur | VP Ops + PM | October |
| Communication: "What's changing and why" | VP Ops | October |
| Artur co-design sessions (routing rules) | PM + Artur | October–November |
| IT Salesforce admin training | IT lead | October–November |
| SF implementation + configuration | IT + external partner | October–January |
| Data migration (last 12 months) | IT + PM | December–January |
| Agent training (role-based) | External partner + IT | January |
| UAT with 5 agents (pilot group) | PM + agents | January |

### Phase 2 — Go-live (Q1 2027)
| Activity | Owner | Timing |
|---|---|---|
| Parallel run: email inbox + SF for 2 weeks | All agents | Week 1–2 |
| Hypercare support: SF partner on-site | External partner | Week 1–4 |
| Daily check-in: adoption issues | PM | Week 1–4 |
| Decommission Excel tracker (after 90 days) | IT | April |

---

## 7. Change Readiness Score

| Dimension | Score (1–5) | Notes |
|---|---|---|
| Sponsor commitment | 4 | Monika is active and available |
| Leadership alignment | 3 | IT and team leaders need more engagement |
| Employee awareness | 2 | Minimal — change should be communicated immediately |
| Employee willingness | 2 | Concerns identified; not yet addressed |
| Organizational capacity | 3 | IT stretched; agents at full capacity; training time needs to be carved out |
| **Overall readiness** | **2.8 / 5** | **Moderate — requires structured change management** |

---

## 8. Success Metrics

| Metric | Baseline | Target (90 days post-launch) |
|---|---|---|
| All cases logged in SF (not email) | 0% | 100% |
| Average case response time | 6 hours | < 2 hours |
| Agent satisfaction with SF (survey) | N/A | ≥ 3.5 / 5 |
| Customer CSAT (first measurement) | Unknown | Establish baseline |
| Excel tracker decommissioned | Active | Archived |

---

*Change Impact Assessment v1.0 | Salesforce Service Cloud | Meditech S.A. | 2026-09-16*
