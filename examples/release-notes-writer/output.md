# Sample Output — release-notes-writer

---

## Version for App Store / Google Play (Public — Consumer)

**MobilBank 3.4 — What's New**

### Log in faster with your face or fingerprint
You can now open MobilBank with Face ID (iPhone) or fingerprint (Android) — no need to type your PIN every time. Your PIN is always available as a backup if biometrics aren't set up or don't recognize you.

### Send money in seconds — any time
Instant domestic transfers now arrive in under 10 seconds, 24 hours a day, 7 days a week — including evenings, weekends, and public holidays. No more waiting until the next business day.

### Know where your money goes with Budget Tracker
Set a monthly spending limit for categories like food, transport, and entertainment. The app will notify you when you've used 80% of your budget — and again if you hit 100%. Find Budget Tracker in the main menu under "My Finances."

### This update is also faster
The app opens and logs in 40% quicker than before. Long transaction histories no longer slow things down.

---

**Fixes**
- Push notifications on Android should now arrive reliably for all users

**Known issues**
- Apple Watch app: balance may show an older figure; we'll fix this in the next update
- Android 14: a background color issue on the transaction detail screen; cosmetic only, no data affected

---

## Internal / Technical Release Notes (for Internal Teams)

**MobilBank v3.4.0 | Release date: 2026-10-01 | iOS + Android**

---

### New Features

#### F-1: Biometric Authentication
- **iOS:** Face ID via LocalAuthentication framework. Fallback: PIN
- **Android:** BiometricPrompt API (fingerprint + face where supported by device)
- PIN remains mandatory at account setup and as fallback for failed biometric; not removable
- Biometric data stored locally only; never transmitted to server
- Feature flag: `BIOMETRIC_AUTH_ENABLED` — enabled for 100% of users at release

#### F-2: Express Elixir Integration (Instant Payments)
- Replaced Elixir D0 batch settlement with Express Elixir (KIR S.A.)
- Processing time: < 10 seconds; 24/7 availability
- Supported: PLN only; domestic recipients with IBAN only
- Transfer limit: PLN 100,000 per transaction (Express Elixir scheme limit)
- Backend: new `POST /payments/instant` endpoint with synchronous response
- Cut-off times: none (24/7 scheme)

#### F-3: Budget Tracker
- Monthly spending categories: Food, Transport, Shopping, Entertainment, Health, Other (configurable)
- Category rules: based on merchant category codes (MCC) from transaction data
- Threshold notifications: 80% → info push; 100% → alert push
- Budget persistence: monthly reset on the 1st; historical data retained 12 months
- Data source: transaction history API; excludes scheduled transfers and savings

---

### Improvements

| Area | Change | Impact |
|---|---|---|
| Auth token flow | Replaced session polling with JWT refresh; reduced round-trips | Login 40% faster (P50); P95 reduced from 3.1s to 1.4s |
| Transaction list | Switched from full-load to cursor-based pagination | No freeze on accounts with >100 transactions |
| Push delivery (Android 12+) | Fixed Firebase Cloud Messaging token refresh bug causing silent failure | Delivery failure rate: 8% → <0.5% |

---

### Removed / Deprecated

| Feature | Reason | Migration |
|---|---|---|
| SMS OTP login | Last user migrated 2026-09-01; KNF guidance recommends authenticator apps | All users on TOTP/biometric; SMS OTP flow removed from codebase |
| "Classic view" toggle | 1.8% usage at sunset; code complexity not justified | Classic view archived; `UI_CLASSIC_VIEW` feature flag removed |

---

### Known Issues (Carried to v3.5)

| Issue | Platform | Severity | Workaround |
|---|---|---|---|
| Apple Watch app shows stale balance (15 min cache not refreshed) | iOS / watchOS | Low | Pull to refresh on watch app |
| Dark mode: incorrect background on transaction detail | Android 14 | Cosmetic | None needed |

---

### Technical Notes

- Min iOS version: 15.0 (unchanged)
- Min Android version: 8.0 (API 26, unchanged)
- Force update: no (soft prompt for users on v3.2 or earlier)
- Rollout: phased — 10% day 1, 50% day 3, 100% day 7
- Monitoring: New Relic dashboard `mobilbank-v3.4-rollout` active from Oct 1 00:00

---

*MobilBank v3.4.0 | 2026-10-01 | Internal Distribution: Product, Engineering, Support, Marketing*
