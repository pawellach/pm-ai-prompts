# Skill: Confluence Program Dashboard

> **Cel:** Generuje health dashboard programu na poziomie portfolio — agreguje dane z Jiry (epiki, sprinty, blokery) i zapisuje jako Confluence page z ASCII-based wizualizacją statusów.
> **Kiedy używać:** Przed Steering Committee, przy monthly/quarterly review, jako automatyczny raport dla sponsora programu.
> **Output:** Gotowa Confluence page z RAG traffic light, progress bars, trend arrows i sekcją ryzyk.

---

## Jak używać

Podaj nazwę programu lub listę epików/projektów w Jirze. Skill odpyta Jirę, zagreguje statusy i wygeneruje stronę w Confluence. Jeśli chcesz zaktualizować istniejącą stronę zamiast tworzyć nową — podaj ID strony.

```
/confluence-program-dashboard [nazwa programu lub lista epik IDs] [--page-id ID]
```

---

## Workflow

### Krok 1 — Zbierz dane z Jiry

Dla każdego epiku/projektu pobierz:

```jql
issuetype = Epic AND project = [PROJECT] AND status != Done
```

Per epik zbierz:
- Łączna liczba tasków (wszystkich statusów)
- Taski Done / In Progress / To Do
- Blokery (label = "blocker" lub status = "Blocked")
- Ostatnia aktywność (updated w ostatnich 7 dniach)
- Assignee / owner

### Krok 2 — Oblicz metryki

**Completion %:**
```
completion = (Done / Total) × 100
```

**RAG Status:**
```
🟢 GREEN  — completion ≥ plan_target AND blokery = 0
🟡 AMBER  — completion < plan_target LUB blokery > 0 AND blokery ≤ 2
🔴 RED    — completion << plan_target (>15% behind) LUB blokery > 2
```

**Trend (vs poprzedni tydzień):**
```
↑ — completion wzrósł >5%
→ — completion zmienił się ±5%
↓ — completion spadł lub brak aktywności 7+ dni
```

**Progress bar ASCII (20 znaków):**
```
[████████████░░░░░░░░] 60%
```

### Krok 3 — Generuj Confluence page

Format strony:

```
# [NAZWA PROGRAMU] — Dashboard [YYYY-MM-DD]

## Status Ogólny: 🟡 AMBER

| Epic | RAG | Progress | Trend | Blokery | Owner |
|---|---|---|---|---|---|
| [Nazwa epiku] | 🟢 | [████████░░░░░░░░░░░░] 40% | ↑ | 0 | [Assignee] |
| [Nazwa epiku] | 🔴 | [████░░░░░░░░░░░░░░░░] 20% | ↓ | 3 | [Assignee] |

## Blokery wymagające uwagi

| Ticket | Tytuł | Blokuje | Od kiedy | Owner |
|---|---|---|---|---|
| [SAL-XXX] | [opis] | [epic] | [data] | [osoba] |

## Milestone'y (najbliższe 2 tygodnie)

| Data | Epic | Milestone | Status |
|---|---|---|---|
| [YYYY-MM-DD] | [epic] | [opis] | 🟢/🟡/🔴 |

## Komentarz Programowy

[2-3 zdania statusu narracyjnego: co idzie dobrze, co jest zagrożone, co wymaga decyzji sponsora]

---
*Wygenerowano automatycznie przez Confluence Program Dashboard skill · [timestamp]*
```

### Krok 4 — Zapis do Confluence

Jeśli `--page-id` podany → aktualizuj istniejącą stronę (dodaj wersję).  
Bez `--page-id` → utwórz nową stronę w przestrzeni wskazanej w konfiguracji lub zapytaj.

Wyślij URL nowej/zaktualizowanej strony jako output skilla.

---

## Konfiguracja (opcjonalna)

W root repo `skills/confluence-program-dashboard/config.json`:
```json
{
  "defaultSpace": "PM",
  "parentPageTitle": "Program Dashboards",
  "weeklySchedule": true,
  "defaultProjects": ["SAL", "CDP"]
}
```

---

## Upgrade — ASCII health metrics (v2.3)

Wizualizacja w tabeli używa:

| Symbol | Znaczenie |
|---|---|
| `[████████████░░░░░░░░]` | Progress bar (20 znaków = 5% każdy) |
| `🟢 🟡 🔴` | RAG traffic light |
| `↑ → ↓` | Trend tygodniowy |
| `⚠` | Blocker alert |
| `✅` | Milestone osiągnięty |
| `📅` | Zbliżający się deadline (≤7 dni) |

Przykład kompletnego wiersza tabeli:
```
| Portal B2B | 🟡 | [████████████░░░░░░░░] 60% ↑ | ⚠ 1 bloker | Jan Kowalski |
```
