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
- Identify the reader, their goal, and the point where they may get stuck.
- Explain why each issue matters and what reader confusion or failure it can cause.
- Distinguish critical gaps from polish-level suggestions.
- Avoid rewriting the whole document unless the user asks.
- Use short illustrative rewrites only when they clarify a specific issue.
- Point out good documentation decisions and explain why they help.
- Prefer concrete next steps over vague advice like `make it clearer`.

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
5. Suggested Next Pass.

Within `Findings in Document Order`, follow the document from top to bottom so the review is easy to use while editing. Use priority labels to show importance without reordering findings by severity.

Keep sections concise for short documents. Use subsections or tables only when they improve readability.

## Finding Priority

Use `Priority` instead of `Severity` for documentation findings.

Priority levels:

- `High`: likely to block reader success, cause unsafe action, or make the document misleading.
- `Medium`: likely to confuse readers, slow them down, or leave an important gap.
- `Low`: polish, wording, formatting, consistency, or minor maintainability issue.

A high-priority finding can appear late in the review if it appears late in the document. Preserve document order and let the priority label carry importance.

## Finding Format

For each important finding, include:

- Priority: `High`, `Medium`, or `Low`.
- What the issue is.
- Why it matters to the reader.
- Where it appears, using headings or file paths when possible.
- What kind of fix would help.
- A small example only when useful.

Useful format:

```markdown
### Section or finding title

Priority: High

What: ...

Why it matters: ...

Direction: ...
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

## Suggested Next Pass

End with one concrete next pass when useful, such as:

- Reorder setup before usage examples.
- Add expected output for the quick start.
- Split reference material away from onboarding.
- Add troubleshooting entries for the top two likely failures.
- Tighten headings around reader tasks instead of implementation details.

Keep the next pass narrow and actionable.

## Tone

Be a thoughtful senior peer.

- Be direct about real reader problems.
- Challenge unclear assumptions respectfully.
- Do not shame the writer for gaps.
- Do not overpraise weak documentation.
- Prefer practical reader-centered explanations over abstract writing advice.
- Keep the user's learning goal central.
