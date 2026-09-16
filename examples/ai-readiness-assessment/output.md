# Sample Output — ai-readiness-assessment

# AI Readiness Assessment
**Client:** ProMetal Sp. z o.o.
**Assessment date:** 2026-09-16
**Sponsor:** Marek Żurawski, COO
**Prepared by:** [Consultant name]
**Version:** 1.0 DRAFT

---

## 1. Executive Summary

**Assessment scope:** Enterprise-wide AI readiness across People, Processes, Data, and Technology dimensions. Assessment based on stakeholder interviews and document review.

**Overall readiness level: 2.1 / 5 — Developing**
ProMetal has the raw ingredients for AI adoption — years of operational data, identified use cases, and a board mandate — but lacks the organizational foundations to execute successfully at this time. The primary blockers are change fatigue from a recent failed ERP upgrade, absence of any data/AI skills in-house, and data that is collected but not curated.

**Top 3 strengths:**
1. Concrete, high-value AI use cases already identified (predictive maintenance, quality vision, demand forecasting)
2. 8 years of ERP data + MES machine sensor history provides a potential training data asset
3. COO sponsorship gives the initiative credibility and access

**Top 3 blockers:**
1. Zero in-house AI/ML capability — any meaningful work requires external partners + internal upskilling
2. Change fatigue is real and unaddressed — launching AI without a trust-repair plan risks another failed initiative
3. Quality control data is on paper — the highest-value AI use case (vision QC) cannot be built without digitization first

**Recommended first initiative:** Predictive maintenance pilot on 2 CNC machines using existing MES sensor data. Requires no new infrastructure, has an identifiable data owner (factory manager), and can show ROI within 60 days.

---

## 2. AI Maturity Matrix

| Dimension | Score (1–5) | Evidence | Key strength | Key gap |
|---|---|---|---|---|
| People | 1.5 | No AI/ML skills; SQL capability in IT; Excel-based BI in Finance | SQL and reporting foundation exists | No AI/ML engineers; change fatigue risk |
| Processes | 2.0 | MES collects data but unused; QC still paper-based; ERP tracks maintenance partly | Well-defined manufacturing processes | Digitization gaps; no process automation culture |
| Data | 2.5 | 8 years ERP data, MES sensor history, but no governance, no data catalog | Longitudinal operational data exists | No governance; quality data not digitized; siloed |
| Technology | 2.5 | Cloud-ready ERP; MES in place; standard IT infra | Modern ERP foundation | No cloud AI services; no integration platform; shadow IT (Excel) |

**Overall: 2.1 — Developing**

---

## 3. Dimension Deep-Dives

### 3.1 People (Score: 1.5)

**Current state:**
The 4-person IT team handles infrastructure and internal development but has no exposure to data science, machine learning, or AI tooling. The two internal developers are proficient in SQL and build reports on demand, which provides a minimal analytical foundation. The Finance analyst maintains Excel dashboards that the business relies on for operational decisions.

The more significant challenge is organizational. The failed ERP upgrade has created a climate where employees — especially shop floor workers and middle management — associate large technology initiatives with disruption, broken promises, and extra work. Any AI initiative that does not explicitly address this trust deficit will face the same resistance that derailed the ERP.

**Gaps:**
- No one can own, build, or maintain an AI model internally
- No structured learning & development plan for data literacy
- No internal change management capability

**What "Level Up" requires (to reach Level 3):**
- Hire or designate one Data/AI product owner (internal champion, not a builder)
- Engage an external AI/ML partner for model development and first 12 months of operation
- Run a 2-day data literacy workshop for the COO, factory managers, and IT lead
- Address the change fatigue explicitly in the AI roadmap communication plan

---

### 3.2 Processes (Score: 2.0)

**Current state:**
ProMetal's manufacturing processes are well-understood and documented in the MES and ERP — this is the foundation for AI. However, the MES sensor data is collected but not used: no one reviews it systematically, no alerts are configured, and factory managers rely on experience rather than data for maintenance decisions.

The quality control process is entirely paper-based. Checklists are filled by operators, filed physically, and sampled by QC supervisors. This creates a significant barrier for the highest-potential AI use case (vision-based quality inspection) — the training data does not exist in digital form.

**Gaps:**
- QC digitization is a prerequisite for vision AI, not a parallel track
- Maintenance data is split between ERP (scheduled) and Excel (actual/ad hoc), creating an unreliable history
- No current process automation (no RPA, no workflow tools) — AI would be the first significant automation investment

**What "Level Up" requires:**
- Digitize QC checklists (simple app or even Google Forms) — 8-10 weeks, low cost
- Consolidate maintenance log data into ERP — cleaning exercise, owned by factory managers
- Identify 2-3 "AI process owners" in operations who will be accountable for adoption

---

### 3.3 Data (Score: 2.5)

**Current state:**
ProMetal's strongest asset is its operational data history. The ERP holds 8 years of order, materials, and financial data. The MES collects continuous machine sensor data (vibration, temperature, cycle time) going back at least 3 years for the main CNC machines. This is rare for a 320-person manufacturer and is a genuine competitive advantage for AI adoption.

However, the data is not governed. There is no data dictionary, no quality SLA, no ownership model. The MES data has not been validated — sensor calibration history is unknown. The maintenance log split across ERP and Excel means any model trained on maintenance data will have gaps and inaccuracies that must be resolved before training.

**Gaps:**
- No data governance or ownership structure
- Quality control data not digitized (paper-based)
- No data catalog — unknown which MES sensors are reliable vs miscalibrated
- Master data (customer, product) not reconciled across ERP and legacy systems

**What "Level Up" requires:**
- Conduct a data audit for the predictive maintenance pilot: validate 3 years of MES sensor data for the pilot machines
- Assign a "data steward" role to the IT developer who builds reports — formalize with 20% time allocation
- Start a simple data catalog (even a shared spreadsheet) listing key data sources, owners, quality status

---

### 3.4 Technology (Score: 2.5)

**Current state:**
The core infrastructure is adequate for AI adoption. Comarch Optima ERP is modern enough to expose data via API or export. The MES runs on Windows servers on-premises. IT manages a standard setup with no obvious blockers.

The risk is the absence of cloud AI services and the lack of integration capability. Any ML workloads (model training, inference) would need to run on cloud infrastructure that does not currently exist. There is no integration platform — systems communicate via scheduled exports and manual processes. Shadow IT in the form of Excel files is significant.

**Gaps:**
- No cloud AI infrastructure (Azure ML, AWS SageMaker, or equivalent)
- No integration platform — data pipelines are manual
- No API layer for MES data — export only
- Security policy for cloud data transfer not defined (GDPR relevant for customer data)

**What "Level Up" requires:**
- Choose a cloud provider and set up a sandboxed AI environment (Azure recommended — Comarch Optima integrates well)
- Define data classification policy: which data can leave the organization for cloud AI services
- Establish a basic data pipeline from MES → cloud storage for the pilot machines

---

## 4. Prioritized Roadmap

### Quick Wins — 0–90 days

| Initiative | Dimension | Expected outcome | Owner | Effort |
|---|---|---|---|---|
| Predictive maintenance pilot (2 CNC machines) | Data + Technology | Demonstrate AI feasibility; first model showing anomaly prediction | IT lead + Factory manager | Medium |
| MES data audit for pilot machines | Data | Validated 3-year sensor dataset; known data quality level | IT developer | Low |
| Digitize QC checklists (Forms/app) | Processes | Digital QC data collection starts; prerequisite for vision AI | IT + QC Supervisor | Low |
| AI literacy workshop (COO + factory managers + IT) | People | Shared understanding of AI capabilities/limits; buy-in | External facilitator | Low |
| Cloud sandbox setup (Azure) | Technology | Infrastructure ready for model training | IT lead | Low |

### Foundation — 3–6 months

| Initiative | Dimension | Expected outcome | Owner | Effort |
|---|---|---|---|---|
| Predictive maintenance — production deployment | Technology | Live alert system on all CNC machines; documented ROI | External AI partner + IT | High |
| Maintenance log consolidation in ERP | Data | Single source of truth for maintenance history | Factory managers + IT | Medium |
| Data steward role formalized | Data | Data ownership model established; quality tracking starts | IT developer | Low |
| Demand forecasting pilot (ERP data) | Data + Processes | First model for raw material demand; reduces overstock | Finance + IT | Medium |

### Strategic — 6–12 months

| Initiative | Dimension | Expected outcome | Owner | Effort |
|---|---|---|---|---|
| Vision-based quality inspection pilot | Processes + Technology | Camera + AI model for defect detection; QC labor reduction | External partner + QC | High |
| Data platform (basic DWH or data lake) | Data | Unified data store across ERP + MES + QC; foundation for analytics | IT + external | High |
| Internal AI product owner hire | People | In-house capability to run AI roadmap | HR + COO | Medium |
| Change management program (AI adoption) | People | Structured communication and training plan for 320 employees | HR + COO + change mgmt | Medium |

---

## 5. Investment Estimate

| Category | 0–90 days | 3–6 months | 6–12 months | Total (12 months) |
|---|---|---|---|---|
| External AI/ML partner | €15,000–25,000 | €40,000–60,000 | €60,000–90,000 | €115,000–175,000 |
| Cloud infrastructure (Azure) | €1,000–2,000 | €3,000–6,000 | €8,000–15,000 | €12,000–23,000 |
| Training & workshops | €5,000–8,000 | €5,000–10,000 | €10,000–20,000 | €20,000–38,000 |
| Internal IT time (est.) | €6,000 | €15,000 | €25,000 | €46,000 |
| **Total estimate** | **€27,000–41,000** | **€63,000–91,000** | **€103,000–150,000** | **€193,000–282,000** |

**Note:** These are rough order-of-magnitude estimates. A detailed business case should be produced for each initiative before budget approval.

---

## 6. Key Risks

| Risk | Probability | Impact | Mitigation |
|---|---|---|---|
| Change fatigue derails adoption despite technical success | High | High | Lead with communication plan; involve factory managers as co-owners, not recipients |
| MES sensor data quality too poor for reliable models | Medium | High | Data audit in 90-day phase; do not invest in full deployment until audit complete |
| External AI partner dependency without knowledge transfer | Medium | High | Contract must include training and documentation; internal AI owner hire in parallel |
| Scope creep — board demands all 3 use cases simultaneously | High | Medium | Present roadmap as deliberate sequencing, not delay; one pilot at a time builds credibility |
| GDPR / data sovereignty issue for cloud AI | Low | Medium | Legal review of data classification before cloud setup; anonymize/aggregate where needed |

---

## 7. Recommended First Pilot: Predictive Maintenance on CNC Machines

**Use case:** Predict machine failure 24–72 hours before it occurs, enabling planned maintenance instead of reactive repair.

**Why this first:**
- Data exists (MES sensor data, 3+ years)
- Process is well understood (maintenance already happens — AI improves it, doesn't replace it)
- No customer data → lower GDPR risk
- Factory manager is a natural owner
- ROI is quantifiable (unplanned downtime cost vs planned maintenance cost)

**Data needed:** MES sensor streams (vibration, temperature, cycle time) for 2 target machines + maintenance event history from ERP.

**Success metrics:**
- Model accuracy: >80% precision for failure prediction within 72h window
- Reduction in unplanned downtime: target 30% within 6 months of deployment
- Maintenance cost reduction: target 15%

**Who owns it:** Factory Manager + IT Developer + External AI Partner

**Timeline:** 8-week pilot, 4-week deployment, 8-week measurement period.

---

*Assessment v1.0 | ProMetal Sp. z o.o. | 2026-09-16*
*Next step: Share with COO for validation. Produce detailed business case for Q4 board presentation.*
