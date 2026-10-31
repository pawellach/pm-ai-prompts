# prioritize-features

> Skill Claude Code — wywołaj: `/prioritize-features [rice|ice|wsjf|moscow|compare] [lista ficzerów lub backlog]`

## Co robi

Priorytetyzuje backlog ficzerów używając czterech frameworków: RICE, ICE, WSJF, MoSCoW. Każdy tryb generuje scored table + uzasadnienie + outcome-roadmap w formacie który można wkleić do Jiry lub Confluence.

## Kiedy używać

- Sprint planning — co bierzemy w tym sprincie (tryb `rice` lub `ice`)
- PI Planning / kwartalna roadmapa — co i kiedy (tryb `wsjf`)
- Stakeholder alignment — co robimy a czego nie (tryb `moscow`)
- Nie wiesz który framework wybrać (tryb `compare` — rekomenduje)

## Argumenty / tryby

| Tryb | Framework | Kiedy użyć |
|---|---|---|
| `rice [lista]` | Reach × Impact × Confidence / Effort | Dużo ficzerów, porównujesz wpływ na użytkowników |
| `ice [lista]` | Impact × Confidence × Ease | Szybka priorytetyzacja, brak danych Reach |
| `wsjf [lista]` | (Value + Time + Risk) / Job Size | SAFe PI Planning, epiki wielosprint |
| `moscow [lista]` | Must/Should/Could/Won't | Stakeholder communication, release scoping |
| `compare [lista]` | meta-analiza | Nie wiesz co wybrać — dostaniesz rekomendację |

## Instrukcja dla Claude

### Krok 0: Przygotowanie ficzerów

Zanim zaczniesz scorować, upewnij się że każdy ficzers jest opisany jako: **kto + co + dlaczego** (user story format). Jeśli backlog zawiera zadania techniczne lub bugi — zapytaj czy uwzględnić je w tej samej skali.

---

### Tryb: RICE

**Formuła:** `RICE = (Reach × Impact × Confidence%) / Effort`

| Wymiar | Skala | Opis |
|--------|-------|------|
| Reach | liczba użytkowników/miesiąc | ile osób dotknie ta zmiana |
| Impact | 0.25 / 0.5 / 1 / 2 / 3 | minimalna / niska / średnia / wysoka / masywna |
| Confidence | 20% / 50% / 80% / 100% | pewność co do Reach i Impact |
| Effort | person-weeks | ile pracy wymaga implementacja |

Scoring: podaj uzasadnienie per wymiar, szczególnie Confidence — dlaczego takie %.

---

### Tryb: ICE

**Formuła:** `ICE = Impact × Confidence × Ease`

| Wymiar | Skala 1-10 | Opis |
|--------|-----------|------|
| Impact | 1-10 | jak mocno wpłynie na cel/metrykę |
| Confidence | 1-10 | jak pewni jesteśmy Impact |
| Ease | 1-10 | jak łatwo to zrobić (10 = bardzo łatwo) |

Szybki scoring — bez twardych danych. Dobry na early-stage lub duże listy.

---

### Tryb: WSJF (SAFe)

**Formuła:** `WSJF = (Business Value + Time Criticality + Risk Reduction) / Job Size`

| Wymiar | Skala Fibonacci: 1,2,3,5,8,13 | Opis |
|--------|-------------------------------|------|
| Business Value | 1-13 | wartość dla klienta/biznesu |
| Time Criticality | 1-13 | konsekwencja opóźnienia |
| Risk Reduction | 1-13 | ile ryzyka usuwa (ROAM: Resolved/Owned/Accepted/Mitigated) |
| Job Size | 1-13 | relative sizing (story points/t-shirt) |

WSJF faworyzuje małe zadania z wysoką krytyką czasową — to feature, nie bug.

---

### Tryb: MoSCoW

Przypisz każdy ficzers do kategorii z uzasadnieniem:

- **Must Have:** bez tego release się nie odbywa / zobowiązanie kontraktowe / krytyczne dla bezpieczeństwa
- **Should Have:** ważne, ale jest workaround / release możliwy bez tego
- **Could Have:** "nice to have" / wchodzi jeśli zostanie czas
- **Won't Have (this time):** explicite odrzucone — z powodu, nie "może kiedyś"

Reguła: jeśli wszystko to "Must Have" — masz problem priorytetyzacyjny, nie backlog.

---

### Tryb: compare

Oceń backlog pod kątem trzech pytań:
1. Czy masz dane (liczba użytkowników, konwersja)? → tak: RICE, nie: ICE
2. Czy planujesz wielosprint / PI Planning? → tak: WSJF
3. Czy potrzebujesz komunikacji do stakeholderów co robimy/nie robimy? → Moscow

Rekomenduj jeden główny framework + sugeruj Moscow jako nakładkę komunikacyjną.

---

### Krok finalny (wszystkie tryby): Outcome Roadmap

Po scorowaniu wygeneruj roadmapę opartą na outcome (nie na feature list):

```
NOW (Sprint/Quarter bieżący):
  Cel: [metryka którą chcemy ruszyć]
  Ficzery: [TOP 3 z najwyższym score]

NEXT (Sprint/Quarter następny):
  Cel: [następny outcome]
  Ficzery: [kolejne 3-5]

LATER (backlog):
  Monitorujemy ale nie commitujemy:
  [pozostałe Should/Could]
```

## Output

```
PRIORYTETYZACJA — [framework] — [data]
Cel produktowy: [metryka]

SCORED TABLE:
| # | Ficzers | Reach | Impact | Conf | Effort | RICE Score | Uzasadnienie |
|---|---------|-------|--------|------|--------|------------|--------------|
| 1 | [nazwa] |  500  |   2    | 80%  |   2    |    400     | [dlaczego]   |
| 2 | ...     |       |        |      |        |            |              |

OUTCOME ROADMAP:
NOW → [cel]: [Top 1-3]
NEXT → [cel]: [Next 3-5]
LATER: [reszta]

JIRA OUTPUT:
Epic priorytet Q4: [lista ordered by score]
Won't do (MoSCoW): [lista z uzasadnieniami]
```

## Przykład

**Wywołanie:** `/prioritize-features rice "notification system, bulk export, API docs, dark mode, mobile app, SSO integration"`

Skill policzy RICE dla każdego i wykaże że np. SSO integration ma najwyższy score pomimo dużego Effort — bo Reach obejmuje wszystkich enterprise customers (unlock segment), a Confidence jest wysoka bo mamy dane z sales calls.
