---
name: ai-audit-reporter
description: |
  Auto-generate an AI usage audit report for an organization. Use when — (1) user writes `/ai-audit-reporter` or `/ai-audit`, (2) user asks "generate AI audit report", "what AI tools are we using", "AI risk matrix for our org", "audit our AI usage". Gathers evidence from Jira, Confluence, git history, and optional manual input; produces an executive summary, system inventory, data flow map, and risk matrix. Paths A (Enterprise PM) and C (Consulting).
---

# ai-audit-reporter — AI Usage Audit Report Generator

Role: AI Governance Analyst / Enterprise PM. Produces a board-ready AI audit report from available organizational data sources.

---

## Step 0 — Check Available Data Sources

Check which tools are accessible:

**0a. Atlassian MCP**
Call `getAccessibleAtlassianResources`. If available: extract `cloudId` and note that Jira and Confluence are accessible.

**0b. Git history**
Check for a local git repository: run `git log --oneline -50 2>/dev/null | head -20` or equivalent. If available: git log is a data source.

**0c. Local config**
Check for `~/.claude/skills/ai-audit-reporter/config.json`.
- Exists: use stored organization name, Jira project keys, Confluence space keys.
- Missing: proceed to Step 1 setup and save config after.

---

## Step 1 — Gather Organizational Context

Ask in a single message:

```
To generate the AI audit report, I need a few details about your organization:

1. Organization / team name (for report header)
2. Primary Jira project key(s) to scan — e.g. "PROJ, SAL, ENG" (or "all accessible")
3. Confluence space key(s) to search — e.g. "TECH, HR" (or "all accessible")
4. Time range for audit — e.g. "last 6 months", "last 12 months", "all time"
5. Any known AI tools already in use? (list them — even partially — I will verify and expand)
6. Are there any AI tools or systems that are OFF LIMITS for this audit? (e.g., personal tools not on company systems)
```

Save answers to `~/.claude/skills/ai-audit-reporter/config.json`:
```json
{
  "orgName": "<name>",
  "jiraProjects": ["<keys>"],
  "confluenceSpaces": ["<keys>"],
  "auditPeriodMonths": 12,
  "knownAiTools": ["<tool list>"]
}
```

Confirm: "Config saved. Starting audit data collection..."

---

## Step 2 — Data Collection (run in parallel)

### 2a. Jira scan — AI-related tickets

Search Jira for AI mentions using `searchJiraIssuesUsingJql`:

```
text ~ "AI" OR text ~ "LLM" OR text ~ "ChatGPT" OR text ~ "OpenAI" OR text ~ "Claude" OR text ~ "Copilot" OR text ~ "machine learning" OR text ~ "model" ORDER BY created DESC
```

For each project in scope, run separately and merge results. Limit to `created >= -365d` (or configured period).

Extract per ticket:
- Summary, project, status, assignee, reporter, created date
- Any vendor names mentioned (OpenAI, Anthropic, Microsoft, Google, etc.)
- Any data types mentioned (customer data, PII, financial, health)
- Any compliance concerns raised (GDPR, data privacy, security review)

### 2b. Confluence scan — AI documentation, policies, decisions

Search Confluence using `searchConfluence`:
- Query 1: `"AI" AND ("policy" OR "governance" OR "guidelines" OR "approved")`
- Query 2: `"LLM" OR "ChatGPT" OR "Copilot" OR "machine learning" OR "AI tool"`
- Query 3: `"data processing" AND "AI"` (flags data risk documentation)

For each relevant page: extract title, space, last updated, author, and a brief summary of content.

### 2c. Git log scan (if available)

Run: `git log --oneline --all --since="12 months ago" --grep="AI\|LLM\|model\|GPT\|claude\|copilot" --format="%h %ad %s" --date=short`

Extract: commit messages referencing AI tools, model integrations, API key additions (flag these as risk signals).

Also scan for AI-related files: `find . -name "*.py" | xargs grep -l "openai\|anthropic\|langchain\|llm\|gpt" 2>/dev/null | head -20`

### 2d. Manual input prompt (if automated sources are sparse)

If fewer than 5 AI-related items are found across 2a–2c, ask:

```
Automated scan found limited AI-related records. To complete the audit, please provide:

1. List of AI tools your team currently uses (tool name, purpose, who uses it, data it accesses)
2. Any AI vendor contracts or subscriptions you know about
3. Any AI systems integrated into your products or services
4. Any AI usage that might not appear in Jira/Confluence (personal subscriptions, shadow IT)

You can paste a list or describe them — I will structure the information.
```

---

## Step 3 — AI System Inventory

Build the AI System Inventory from all collected data. For each identified AI system, extract or estimate:

| Field | Description |
|---|---|
| System Name | e.g. "GitHub Copilot", "Internal Document Q&A", "GPT-4 via OpenAI API" |
| Vendor / Model | e.g. "Microsoft / OpenAI", "Anthropic Claude", "Custom (open-source)" |
| Use Case | What task does it perform? |
| Users | Who uses it? (team name, role, count if known) |
| Data Accessed | What data does it process? (public data / internal documents / customer PII / financial / health) |
| Deployment Type | SaaS / API / on-prem / embedded in product |
| Approval Status | Formally approved / informal use / unknown |
| GDPR Risk | Low (no personal data) / Medium (internal employee data) / High (customer PII / special category) |
| EU AI Act Tier | Minimal / Limited / High / Prohibited / Undetermined |
| Evidence Source | Jira ticket / Confluence page / git commit / manual input |

Present inventory as a table. Flag systems with GDPR Risk = High or EU AI Act Tier = High with 🔴.

---

## Step 4 — Data Flow Assessment

For each system in the inventory, assess data flows:

**4a. Data Classification Matrix**

| AI System | Input Data Type | Output Data Type | Data Leaves EU? | Training Risk | Notes |
|---|---|---|---|---|---|
| | | | Yes/No/Unknown | Possible/None/Unknown | |

**Data classification guide:**
- **Level 1 — Public:** No personal data, publicly available inputs (e.g., web search, public documents)
- **Level 2 — Internal:** Company-internal but non-personal (code, product specs, internal processes)
- **Level 3 — Personal (employee):** Employee names, roles, performance data, HR information
- **Level 4 — Personal (customer):** Customer names, contact data, behavioral data — GDPR applies
- **Level 5 — Special category:** Health, biometric, financial, legal, religious data — Article 9 GDPR

**4b. Data flow risk flags**

Flag any system where:
- Input data is Level 4 or 5 AND no DPA is confirmed → 🔴 Legal blocker
- Data leaves EU/EEA AND no SCCs or adequacy decision → 🔴 GDPR risk
- Vendor uses data for training AND data is Level 3+ → ⚠️ Verify opt-out
- AI system makes decisions affecting individuals WITHOUT human review → ⚠️ Article 22 risk

---

## Step 5 — Risk Matrix

Build the Risk Matrix. Rate each risk dimension 1–5 (1=low, 5=critical) and calculate overall risk score.

| AI System | Capability Risk | Data Privacy Risk | Compliance Risk | Security Risk | Governance Risk | **Overall Risk** |
|---|---|---|---|---|---|---|
| | /5 | /5 | /5 | /5 | /5 | **avg or max** |

**Dimension definitions:**

- **Capability Risk:** What happens if the AI output is wrong? (1=minor inconvenience, 5=significant harm to people or business)
- **Data Privacy Risk:** What data is processed? Is GDPR/compliance handled correctly?
- **Compliance Risk:** Is this system compliant with applicable regulations? Missing approvals?
- **Security Risk:** Could this system expose sensitive data or be exploited?
- **Governance Risk:** Is there a clear owner? Monitoring? Incident process?

For any system with Overall Risk ≥ 4: produce a short risk detail block:
```
🔴 [System Name] — Risk: X/5
Issue: [specific problem]
Immediate action required: [concrete step]
Owner: [role responsible]
```

---

## Step 6 — Approval Status Audit

Categorize each system:

| Category | Criteria |
|---|---|
| ✅ Formally Approved | Evidence of security/legal/procurement review and sign-off |
| ⚠️ Informal Use | Actively used but no formal approval documented |
| ❓ Unknown | Referenced in data but approval status unclear |
| 🔴 Unapproved High-Risk | High-risk use without any approval trail |

Present the categorization table and count by category.

If `⚠️ Informal Use` or `🔴 Unapproved` systems exist: produce an Action Required list:

```
ACTION REQUIRED — Unapproved AI Systems:

1. [System Name]
   - Current use: [description]
   - Risk level: [High/Medium]
   - Required action: Conduct security review → submit for approval or discontinue use
   - Deadline recommendation: [timeframe based on risk]
   - Owner: [responsible team/role]
```

---

## Step 7 — Produce the Audit Report

Write the full report in the following structure:

---

### AI USAGE AUDIT REPORT
**Organization:** [name]
**Audit period:** [date range]
**Report generated:** [current date]
**Prepared by:** AI Audit Reporter (Claude Code skill)
**Status:** DRAFT — for review before distribution

---

### Executive Summary

**Total AI systems identified:** [N]
**High-risk systems:** [N]
**Systems without formal approval:** [N]
**Data privacy risks flagged:** [N]

**Key findings:**
1. [Finding 1 — most important, concrete]
2. [Finding 2]
3. [Finding 3]

**Immediate actions required:**
1. [Action 1 — with owner and deadline]
2. [Action 2]
3. [Action 3]

---

### Section 1: AI System Inventory
[Table from Step 3]

---

### Section 2: Data Flow Assessment
[Table from Step 4a + risk flags from 4b]

---

### Section 3: Risk Matrix
[Table from Step 5 + red-flag detail blocks]

---

### Section 4: Approval Status
[Table from Step 6 + Action Required list]

---

### Section 5: Recommendations

**Immediate (0–30 days)**
| Action | Owner | Priority |
|---|---|---|
| Obtain DPA for [vendors with Level 4+ data] | Legal / DPO | 🔴 Critical |
| Formal review for unapproved high-risk systems | IT Security / Legal | 🔴 Critical |
| Verify training data opt-out for [specific vendors] | IT / Procurement | ⚠️ High |

**Short-term (30–90 days)**
| Action | Owner | Priority |
|---|---|---|
| Establish AI usage policy and approval process | IT Governance | ⚠️ High |
| Assign AI Risk Owners for all high-risk systems | Management | ⚠️ High |
| Implement AI system register (ongoing inventory) | IT / PMO | Medium |

**Ongoing**
| Action | Owner | Cadence |
|---|---|---|
| Quarterly AI usage review | IT Security | Every 3 months |
| AI system register update | Team leads | As new tools adopted |
| Vendor compliance re-verification | Legal / Procurement | Annual |

---

### Section 6: Methodology & Limitations

**Data sources used:**
- Jira: [N tickets scanned, project keys]
- Confluence: [N pages scanned, spaces]
- Git log: [if used — N commits analyzed]
- Manual input: [if used]

**Limitations:**
- Shadow IT: personal subscriptions not connected to company systems are not captured
- This report reflects AI usage that left a documented trace. Undocumented usage may exist.
- Compliance assessment is based on available documentation — legal review is required before treating any item as confirmed compliant or non-compliant.

---

## Output Format

Default output: Markdown document printed to conversation.

If user requests a file: offer to write to `~/ai-audit-report-YYYY-MM-DD.md`.

---

## Error Handling

- **MCP unavailable:** Proceed with manual input mode (Step 1 expanded questionnaire) and git log only. Flag report as "limited data sources."
- **No AI-related records found in Jira/Confluence:** Proceed to manual input prompt (Step 2d). Do not produce an empty inventory.
- **Permission denied on git log:** Skip 2c, note in Section 6 Limitations.

---

## Quick Reference

| Command | Action |
|---|---|
| `/ai-audit-reporter` | Full audit — start from Step 1 |
| `/ai-audit-reporter --quick` | Skip setup questions, use saved config, produce summary only |
| `/ai-audit-reporter --inventory-only` | Produce Section 1 (system inventory) only |
| `/ai-audit-reporter reset` | Delete `config.json` and re-run setup |
