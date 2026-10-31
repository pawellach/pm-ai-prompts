# interview-toolkit

> Skill Claude Code — wywołaj: `/interview-toolkit [prepare|conduct|summarize] [temat/notatki]`

## Co robi

Kompleksowy toolkit do wywiadów z użytkownikami — od przygotowania scenariusza, przez prowadzenie sesji, do gotowego podsumowania Confluence-ready. Trzy tryby pokrywają cały lifecycle wywiadu.

## Kiedy używać

- Planujesz user research session (tryb `prepare`)
- Prowadzisz wywiad i chcesz live guidance + notatki (tryb `conduct`)
- Masz surowe notatki z wywiadu i chcesz je ustrukturyzować (tryb `summarize`)

## Argumenty / tryby

| Tryb | Wejście | Output |
|---|---|---|
| `prepare [cel/hipoteza]` | cel badania, persona, hipotezy | script wywiadu + pytania pogłębiające + checklist logistyczny |
| `conduct [temat]` | temat na żywo | live template na notatki + reminder o technikach |
| `summarize [surowe notatki]` | notatki z wywiadu (paste) | structured insights + quotes + jobs-to-be-done + akcje |

## Instrukcja dla Claude

### Tryb: prepare

1. **Zrozum cel** — co chcemy odkryć? Sformułuj jako pytanie badawcze: "Chcemy zrozumieć jak [persona] robi [zadanie] gdy [kontekst]."

2. **Screening criteria** — zaproponuj 2-3 pytania screeningowe do rekrutacji rozmówców. Określ ideal vs. disqualify profile.

3. **Script wywiadu** — 5 sekcji:
   - **Intro (5 min):** cel, zgodę na nagranie, budowanie relacji — 2-3 pytania o kontekst rozmówcy
   - **Kontekst (10 min):** obecne zachowanie/workflow — pytania open-ended (nie pytaj o przyszłość!)
   - **Problem deep-dive (20 min):** konkretne sytuacje i trudności — technika "opowiedz mi o ostatnim razie gdy..."
   - **Rozwiązania i workarounds (10 min):** co już próbowali, co pomaga — nie pokazuj jeszcze swojego rozwiązania
   - **Zamknięcie (5 min):** co pominąłeś, sieć kontaktów, następne kroki

4. **Pytania pogłębiające** — przygotuj per sekcja:
   - "Dlaczego to dla Ciebie ważne?"
   - "Co się stało wcześniej/potem?"
   - "Powiedz mi więcej..."
   - "Jak często to się zdarza?"
   - "Co zrobiłeś wtedy?"

5. **Czego unikać** — lista anti-patterns: pytania leading, pytania o przyszłość ("czy byś..."), pytania zamknięte jako pierwsze.

### Tryb: conduct

Generuj **live template** — minimalne notatki podczas wywiadu:

```
WYWIAD: [data] [rozmówca: rola/firma]
MODERATOR: [imię]

OBSERWACJE:
- [kluczowe cytaty — używaj cudzysłowów]
- [zachowania/emocje — opisuj, nie interpretuj]
- [przerwy, mimika, wahania]

JOBS TO BE DONE (na żywo):
- When _____, I want to _____, so I can _____

PYTANIA DO DRĄŻENIA PÓŹNIEJ:
- 

SYGNAŁY (zaznacz podczas rozmowy):
⚡ zaskakujące  🔴 problem  💡 pomysł  ⭐ cytat do zachowania
```

Dołącz remindery technik prowadzenia:
- Cisza jest OK — czekaj 5s po odpowiedzi
- Parafrazuj: "Słyszę że... Czy dobrze rozumiem?"
- Nie sugeruj — pytaj "jak" nie "czy"

### Tryb: summarize

1. **Identyfikacja wzorców** — przejrzyj notatki i wypisz: (a) powtarzające się problemy, (b) workarounds które ludzie wymyślili, (c) zaskakujące stwierdzenia

2. **Jobs-to-be-Done** — ze wszystkich wywiadów wypisz JTBD w formacie:
   - **Functional:** When I [sytuacja], I want to [akcja], so I can [cel]
   - **Emotional:** czuję [emocja], gdy [sytuacja]
   - **Social:** chcę żeby [inni] widzieli mnie jako [postrzeganą tożsamość]

3. **Key quotes** — 3-5 cytatów które najlepiej ilustrują problemy (z atrybucją: rola, nie imię)

4. **Synthesis grid** — tabela:
   | Wzorzec | Częstotliwość | Intensywność (1-5) | Quote |
   |---------|---------------|--------------------|-------|

5. **Opportunities** — z wzorców → szanse (Torres-compatible: opis doświadczenia klienta, nie solution)

6. **Następne kroki** — co validować dalej, kogo jeszcze zapytać, jakie eksperymenty

## Output

### Tryb prepare:
```
RESEARCH BRIEF: [cel badania]
Pytanie badawcze: "Chcemy zrozumieć..."
Persona: [opis]
Hipotezy do testowania: [lista]

SCRIPT (60 min):

INTRO (5 min)
"Cześć, dziękuję za czas. Celem naszej rozmowy jest..."
[script + pytania kontekstowe]

SEKCJA 1 — KONTEKST (10 min)
[pytania open-ended]

SEKCJA 2 — DEEP DIVE (20 min)
[pytania + pogłębiające]
...

CHECKLIST PRE-CALL:
□ Zgoda na nagranie
□ Notatnik gotowy
□ Timer ustawiony
□ Quiet mode telefon
```

### Tryb summarize:
```
RESEARCH SYNTHESIS — [data] [N wywiadów]

TOP JOBS-TO-BE-DONE:
1. When [sytuacja], I want to [akcja], so I can [cel]
   Evidence: 3/5 rozmówców, quote: "..."

TOP PROBLEMS:
🔴 [problem] — frequency: 4/5 — intensity: 4/5

OPPORTUNITIES (Torres-ready):
1. [opis doświadczenia klienta, nie solution]

NASTĘPNE KROKI:
□ [akcja] — właściciel: [rola]
```

## Przykład

**Wywołanie:** `/interview-toolkit prepare "Rozumieć jak mid-market PM-owie zarządzają roadmapą przy zmieniających się priorytetach"`

Skill wygeneruje script wywiadu z pytaniami jak: "Opowiedz mi o ostatnim razie kiedy musieliście drastycznie zmienić roadmapę. Co się stało?" — i checklist screening criteria: "PM w firmie 50-500 osób, minimum 6 miesięcy doświadczenia z roadmapą."
