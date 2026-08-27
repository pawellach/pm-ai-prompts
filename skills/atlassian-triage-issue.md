# triage-issue — Atlassian Claude Code skill

> **Source:** Official Atlassian plugin for Claude Code.
> **Requires:** Atlassian MCP plugin installed and connected to Jira/Confluence.
> **Install plugin:** Claude Code → /plugins → search "atlassian" → install.
>
> To use as a skill in your own project, copy this file to `.claude/skills/triage-issue/SKILL.md`.
> The skill activates via `/triage-issue` command in Claude Code.

---
---
name: triage-issue
description: "Intelligently triage bug reports and error messages by searching for duplicates in Jira and offering to create new issues or add comments to existing ones. When an agent needs to: (1) Triage a bug report or error message, (2) Check if an issue is a duplicate, (3) Find similar past issues, (4) Create a new bug ticket with proper context, or (5) Add information to an existing ticket. Searches Jira for similar issues, identifies duplicates, checks fix history, and helps create well-structured bug reports."
---

# Triage Issue

## Keywords
triage bug, check duplicate, is this a duplicate, search for similar issues, create bug ticket, file a bug, report this error, triage this error, bug report, error message, similar issues, duplicate bug, who fixed this, has this been reported, search bugs, find similar bugs, create issue, file issue

## Overview

Automatically triage bug reports and error messages by searching Jira for duplicates, identifying similar past issues, and helping create well-structured bug tickets or add context to existing issues.

**Use this skill when:** Users need to triage error messages, bug reports, or issues to determine if they're duplicates and take appropriate action.

---

## Workflow

### Step 1: Extract Key Information

Analyze the bug report to identify:

**Error signature:**
- Error type or exception name (e.g., "NullPointerException", "TimeoutError")
- Error code or status (e.g., "500", "404")
- Specific error message text (key phrases, not full stack trace)

**Context:**
- Component or system affected
- Environment (production, staging, mobile app)
- User actions leading to error

**Symptoms:**
- Observable behavior
- Impact (e.g., "users can't login")

---

### Step 2: Search for Duplicates

Execute **multiple targeted searches** to catch duplicates with different wording:

```
searchJiraIssuesUsingJql(
  cloudId="...",
  jql='project = "PROJ" AND (text ~ "error signature" OR summary ~ "error signature") AND type = Bug ORDER BY created DESC',
  maxResults=20
)
```

Run 3 searches:
1. Error-focused (error signature keywords)
2. Component-focused (affected system keywords)
3. Symptom-focused (observable behavior keywords)

---

### Step 3: Analyze Search Results

**Duplicate confidence levels:**

| Confidence | Criteria | Action |
|---|---|---|
| >90% | Exact same error + same component + recent (<30 days) | Strongly recommend adding comment to existing |
| 70-90% | Similar error with slight variations | Present as possible duplicate, let user decide |
| 40-70% | Similar symptoms but different error | Mention as potentially related |
| <40% | No similar issues | Recommend creating new issue |

Also check fix history: who fixed similar issues, when, and has it regressed?

---

### Step 4: Present Findings to User

**CRITICAL:** Always present findings and wait for user decision before taking any action.

**Example — likely duplicate:**
```
🔍 Triage Results: Likely Duplicate

Found a very similar issue:

PROJ-456 - Connection timeout during mobile login
Status: Open | Priority: High | Created: 3 days ago
https://yoursite.atlassian.net/browse/PROJ-456

Similarity: Same error, same component, same symptoms.
Difference: [any differences]

Recommendation: Add your details as a comment to PROJ-456

Would you like me to:
1. Add a comment to PROJ-456
2. Create a new issue anyway
3. Show more details about PROJ-456
```

---

### Step 5: Execute User Decision

#### Option A: Add Comment to Existing Issue

```
addCommentToJiraIssue(
  cloudId="...",
  issueIdOrKey="PROJ-456",
  commentBody="## Additional Instance Reported\n\n**Error Details:**\n[error]\n\n**Context:**\n- Environment: [env]\n- User Impact: [impact]"
)
```

#### Option B: Create New Issue

```
createJiraIssue(
  cloudId="...",
  projectKey="PROJ",
  issueTypeName="Bug",
  summary="[Component]: [Error Type] - [Brief Symptom]",
  description="[Issue Description, Error Details, Environment, Steps to Reproduce, Expected/Actual Behavior, User Impact, Related Issues]"
)
```

**Summary format:** `[Component] [Error Type] - [Brief Symptom]`
- ✅ "Mobile Login: Connection timeout during authentication"
- ❌ "Error in production" (too vague)

---

### Step 6: Provide Summary

After action, confirm what was done with link to Jira issue.

---

## Tips for Effective Triage

**Search:**
✅ Use multiple queries with different angles  
✅ Include both open AND resolved issues (miss fix history otherwise)  
✅ Search for error signatures and symptoms separately  

**Issue Creation:**
✅ Clear, specific summaries with component names  
✅ Complete error messages in code blocks  
✅ Environment and impact details  
✅ Reference related issues found during triage  

**Duplicate Assessment:**
- High confidence: exact error + same component + <30 days
- When unsure: lean toward creating new issue (can be closed as duplicate later)
- Linking is better than hiding information

---

## When NOT to Use This Skill

❌ Feature requests → use `spec-to-backlog`  
❌ General task creation → use `capture-tasks-from-meeting-notes`  
❌ Searching for information → use `search-company-knowledge`  
❌ Generating status reports → use `generate-status-report`  

**Use only for:** "Is this a duplicate?", "Triage this error", "Has this been reported?", "Create a bug ticket for this"
