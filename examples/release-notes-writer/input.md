# Sample Input — release-notes-writer

**Product:** MobilBank — consumer mobile banking app
**Release:** v3.4.0
**Release date:** 2026-10-01
**Platform:** iOS (App Store) + Android (Google Play)
**Audience:** End consumers + internal teams

**What's in this release:**

NEW FEATURES:
- Biometric login (Face ID on iOS, fingerprint on Android) — replaces mandatory PIN entry; PIN remains as fallback
- Instant domestic payments (Elixir replacement with Express Elixir) — transfers processed in <10 seconds, available 24/7
- Budget tracker: set monthly spending categories, view progress vs budget, receive push notification at 80% and 100% of budget

IMPROVEMENTS:
- Login speed: 40% faster load time (server-side caching improvements, new auth token flow)
- Transaction history: pagination improved — no more freezing when loading >100 transactions
- Push notification delivery reliability: fixed 8% failure rate on Android 12+ devices

DEPRECATED / REMOVED:
- SMS OTP for login removed (migrated to authenticator app; last user of SMS OTP migrated 2026-09-01)
- "Classic view" UI toggle removed — 98% of users never switched; simplifies codebase

KNOWN ISSUES (not fixed in this release):
- Apple Watch app shows stale balance after 15 minutes; fix in v3.5
- Dark mode on Android 14: background color incorrect on transaction detail screen; cosmetic only; fix in v3.5

**Tone:** Consumer-friendly but clear. No jargon. Positive framing.
