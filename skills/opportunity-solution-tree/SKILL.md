# opportunity-solution-tree

> Skill Claude Code — wywołaj: `/opportunity-solution-tree [build|update|audit] [opis inicjatywy]`

## Co robi

Buduje lub aktualizuje Opportunity Solution Tree (OST) wg metodyki Teresa Torres. Strukturyzuje product discovery od celu biznesowego przez szanse rynkowe do eksperymentów — i generuje gotowy output do Jiry.

## Kiedy używać

- Na początku kwartału/inicjatywy (tryb `build`)
- Po serii wywiadów z użytkownikami — zaktualizuj drzewo (tryb `update`)
- Przed sprint planningiem — sprawdź czy inicjatywy są zakorzenione w outcome (tryb `audit`)
- Gdy backlog jest zbiorem feature'ów bez widocznego celu

## Argumenty / tryby

| Tryb | Kiedy | Co robi |
|---|---|---|
| `build [outcome]` | nowe OST od zera | kompletne drzewo od desired outcome |
| `update [notatki/nowe dane]` | po discovery session | dodaje/przesuwa gałęzie na podstawie nowych informacji |
| `audit [opis inicjatywy]` | przed planowaniem | weryfikuje czy solution → opportunity → outcome linkage jest spójny |

## Instrukcja dla Claude

### Tryb: build

1. **Desired outcome** — potwierdź z użytkownikiem mierzalny outcome: "Co chcemy zmienić w zachowaniu klienta lub metryce biznesowej?" Format: `[metryka] [kierunek] [wartość] w [timeframe]`. Przykład: "Zwiększ retencję 7-dniową o 10% w Q2."

2. **Opportunities (poziom 1)** — odkryj 4-6 szans: problemy lub niezaspokojone potrzeby klientów, które prowadzą do tego outcome. WAŻNE: opportunity to opis doświadczenia klienta, nie rozwiązanie. Zły: "Zrób onboarding tutorial." Dobry: "Nowi użytkownicy nie rozumieją wartości produktu w pierwszych 24h."

3. **Sub-opportunities (poziom 2)** — dla każdej opportunity: czy jest zbyt szeroka? Jeśli tak, rozgałęź na 2-3 konkretniejsze szanse.

4. **Solutions (poziom 3)** — dla każdej opportunity/sub-opportunity: 2-3 pomysły na rozwiązania. Format: czasownik + co + dla kogo.

5. **Experiments (poziom 4)** — dla każdego solution: jak najtaniej i najszybciej sprawdzić czy to działa? (fake door, landing page, paper prototype, 5 wywiadów)

6. **Pytania odkrywcze** — dla każdego węzła poziomu 1-2: "Czego jeszcze nie wiemy o tej szansie?" (1-2 pytania per węzeł)

7. **Output** — wygeneruj ASCII tree + tabela Jira-ready + lista assumptions.

### Tryb: update

1. Poproś o aktualne OST (tekst lub opis) + nowe dane (notatki z wywiadów, wyniki eksperymentów, zmiany biznesowe)
2. Zidentyfikuj: które szanse potwierdzono / obalono / dodano
3. Zaktualizuj drzewo — oznacz zmienione węzły: ✓ (potwierdzone), ✗ (obalone), ★ (nowe)
4. Zaproponuj następne eksperymenty dla potwierdzonych szans

### Tryb: audit

1. Zbierz listę planowanych inicjatyw/epików
2. Dla każdej: sprawdź czy jest widoczne połączenie solution → opportunity → outcome
3. Oflaguj inicjatywy bez jasnego linkage jako "orphan solutions"
4. Zaproponuj mapping lub pytania do PO/PM o uzasadnienie

## Output

```
DESIRED OUTCOME: [mierzalny cel]

├── OPPORTUNITY: [opis doświadczenia klienta]
│   ├── Sub-opportunity: [bardziej konkretna szansa]
│   │   ├── Solution: [pomysł na rozwiązanie]
│   │   │   └── Experiment: [najtańszy test, ~1 tydzień]
│   │   └── Solution: [alternatywny pomysł]
│   └── Sub-opportunity: [inna konkretna szansa]
│       └── ...
└── OPPORTUNITY: [kolejna szansa]
    └── ...

JIRA EPIKI:
| Epic | Opportunity | Priority | Assumptions |
|------|-------------|----------|-------------|
| ...  | ...         | ...      | ...         |

TOP ASSUMPTIONS DO WALIDACJI:
1. [założenie] — test: [metoda] — kryterium pass: [co musi być prawdą]
```

## Przykład

**Wywołanie:** `/opportunity-solution-tree build "Zwiększ liczbę aktywnych użytkowników płatnych o 20% w Q3"`

**Fragment output:**
```
DESIRED OUTCOME: Zwiększ aktywnych użytkowników płatnych o 20% w Q3

├── OPPORTUNITY: Trial users nie widzą wartości przed końcem trialu
│   ├── Sub-opportunity: Użytkownicy nie docierają do "aha moment" w 3 dni
│   │   ├── Solution: Spersonalizowany onboarding flow wg roli
│   │   │   └── Experiment: Email z 3 krokami per rola → mierz activation rate (1 tydzień)
│   │   └── Solution: Proactive check-in call w dniu 2
│   └── Sub-opportunity: Użytkownicy nie wiedzą co robić po setupie
│       └── Solution: In-app progress tracker z next-best-action
└── OPPORTUNITY: Istniejący użytkownicy nie odkrywają premium features
    └── ...
```
