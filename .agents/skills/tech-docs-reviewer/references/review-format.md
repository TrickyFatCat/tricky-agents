# Documentation Review and Audit Format

Read this reference before producing a substantive Quick Review, Documentation Audit, or follow-up assessment. Scale the structure down when one or two comments are already easy to scan.

## Shared Principles

- Lead with no more than three orientation bullets for three or more findings.
- Report no more than five highest-value findings unless the user requests comprehensive coverage or Audit scope requires more.
- Preserve the documentation mode and context required for safe, correct use; brevity is not the only goal.
- Tie each finding to concrete reader friction, failed action, risk, inaccuracy, or maintenance cost.
- Keep the main path ahead of secondary detail.
- End with one focused action or decision when a next step is useful.
- Do not claim medical or accessibility guarantees.

Avoid rigid limits on paragraph, list, heading, table, or example length. Add structure only when it improves navigation or comprehension rather than visual noise.

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

## Quick Review

### Structure

Use only the sections that help:

1. `Overview`.
2. `Findings`.
3. `Good Decisions`.
4. `Questions`, only when answers change the assessment.
5. `Next Step` or `Decision Check`.

For three or more findings, keep `Overview` to no more than three bullets:

- finding count and priority distribution when useful;
- highest-priority reader concern, referencing its number;
- first recommended action.

For one or two simple findings, use one orientation sentence or omit the Overview when it would duplicate the findings.

Use one `Findings` parent section. For three or more findings, optionally start it with a linked list for navigation, followed by detailed findings. Do not create adjacent `Findings Overview` and `Findings` sections.

Example:

```markdown
## Overview

- 3 findings: 1 high, 2 medium.
- Main concern: Finding 1 blocks first use.
- First action: Add expected output.

## Findings

- [1. Quick Start lacks expected output](#1-quick-start-lacks-expected-output) — 🔴 High

### 1. Quick Start lacks expected output

Priority: 🔴 High

**What**

The first command has no success signal.

**Reader impact**

The reader cannot tell whether setup worked.

**Direction**

Add one representative output block.

## Good Decisions

- The validation command is safe and easy to find.

## Next Step

Add expected output under Quick Start.
```

Follow the source from top to bottom when that helps the user apply findings. For multi-file reviews, group findings by file in a stable order. Keep priority visible without reordering findings by priority.

### Finding Priority

Use `Priority` for problems or improvement opportunities:

- `🔴 High`: likely to block reader success, cause unsafe action, or make the documentation misleading.
- `🟡 Medium`: likely to confuse readers, slow them down, or leave an important gap.
- `🟢 Low`: polish, consistency, minor readability, or low-risk maintenance improvement.

Use `Status` for non-problem notes:

- `✅ Accepted`: intentional, resolved, or no change needed.
- `⛔ Declined`: rejected or overridden by the user; do not repeat without new evidence.

A high-priority finding may appear late because document order and impact are separate concerns.

### Finding Format

Use a numbered, descriptive heading:

```markdown
### 1. Section or finding title

Priority: 🟡 Medium

**What**

Describe the issue.

**Reader impact**

Explain the likely confusion, failure, risk, or unnecessary work.

**Direction**

Give a focused direction without rewriting the document by default.
```

Keep findings short. Omit labels that do not help a simple finding.

Add these labels only when needed:

- `**Where**`: location is not obvious from the title.
- `**Evidence**`: a source file, help output, authoritative reference, or observed behavior supports the finding.
- `**Condition**`: the problem applies only to a particular audience, version, platform, or workflow.
- `**Example**`: a small replacement or output sample makes the direction reviewable.

Do not repeat the same rationale under both `Reader impact` and another label.

### Accepted and Declined Notes

Keep them concise:

```markdown
### 2. Compact reference structure

Status: ✅ Accepted

This fits the requested command-reference mode. No change needed.
```

Do not duplicate an accepted finding under `Good Decisions`.

## Documentation Audit

Use [../assets/documentation-audit-template.md](../assets/documentation-audit-template.md) for a formal Audit.

Before assessment:

- resolve the persistent destination;
- define target paths and reviewed files;
- name the documentation mode, intended reader, and reader goal;
- define focus, sources, and exclusions;
- state how evidence was gathered.

During assessment:

- distinguish observed facts, interpretation, and recommendations when confusion could change the outcome;
- include source evidence and confidence for accuracy findings;
- identify source areas that were not checked;
- use detailed examples when they make evidence or direction reviewable;
- preserve good decisions and behavior that should not regress;
- exceed five findings only when the approved Audit scope requires broader coverage.

### Section Ownership and Final Pass

Give each concept one primary location:

- `Audit Summary`: orientation, outcome, highest-priority reader concern, preserved behavior, and next action without detailed evidence.
- `Scope and Evidence`: documentation mode, reader, goal, targets, sources, criteria, exclusions, evidence method, and confidence.
- `Findings`: observed issue, location, evidence, reader impact, direction, and only decision-relevant examples.
- `Good Decisions`: preserved reader benefit not already recorded as an accepted finding.
- `Questions`: only unknowns whose answers can change a finding, confidence, scope, recommendation, or outcome.
- `Untested Areas`: source, renderer, environment, version, workflow, or document areas not tested.
- `Audit Outcome`: final state, concise reason, authority boundary, and next action without repeating finding rationale.

Before finalizing:

1. Remove repeated reader context, evidence, rationale, outcomes, and next actions across sections.
2. Link accepted sources or prior findings instead of restating them.
3. Omit optional sections that do not help the judgment.
4. Preserve short local context when needed for safety, correctness, reader impact, evidence confidence, scope, or authority.

Do not use line, heading, sentence, or paragraph counts as pass/fail limits.

End with one domain outcome:

| Body outcome         | Metadata value         | Use                                                                      |
| -------------------- | ---------------------- | ------------------------------------------------------------------------ |
| No change            | `no-change`            | The reviewed scope needs no material revision.                           |
| Revision recommended | `revision-recommended` | One or more findings justify documentation changes.                      |
| Blocked on evidence  | `blocked-on-evidence`  | Required source, authority, or environment evidence is unavailable.      |
| Defer                | `defer`                | A named dependency or decision should be resolved before further action. |

An Audit reports assessment state. It does not approve a proposal, source-document edit, migration, or implementation. Follow the active project workflow if accepted findings later become tracked changes.

## Good Decisions

Name specific decisions, explain their reader benefit, and state what should be preserved when useful. Avoid generic praise such as `looks good`.

## Questions

Ask only questions whose answers can change the finding, recommendation, evidence confidence, or outcome. Keep them few and decision-oriented. Do not disguise criticism as a question.

## Follow-Up Assessment

When earlier assessment history matters:

1. Read the prior artifact when continuity is requested or required by the active workflow.
2. Verify resolved findings instead of presenting them as new problems.
3. Keep accepted decisions only when they prevent repeated recommendations.
4. Do not repeat declined findings without new evidence.
5. Label newly discovered issues as new findings.
6. Number findings within the current assessment; treat each saved artifact as its own snapshot unless the active lifecycle says otherwise.

Do not silently change a previous finding's status. The user or active workflow confirms whether it is accepted, declined, or resolved.

## Next Action

End with one narrow action when implementation is ready:

```markdown
## Next Step

Add expected output under Quick Start.
```

When the user is still deciding, end with a focused prompt:

```markdown
## Decision Check

Should this remain a compact reference or become a first-time setup guide?
```

Avoid vague directions such as:

- Make this shorter.
- Add more headings.
- Simplify everything.
- Make this accessible.

Name the obstacle, reader impact, and focused direction instead.
