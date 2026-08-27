# search-company-knowledge — Atlassian Claude Code skill

> **Source:** Official Atlassian plugin for Claude Code.
> **Requires:** Atlassian MCP plugin installed and connected to Jira/Confluence.
> **Install plugin:** Claude Code → /plugins → search "atlassian" → install.
>
> To use as a skill in your own project, copy this file to `.claude/skills/search-company-knowledge/SKILL.md`.
> The skill activates via `/search-company-knowledge` command in Claude Code.

---
---
name: search-company-knowledge
description: "Search across company knowledge bases (Confluence, Jira, internal docs) to find and explain internal concepts, processes, and technical details. When an agent needs to: (1) Find or search for information about systems, terminology, processes, deployment, authentication, infrastructure, architecture, or technical concepts, (2) Search internal documentation, knowledge base, company docs, or our docs, (3) Explain what something is, how it works, or look up information, or (4) Synthesize information from multiple sources. Searches in parallel and provides cited answers."
---

# Search Company Knowledge

## Keywords
find information, search company knowledge, look up, what is, explain, company docs, internal documentation, Confluence search, Jira search, our documentation, internal knowledge, knowledge base, search for, tell me about, get information about, company systems, terminology, find everything about, what do we know about, deployment, authentication, infrastructure, processes, procedures, how to, how does, our systems, our processes, internal systems, company processes, technical documentation, engineering docs, architecture, configuration, search our docs, search internal docs, find in our docs

## Overview

Search across siloed company knowledge systems (Confluence, Jira, internal documentation) to find comprehensive answers to questions about internal concepts, systems, and terminology. This skill performs parallel searches across multiple sources and synthesizes results with proper citations.

**Use this skill when:** Users ask about internal company knowledge that might be documented in Confluence pages, Jira tickets, or internal documentation.

---

## Workflow

### Step 1: Identify Search Query

Extract the core search terms from the user's question.

**Examples:**
- User: "Find everything about Stratus minions" → Search: "Stratus minions"
- User: "What do we know about the billing system?" → Search: "billing system"
- User: "Explain our deployment process" → Search: "deployment process"

---

### Step 2: Execute Parallel Search

Search across all available knowledge sources simultaneously for comprehensive coverage.

#### Option A: Cross-System Search (Recommended First)

Use the **`search`** tool (Rovo Search) to search across Confluence and Jira at once:

```
search(
  cloudId="...",
  query="[extracted search terms]"
)
```

#### Option B: Targeted Confluence Search

```
searchConfluenceUsingCql(
  cloudId="...",
  cql="text ~ 'search terms' OR title ~ 'search terms'"
)
```

#### Option C: Targeted Jira Search

```
searchJiraIssuesUsingJql(
  cloudId="...",
  jql="text ~ 'search terms' OR summary ~ 'search terms'"
)
```

#### Search Strategy

1. Start with `search` (cross-system) — always try this first
2. If results are unclear, follow up with targeted searches
3. If results mention specific pages/tickets, fetch them for details

---

### Step 3: Fetch Detailed Content

After identifying relevant sources, fetch full content for comprehensive answers.

#### For Confluence Pages

```
getConfluencePage(
  cloudId="...",
  pageId="[page ID from search results]",
  contentFormat="markdown"
)
```

#### For Jira Issues

```
getJiraIssue(
  cloudId="...",
  issueIdOrKey="PROJ-123"
)
```

**Prioritization:**
1. Official documentation pages
2. Recent/relevant issues
3. Additional context pages

---

### Step 4: Synthesize Results

Combine information from multiple sources into a coherent answer.

**Structure:**
1. **Direct Answer First** — clear, concise answer
2. **Detailed Explanation** — organized by topic, not by source
3. **Source Attribution** — note where each piece comes from
4. **Highlight Discrepancies** — if sources conflict, note it explicitly
5. **Provide Context** — mention if information is outdated

---

### Step 5: Provide Citations

Always include links to source materials.

```
## Sources

**Confluence Documentation:**
- [Page Title](https://yoursite.atlassian.net/wiki/spaces/SPACE/pages/12345)

**Jira Issues:**
- [PROJ-123](https://yoursite.atlassian.net/browse/PROJ-123) - Brief description
```

---

## Tips for High-Quality Answers

### Do:
✅ Always search before answering (don't rely on general knowledge)  
✅ Cite all sources with links  
✅ Note discrepancies explicitly  
✅ Mention when information is old  
✅ Structure answers clearly with headers  

### Don't:
❌ Assume general knowledge applies to this company  
❌ Make up information if search returns nothing  
❌ Ignore conflicting information  
❌ Quote entire documents (summarize instead)  

---

## When NOT to Use This Skill

❌ General technology questions (use your training knowledge)  
❌ External documentation (use web search)  
❌ Company-agnostic questions  
❌ Questions about other companies  
