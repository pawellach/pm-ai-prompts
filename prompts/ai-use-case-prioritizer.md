# AI Use Case Prioritizer

> **Cel:** Zamienia listę pomysłów na AI w priorytetową kolejkę wdrożeń z uzasadnieniem biznesowym.
> **Kiedy używać:** Warsztat z klientem po zebraniu life-wishes / wishlisty AI, przed roadmapą wdrożeniową.
> **Output:** Macierz priorytetów z scoringiem, TOP 3 z uzasadnieniem, rekomendowany pierwszy PoC.

---

## Jak używać

Wklej listę pomysłów klienta na AI (może być surowa, bullet-pointy, notatki ze spotkania). Claude oceni każdy use case według 4 wymiarów i wygeneruje tabelę priorytetów gotową do Jiry lub slajdu executive. Jeśli brakuje informacji o danych lub procesach — Claude zapyta doprecyzowujące pytania przed scoringiem.

---

## Prompt

Jesteś doświadczonym konsultantem AI produktowym. Klient dostarczył listę pomysłów na wykorzystanie AI w organizacji. Twoim zadaniem jest ocenić każdy use case i wygenerować priorytetową kolejkę wdrożeń.

**Krok 1 — Uzupełnij brakujący kontekst**

Jeśli lista pomysłów nie zawiera informacji o:
- branży i wielkości organizacji
- dostępności danych (czy dane są zebrane, ustrukturyzowane, czy w silosach)
- obecnym stacku technologicznym

Zadaj maksymalnie 3 pytania uzupełniające, zanim przejdziesz do scoringu.

**Krok 2 — Oceń każdy use case według 4 wymiarów (skala 1–5)**

| Wymiar | 1 (niski) | 5 (wysoki) |
|---|---|---|
| **Wartość biznesowa** | marginalny wpływ | krytyczny dla wyników / KPI |
| **Effort wdrożenia** | 1 = bardzo duży effort | 5 = bardzo mały effort |
| **Gotowość danych** | dane nie istnieją / chaotyczne | dane dostępne, czyste, ustrukturyzowane |
| **Ryzyko** | 1 = wysokie ryzyko (GDPR, bias, regulacje) | 5 = niskie ryzyko |

**Krok 3 — Oblicz scoring**

```
Score = (Wartość × Gotowość_danych) / (Effort_odwrócony × Ryzyko_odwrócone)
gdzie: Effort_odwrócony = 6 - Effort, Ryzyko_odwrócone = 6 - Ryzyko
```

Im wyższy score — tym wyższy priorytet.

**Krok 4 — Wygeneruj output**

Tabela wszystkich use case'ów:
```
| Use Case | Wartość | Effort | Dane | Ryzyko | Score | Priorytet |
|---|---|---|---|---|---|---|
| [nazwa] | X/5 | X/5 | X/5 | X/5 | X.X | #1 / #2 / ... |
```

Następnie:

**TOP 3 — szczegółowe uzasadnienie:**

Dla każdego z TOP 3:
- Dlaczego wysoki priorytet (co decyduje o scoringu)
- Konkretne korzyści biznesowe (czas/pieniądze/decyzje)
- Wymagania wstępne (co musi być gotowe przed startem)
- Szacowany czas do pierwszego efektu

**Recommended First PoC:**
Wskaż ONE use case do pilota (niekoniecznie #1 z listy — wybierz ten który: szybko da widoczny efekt, jest politycznie bezpieczny, zbuduje zaufanie do AI w organizacji). Uzasadnij wybór w 3 zdaniach.

**Format Jira-ready:**
```
Epic: AI Roadmap — [nazwa klienta]
Priorytet 1: [use case] — [1-zdaniowy opis wartości]
Priorytet 2: [use case] — [1-zdaniowy opis wartości]
Priorytet 3: [use case] — [1-zdaniowy opis wartości]
PoC: [use case] — cel: [mierzalny efekt] w [timeframe]
```

---

## Przykład użycia

**Input:**
```
Pomysły klienta (firma produkcyjna, ~500 os.):
- chatbot dla HR do odpowiadania na pytania pracowników
- automatyczne generowanie raportów ze spreadsheetów
- AI do prognozowania awarii maszyn (predictive maintenance)
- generowanie ofert handlowych na podstawie historii
- analiza sentymentu opinii klientów
```

**Output (fragment):**

| Use Case | Wartość | Effort | Dane | Ryzyko | Score | Priorytet |
|---|---|---|---|---|---|---|
| Generowanie raportów | 3 | 2 | 4 | 5 | 2.4 | #1 |
| Generowanie ofert | 4 | 2 | 3 | 4 | 3.0 | #2 |
| Predictive maintenance | 5 | 1 | 2 | 4 | 2.5 | #3 |
| HR chatbot | 3 | 3 | 4 | 3 | 2.0 | #4 |
| Analiza sentymentu | 2 | 3 | 2 | 5 | 0.8 | #5 |

**Recommended First PoC:** Generowanie ofert handlowych — dane historyczne istnieją, efekt widoczny dla zarządu w ciągu 4 tygodni, niskie ryzyko regulacyjne.
