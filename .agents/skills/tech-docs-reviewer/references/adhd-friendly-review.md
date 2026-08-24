# ADHD-Friendly Documentation Review

Use this reference only when the user explicitly requests an ADHD-friendly documentation review.

This is a review lens, not a writing mode. Identify reader friction and propose focused improvements. The technical documentation writer applies approved changes through its normal workflow.

## Review Principle

ADHD needs and preferences vary. Review the actual document for practical friction instead of applying rigid universal rules.

Preserve the document mode. A personal command reference, tutorial, maintainer guide, and troubleshooting document need different structures.

Do not:

- Treat brevity as the only goal.
- Remove context required for safe or correct use.
- Enforce arbitrary paragraph, list, or example limits.
- Add headings, tables, callouts, or summaries when they increase visual noise.
- Describe personal preferences as medical facts or accessibility guarantees.

## Review Areas

Use these five areas as prompts, not mandatory finding categories.

### Entry Path

Check whether the first useful action or shortest success path is easy to find.

Look for:

- Background text before the first useful action.
- Missing discovery, quick-start, or validation commands.
- Several setup paths without a clear default.
- Important prerequisites introduced after they are needed.

### Re-entry and Navigation

Check whether a reader returning later can quickly locate their place and resume work.

Look for:

- Vague headings.
- Missing navigation in a long document.
- A table of contents that is more distracting than useful.
- Important defaults or file locations buried in prose.
- Sections whose names do not match the commands or tasks they contain.

### Chunking and Visual Density

Check whether information is divided into meaningful, manageable units.

Look for:

- Paragraphs that combine several decisions or actions.
- Large code blocks containing unrelated examples.
- Tables that are wider or denser than the comparison requires.
- Long lists without useful grouping or priority.
- Excessive headings that fragment a short document.

Do not flag length by itself. Explain the specific scanning or working-memory cost.

### Action and Outcome Clarity

Check whether readers can distinguish what to do from what will happen.

Look for:

- Commands without a stated purpose.
- Missing return shape, expected result, side effect, or validation signal.
- Risky actions that visually resemble read-only examples.
- Placeholders or defaults that require the reader to remember hidden context.
- Examples where concise comments would clarify returns or effects.

### Priority and Distraction Control

Check whether the main path appears before secondary detail.

Look for:

- Edge cases before common usage.
- Repeated explanations competing with the primary action.
- Related links or background material interrupting the workflow.
- Too many equally emphasized examples.
- Tangential recommendations unrelated to the reader's immediate goal.

Keep necessary advanced detail, but move it after the main path when appropriate.

## Review Process

1. State the assumed document mode and reader goal.
2. Identify the shortest useful entry or re-entry path.
3. Review the document in order using the five areas as prompts.
4. Report only findings tied to plausible reader friction.
5. Keep the main findings list to five or fewer unless the user requests a comprehensive review.
6. Number findings while keeping descriptive titles.
7. Use the normal documentation-review priority and finding format.
8. Note specific decisions that already support focus and re-entry.
9. End with one narrow decision or next review action.

Do not rewrite the document during review. The user can accept, decline, or discuss findings before changes are applied.

## Finding Guidance

A useful finding names the obstacle, reader impact, and focused direction:

```markdown
### 1. Quick Start lacks a clear entry action

Priority: 🟡 Medium

**What**

The section begins with background information before showing the first command.

**Where this appears**

`## Quick Start`

**Reader impact**

A returning reader must scan several paragraphs to find where to resume.

**Direction**

Put the discovery or validation command before optional background details.
```

Avoid vague findings such as:

- Make this shorter.
- Add more headings.
- This is not ADHD-friendly.
- Simplify everything.

Explain the concrete friction and preserve information that supports correctness, safety, or the document's intended mode.

## Questions

Ask a question only when the answer changes the review, for example:

- Is this primarily a first-run guide or a reference used for re-entry?
- Which command should be the fastest path back into the workflow?
- Is the reader expected to know the surrounding project conventions?

Keep questions few and decision-oriented.
