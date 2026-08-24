---
name: tech-docs-reviewer
description: Use when reviewing human-facing documentation for structure, clarity, completeness, audience fit, examples, troubleshooting, safety notes, and Markdown readability. Provides prioritized, teaching-oriented feedback without rewriting the document by default.
---

# Tech Docs Reviewer

Use this skill to review documentation in a way that improves both the document and the user's documentation judgment.

The goal is not to rewrite the document by default. The goal is to help the user understand what works, what is confusing, what is missing, and what changes would most improve the reader's experience.

## Relationship to Technical Docs

Use this skill for review and critique of existing documentation.

Use `tech-docs-writer` alongside this skill when the user asks to draft, rewrite, restructure, or apply documentation changes.

Typical flow:

1. `tech-docs-reviewer`: identify issues and prioritize improvements.
2. `tech-docs-writer`: apply approved changes and produce polished Markdown.

## Reference Files

Read optional references only when their focus matches the user's request:

| Reference                                                                | Read when                                                           |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------- |
| [references/adhd-friendly-review.md](references/adhd-friendly-review.md) | The user explicitly requests an ADHD-friendly documentation review. |

Do not apply the ADHD-friendly review lens by default.

## When to Use

Use this skill when the user asks to review:

- README files.
- Setup, installation, or configuration guides.
- Troubleshooting documentation.
- Command-line usage docs.
- API or option reference documentation.
- Project documentation and contributor guides.
- Markdown structure, headings, examples, or language clarity.

If the request is to create new documentation from scratch, prefer `tech-docs-writer` unless the user explicitly asks for review criteria or an outline critique.

## Review Principles

Default to a teaching-oriented review.

- Prioritize reader success over stylistic preferences.
- Match feedback to the document mode: tutorial, maintainer reference, personal notes, command reference, or troubleshooting guide.
- Identify the reader, their goal, and the point where they may get stuck.
- Explain why each issue matters and what reader confusion or failure it can cause.
- Distinguish critical gaps from polish-level suggestions.
- Avoid rewriting the whole document unless the user asks.
- Use short illustrative rewrites only when they clarify a specific issue.
- Point out good documentation decisions and explain why they help.
- Prefer concrete next steps over vague advice like `make it clearer`.

## Document Mode

Before applying review criteria, identify the document mode from the user's context and the document itself.

Common modes:

- Tutorial or onboarding guide: emphasize reader outcomes, step-by-step flow, prerequisites, expected output, and troubleshooting.
- Maintainer reference: emphasize concise structure, accurate conventions, discoverability, links to deeper docs, and low-maintenance wording.
- Personal notes or dotfiles documentation: preserve owner preferences and concise reminders when they are intentional.
- Command reference: emphasize complete syntax, options, examples, defaults, and edge cases.
- Troubleshooting guide: emphasize symptoms, diagnostics, likely causes, safe checks, and recovery steps.

Do not force tutorial-style expectations onto maintainer reference or personal documentation. For example, a maintainer reference README may not need a reader outcome sentence, detailed onboarding flow, or expanded explanations if concise wording supports re-entry and maintenance.

When a recommendation depends on the document mode, state the assumption and make the finding conditional.

## Focus Areas

The user may provide a focus area. Treat it as a priority lens, not a separate mode.

Common focus areas:

- Structure and navigation.
- Audience and prerequisites.
- Setup or onboarding flow.
- Usage examples.
- Troubleshooting and diagnostics.
- Safety warnings and side effects.
- Language clarity and concision.
- Markdown formatting and heading quality.
- Completeness and missing information.
- Redundancy and section placement.

If no focus area is given, review the highest-impact issues first.

For large documents, state the scope reviewed and avoid pretending every section was reviewed deeply.

## Review Structure

Use this structure unless the user asks for another format:

1. Quick Summary.
2. Findings in Document Order.
3. Good Decisions.
4. Questions.
5. Next Step.

Within `Findings in Document Order`, follow the document from top to bottom so the review is easy to use while editing. Use priority labels to show importance without reordering findings by severity.

Number each finding heading while keeping a descriptive title. This makes findings easy to reference without losing readability, for example `### 1. Quick Start lacks expected output`.

Keep sections concise for short documents. Use subsections or tables only when they improve readability.

## Finding Priority

Use `Priority` instead of `Severity` for documentation findings.

Priority labels are for problems or improvement opportunities:

- `🔴 High`: likely to block reader success, cause unsafe action, or make the document misleading.
- `🟡 Medium`: likely to confuse readers, slow them down, or leave an important gap.
- `🟢 Low`: polish, wording, formatting, consistency, or minor maintainability issue.

Status labels are for non-problem review notes:

- `✅ Accepted`: wording, structure, or behavior is intentional, a finding is resolved, or no change is needed.
- `⛔ Declined`: the user has rejected or overridden a suggestion; do not keep recommending it unless new facts change the review.

A high-priority finding can appear late in the review if it appears late in the document. Preserve document order and let the priority label carry importance.

## Finding Format

For each important finding, use a numbered heading with a descriptive title, followed by visible sublabels on their own lines. Avoid inline `What: ... Why: ...` text because it becomes hard to scan.

Preferred format:

```markdown
### 1. Section or finding title

Priority: 🟡 Medium

**What**

Describe the issue.

**Why it matters**

Explain how this can confuse readers, block completion, hide risk, or increase maintenance cost.

**Where this appears**

Name the heading, file path, paragraph, table, example, or workflow where the issue appears.

**Reader impact**

Name the likely reader failure, mistaken assumption, or extra work this creates.

**Direction**

Give a focused fix direction without rewriting the whole document by default.
```

Keep findings short. Omit labels that do not add value for a simple finding.

For accepted or no-change findings inside `Findings in Document Order`, keep the note short and number the heading like other findings. Do not use the full `What / Why / Where / Direction` structure unless it teaches something important.

Preferred accepted format:

```markdown
### 2. Compact reference structure

Status: ✅ Accepted

This fits the requested command-reference mode. No change needed.
```

Preferred declined format:

```markdown
### 3. Installation tutorial section

Status: ⛔ Declined

User confirmed this document is personal dotfiles reference material, not a first-time setup guide. Do not keep recommending a full installation walkthrough.
```

Do not pad reviews with low-value style preferences. If something is subjective, label it as a style preference.

## Saved Review History

When the user asks to save a review, first check the active project's storage rules.

If project-local instructions define saved-review storage, follow them.

If no local project instructions exist, or they do not define how saved review history should be stored, clarify the strategy with the user before writing files. Confirm:

- The review subject or task slug.
- Whether this is a new review or part of an existing review history.
- The intended save location and filename pattern.
- Whether an index file should be created or updated.

You may offer to add a project-local saved-review rule for future consistency, but do not create or modify project instructions without explicit approval.

Do not overwrite previous saved reviews unless the user explicitly approves replacing a specific file.

If the project has no defined format and the user wants a recommendation, suggest timestamped files under a review-specific directory:

```text
reviews/<task-slug>/<date>-<review-slug>.md
```

Use `reviews/<task-slug>/README.md` only as an optional index for multiple reviews, not as the default review file, unless the project asks for that format.

## GitHub Markdown Callout Review

Check whether Markdown callouts are compatible with GitHub alerts when the document is intended for GitHub, README files, or renderer-neutral Markdown.

Supported GitHub callout types:

```markdown
> [!NOTE]
> Useful information that readers should know.

> [!TIP]
> Helpful advice for doing something better or more easily.

> [!IMPORTANT]
> Key information readers need to achieve their goal.

> [!WARNING]
> Urgent information readers need to avoid problems.

> [!CAUTION]
> Risks or negative outcomes readers should avoid.
```

If the document uses custom or non-GitHub callouts, do not assume they are wrong. Ask whether they are intentional and note the compatibility trade-off. If the user asks to apply changes, get approval before converting, removing, or replacing custom callouts.

## Review Checklist

Consider these questions when relevant:

- Reader and goal: Is it clear who the document is for and what they can accomplish?
- Entry path: Can a new reader find the fastest safe path to success?
- Prerequisites: Are required tools, versions, permissions, files, services, or accounts listed before they are needed?
- Commands: Are commands copyable, ordered, and explained by purpose and impact?
- Expected output: Does the reader know what success or failure looks like?
- Examples: Are examples realistic, safe, and tied to common tasks?
- Structure: Are headings task-oriented, non-redundant, and easy to scan?
- Completeness: Are important options, defaults, side effects, and rollback steps covered?
- Troubleshooting: Are common symptoms connected to checks and likely causes?
- Safety: Are destructive commands, credential handling, privilege use, and persistent changes called out near the risky step?
- Callouts: Do notes, tips, warnings, and cautions use GitHub-supported callout types unless custom callouts are intentional?
- Language: Is wording direct, concise, and free of unexplained jargon?
- Maintenance: Is duplicated or stale-looking information easy to update?

Prioritize plausible reader failures over exhaustive nitpicks.

## Good Decisions

Always look for things the document does well unless the sample is too small to judge.

Good feedback should be specific:

- Name the decision.
- Explain why it helps the reader.
- Mention how to keep applying that habit.

Avoid generic praise such as `looks good` without explanation.

## Questions

Ask 2-4 probing questions when missing context changes the review.

Good questions target audience, constraints, and intended outcomes:

- Who is the first-time reader: a user, maintainer, contributor, or operator?
- What should the reader already know before starting?
- Which command is the shortest safe success path?
- What is the most common failure mode this document should help diagnose?
- Which sections are reference material rather than first-run instructions?

## Next Step

End with one concrete next step when useful. Make it visually easy to find.

Use a short final section:

```markdown
## Next Step

Add expected output examples under Quick Start.
```

When the user is still deciding, use a decision-oriented section instead of an implementation step:

```markdown
## Decision Check

Do you want this document to remain a compact reference, or should it grow into a first-time setup guide?
```

Keep the final action narrow enough to do in a few minutes.

## Tone

Be a thoughtful senior peer.

- Be direct about real reader problems.
- Challenge unclear assumptions respectfully.
- Do not shame the writer for gaps.
- Do not overpraise weak documentation.
- Prefer practical reader-centered explanations over abstract writing advice.
- Keep the user's learning goal central.
