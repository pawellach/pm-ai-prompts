# pm-ai-prompts — Roadmapa

*Ostatnia aktualizacja: 2026-10-31 · Wersja aktualna: v2.2.1*

---

## Historia — co zrobiono

| Wersja | Data | Co |
|---|---|---|
| v1.5.0 | 2026-09-16 | examples/ (18 par input/output), confluence-page-from-template, azure-devops-work-item-triage, interview-prep-coach, ai-readiness-assessment, business-case-writer, technical-discovery-facilitator |
| v1.6.0 | 2026-09-23 | consulting-proposal-writer, sow-generator, change-management-planner, consulting-client-status-pack, executive-presentation-builder |
| v1.8.0 | 2026-10-07 | sprint-close-synthesizer, stakeholder-update-generator, post-project-review, ai-product-spec |
| v1.9.0 | 2026-10-08 | jira-intake v2 — state management, registry.json, workload awareness, cross-ticket intelligence, stats view, bridge do requirements-analyst |
| v2.0 | 2026-10-15 | offer-evaluation-framework, salary-negotiation-script, linkedin-outreach-writer |
| v2.1 | 2026-10-22 | ai-governance-framework, model-evaluation-scorecard, ai-audit-reporter |
| v2.2 | 2026-10-29 | project-status-escalation, scope-creep-detector, requirements-analyst upgrade (tryb gap-analysis) |
| v2.2.1 | 2026-10-31 | ai-use-case-prioritizer, client-value-narrative-builder, confluence-program-dashboard, opportunity-solution-tree, assumptions-mapper, interview-toolkit, prioritize-features |
| v2.3 | 2026-10-31 | data-product-spec, kpi-dashboard-designer, confluence-program-dashboard upgrade (ASCII viz) |
| v2.3 | 2026-10-31 | data-product-spec, kpi-dashboard-designer, confluence-program-dashboard upgrade (ASCII health viz) |

---

## Plan — co i kiedy

### ✅ Sprint 2.2.1 (v2.2.1) — DONE 2026-10-31

- ✅ `prompts/ai-use-case-prioritizer.md` — lista życzeń klienta → priorytetyzacja AI use case'ów: wartość vs effort, dane, ryzyko
- ✅ `prompts/client-value-narrative-builder.md` — praca techniczna → ROI dla executive; "3 systemy → czas decyzji −40%"
- ✅ `skills/confluence-program-dashboard/` — health dashboard programu z Jiry + Confluence (poziom portfolio)
- ✅ `skills/opportunity-solution-tree/` — OST wg Torres, output jako Jira epic tree
- ✅ `skills/assumptions-mapper/` — macierz confidence × impact, output: tickety walidacyjne do Jiry
- ✅ `skills/interview-toolkit/` — script + prowadzenie + summarize w jednym flow, output Confluence-ready
- ✅ `skills/prioritize-features/` — RICE/ICE/WSJF/MoSCoW jako komendy + outcome-roadmap

---

### ✅ Sprint 9 (v2.3) — DONE 2026-10-31

- ✅ `prompts/data-product-spec.md` — spec na produkt danych: definicja, metryki jakości (freshness SLA, completeness, lineage), własność, downstream consumers
- ✅ `prompts/kpi-dashboard-designer.md` — od pytania biznesowego do spec dashboardu: hierarchia KPI (north star → leading → lagging), układ widoku, brief dla BI developera
- ✅ `skills/confluence-program-dashboard/` — **upgrade**: ASCII/text wizualizacja health metrics (progress bar, RAG traffic light, trend arrow ↑↓→)

---

### Sprint 13 (v2.6) — zaplanowany 2026-11-12

Strategy + Market Research Layer (~4h):

- [ ] `skills/product-strategy-builder/` — vision + lean-canvas + value-proposition w jednym workflow; output: 1-page strategy doc + OKR seed + Jira output
- [ ] `skills/market-intelligence/` — competitor-analysis + battlecard; Salesforce-specific positioning (CFO/Mid-market ERP), output: Confluence page + CRM battlecard
- [ ] `prompts/user-personas-jtbd.md` — persony przez Jobs-to-be-Done (functional + emotional + social job), kontekst enterprise B2B
- [ ] `prompts/customer-journey-map.md` — journey z friction jako opportunity spaces (Torres linkage); stage → action → pain → opportunity → OST-ready
- [ ] `prompts/market-sizing.md` — TAM/SAM/SOM bottom-up i top-down; gotowy przykład Salesforce ecosystem sizing

---

### Sprint 10 (v2.5) — zaplanowany 2026-11-12

Integration & Ecosystem (~5h):

- [ ] `prompts/api-product-spec.md` — spec API: endpoints (REST/GraphQL), auth, rate limiting, versioning, breaking-change policy
- [ ] `skills/github-pr-to-release-notes/` — **upgrade**: breaking changes (semver major bump), migration guide stub, Keep a Changelog wariant
- [ ] `skills/jira-sync/` — **upgrade**: integracja z registry.json z jira-intake; przy zamknięciu ticketu aktualizuje status w registry

---

### Sprint 14 (v2.7) — zaplanowany 2026-11-19

Execution Upgrades — Red-team, Pre-mortem, WWAS (~3h):

- [ ] `skills/strategy-red-team/` — steelman + attack + rank failure modes (impact × likelihood × cheapness-to-test); output: Jira risk register + linkowanie do assumption tickets z OST
- [ ] `skills/pre-mortem/` — "wyobraź sobie że projekt się nie udał" → dlaczego? → mitigation; wariant dla AI product (model failed / data drift / adoption failure); output: Jira epic z risk mitigation tasks
- [ ] `prompts/job-stories.md` — JTBD job stories (When I... I want to... So I can...); outcome metric per story + połączenie z OST opportunities
- [ ] `prompts/sprint-wwas.md` — What Worked / What didn't / Action / System change; output: Jira follow-up tickety + Confluence team health history

---

### Sprint 11 (v3.0) — zaplanowany 2026-11-26

Multi-Agent PM Platform — przepisanie architektury (~10h):

- [ ] `~/.claude/skills/shared/registry.json` — globalny shared state: tickety (jira-intake), releases (jira-sync), sprinty (sprint-close-synthesizer)
- [ ] `skills/pm-ai-orchestrator/` — orkiestrator: pytanie PM-a → właściwy skill + pre-loaded kontekst z registry
- [ ] `skills/weekly-pm-briefing/` — poniedziałkowy briefing (cron 9:00): sprint status z Jiry + kluczowe decyzje + workload alert + komunikacja do wysłania
- [ ] `docs/pm-ai-system-overview.md` — diagram przepływu danych między skillami, use cases per rola (PM / Analyst / Consultant / FDM), quick-start

---

## Strategia różnicowania vs phuryn/pm-skills

*Analiza 2026-10-31 — 9 pluginów Huryna, 69 skills, 42 komendy*

**Huryn = framework-first** (Torres/Cagan/Savoia), generyczny PM w SaaS.
**Nasze repo = tooling-native** (Jira/Linear/Confluence/Salesforce), enterprise-ready, z warstwą kariery i consultingu.

Reguła: bierzemy najlepsze idee Huryna → przepisujemy z integracją narzędziową i kontekstem enterprise B2B SaaS. Każdy skill kończy się **gotowym outputem do Jiry/Confluence** — to jest różnica między 10/10 a 15/10.

**Unikalna wartość których Huryn nie ma:**
- Salesforce layer (salesforce-newsletter-editor, salesforce-create-internal-user)
- Jira/Linear/Confluence native z shared state (registry.json) — głębsza integracja
- Career layer z negocjacjami i outreachem (4 narzędzia vs 2 u Huryna)
- Consulting/FDM layer (SOW, change-impact, technical-discovery, client-status-pack)
- Enterprise governance (ai-governance-framework, scope-creep-detector)
