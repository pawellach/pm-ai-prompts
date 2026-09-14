---
name: github-pr-to-release-notes
description: Generate structured release notes from merged GitHub PRs for a given milestone or date range
---

# GitHub PR → Release Notes

Read merged PRs from a GitHub repository and generate ready-to-publish release notes in all three formats defined in `prompts/release-notes-writer.md`.

## When to use this skill

Use this skill when the user says:
- "Generate release notes for v2.3.0"
- "What shipped in the last sprint / this week / this milestone?"
- "Pull the PR list and write the release notes"
- "Prepare the changelog from GitHub"

## Prerequisites

- `gh` CLI installed and authenticated (`gh auth status`)
- Repository accessible from the current machine

## Step 1 — Identify the scope

Determine which PRs to include. Ask the user for one of:

**Option A — By milestone:**
```bash
gh pr list --repo OWNER/REPO --state merged --search "milestone:v1.2.3" --json number,title,labels,mergedAt,body --limit 100
```

**Option B — By date range:**
```bash
gh pr list --repo OWNER/REPO --state merged --json number,title,labels,mergedAt,body --limit 100 | \
  jq '[.[] | select(.mergedAt > "2026-01-01T00:00:00Z" and .mergedAt < "2026-02-01T00:00:00Z")]'
```

**Option C — By tag comparison (since last release):**
```bash
# Find the last release tag
gh release list --repo OWNER/REPO --limit 5

# List commits between tags
git log v1.1.0..v1.2.0 --oneline

# Match commits to PRs
gh pr list --repo OWNER/REPO --state merged --search "base:main" --json number,title,labels,mergedAt --limit 100
```

If the user hasn't specified a repo, ask: "Which GitHub repository? (owner/repo format)"

## Step 2 — Categorize PRs by label

Map GitHub labels to release note categories:

| GitHub Label | Release Note Category |
|-------------|----------------------|
| `breaking-change`, `breaking` | Breaking Changes |
| `feature`, `enhancement`, `new` | New Features |
| `improvement`, `refactor`, `perf` | Improvements |
| `bug`, `fix`, `bugfix` | Bug Fixes |
| `security`, `vulnerability`, `cve` | Security Updates |
| `deprecation`, `deprecated` | Deprecations |
| No label / `chore`, `docs`, `ci` | (ask user whether to include) |

If a PR has no labels, classify by title keywords:
- Starts with "feat:", "feature:", "add " → New Features
- Starts with "fix:", "bug:", "patch " → Bug Fixes
- Starts with "perf:", "optim" → Improvements
- Starts with "BREAKING", "breaking:" → Breaking Changes

Flag any PRs where classification is ambiguous — do not silently skip them.

## Step 3 — Extract PR metadata

For each PR, capture:
- PR number and title
- Author
- Linked issues (from PR body — `Fixes #123`, `Closes #456`)
- Merge date
- Description / body (first paragraph, cleaned of markdown links and checklists)

Skip PRs labeled: `wip`, `do-not-merge`, `draft`, `internal-only` — note the count skipped.

## Step 4 — Generate release notes

Pass the categorized PR list to the three-format structure from `prompts/release-notes-writer.md`:

**Format A — Technical (for developers):**
- List each PR with its number, title, and brief description
- Breaking changes section first, always
- Migration steps if any breaking changes exist

**Format B — Product (for users and customer success):**
- Translate PR titles into user-facing benefit language
- Group by feature area, not by PR
- Skip internal PRs (infra, CI, chore, refactor unless user-visible)

**Format C — Executive (for stakeholders):**
- Maximum 8 bullets total
- Business impact language only
- Security patches always mentioned if present

## Step 5 — Output

Produce all three formats plus:

```
## PR Summary
- Total PRs merged: N
- Breaking changes: N
- New features: N
- Bug fixes: N
- Security patches: N
- PRs skipped (WIP/internal): N
- Ambiguous (manual review needed): [list]
```

## Common issues

**PRs without good titles:** If a significant portion of PRs have commit-style titles ("fix stuff", "WIP", "update"), flag them in the output as `[NEEDS REVIEW]` rather than generating poor release notes.

**Large release (50+ PRs):** Group related PRs before writing — don't produce 50 bullet points. Summarize by theme.

**Monorepo with multiple services:** Ask the user which subdirectory/package/service to scope to, or whether notes should cover all packages.
