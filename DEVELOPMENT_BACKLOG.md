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

### Sprint 4 (v1.8.0) — Living Project Intelligence — ~4h pracy
1. `skills/sprint-close-synthesizer/` — koniec sprintu: pull zamkniętych ticketów z Jiry → velocity, przeniesienia, seed planowania następnego; dopełnienie jira-sync
2. `skills/stakeholder-update-generator/` — Jira + commit log → gotowy update per audience (exec/team/client); różny ton, różna głębokość
3. `prompts/post-project-review.md` — project closure: lessons learned, outcomes vs. plan, materiał na case study
4. `prompts/ai-product-spec.md` — spec dla AI feature: wymagania na model, kryteria eval, fallback behavior, bias considerations

### Sprint 5 (v1.9.0) — jira-intake v2: Internal Records — ~5h pracy (upgrade istniejącego skilla)
Upgrade `skills/jira-intake/` o warstwę state management — bezstanowość to obecna główna słabość skilla.

**Co dodać:**
1. **Historia lokalna** — `~/.claude/skills/jira-intake/history/<TICKET>.md` z pełną analizą, datą, assignee, complexity. Powtórne uruchomienie na tym samym tickecie wykrywa poprzednią analizę
2. **Registry** — `registry.json`: lista przetworzonych ticketów (date, assignee, complexity, epic). Ładowany przy każdym intake jako kontekst
3. **Workload awareness** — przed przypisaniem sprawdza registry: ile otwartych intake ma dany dev w bieżącym tygodniu
4. **Cross-ticket intelligence** — przy nowym tickecie: kolizje w tym samym komponencie/epiku/assignee z otwartymi ryzykami
5. **Stats view** — `/jira-intake stats`: wzorce complexity per komponent, rozkład assignee, recurring open questions
6. **Bridge do requirements-analyst** — gdy complexity=Complex: "Chcesz pełną analizę wymagań? (`/requirements-analyst <TICKET>`)"
