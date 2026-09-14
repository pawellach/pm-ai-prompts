# pm-ai-prompts — Development Backlog

Wszystkie planowane rozszerzenia repozytorium, pogrupowane według ścieżki kariery i priorytetu.
Aktualizować po każdej sesji roboczej.

Last updated: 2026-09-14

---

## Wersja aktualna: v1.4.0

Zrobione: 7 promptów (roadmap-planner, okr-kpi-builder, project-kickoff-facilitator, decision-log-writer,
release-notes-writer, raid-board-automator, vendor-evaluation) + 3 skille (github-pr-to-release-notes,
linear-sprint-dashboard, release-manager) + examples/ (3 pary) + rename sharepoint.

---

## Mid-term — v1.5.0

| Co | Typ | Priorytet |
|---|---|---|
| `skills/confluence-page-from-template/` | Skill Claude Code | Wysoki |
| `skills/azure-devops-work-item-triage/` | Skill Claude Code | Wysoki |
| Wypełnij `examples/` dla wszystkich istniejących promptów (14 promptów × input+output) | Dokumentacja | Średni |
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
| Azure DevOps | Tylko archiwum (Symfonia) | ADO MCP → skill w v1.5.0 |
| GitLab | Nie w stacku | GitLab MCP |
| Buildkite / CircleCI | Nie w stacku | CI API → release-manager extension |

---

## Kolejność realizacji (sugerowana)

### Sprint 1 (v1.5.0) — ~4h pracy
1. `confluence-page-from-template` skill
2. `azure-devops-work-item-triage` skill
3. `examples/` dla wszystkich 14 istniejących promptów
4. `career/interview-prep-coach.md`
5. `prompts/ai-readiness-assessment.md`

### Sprint 2 (v1.6.0) — ~4h pracy
1. `prompts/business-case-writer.md`
2. `prompts/consulting-proposal-writer.md`
3. `prompts/technical-discovery-facilitator.md`
4. `skills/consulting-client-status-pack/`
5. `prompts/change-management-planner.md`

### Sprint 3 (v1.7.0) — ~3h pracy
1. Pozostałe prompty ścieżki B, C, D
2. Skille enterprise PM
3. HubSpot MCP prototype (jeśli L2Studio uruchomione)
