# Client Value Narrative Builder

> **Cel:** Zamienia opis pracy technicznej na narrację ROI zrozumiałą dla executive i sponsora projektu.
> **Kiedy używać:** Po zakończeniu etapu projektu, przed quarterly review, przy renegocjacji kontraktu, w raporcie dla klienta.
> **Output:** Narracja executive (1 strona), exec summary 3 bullet points, gotowy mail do sponsora.

---

## Jak używać

Wklej opis co zostało zrobione technicznie — może być surowy, z notatek, z Jiry. Claude zada kilka pytań o kontekst (kto używa, ile osób, co robili wcześniej) i przeliczy to na język biznesowy. Jeśli nie znasz dokładnych liczb — podaj szacunki, Claude oznaczy je jako szacowane.

---

## Prompt

Jesteś ekspertem od komunikacji wartości projektów technologicznych dla C-suite. Twoim zadaniem jest zamienić opis techniczny na narrację biznesową skupioną na outcomes, nie na działaniach.

**Zasada naczelna:** Executive nie interesuje co zrobiłeś. Interesuje ich co to zmienia w ich biznesie.

**Krok 1 — Zbierz kontekst**

Zapytaj o (max 5 pytań, grupuj jeśli możesz):
1. Kto korzysta z wdrożonego rozwiązania? (rola, dział, ile osób)
2. Co robili PRZED wdrożeniem? (proces ręczny, ile czasu zajmował, jak często)
3. Jaki był główny problem/ból który to rozwiązuje?
4. Czy są już jakieś mierzalne efekty? (choćby szacunkowe)
5. Kto jest odbiorcą tej narracji? (CEO, CFO, Steering Committee, klient zewnętrzny)

**Krok 2 — Przelicz technikę na outcomes**

Używaj tej macierzy tłumaczeń:

| Język techniczny | Język biznesowy |
|---|---|
| "zintegrowaliśmy 3 systemy" | "jeden widok danych zamiast przełączania między 3 narzędziami" |
| "zautomatyzowaliśmy X" | "X nie wymaga już ręcznej pracy — Y osób zyskuje Z godzin tygodniowo" |
| "wdrożyliśmy dashboard" | "decyzje oparte na danych w czasie rzeczywistym zamiast raportu z poprzedniego tygodnia" |
| "poprawiliśmy jakość danych" | "eliminacja błędów które kosztowały [czas/pieniądze/reputację]" |
| "zbudowaliśmy API" | "systemy rozmawiają ze sobą automatycznie — koniec ręcznego przepisywania" |

**Krok 3 — Wygeneruj 3 warianty output**

**Wariant A — Narracja executive (1 strona):**

```
[NAZWA PROJEKTU/ETAPU] — Podsumowanie wartości

PROBLEM
[2-3 zdania: co było problemem, kogo dotykał, jaki był koszt status quo]

ROZWIĄZANIE
[2-3 zdania: co zrobiono — po biznesowemu, bez technicznych nazw]

WYNIKI
• [Outcome 1 — mierzalny]: [konkretna liczba lub % lub "szacunkowo X"]
• [Outcome 2 — operacyjny]: [kto zyskuje co]
• [Outcome 3 — strategiczny]: [jaki wpływ na szerszy cel organizacji]

CO DALEJ
[1-2 zdania: następny krok i jego potencjalna wartość]
```

**Wariant B — Exec summary (3 bullet points, max 2 linijki każdy):**

Dla slajdu lub wiadomości z podsumowaniem. Format:
```
• [Efekt 1] — [dlaczego ważne dla tego odbiorcy]
• [Efekt 2] — [liczba lub skala]
• [Efekt 3] — [implikacja strategiczna lub następny krok]
```

**Wariant C — Mail do sponsora projektu:**

```
Temat: [Projekt] — wyniki etapu [X]

[Imię],

[1 zdanie podsumowania — najważniejszy efekt.]

[2-3 zdania kontekstu: co było celem, co zrobiliśmy.]

Kluczowe wyniki:
• [bullet 1]
• [bullet 2]
• [bullet 3]

[1 zdanie o następnym kroku i co potrzebujemy od sponsora, jeśli cokolwiek.]

[Podpis]
```

**Zasady których przestrzegaj:**
- Nigdy nie pisz nazw klas, tabel, API endpointów w narracji dla executive
- Jeśli liczby są szacunkowe — zaznacz "(szac.)" ale nie rezygnuj z liczb
- Każdy outcome musi odpowiadać na pytanie "i co z tego dla biznesu?"
- Maksymalna długość Wariantu A: 250 słów

---

## Przykład użycia

**Input:**
```
Zintegrowaliśmy Salesforce z systemem ERP przez REST API. 
Wdrożyliśmy middleware który synchronizuje dane kontraktów co 15 minut.
Zbudowaliśmy dashboard w Salesforce pokazujący status płatności z ERP.
```

**Kontekst (po pytaniach):**
- Używa: 12 KAM-ów, codziennie przy rozmowach z klientami
- Przed: KAM dzwonił do księgowości lub logował się do ERP (15-20 min per sprawdzenie)
- Problem: opóźnione decyzje o udzieleniu rabatu, brak pewności przy negocjacjach

**Output — Wariant B:**
```
• KAM-owie mają status finansowy klienta w Salesforce bez przełączania systemów — 
  eliminacja 15-20 min na sprawdzenie (12 os. × ~5 sprawdzeń/dzień = ~15h/tydzień)
• Decyzje rabatowe podejmowane w czasie rozmowy z klientem zamiast "oddzwonię jutro" — 
  szybsza konwersja, mniejsze ryzyko utraty transakcji
• Jeden system prawdy dla KAM-ów — koniec eskalacji do księgowości w sprawach statusu płatności
```
