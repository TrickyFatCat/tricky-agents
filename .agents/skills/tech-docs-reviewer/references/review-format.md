# Documentation Review Domain Guidance

Use this reference for documentation-specific evidence, criteria, priorities, finding fields, outcomes, and follow-up judgment.

Read [`audit-workflow/references/review.md`](../../audit-workflow/references/review.md) for conversational Review mechanics and [`audit-workflow/references/audit.md`](../../audit-workflow/references/audit.md) for formal Audit mechanics. For a Documentation Audit, adapt the shared [artifact Audit template](../../audit-workflow/assets/artifact-audit-template.md) with the domain additions below.

## Domain Contract

- Prioritize reader success over personal style preference.
- Preserve context required for safe and correct use; brevity is not the only goal.
- Tie findings to reader friction, failed action, risk, inaccuracy, or maintenance cost.
- Keep the main path ahead of secondary detail.
- Review in source order when that helps the user apply findings.
- For multi-file reviews, group findings by file in a stable order.
- Report no more than five highest-value findings by default; expand only when the user requests comprehensive coverage or Audit scope requires it.
- Do not claim medical or accessibility guarantees.

Use shared structure proportionally. Do not force every domain prompt, label, or section into the output.

## Whole-Document and Writing-Quality Pass

Scale this pass to the document, requested focus, and assessment mode:

1. Confirm the document purpose, documentation mode, intended reader, and reader goal.
2. Map each section's responsibility and the reader's path through the document.
3. Check progression, transitions, duplication, misplaced detail, mixed purposes, audience boundaries, and navigation.
4. Assess terminology, complexity, density, abstraction, repetition, and tone where they affect reader success.
5. Convert only material reader impact into findings.

Use this whole-document view before local prose critique when structure can change the interpretation of individual passages.

## Reader-Friction Prompts

Use these as prompts, not mandatory finding categories.

### Entry Path

Check whether the first useful action or shortest safe success path is easy to find. Look for background before action, unclear defaults, competing setup paths, and prerequisites introduced after use.

### Re-entry and Navigation

Check whether a returning reader can locate a task and resume work. Look for vague headings, missing or excessive navigation, buried paths and defaults, and section names that do not match reader tasks.

### Chunking and Visual Density

Check whether information is grouped into meaningful units. Look for paragraphs with several decisions, unrelated examples in one code block, unnecessarily dense tables, ungrouped lists, and headings that fragment a short document.

Do not flag length by itself. Explain the scanning, comprehension, or working-context cost.

### Action and Outcome Clarity

Check whether readers can distinguish what to do from what will happen. Look for commands without purpose, missing output or validation signals, hidden side effects, unclear placeholders, and examples whose return or effect is ambiguous.

### Priority and Distraction Control

Check whether common use appears before edge cases and whether secondary links, background, repeated explanations, or equally emphasized examples compete with the main path.

Keep necessary advanced detail, but recommend moving it after the main path when appropriate.

## Documentation Finding Judgment

Apply shared finding layout with documentation-specific priorities:

- `🔴 High`: likely to block reader success, cause unsafe action, or make the documentation misleading.
- `🟡 Medium`: likely to confuse readers, slow them down, or leave an important gap.
- `🟢 Low`: polish, consistency, minor readability, or low-risk maintenance improvement.

Use status for non-problem notes when useful:

- `✅ Accepted`: intentional, resolved, or no change needed.
- `⛔ Declined`: rejected or overridden by the user; do not repeat without new evidence.

Add only domain fields that make a finding clearer:

- `What`: observed documentation problem.
- `Where`: path, heading, table, example, or workflow when location is not obvious.
- `Evidence`: source, implementation behavior, project rule, or inspected content when support matters.
- `Condition`: audience, version, platform, or workflow limit.
- `Reader impact`: likely failure, risk, confusion, delay, or maintenance cost.
- `Direction`: focused improvement without rewriting by default.
- `Example`: small replacement or output sample when it makes the direction reviewable.

Do not repeat the same rationale under multiple labels. Keep accepted findings concise and do not duplicate them under Good Decisions.

## Documentation Audit Additions

Before assessment, establish:

- documentation mode;
- intended reader and reader goal;
- reviewed targets and coverage;
- focus and source material;
- exclusions and uninspected areas;
- evidence method and confidence; and
- relevant renderer, environment, version, or workflow assumptions.

Use [review-persistence.md](review-persistence.md) for metadata encoding, saved-artifact lifecycle, and destination behavior. This reference owns the meaning of documentation outcomes.

Use one domain assessment outcome when the project or tracked workflow requires it:

| Outcome              | Metadata value         | Meaning                                                              |
| -------------------- | ---------------------- | -------------------------------------------------------------------- |
| No change            | `no-change`            | The reviewed scope needs no material revision.                       |
| Revision recommended | `revision-recommended` | One or more findings justify documentation changes.                  |
| Blocked on evidence  | `blocked-on-evidence`  | Required source, authority, or environment evidence is unavailable.  |
| Defer                | `defer`                | A named dependency or decision should be resolved before proceeding. |

These values record assessment state, not implementation approval. For an informational Audit, do not manufacture an action-oriented next step. When a concluding domain outcome is useful, keep final state, concise reason, authority boundary, and next action in one location rather than duplicating them in the summary.

A Documentation Audit remains assessment only. It cannot approve a proposal, annotation, source-document edit, migration, or implementation.

## Follow-Up Assessment

When earlier assessment history matters:

1. Read the prior artifact when continuity is requested or required.
2. Verify resolved findings instead of presenting them as new problems.
3. Keep accepted decisions only when they prevent repeated recommendations.
4. Do not repeat declined findings without new evidence.
5. Label newly discovered issues as new findings.
6. Number findings within the current assessment unless the active lifecycle requires continuity.

Do not silently change a previous finding's status. The user or active workflow confirms whether it is accepted, declined, or resolved.

## Good Decisions

Name specific decisions, explain their reader benefit, and state what should be preserved when useful. Avoid generic praise.
