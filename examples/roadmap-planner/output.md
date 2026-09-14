# Sample Output — roadmap-planner

## Podsumowanie strategiczne

Projekt wymiany ERP ma jasny cel biznesowy (skrocenie zamkniecia miesiaca, eliminacja reconciliacji, widocznosc stanow) z twardym ograniczeniem czasowym — wygasniecie wsparcia legacy 2027-06-30. Trzy kluczowe zaklady: (1) wybor systemu ERP do konca H1, (2) migracja danych jako sciezka krytyczna przez caly projekt, (3) rownolegle uruchomienie przez minimum 2 miesiace przed go-live. Kluczowe zalozenie: integracja z e-commerce i aplikacja mobilna to H3 — nie blokuja podstawowego celu biznesowego i moga sie posunac jesli budzet lub harmonogram sa zagrozony.

---

## Mapa drogowa

| Inicjatywa | Temat | Horyzont | Wynik biznesowy | Wartosc | Wysilek | Wlasciciel | Zaleznosci | Status |
|------------|-------|----------|-----------------|---------|---------|------------|------------|--------|
| Wybor i zakup systemu ERP | Platforma | H1 (mies. 1-3) | Unblocking wszystkich pozostalych inicjatyw | W | S | Sponsor + PM | Brak | Planowany |
| Migracja danych z 4 systemow legacy | Dane | H1-H2 (mies. 2-9) | Eliminacja reconciliacji recznej | W | W | Tech Lead | Wybor ERP | Planowany |
| Modul finansowy i zamkniecie miesiaca | Finanse | H1-H2 (mies. 3-9) | Skrocenie close z 10 do 3 dni | W | S | CFO + konsultanci | Wybor ERP | Planowany |
| Modul zarzadzania magazynem (3 lokalizacje) | Magazyn | H2 (mies. 4-10) | Widocznosc stanow w czasie rzeczywistym | W | S | WH Manager | Migracja danych | Planowany |
| Integracja z CRM | Integracje | H2 (mies. 6-11) | Spojny widok klienta, brak duplikatow | S | S | IT Lead | Wybor ERP, CRM API | Planowany |
| Program szkolen uzytkownikow | Adopcja | H2-H3 (mies. 8-13) | Adopcja > 90% uzytkownikow w 30 dni po go-live | W | N | Change Manager | Modul finansowy, WH | Planowany |
| Okres rownoleglego dzialania | Walidacja | H3 (mies. 12-14) | Zerowe ryzyko utraty danych przy przejsciu | W | S | PM | Wszystkie moduly | Planowany |
| Decommissioning systemow legacy | Zamkniecie | H3 (mies. 15-17) | Redukcja kosztow utrzymania legacy | S | N | IT Ops | Rownolegle uruchomienie | Planowany |
| Integracja z e-commerce | Integracje | H3 (mies. 13-17) | Automatyczne zamowienia, brak recznego przepisywania | S | W | IT Lead | Integracja CRM | Planowany |
| Aplikacja mobilna dla magazynow | Mobile | H3 (mies. 15-18) | Szybsze przyjecia towarow | N | W | IT Lead | Modul WH | Planowany |

**Legenda:** W = Wysoki, S = Sredni, N = Niski

---

## Rejestr zalozen

| # | Zalozenie | Wplyw jesli blad | Termin walidacji |
|---|-----------|-----------------|-----------------|
| Z-1 | Wybrany ERP ma gotowe API dla CRM i e-commerce | Koniecznosc custom integracji — +3 mies., +200k PLN | Podczas RFP (mies. 2) |
| Z-2 | Dane w systemach legacy sa wystarczajacej jakosci do migracji | Projekt migracji wydluzony o 2-4 miesiace | Audyt danych (mies. 2-3) |
| Z-3 | Kluczowy personel konsultantow dostepny przez caly projekt | Opoznienie o 1-3 miesiace przy rotacji | Umowy z firma konsultingowa (mies. 1) |
| Z-4 | Budzet 2M PLN obejmuje licencje, wdrozenie i szkolenia | Koniecznosc ciec zakresu lub dodatkowego finansowania | Business case (mies. 1) |
| Z-5 | Mozliwe uruchomienie przed 2027-06-30 (wygasniecie legacy) | Koniecznosc przedluzenia kontraktu legacy — ryzyko bezpieczenstwa | Harmonogram szczegolowy (mies. 3) |

---

## Otwarte pytania

1. Czy aplikacja mobilna jest w budzecie projektu, czy osobna inicjatywą CAPEX? (decyzja: mies. 1)
2. Ktory CRM jest systemem zrodlowym dla integracji? Czy jest dokumentacja API? (do weryfikacji: mies. 2)
3. Czy dopuszczamy krotkie okno downtime (np. weekend) dla migracji koncowej, czy wymagane zero-downtime? (decyzja: mies. 2)
4. Kto jest wlascicielem biznesowym danych w procesie migracji — kto podpisuje akceptacje jakosci? (mies. 1)

---

## Rekomendowane nastepne dzialanie

**Przeprowadzic audyt jakosci danych w 4 systemach legacy w ciagu 3 tygodni** — to jest sciezka krytyczna i jednoczesnie najbardziej niepewna. Wszystko inne (wybor ERP, harmonogram) bedzie korygowane w zaleznosci od wynikow audytu.
