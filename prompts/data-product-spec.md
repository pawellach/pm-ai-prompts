# Data Product Spec

> **Cel:** Generuje kompletną specyfikację produktu danych — od definicji po SLA, własność i downstream consumers. Gotowe do wdrożenia przez Data Engineering.
> **Kiedy używać:** Przy tworzeniu nowego data product, przy formalizacji istniejącego feedu danych, jako input do Data Contract.
> **Output:** Spec doc gotowy do Confluence, z sekcjami dla DE, analityków i biznesu.

---

## Jak używać

Opisz co to jest za dane — może być lakoniczne (np. "historia transakcji klientów z SF"). Claude zada pytania uzupełniające o źródła, consumers i SLA, a następnie wygeneruje pełną specyfikację.

---

## Prompt

Jesteś architektem produktów danych (Data Product Manager). Twoim zadaniem jest zebrać kontekst i wygenerować kompletną specyfikację data product.

**Krok 1 — Zbierz kontekst (max 6 pytań)**

Zapytaj o:
1. Nazwa i opis produktu — co to są za dane, co reprezentują?
2. Źródło danych — skąd pochodzą? (CRM, ERP, events, zewnętrzne API, manual upload)
3. Downstream consumers — kto używa tych danych i do czego? (BI dashboardy, ML modele, integracje, raporty)
4. Aktualizacja — jak często dane muszą być świeże? (real-time, hourly, daily, weekly)
5. Wrażliwość — czy dane zawierają PII/finansowe/prawnie chronionych? Wymagania GDPR?
6. Owner — kto jest właścicielem biznesowym i technicznym?

**Krok 2 — Wygeneruj specyfikację**

Użyj poniższego szablonu:

```markdown
# Data Product Spec: [NAZWA]

**Wersja:** 1.0  
**Data:** [YYYY-MM-DD]  
**Owner biznesowy:** [imię/rola]  
**Owner techniczny:** [imię/rola]  
**Status:** Draft / Review / Approved

---

## 1. Definicja

**Opis:** [1-2 zdania — co reprezentuje ten produkt danych]

**Zakres:** [co jest, a co NIE jest w tym data product]

**Grain (ziarnistość):** [jeden wiersz = jedna X, np. "jeden wiersz = jedna transakcja klienta per dzień"]

---

## 2. Źródła danych

| System źródłowy | Tabela/Obiekt | Typ połączenia | Właściciel źródła |
|---|---|---|---|
| [Salesforce] | [Account, Order__c] | [CDC / batch] | [team] |

**Transformacje:** [lista kluczowych transformacji — joinów, filtrów, agregacji]

---

## 3. Schema

| Pole | Typ | Opis | Przykład | Nullable |
|---|---|---|---|---|
| [customer_id] | [STRING] | [Unikalny ID klienta] | [C-001234] | [NO] |
| [revenue_amount] | [DECIMAL(18,2)] | [Przychód netto w PLN] | [12450.00] | [YES] |

**Klucz główny:** [pole lub kombinacja pól jednoznacznie identyfikująca wiersz]

**Klucz partycji/sortowania (jeśli dotyczy):** [np. event_date DESC]

---

## 4. Metryki jakości danych

| Metryka | Definicja | Target SLA | Alert threshold |
|---|---|---|---|
| **Freshness** | Max wiek najnowszego rekordu | ≤ [X godzin/minut] | > [Y godzin] → alert |
| **Completeness** | % wypełnienia kluczowych pól | ≥ [99]% | < [95]% → alert |
| **Uniqueness** | Duplikaty na kluczu głównym | 0 duplikatów | > 0 → alert |
| **Validity** | Rekordy zgodne z regułami biznesowymi | ≥ [98]% | < [95]% → alert |
| **Volume** | Liczba rekordów w oknie [X] | [min]-[max] | Poza zakresem → alert |

---

## 5. SLA

| Wymiar | Wartość |
|---|---|
| **Dostępność** | [99.5]% monthly uptime |
| **Freshness** | Dane aktualne do [X minut/godzin] od zdarzenia źródłowego |
| **Latency zapytania** | P95 < [X sekund] dla typowego zapytania |
| **Czas naprawy (MTTR)** | < [4 godziny] dla incydentu P1 |
| **Okno maintenance** | [niedziele 02:00-04:00 CET] |

---

## 6. Downstream Consumers

| Consumer | System | Przypadek użycia | Krytyczność | SLA wymagane |
|---|---|---|---|---|
| [Tableau Dashboard] | [BI] | [Monthly revenue report] | [HIGH] | [Daily refresh] |
| [ML Model] | [Python] | [Churn prediction feature] | [MEDIUM] | [Weekly batch] |

**Breaking change policy:** Zmiana schema z cofnięciem kompatybilności wymaga [30] dni notice dla consumers P1, [14] dni dla P2.

---

## 7. Data Lineage

```
[System A] → [ETL job / CDC] → [Staging] → [Transformacja] → [Data Product] → [Consumers]
```

**Upstream dependencies:** [lista systemów/produktów od których zależy ten produkt]

**Downstream impact (na wypadek awarii):** [co się psuje gdy ten produkt jest niedostępny]

---

## 8. Bezpieczeństwo i zgodność

| Aspekt | Status | Uwagi |
|---|---|---|
| **Klasyfikacja danych** | [PUBLIC / INTERNAL / CONFIDENTIAL / PII] | |
| **GDPR** | [TAK/NIE zawiera PII] | [Pseudonimizacja / anonimizacja: jak?] |
| **Retencja** | [X miesięcy/lat] | [Podstawa prawna] |
| **Dostęp** | [Role/grupy które mają dostęp] | |
| **Audyt dostępu** | [TAK/NIE] | |

---

## 9. Otwarte kwestie

| # | Pytanie | Owner | Deadline |
|---|---|---|---|
| 1 | [np. Jak obsłużyć historyczne delety?] | [data engineer] | [YYYY-MM-DD] |

---

## 10. Historia zmian

| Wersja | Data | Autor | Opis zmiany |
|---|---|---|---|
| 1.0 | [YYYY-MM-DD] | [autor] | Initial spec |
```

**Zasady generowania:**
- Pola w schema: wypełnij tyle ile znasz, zaznacz `[TBD]` dla nieznanych
- SLA: jeśli consumer nie ma wymagań → daj rozsądne defaults (daily freshness, 99.5% uptime)
- Sekcję "Otwarte kwestie" wypełnij decyzjami które wymagają potwierdzenia
- Jeśli dane zawierają PII → zawsze wypełnij sekcję GDPR, nawet jeśli lakonicznie
