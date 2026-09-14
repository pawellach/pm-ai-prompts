# Sample Output — risk-register-analyst

## A. Podsumowanie ryzyk (Executive Summary)

Projekt migracji CRM do Salesforce identyfikuje piec ryzyk, z ktorych dwa sa krytyczne: brak wybranego narzedzia do migracji danych oraz zaleznosc od jednego dewelopera znajacego system legacy. Profil ryzyk projektu jest wysoki pod wzgledem harmonogramu i techniczny ze wzgledu na sztywna date uruchomienia (2026-12-01) w polaczeniu z niezwyklymi okolicznosciami (sezon swiateczny, brak rezerwy personalnej). Obecne pokrycie dzialan lagodzacych jest niewystarczajace — ryzyka R-001 i R-002 nie maja przypisanych mitygacji. Rekomendowane natychmiastowe dzialanie: wybor narzedzia migracyjnego i opracowanie planu zastepstwa dla kluczowego dewelopera w ciagu 2 tygodni.

---

## B. Rejestr RAID

### RYZYKA

| ID | Opis | Przyczyna | Prawdopodobienstwo | Wplyw | Wynik | Mitygacja | Kontyngencja | Wlasciciel | Data przegladu | Status |
|----|------|-----------|-------------------|-------|-------|-----------|--------------|------------|---------------|--------|
| R-001 | Migracja danych moze sie nie powiesc — 500k rekordow, brak wybranego narzedzia | Brak decyzji technologicznej, nieznana jakosc danych zrodlowych | W | W | KRYTYCZNY | Natychmiastowy wybor narzedzia (DataLoader / Talend / MigrationTool); przeprowadzenie audytu jakosci danych do 2026-10-01 | Przygotowanie planu rollback; freeze danych zrodlowych 48h przed migracja | Tech Lead | 2026-10-01 | Otwarty |
| R-002 | Kluczowy deweloper moze odejsc — jedyna osoba znajaca system legacy | Single point of failure, brak dokumentacji systemu legacy | S | W | WYSOKI | Natychmiastowe rozpoczecie dokumentowania systemu legacy; wdrozenie shadow developera | Kontraktowanie zewnetrznego specjalisty w reserve | PM | 2026-09-28 | Otwarty |
| R-003 | Uzytkownicy biznesowi niedostepni na UAT — konflikty z sezonem swiatecznym | Data go-live 2026-12-01 pokrywa sie z urlopami grudniowymi | W | S | WYSOKI | Zaplanowanie UAT na pazdziernik-listopad; uzyskanie formalnych potwierdzen dostepnosci od managerow | Ograniczenie zakresu UAT do procesow krytycznych; delegowanie zastepstw | PM | 2026-09-30 | Otwarty |
| R-004 | Przekroczenie budzetu projektu | Niezidentyfikowane wymagania, koszty licencji Salesforce wyzsze niz planowane | S | S | SREDNI | Zablokowanie zakresu (scope freeze) od 2026-10-15; tygodniowy monitoring kosztow | Eskalacja do sponsora przy przekroczeniu 10% budzetu | Sponsor | 2026-10-15 | Otwarty |
| R-005 | Niska adopcja uzytkownikow po uruchomieniu | Brak programu change management, krotki czas na szkolenia w grudniu | S | S | SREDNI | Wdrozenie planu komunikacji i szkolen od wrzesnia; wyznaczenie ambasadorow w dzialach | Przedluzenie okresu wsparcia polaunchowego do 2027-01-31 | Change Manager | 2026-10-01 | Otwarty |

### ZALOZENIA

| ID | Opis | Podstawa | Wplyw jesli blad | Wlasciciel | Data walidacji | Status |
|----|------|----------|-----------------|------------|---------------|--------|
| A-001 | Dane zrodlowe sa kompletne i mozliwe do mapowania na model Salesforce | Wstepna analiza systemu legacy | Istotne opoznienie migracji | Tech Lead | 2026-10-01 | Do walidacji |
| A-002 | Licencje Salesforce zostana dostarczone do 2026-10-15 | Deklaracja sponsora | Blokada srodowiska testowego | Sponsor | 2026-09-30 | Do walidacji |

### PROBLEMY (Issues)

| ID | Opis | Wplyw | Priorytet | Wlasciciel | Dzialanie | Termin | Status |
|----|------|-------|-----------|------------|-----------|--------|--------|
| I-001 | Brak wybranego narzedzia do migracji danych — decyzja opozniona o 3 tygodnie | Blokuje planowanie technikaliow migracji | W | Tech Lead | Decyzja do 2026-09-21 | 2026-09-21 | Aktywny |

### ZALEZNOSCI

| ID | Opis | Typ | Wplyw jesli zablokowane | Wlasciciel | Termin | Status |
|----|------|-----|------------------------|------------|--------|--------|
| D-001 | Dostarczenie licencji Salesforce przez dzial zakupow | Wewnetrzny | Brak srodowiska testowego | Dział zakupów | 2026-10-15 | Oczekujacy |
| D-002 | Freeze systemu legacy (brak zmian w danych) na 48h przed migracja | Wewnetrzny | Niespojnosc danych migrowanych | IT Ops | 2026-11-29 | Planowany |

---

## C. Mapa ryzyk (heatmap)

```
                Niski wplyw   Sredni wplyw   Wysoki wplyw
Wysokie prawd  |             |   R-003       |   R-001     |
Srednie prawd  |             |   R-004, R-005|   R-002     |
Niskie prawd   |             |               |             |
```

---

## D. Top 3 ryzyk — analiza szczegolowa

### R-001: Ryzyko niepowodzenia migracji danych

**Opis:** 500 000 rekordow bez wybranego narzedzia migracyjnego i bez audytu jakosci danych. Data go-live jest stala.

**Analiza przyczynowa (5 Whys):**
1. Dlaczego migracja moze sie nie powiesc? Bo nie wiemy jak wyglada jakosc danych zrodlowych.
2. Dlaczego tego nie wiemy? Bo nie wybrano jeszcze narzedzia i nie przeprowadzono audytu.
3. Dlaczego nie wybrano narzedzia? Bo decyzja zostala odlozona — priorytetem byl wybor konfiguracji Salesforce.
4. Dlaczego priorytetyzacja byla taka? Brak PM-a z doswiadczeniem w projektach migracyjnych.
5. Dlaczego brak doswiadczenia? Zalozenie, ze migracja to "tylko techniczny detail" — niedoszacowanie zlozonosci.

**Dzialania mitygujace:**
1. Wybrac narzedzie migracyjne do 2026-09-21 (DataLoader Pro lub Talend Open Studio)
2. Przeprowadzic profiling danych zrodlowych (duplikaty, brakujace pola, niezgodnosci typow) do 2026-10-01
3. Przeprowadzic pilotowa migracje 5% rekordow (test run) do 2026-10-31
4. Zaplanowac pelna migracje na 2026-11-15 z buforem 2 tygodni przed go-live

**Sygnaly ostrzegawcze:** Profiling danych pokazuje >5% duplikatow; test run trwa >2h dla 5% rekordow; mapowanie pol nie jest kompletne do 2026-10-15.

**Prog eskalacji:** Eskalacja do sponsora jezeli narzedzie nie zostanie wybrane do 2026-09-21 lub test run sie nie powiedzie.

---

### R-002: Odejscie kluczowego dewelopera

**Opis:** Jedna osoba zna system legacy. Jej odejscie (choroba, rezygnacja) blokuje migracje bez mozliwosci zastapienia.

**Dzialania mitygujace:**
1. Sesje dokumentacyjne 2x w tygodniu przez pierwsze 4 tygodnie — tech lead dokumentuje decyzje architektoniczne
2. Przydzielenie shadow developera (junior) ktory towarzyszy we wszystkich pracach na legacy
3. Zapis sesji pair programming jako archiwum wideo
4. Kontraktowanie zewnetrznego specjalisty w reserve (contract, bez aktywacji) — gotowy do startu w 5 dni

**Sygnaly ostrzegawcze:** Deweloper bierze wiecej urlopu niz zwykle; brak dokumentacji po 2 tygodniach sesji.

**Prog eskalacji:** Jakikolwiek nieplanowany brak dewelopera > 3 dni robocze — natychmiastowa aktywacja kontraktu rezerwowego.

---

### R-003: Niedostepnosc uzytkownikow na UAT

**Opis:** Planowany UAT w grudniu koliduje z urlopami swiatecznymi. Bez UAT nie ma formalnego odbioru systemu.

**Dzialania mitygujace:**
1. Przesuniecie UAT na 2026-11-03 — 2026-11-21 (4 tygodnie przed go-live)
2. Uzyskanie pisemnych potwierdzen dostepnosci od managerow dzialow do 2026-09-30
3. Wyznaczenie po jednym "UAT champion" per dzial — osoba odpowiedzialna za organizacje zastepstw
4. Przygotowanie scenariuszy UAT do 2026-10-15 aby nie tracic czasu w listopadzie

**Sygnaly ostrzegawcze:** Potwierdzenia dostepnosci nie splywaja do 2026-09-30; zakres scenariuszy UAT nie jest zatwierdzony do 2026-10-20.

---

## E. Rekomendowane dzialania natychmiastowe

| # | Dzialanie | Wlasciciel | Termin | Priorytet |
|---|-----------|------------|--------|-----------|
| 1 | Wybrac narzedzie do migracji danych | Tech Lead | 2026-09-21 | KRYTYCZNY |
| 2 | Rozpoczac dokumentowanie systemu legacy (sesje 2x/tydzien) | Tech Lead | 2026-09-18 | KRYTYCZNY |
| 3 | Potwierdzic dostepnosc uzytkownikow na UAT w listopadzie | PM | 2026-09-30 | WYSOKI |
| 4 | Przeprowadzic profiling danych zrodlowych | Tech Lead | 2026-10-01 | WYSOKI |
| 5 | Wyslac zamowienie na licencje Salesforce | Sponsor | 2026-09-25 | WYSOKI |
