---
name: release-manager
description: End-to-end release coordination — pre-release checklist, go/no-go gate, deployment tracking, and post-release verification
---

# Release Manager

Orchestrate an end-to-end software release: from pre-release checks through deployment tracking to post-release verification.

## When to use this skill

Use this skill when the user says:
- "We're releasing today — help me run the release"
- "Go/no-go for tomorrow's deployment"
- "Run the release checklist"
- "Post-mortem: the release failed — walk me through it"
- "What's the rollback plan?"

## Prerequisites

- Release version and target date known
- Access to relevant tools (GitHub/Linear/Jira for ticket status, deployment tooling for status)
- On-call contact list available or accessible

## Phase 1 — Pre-release gate (T-24h to T-1h)

Run through each gate item and mark Pass / Fail / N/A:

### Code readiness
- [ ] All planned tickets/PRs merged to release branch
- [ ] No open PRs targeting this release branch (or explicitly deferred)
- [ ] Branch builds green (CI passing)
- [ ] No critical-severity issues open in the release milestone

### Testing
- [ ] Automated test suite passing (unit + integration)
- [ ] Manual QA sign-off received (who signed off, when)
- [ ] Regression tests run on staging
- [ ] Performance baseline not degraded (if benchmarks exist)
- [ ] Security scan clean (no new HIGH/CRITICAL findings introduced in this release)

### Operations readiness
- [ ] Release notes prepared and reviewed (Format A + B at minimum)
- [ ] Rollback plan documented (see Phase 4)
- [ ] On-call engineer briefed and available during deployment window
- [ ] Monitoring alerts configured for new features
- [ ] Feature flags set correctly for gradual rollout (if applicable)
- [ ] Database migrations reviewed — are they backward-compatible?
- [ ] External dependencies confirmed available (3rd party APIs, integrations)

### Stakeholder readiness
- [ ] Customer-facing communication drafted (if user-impacting changes)
- [ ] Support team briefed on new features and known issues
- [ ] Release approved by product owner / release manager

**Go/no-go decision:**
- All blocking items (code readiness, critical testing) must be Pass
- Non-blocking items (stakeholder comms, monitoring) can be Fail with documented mitigation
- Any single FAIL on a blocking item = NO-GO unless explicitly overridden by decision-maker

Present the gate summary and ask: "Go or no-go?"

## Phase 2 — Deployment tracking

During the deployment window, track status in real time:

```
[HH:MM] Deployment started — [who, environment, version]
[HH:MM] Database migrations complete — [pass/fail]
[HH:MM] Application deployed — [pass/fail]
[HH:MM] Smoke tests running...
[HH:MM] Smoke tests — [pass/fail]
[HH:MM] Monitoring check — [metrics normal/anomaly detected]
[HH:MM] Release COMPLETE / ROLLBACK INITIATED
```

After each step, ask for the result before proceeding to the next — do not auto-advance.

**Key metrics to check post-deployment (ask the user to verify):**
- Error rate: current vs. baseline (target: <baseline + 0.1%)
- P95 latency: current vs. baseline (target: no >20% degradation)
- Key business metrics (conversion rate, active users — if applicable)

## Phase 3 — Post-release verification (T+30min to T+2h)

Verification checklist:
- [ ] All new features accessible and functioning in production
- [ ] No new error spikes in monitoring (check logs, APM, Sentry/Datadog)
- [ ] Previous functionality (regression) working correctly
- [ ] Database migration applied cleanly
- [ ] Any 3rd-party integrations confirmed working
- [ ] Customer-facing announcement published (if planned)

If all pass: declare release successful and close the release ticket.

If issues found: initiate hotfix or rollback decision (see Phase 4).

## Phase 4 — Rollback plan

Before the release begins, the rollback plan must exist. Template:

```
## Rollback Plan — [Release Version]

**Trigger:** Roll back if [specific condition — e.g., error rate >2x baseline for >10 min, or critical feature broken]

**Decision maker:** [Name, role]

**Steps:**
1. [Redeploy previous version / revert migration / disable feature flag]
2. [Verify service restored]
3. [Notify stakeholders]
4. [Update status page if public-facing]

**Estimated rollback time:** [N minutes]
**Data risk:** [None / Low — migration is reversible / HIGH — migration is NOT reversible, requires manual intervention]
```

If the migration is NOT reversible, flag this prominently — it affects the rollback decision threshold.

## Phase 5 — Release retrospective (T+24h)

Produce a brief post-release report:

```
## Release Retrospective — [Version] — [Date]

**Outcome:** Successful / Partial / Rolled back

**Timeline:**
- Planned deployment: [time]
- Actual deployment start: [time]
- Deployment complete: [time]
- Issues detected: [time] / None

**Issues encountered:**
- [List any problems during deployment, even minor ones]

**What went well:**
- [1-3 specific things]

**What to improve:**
- [1-3 specific things for the next release process]

**Action items:**
| Action | Owner | Due |
|--------|-------|-----|
```

Retrospective is mandatory after any rollback or deployment that took >2x the planned window.

## Hotfix protocol

If a critical issue is discovered post-release:

1. **Assess severity** — is this a rollback-level issue or a hotfix?
   - Rollback: data corruption, complete feature failure, security breach
   - Hotfix: significant but partial failure, known workaround exists

2. **Hotfix release process:**
   - Create `hotfix/vX.Y.Z+1` branch from the release tag (not main)
   - Apply minimal fix only — no feature work
   - Run targeted tests for the affected component
   - Go through abbreviated gate (code + critical tests only)
   - Deploy with expedited approval

3. **Communication:** notify affected users immediately — do not wait for hotfix to be deployed.

## Common issues

**Database migration not backward-compatible:** Flag before deployment. If rollback is needed after migration, this becomes a P0 incident, not just a deployment revert.

**Multiple environments (staging, UAT, prod):** Run Phase 1 gate for each environment separately. Prod gate is always stricter.

**Scheduled maintenance window:** If deployment requires downtime, ensure status page updated and user notification sent >24h in advance.
