# Skill Review Format

Read this reference before producing a normal or follow-up review of a skill and its supporting resources. Scale the format down for one or two simple findings instead of filling every section mechanically.

## Review Structure

Use [../assets/skill-review-report-template.md](../assets/skill-review-report-template.md) for substantial reviews or saved review reports.

Use this structure unless the user requests another format:

1. Findings Overview, for three or more findings.
2. Findings.
3. Good Decisions.
4. Best-Practice Check, only when reviewing against Agent Skills or another baseline.
5. Questions, only when answers would change the recommendation.
6. Update Scope or Decision Check.

Keep visible section names concise. Put ordering, priority, and status details inside sections rather than appending them to headings.

## Findings Overview

For three or more findings, add a linked overview before the detailed findings:

```markdown
## Findings Overview

- [1. Routing](#1-routing) — ✅ Pass
- [2. Approval gate](#2-approval-gate) — ✅ Pass
- [3. Safety section](#3-safety-section) — 🟢 Optional polish
```

Keep each line to the finding link plus priority or status. Do not repeat evidence or recommended actions. For one or two findings, use a one-sentence diagnosis or omit the overview when it would duplicate the findings.

## Findings

Report no more than five highest-value findings unless the user requests an exhaustive review.

Present findings in source order when that makes the review easier to apply. For multi-file reviews, group findings by file in a stable order. Use priority labels without reordering findings by severity.

Number each finding and use a concise noun phrase for its heading:

```markdown
### 1. Reference loading
```

Do not include priority, status, evidence, or the proposed fix in the heading.

## Finding Priority and Status

Use one metadata line after the heading. Never put priority or status in the heading.

Use `Priority` for problems:

- `🔴 High`: likely to break discovery or routing, weaken an approval or safety boundary, leave broken references, or make a migration incomplete.
- `🟡 Medium`: likely to create unclear responsibility boundaries, maintenance problems, validation gaps, or ineffective progressive disclosure.
- `🟢 Low`: wording, organization, naming, consistency, or other low-risk polish.

Use `Status` for non-problem notes and optional polish:

- `✅ Pass`: checked behavior is correct and should stay unchanged.
- `🟢 Optional polish`: low-risk readability or organization improvement that is not a blocker.
- `⛔ Declined`: the user rejected or overrode the suggestion; do not repeat it unless new evidence changes the review.

Preserve source order and let the metadata line communicate importance.

## Finding Format

Use a numbered heading followed by priority or status on its own line:

```markdown
### 1. Marker discovery

Priority: 🔴 High

**Evidence**

The workflow defines supported marker formats, but the initial search failed to find two `> REVIEW` blocks.

**Why it matters**

Missed markers can make a review appear complete while user feedback remains unresolved.

**Recommended action**

Use a broad whole-word search before classifying exact marker syntax.
```

Keep headings short. Use a noun phrase, not a sentence.

Use `**Evidence**` for the observation and support. Keep it to one short paragraph unless more detail is required.

Use `**Why it matters**` for impact, failure modes, maintenance cost, and risks. Omit it for pass notes or simple optional polish when it would add noise.

Use `**Recommended action**` for the smallest useful change. Explain a trade-off only when it affects the decision.

When recommending a concrete wording replacement, show the current wording before the proposed wording. Use compact `Old wording` and `New wording` blocks. Do not use a grid/table for wording replacements unless the user explicitly asks for one. Do not force old/new blocks for conceptual recommendations where exact text is not being replaced.

When recommending a reusable output pattern, include one compact positive example when it makes the recommendation easier to review or apply. Add a short “avoid this” example only when a likely wrong pattern needs contrast. Omit examples for routine wording edits or conceptual recommendations where they add ceremony.

Omit labels that add no value to a simple finding. Do not turn every sentence into a subsection.

## Accepted and Declined Notes

Keep pass notes concise:

```markdown
### 2. Approval gate

Status: ✅ Pass

**Evidence**

The gate names exact files and requires separate approval for expanded scope. Preserve it.
```

Keep declined findings equally direct:

```markdown
### 3. Shared review skill

Status: ⛔ Declined

**Evidence**

The user prefers separate reviewer skills. Do not keep recommending a shared abstraction without new evidence.
```

Do not apply the full problem, risk, and recommended-action format unless the note teaches something important.

## Best-Practice Check

Use a compact best-practice table when the review compares a skill to Agent Skills or another explicit baseline.

Check only areas relevant to the task:

- Real expertise and source material.
- Progressive disclosure.
- Context economy.
- Calibrated control.
- Templates and output formats.
- Validation or refinement loops.
- Description/routing quality.

Do not add this section for routine reviews when it would repeat the findings.

## Good Decisions

Identify concrete decisions worth preserving:

- Name the decision.
- Explain why it improves routing, safety, portability, maintainability, or progressive disclosure.
- State what should remain unchanged when useful.

Do not duplicate accepted findings in both Findings and Good Decisions.

## Questions

Ask questions only when the answers can change the recommendation, scope, or migration path. Keep them few and decision-oriented.

Do not disguise criticism as a question or add questions only to satisfy the format.

## Follow-Up Reviews

When previous review history is relevant:

1. Verify resolved findings instead of presenting them as new problems.
2. Preserve accepted and declined decisions when they prevent repeated recommendations.
3. Identify newly discovered issues as new findings.
4. Do not change a previous status without user confirmation or new evidence.

## Update Scope

When implementation is ready, end with a narrow scope that lists:

- Exact files to create, modify, move, or delete.
- Artifact role and naming rule for new files, including any `README.md` exception.
- Routing dependencies or external records that also need changes.
- Validation required after implementation.

For substantial updates, use [../assets/skill-change-proposal-template.md](../assets/skill-change-proposal-template.md).

Use `Decision Check` instead when an unresolved design choice changes the file scope or behavior.
