# spec-to-backlog — Atlassian Claude Code skill

> **Source:** Official Atlassian plugin for Claude Code.
> **Requires:** Atlassian MCP plugin installed and connected to Jira/Confluence.
> **Install plugin:** Claude Code → /plugins → search "atlassian" → install.
>
> To use as a skill in your own project, copy this file to `.claude/skills/spec-to-backlog/SKILL.md`.
> The skill activates via `/spec-to-backlog` command in Claude Code.

---
---
name: spec-to-backlog
description: "Automatically convert Confluence specification documents into structured Jira backlogs with Epics and implementation tickets. When an agent needs to: (1) Create Jira tickets from a Confluence page, (2) Generate a backlog from a specification, (3) Break down a spec into implementation tasks, or (4) Convert requirements into Jira issues. Handles reading Confluence pages, analyzing specifications, creating Epics with proper structure, and generating detailed implementation tickets linked to the Epic."
---

# Spec to Backlog

## Overview

Transform Confluence specification documents into structured Jira backlogs automatically. This skill reads requirement documents from Confluence, intelligently breaks them down into logical implementation tasks, **creates an Epic first** to organize the work, then generates individual Jira tickets linked to that Epic—eliminating tedious manual copy-pasting.

## Core Workflow

**CRITICAL: Always follow this exact sequence:**

1. **Fetch Confluence Page** → Get the specification content
2. **Ask for Project Key** → Identify target Jira project
3. **Analyze Specification** → Break down into logical tasks (internally, don't create yet)
4. **Present Breakdown** → Show user the planned Epic and tickets
5. **Create Epic FIRST** → Establish parent Epic and capture its key
6. **Create Child Tickets** → Generate tickets linked to the Epic
7. **Provide Summary** → Present all created items with links

**Why Epic must be created first:** Child tickets need the Epic key to link properly during creation. Creating tickets first will result in orphaned tickets.

---

## Step 1: Fetch Confluence Page

When triggered, obtain the Confluence page content.

### If user provides a Confluence URL:

Extract the cloud ID and page ID from the URL pattern:
- Standard format: `https://[site].atlassian.net/wiki/spaces/[SPACE]/pages/[PAGE_ID]/[title]`
- The page ID is the numeric value in the URL path

### If user provides only a page title or description:

Use the `search` tool to find the page.

### Fetch the page:

```
getConfluencePage(
  cloudId="...",
  pageId="123456",
  contentFormat="markdown"
)
```

---

## Step 2: Ask for Project Key

**Before analyzing the spec**, determine the target Jira project:

Ask the user: "Which Jira project should I create these tickets in? Please provide the project key (e.g., PROJ, ENG, PRODUCT)."

Once you have the project key, call `getJiraProjectIssueTypesMetadata` to understand available issue types.

**Select appropriate issue types for child tickets:**

- **"Bug"** — fix existing problems, defects, errors, incorrect behavior
- **"Story"** — new user-facing features, UX improvements, customer-requested capabilities
- **"Task"** — technical work, infrastructure, refactoring, documentation, configuration

---

## Step 3: Analyze Specification

Read the Confluence page content and internally decompose it into:

### Epic-Level Goal
What is the overall objective? This becomes your Epic.

### Implementation Tasks
Break the work into logical, independently implementable tasks (3-10 tasks typical).

**Breakdown principles:**
- **Size:** 3-10 tasks per spec
- **Clarity:** Each task should be specific and actionable
- **Independence:** Tasks can be worked on separately when possible
- **Completeness:** Include backend, frontend, testing, documentation as needed

---

## Step 4: Present Breakdown to User

**Before creating anything**, show the planned breakdown:

```
I've analyzed the spec and here's the backlog I'll create:

**Epic:** [Epic Summary]
[Brief description of epic scope]

**Implementation Tickets (7):**
1. [Story] [Task 1 Summary]
2. [Task] [Task 2 Summary]
3. [Bug] [Task 3 Summary]
...

Shall I create these tickets in [PROJECT KEY]?
```

Wait for user confirmation. Allow them to request changes.

---

## Step 5: Create Epic FIRST

```
createJiraIssue(
  cloudId="...",
  projectKey="PROJ",
  issueTypeName="Epic",
  summary="[Epic Summary]",
  description="[Epic Description with Overview, Objectives, Scope, Success Criteria]"
)
```

**Capture the Epic Key** from the response (e.g., "PROJ-123") — needed for every child ticket.

---

## Step 6: Create Child Tickets

For each task:

```
createJiraIssue(
  cloudId="...",
  projectKey="PROJ",
  issueTypeName="[Story/Task/Bug]",
  summary="[Task Summary]",
  description="[Context, Requirements, Technical Details, Acceptance Criteria]",
  parent="PROJ-123"
)
```

**Acceptance Criteria format** (testable and specific):
- ✅ "API returns 201 status on successful user creation"
- ❌ "User can log in" (too vague)

---

## Step 7: Provide Summary

```
✅ Backlog created successfully!

**Epic:** PROJ-123 - [Epic Title]
https://yoursite.atlassian.net/browse/PROJ-123

**Implementation Tickets (N):**
1. PROJ-124 - [Task summary] — https://...
2. PROJ-125 - [Task summary] — https://...
...

**Source:** [Confluence page URL]

**Next Steps:**
- Review tickets for accuracy
- Assign to team members
- Estimate story points
- Schedule for sprint
```

---

## Edge Cases

- **Existing Epic:** Skip creation, ask for Epic key, proceed with Step 6
- **Large specs (15+ tickets):** Ask user to confirm or adjust scope before creating
- **Custom required fields:** Use `getJiraIssueTypeMetaWithFields` and ask user for values
- **Ambiguous spec:** Create fewer, broader tickets with refinement notes

---

## Tips for Quality Breakdowns

- Be specific: ❌ "Do frontend work" → ✅ "Create login form UI with email/password inputs and validation"
- Include technical context: mention specific technologies when clear from spec
- Related work stays in the same ticket; split when different specialties
- Note dependencies in ticket descriptions
- Include testing: either as part of feature tasks or as separate testing tasks
