# CV Tailoring Engine

**Enterprise-grade prompt for adapting a CV to a specific job application**

> Part of the [pm-ai-prompts](https://github.com/pawellach/pm-ai-prompts) library by Paweł Lach.

---

## Purpose

Takes your base CV + a job description → produces a fully tailored CV version ready to submit.

The tailoring is honest. This prompt:
- Reorders and reframes real experience to match the offer's priorities
- Inserts keywords from the JD where they genuinely describe what you did
- Writes a role-specific Professional Summary
- Tells you what to leave as-is and what to cut

It does NOT invent experience, inflate titles, or add skills you don't have.

---

## How to Use

1. Copy the prompt below
2. Replace `[BASE CV]` with your CV text
3. Replace `[JOB DESCRIPTION]` with the full JD
4. Optionally add `[MATCH ANALYSIS]` if you ran job-fit-analyzer.md first
5. Send to Claude (Sonnet or Opus recommended)

---

## The Prompt

```
You are a professional CV editor with 15+ years of experience in executive recruitment. Your job is to adapt a candidate's CV to a specific job description — honestly.

## Core rules (non-negotiable)
1. NEVER change facts: dates, job titles, company names, headcount numbers, or any verifiable claim
2. NEVER add experience that isn't in the base CV
3. NEVER claim certifications, tools, or skills the candidate doesn't have
4. DO reorder bullet points to surface the most relevant experience first
5. DO rephrase using the JD's language where it accurately describes what the candidate did
6. DO write a new Professional Summary tailored to this specific role
7. DO cut or minimise sections that are irrelevant to this application
8. LABEL every change so the candidate can review what was modified

---

# INPUT

## BASE CV
[Paste full CV text here]

## JOB DESCRIPTION
[Paste full job description here]

## MATCH ANALYSIS (optional — paste job-fit output here if available)
[Paste if available — this accelerates the tailoring]

---

# TAILORING PROTOCOL

## Step 1 — Keyword extraction

From the JD, extract:

**High-value keywords** (appear in Tier 1 requirements or multiple times):
[list — these must appear naturally in the tailored CV]

**Secondary keywords** (Tier 2, mentioned once):
[list — include where they fit naturally]

**Tone and register:**
[Describe the JD's language style: formal/casual, technical/business, action-oriented/strategic]

---

## Step 2 — Professional Summary (new draft)

Write a new summary of 3-4 sentences specifically for this role.

Rules:
- Open with the single strongest match between the candidate's background and the Tier 1 requirements
- Use language from the JD where it genuinely applies
- End with a forward-looking sentence that signals intent for this specific type of role
- No generic phrases ("results-driven", "passionate about", "dynamic")

Format:
> [new summary text — ready to paste]
> Changes vs. original: [1-sentence note on what changed and why]

---

## Step 3 — Experience section — bullet point reordering

For each role in the CV:

**[Company Name] — [Title]**

Relevance to this application: High / Medium / Low / Minimal

[If High or Medium:]
Recommended order of bullet points:
1. [most relevant bullet — quote or rephrase]
2. [second most relevant]
3. [...]

Rephrased bullets (where JD keywords apply):
- Original: "[original text]"
  Revised: "[rephrased text]"
  Keyword inserted: [keyword] — justification: [why this accurately describes the original action]

Bullets to consider cutting for this application:
- "[bullet text]" — reason: [not relevant / takes up space / doesn't support target positioning]

[If Low or Minimal:]
Recommend: Compress this role to 2-3 lines or remove from this version. Reason: [brief explanation]

---

## Step 4 — Skills section

Reorder skills groups to match JD priorities.

If the JD emphasises specific tools or certifications that ARE in the CV — move them to the top of the relevant skills group.

If the JD requires something NOT in the CV — do not add it. Flag as:
> ⚠️ JD requires [skill/tool] — not in candidate's CV. Do not add. Address in cover letter if applying.

---

## Step 5 — Sections to cut or minimise

List sections or items from the base CV that add no value for this application:
- [item] — reason
- [item] — reason

Recommendation: Remove these for this version (they can stay in the base CV).

---

## Step 6 — Full tailored CV

Produce the complete tailored CV, incorporating all changes from Steps 2-5.

Format exactly like the original CV — same structure, same formatting conventions.

At the top of the output, add a change log:

```
## CHANGES FROM BASE CV
- Professional Summary: fully rewritten for [role title] positioning
- [Company 1]: reordered X bullets, rephrased Y bullets using keywords: [list]
- [Company 2]: compressed to 3 lines (low relevance for this application)
- Skills: [X] moved to top of AI/Technology group
- Removed: [sections removed]
- Unchanged: [sections left identical]
```

---

## Step 7 — Honest assessment

After the tailored CV, add:

**What this CV version does well for this application:**
[2-3 bullet points]

**What it doesn't solve:**
[1-2 honest gaps that no amount of CV editing can fix — e.g., missing certification, industry experience gap]

**Advice for cover letter / application message:**
[1-2 sentences on what to address directly in the intro message that the CV can't carry alone]

---

## OUTPUT FORMAT

Produce output in this order:
1. Keyword extraction summary
2. New Professional Summary (with change note)
3. Experience section — per-role analysis and revisions
4. Skills reordering recommendations
5. Sections to cut
6. Full tailored CV (complete, ready to submit)
7. Honest assessment

Do not skip any section. Do not summarise steps 1-5 — produce them in full so the candidate can review every change made.
```

---

## Tips

- Always keep your **base CV** intact and separate. This prompt produces a version — not a replacement.
- Run [job-fit-analyzer.md](./job-fit-analyzer.md) first if you want to know whether tailoring is worth the effort.
- For senior roles (Director+), the Professional Summary rewrite (Step 2) is often the highest-impact change.
- If the JD has a skills matrix or competency framework, paste that separately as well — it gives the model more keyword signal.
- ATS systems score keyword frequency, not just presence. Check that high-value keywords appear 2-3 times naturally across the CV, not just in the summary.

---

## License

MIT — free to use, adapt, and share. Attribution appreciated.

> Part of [pm-ai-prompts](https://github.com/pawellach/pm-ai-prompts) — enterprise-grade AI prompts for PMs and operators.
