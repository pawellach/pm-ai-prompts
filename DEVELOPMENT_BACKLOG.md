# pm-ai-prompts — Development Backlog

Wszystkie planowane rozszerzenia repozytorium, pogrupowane według ścieżki kariery i priorytetu.
Aktualizować po każdej sesji roboczej.

Last updated: 2026-09-23

---

## Wersja aktualna: v1.5.0

Zrobione v1.5.0: 4 prompty (interview-prep-coach, ai-readiness-assessment, business-case-writer,
technical-discovery-facilitator) + 2 skille (confluence-page-from-template, azure-devops-work-item-triage)
+ examples/ dla wszystkich 21 promptów (18 nowych par).

---

## Mid-term — v1.6.0

| Co | Typ | Priorytet |
|---|---|---|
| `prompts/consulting-proposal-writer.md` | Prompt | Wysoki |
| `prompts/sow-generator.md` | Prompt | Wysoki |
| `prompts/change-management-planner.md` | Prompt | Wysoki |
| `skills/consulting-client-status-pack/` | Skill Claude Code | Wysoki |
| `prompts/executive-presentation-builder.md` | Prompt | Wysoki |
| README — sekcja "How to use with Claude Code" z video/gif | Dokumentacja | Niski |

---

## Backlog — Ścieżka B: Job Search (etat)

Prompty do `career/`:

| Plik | Opis | Priorytet |
|---|---|---|
| `career/interview-prep-coach.md` | Company research + role-specific Q&A + STAR coaching per pytanie. Wersja PM/AI/Salesforce | Wysoki |
| `career/salary-negotiation-script.md` | Od oferty → strategia negocjacji, język counter-offeru, BATNA, walk-away point | Wysoki |
| `career/linkedin-outreach-writer.md` | Cold/warm wiadomości do rekruterów i hiring managerów — ton który nie brzmi jak spam | Średni |
| `career/offer-evaluation-framework.md` | Porównanie wielu ofert: total comp, learning curve, brand value, remote, exit options | Średni |

---

## Backlog — Ścieżka C: Consulting (L2Studio)

Prompty do `prompts/`:

| Plik | Opis | Priorytet |
|---|---|---|
| `prompts/consulting-proposal-writer.md` | Brief klienta → pełna propozycja: zakres, podejście, timeline, struktura cenowa | Wysoki |
| `prompts/sow-generator.md` | Z zatwierdzonej propozycji → Statement of Work gotowy do podpisania | Wysoki |
| `prompts/ai-readiness-assessment.md` | Audyt dojrzałości AI klienta: ludzie, procesy, dane, technologia — output: matryca + roadmap | Wysoki |
| `prompts/ai-use-case-prioritizer.md` | Lista życzeń klienta → priorytetyzacja use case'ów AI (wartość vs effort, dane, ryzyko) | Wysoki |
| `prompts/case-study-writer.md` | Notatki z projektu → anonimizowane case study: outcomes-focused, bez liczb NDA | Średni |
| `prompts/change-request-evaluator.md` | Zmiana zakresu → analiza wpływu na czas/budżet/ryzyko, rekomendacja | Średni |

Skille Claude Code:

| Katalog | Opis | Priorytet |
|---|---|---|
| `skills/consulting-client-status-pack/` | Weekly pack dla klienta: status, ryzyka, decyzje potrzebne, next steps — z Jiry + notatek | Wysoki |
| `skills/proposal-from-template/` | Wypełnia szablon propozycji z kontekstem rozmowy lub briefu | Średni |

---

## Backlog — Ścieżka A: Enterprise PM / AI Product Manager

Prompty do `prompts/`:

| Plik | Opis | Priorytet |
|---|---|---|
| `prompts/business-case-writer.md` | Od okazji → uzasadnienie inwestycji: problem, rozwiązanie, ROI, ryzyka, ask dla sponsora | Wysoki |
| `prompts/executive-presentation-builder.md` | Outline + talking points dla C-suite (struktura i narracja, nie slajdy) | Wysoki |
| `prompts/initiative-portfolio-scorer.md` | Priorytetyzacja wielu inicjatyw: ważony scoring, ograniczenia zasobów, konflikty | Średni |
| `prompts/change-management-planner.md` | Analiza interesariuszy, mapa oporu, plan komunikacji dla transformacji / AI adoption | Wysoki |
| `prompts/program-governance-setup.md` | Framework governance dla multi-project program: komitety, reporting, escalation path | Średni |

Skille Claude Code:

| Katalog | Opis | Priorytet |
|---|---|---|
| `skills/confluence-program-dashboard/` | Health dashboard programu z Jiry + Confluence (poziom portfolio, nie sprint) | Wysoki |
| `skills/quarterly-business-review-builder/` | QBR pack ze źródeł danych: co zrobiono, wyniki vs plan, next quarter priorities | Średni |

---

## Backlog — Ścieżka D: FDM (Forward Deployment Manager)

Prompty do `prompts/` (narzędzia pracy u klienta, nie zarządzania projektem):

| Plik | Opis | Priorytet |
|---|---|---|
| `prompts/technical-discovery-facilitator.md` | Structured discovery z tech + biznes: mapowanie systemów, data flows, pain points, integration gaps. FDM day 1–5 | Wysoki |
| `prompts/client-value-narrative-builder.md` | Praca techniczna → ROI dla executive. "3 systemy zintegrowane" → "czas decyzji skrócony o 40%" | Wysoki |
| `prompts/data-strategy-advisor.md` | Od pytania biznesowego → wymagania na dane → ścieżka implementacji | Wysoki |
| `prompts/rapid-prototype-brief.md` | Problem statement → spec prototypu → demo script. FDM dostarcza PoC w tygodniu | Średni |
| `prompts/stakeholder-trust-builder.md` | Mapa interesariuszy u klienta: sojusznicy, blokujący, realna vs formalna władza, strategia | Wysoki |

Skille Claude Code:

| Katalog | Opis | Priorytet |
|---|---|---|
| `skills/technical-discovery-synthesizer/` | Notatki + dokumenty klienta → mapa systemów, luki, rekomendowane pytania follow-up | Wysoki |
| `skills/demo-prep-assistant/` | Product docs + client context → scenariusze demo, test data, talking points per stakeholder | Średni |

---

## Narzędzia PM i consultingowe — NIE używam (potencjalne integracje)

### Project & Task Management
| Narzędzie | Dlaczego nie używam | Potencjalna integracja |
|---|---|---|
| Notion | Nie w stacku | Notion MCP → skills/notion-project-page |
| ClickUp | Nie w stacku | ClickUp API → skill |
| Monday.com | Nie w stacku | Monday API |
| Asana | Nie w stacku | Asana MCP |
| Trello | Zbyt proste | — |
| Basecamp | Nie w stacku | — |
| Smartsheet | Enterprise, nie mam | Smartsheet API |
| GitHub Issues | Używam git, nie Issues do PM | GitHub MCP → skill |

### Data & Reporting
| Narzędzie | Dlaczego nie używam | Potencjalna integracja |
|---|---|---|
| Power BI | Nie wdrożone | Power BI REST API |
| Tableau | Nie wdrożone | Tableau MCP (beta) |
| Airtable | Nie w stacku | Airtable API → skill |
| Looker | Enterprise, nie mam | — |

### CRM & Sales (przydatne przy consultingu)
| Narzędzie | Dlaczego nie używam | Potencjalna integracja |
|---|---|---|
| HubSpot | L2Studio nie ma CRM | HubSpot MCP → consulting pipeline |
| Pipedrive | Nie w stacku | Pipedrive API |
| Zoho CRM | Nie w stacku | — |

### Collaboration & Docs
| Narzędzie | Dlaczego nie używam | Potencjalna integracja |
|---|---|---|
| Miro / Mural | Brak integracji AI | Miro REST API → diagram export |
| Coda | Nie w stacku | Coda API |
| Slite | Nie w stacku | — |
| Loom | Brak | Loom API (transkrypcje) |

### DevOps & Engineering (dla FDM/technical roles)
| Narzędzie | Dlaczego nie używam | Potencjalna integracja |
|---|---|---|
| Azure DevOps | Tylko archiwum (Symfonia) | ✅ `skills/azure-devops-work-item-triage` — wydane v1.5.0 |
| GitLab | Nie w stacku | GitLab MCP |
| Buildkite / CircleCI | Nie w stacku | CI API → release-manager extension |

---

## Kolejność realizacji (sugerowana)

### ✅ Sprint 1 (v1.5.0) — DONE 2026-09-16
1. ✅ `confluence-page-from-template` skill
2. ✅ `azure-devops-work-item-triage` skill
3. ✅ `examples/` dla wszystkich 21 promptów
4. ✅ `career/interview-prep-coach.md`
5. ✅ `prompts/ai-readiness-assessment.md`
6. ✅ `prompts/business-case-writer.md`
7. ✅ `prompts/technical-discovery-facilitator.md`

### ✅ Sprint 2 (v1.6.0) — DONE 2026-09-23
1. `prompts/consulting-proposal-writer.md`
2. `prompts/sow-generator.md`
3. `prompts/change-management-planner.md`
4. `skills/consulting-client-status-pack/`
5. `prompts/executive-presentation-builder.md`

### Sprint 3 (v1.7.0) — ~3h pracy — zaplanowany na 2026-09-30 12:00
1. `career/salary-negotiation-script.md` — od oferty → strategia negocjacji, counter-offer, BATNA, walk-away (ścieżka B)
2. `career/linkedin-outreach-writer.md` — cold/warm outreach do rekruterów; ton który nie brzmi jak spam (ścieżka B)
3. `prompts/ai-use-case-prioritizer.md` — lista życzeń klienta → priorytetyzacja AI use case'ów: wartość vs effort, dane, ryzyko (ścieżka C)
4. `prompts/client-value-narrative-builder.md` — praca techniczna → ROI dla executive; "3 systemy → czas decyzji −40%" (ścieżka D)
5. `skills/confluence-program-dashboard/` — health dashboard programu z Jiry + Confluence: poziom portfolio, nie sprint (ścieżka A)

### ✅ Sprint 4 (v1.8.0) — Living Project Intelligence — DONE 2026-10-07
1. ✅ `skills/sprint-close-synthesizer/` — koniec sprintu: pull zamkniętych ticketów z Jiry → velocity, przeniesienia, seed planowania następnego; dopełnienie jira-sync
2. ✅ `skills/stakeholder-update-generator/` — Jira + commit log → gotowy update per audience (exec/team/client); różny ton, różna głębokość
3. ✅ `prompts/post-project-review.md` — project closure: lessons learned, outcomes vs. plan, materiał na case study
4. ✅ `prompts/ai-product-spec.md` — spec dla AI feature: wymagania na model, kryteria eval, fallback behavior, bias considerations

### ✅ Sprint 5 (v1.9.0) — jira-intake v2: Internal Records — DONE 2026-10-08
Upgrade `skills/jira-intake/` o warstwę state management — bezstanowość to obecna główna słabość skilla.

**Co dodano:**
1. ✅ **Historia lokalna** — `~/.claude/skills/jira-intake/history/<TICKET>.md` z pełną analizą, datą, assignee, complexity. Powtórne uruchomienie na tym samym tickecie wykrywa poprzednią analizę
2. ✅ **Registry** — `registry.json`: lista przetworzonych ticketów (date, assignee, complexity, epic). Ładowany przy każdym intake jako kontekst
3. ✅ **Workload awareness** — przed przypisaniem sprawdza registry: ile otwartych intake ma dany dev w bieżącym tygodniu
4. ✅ **Cross-ticket intelligence** — przy nowym tickecie: kolizje w tym samym komponencie/epiku/assignee z otwartymi ryzykami
5. ✅ **Stats view** — `/jira-intake stats`: wzorce complexity per komponent, rozkład assignee, recurring open questions
6. ✅ **Bridge do requirements-analyst** — gdy complexity=Complex: "Chcesz pełną analizę wymagań? (`/requirements-analyst <TICKET>`)"

---

### Sprint 6 (v2.0) — Career Intelligence Layer — ~4h — zaplanowany na 2026-10-15 12:00

Prompty dla ścieżki B (Job Search / etat) — narzędzia kariery oparte na danych rynkowych:

1. `career/offer-evaluation-framework.md` — porównanie wielu ofert jednocześnie: total comp (base + bonus + equity + benefits), learning curve, brand value, remote/hybrid policy, exit options w perspektywie 2 lat; output: scoring matrix + rekomendacja + pytania negocjacyjne
2. `career/salary-negotiation-script.md` — od oferty do zamknięcia: strategia counter-offeru, BATNA, walk-away point, konkretne zdania do wypowiedzenia lub napisania; uwzględnia różne kultury negocjacji (US vs PL vs remote-first)
3. `career/linkedin-outreach-writer.md` — cold/warm wiadomości do rekruterów i hiring managerów; ton który nie brzmi jak spam; warianty: "szukam aktywnie", "otwarty na propozycje", "polecenie od znajomego"

---

### Sprint 7 (v2.1) — AI Governance & Policy — ~3h — zaplanowany na 2026-10-22 12:00

Prompty dla AI Product Managera i Consultanta — odpowiedź na rosnące zapotrzebowanie na AI governance w enterprise:

1. `prompts/ai-governance-framework.md` — risk assessment dla AI deploymentu w organizacji: GDPR compliance, bias evaluation, accountability matrix (kto odpowiada za co gdy model się myli), escalation path; output: gotowy framework do zatwierdzenia przez prawnika i zarząd
2. `prompts/model-evaluation-scorecard.md` — structured evaluation LLM/AI vendors przed zakupem: capabilities (benchmark vs task-specific), costs (tokens, fine-tuning, infra), compliance (data residency, SOC2, GDPR), integration complexity; output: scorecard z rekomendacją i uzasadnieniem
3. `skills/ai-audit-reporter/` — Claude Code skill: auto-raport AI usage w organizacji (jakie modele, przez kogo, do czego, jakie dane przetwarzają); dane z Jiry + confluence + git log; output: executive summary + risk matrix

---

### Sprint 8 (v2.2) — Consulting Operations — ~4h — zaplanowany na 2026-10-29 12:00

Narzędzia dla consultanta zarządzającego projektami i scope'em:

1. `prompts/project-status-escalation.md` — kiedy i jak eskalować: 3-poziomowa matryca (sponsor / steering / board), gotowe maile dla każdego poziomu, zasada "no surprise escalation", timing (kiedy najlepiej eskalować w tygodniu)
2. `prompts/scope-creep-detector.md` — analiza scope vs SOW: flagowanie nieautoryzowanych zmian, klasyfikacja (gold-plating / misunderstanding / genuine new req), propozycja change order z ceną i uzasadnieniem
3. `skills/requirements-analyst/` — **upgrade** istniejącego skilla: nowy tryb `gap-analysis` — porównuje istniejący system (dokumentacja/Confluence) z wymaganiami, identyfikuje luki i sprzeczności, output: gap register z priorytetami

---

### Sprint 9 (v2.3) — Data & Analytics PM — ~4h — zaplanowany na 2026-11-05 12:00

Narzędzia dla PM-a pracującego z danymi i dashboardami:

1. `prompts/data-product-spec.md` — spec na produkt danych: definicja (co to jest, kto używa), metryki jakości (freshness SLA, completeness, lineage), własność, tryb dostępu, downstream consumers; output: spec gotowy do review przez Data Engineering
2. `prompts/kpi-dashboard-designer.md` — od pytania biznesowego do spec dashboardu: hierarchia KPI (north star → leading → lagging), wymagania na dane (źródło, granulacja, odświeżanie), układ widoku; output: brief dla BI developera
3. `skills/confluence-program-dashboard/` — **upgrade** istniejącego skilla: dodaj ASCII/text wizualizację health metrics (progress bar, RAG traffic light, trend arrow ↑↓→) dla środowisk bez obsługi HTML/markdown rich

---

### Sprint 10 (v2.5) — Integration & Ecosystem — ~5h — zaplanowany na 2026-11-12 12:00

Rozszerzenia istniejących skilli + nowe narzędzia dla architektów integracji:

1. `prompts/api-product-spec.md` — spec API produktu: endpoints (REST/GraphQL), auth (OAuth2/API key/SAML), rate limiting, versioning strategy (semver vs date), developer experience checklist, breaking-change policy
2. `skills/github-pr-to-release-notes/` — **upgrade**: wykrywanie breaking changes (semver major bump triggers), komunikat dla integratorów (migration guide stub), wariant "changelog entry" dla Keep a Changelog
3. `skills/jira-sync/` — **upgrade**: integracja z `registry.json` z jira-intake; przy zamknięciu ticketu aktualizuje status w registry na "Done"; cross-skill awareness (jira-sync wie o historii intake)

---

### Sprint 11 (v3.0) — Multi-Agent PM Platform — ~10h — data TBD

Przepisanie architektury — skille stają się spójnym systemem komunikującym się przez shared state:

**Architektura:**
- `~/.claude/skills/shared/registry.json` — globalny shared state: tickety (z jira-intake), releases (z jira-sync), sprinty (z sprint-close-synthesizer); każdy skill czyta i pisze
- `skills/pm-ai-orchestrator/` — orkiestrator który na podstawie pytania użytkownika dobiera właściwy skill i przekazuje kontekst z registry; wejście: dowolne pytanie PM-a; wyjście: wywołanie odpowiedniego skilla z pre-loaded kontekstem
- `skills/weekly-pm-briefing/` — poniedziałkowy briefing automatyczny (cron 9:00 Pn): sprint status z Jiry + kluczowe decyzje do podjęcia dziś + workload alert jeśli ktoś ma >3 otwarte + komunikacja do wysłania (Confluence/mail)

**Dokumentacja systemu:**
- `docs/pm-ai-system-overview.md` — jak używać całego zestawu jako spójnego systemu PM AI: diagram przepływu danych między skillami, use cases per rola (PM / Analyst / Consultant / FDM), quick-start dla nowego użytkownika
