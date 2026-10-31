# assumptions-mapper

> Skill Claude Code — wywołaj: `/assumptions-mapper [new|sprint|checkpoint] [opis pomysłu/inicjatywy]`

## Co robi

Identyfikuje ukryte założenia w inicjatywie/feature/strategii, priorytetyzuje je na macierzy confidence × impact i wskazuje najtańszy test dla każdego krytycznego założenia. Output zawiera gotowe tickety Jira z typem testu i kryterium pass/fail.

## Kiedy używać

- Przed podjęciem decyzji o rozpoczęciu inicjatywy (tryb `new`)
- Przed sprint planningiem — co ryzykujemy w tym sprincie (tryb `sprint`)
- Po discovery session / wywiadach — co się potwierdziło (tryb `checkpoint`)

## Argumenty / tryby

| Tryb | Wejście | Cel |
|---|---|---|
| `new [opis pomysłu]` | nowa inicjatywa/feature | zidentyfikuj i priorytetyzuj założenia przed startem |
| `sprint [lista zadań]` | planowane zadania sprintu | jakie założenia ryzykujemy w tym sprincie |
| `checkpoint [notatki]` | wyniki wywiadów/eksperymentów | co potwierdzono, co obalono, co nowe |

## Instrukcja dla Claude

### Krok 1: Identyfikacja założeń (wszystkie tryby)

Zbierz założenia w 4 kategoriach DVFU:

- **Desirability** — klienci tego chcą/potrzebują? ("Użytkownicy będą chcieli logować się przez Google")
- **Viability** — model biznesowy zadziała? ("Klienci zapłacą za ten feature premium")
- **Feasibility** — możemy to zrobić technicznie/operacyjnie? ("Integracja z X zajmie 2 tygodnie")
- **Usability** — użytkownicy będą mogli to obsłużyć? ("Użytkownicy zrozumieją nowy flow bez instrukcji")

Dla każdego obszaru wyciągnij 3-5 założeń. Formułuj je jako twierdzenia, które mogą być fałszywe.

### Krok 2: Scoring confidence × impact

Dla każdego założenia oceń:
- **Confidence (1-5):** jak bardzo jesteś pewien że to prawda? (1 = zgadujemy, 5 = mamy dane)
- **Impact (1-5):** co się stanie jeśli okaże się fałszywe? (1 = minor, 5 = inicjatywa pada)

**Priorytet = (6 - confidence) × impact** — wyższy wynik = testuj najpierw.

### Krok 3: Najtańszy test dla TOP 5

Dla 5 najwyżej ocenionych założeń zaproponuj test:

| Metoda | Koszt | Kiedy |
|---|---|---|
| 5 wywiadów użytkowników | niski | desirability/usability |
| Fake door / landing page | niski | desirability/viability |
| Paper prototype | niski | usability |
| Spike techniczny | średni | feasibility |
| Pilotaż z 1 klientem | średni | viability |
| A/B test | wysoki | po walidacji jakościowej |

### Krok 4: Output Jira-ready

Dla każdego TOP 5 założenia: gotowy ticket jako "Assumption validation: [założenie]" z typem zadania, opisem testu i kryterium pass/fail.

## Output

```
ASSUMPTIONS MAP — [nazwa inicjatywy]

MACIERZ (Confidence × Impact):

            IMPACT
            1   2   3   4   5
C  1  │         │       │ [A] │     │
O  2  │         │   [B] │     │ [C] │
N  3  │   [D]   │       │     │     │
F  4  │         │   [E] │     │     │
   5  │         │       │     │     │

PRIORYTET TESTOWANIA:
🔴 KRYTYCZNE (testuj natychmiast):
  [A] "Użytkownicy zmienią swój workflow" — Confidence: 1, Impact: 5 → Score: 20
      Test: 5 wywiadów → kryterium PASS: 4/5 mówi że zmieni
  [C] "Integracja z Salesforce zajmie < 2 tyg" — Confidence: 2, Impact: 4 → Score: 16
      Test: Spike 2-dniowy → kryterium PASS: MVP możliwy w 1 tygodniu

🟡 WAŻNE (testuj w sprincie 2):
  [B] "Klient zapłaci 50 zł/mies. za ten feature" — Score: 12

🟢 MONITORUJ:
  [D] "Mamy dane w odpowiednim formacie" — Score: 4

JIRA TICKETY (gotowe do wklejenia):
1. [SPIKE] Assumption validation: Użytkownicy zmienią swój workflow
   5 wywiadów z obecnymi użytkownikami — pytaj o obecny workflow i gotowość do zmiany
   PASS: ≥4/5 wyraża gotowość, FAIL: <3/5 — rethink feature

2. [SPIKE] Assumption validation: Integracja SF < 2 tyg
   2-dniowy spike techniczny — PASS: prototyp możliwy, FAIL: eskaluj do arch review
```

## Przykład

**Wywołanie:** `/assumptions-mapper new "Dodajemy AI-powered invoice matching do naszego ERP"`

Skill zidentyfikuje m.in.:
- Desirability: "Księgowi chcą być zastąpieni przez AI" (Confidence: 2, Impact: 5 → 🔴)
- Feasibility: "Nasze faktury mają ustandaryzowany format" (Confidence: 3, Impact: 4 → 🔴)
- Viability: "Klienci enterprise zaakceptują AI w procesie finansowym bez audytu" (Confidence: 1, Impact: 5 → 🔴)
