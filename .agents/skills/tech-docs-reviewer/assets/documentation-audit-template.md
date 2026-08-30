# Documentation Audit Template

Use this asset for a formal, bounded, always-saved Documentation Audit. Apply project-local metadata, storage, renderer, naming, formatter, and validation rules first. Omit optional or empty fields and sections.

Do not copy Skill Creator-specific proposal, decision-record, or implementation sections into a documentation Audit.

## Copyable Template

```markdown
---
type: documentation-assessment
mode: audit
status: complete
created: YYYY-MM-DD
target:
  - path/to/document.md
focus: <optional focus>
outcome: no-change | revision-recommended | blocked-on-evidence | defer
---

# Documentation Audit: <Subject>

## Audit Summary

Use no more than five short bullets:

- Outcome: <domain outcome>.
- Findings: <count and priority distribution>.
- Main concern: Finding <number> — <reader impact>.
- Preserve: <important behavior or decision>.
- Next action: <one focused action or decision>.

## Scope and Evidence

- Documentation mode: <tutorial, how-to, reference, explanation, troubleshooting, maintainer, README, or personal documentation>.
- Intended reader: <reader>.
- Reader goal: <goal>.
- Reviewed targets:
    - `path/to/document.md`
- Sources and criteria:
    - <source, implementation evidence, project requirement, or review criterion>.
- Exclusions:
    - <area not reviewed>.
- Evidence confidence: <confirmed, partial, or conditional, with reason when useful>.

For a documentation directory or set, list every reviewed file and excluded area. Do not imply complete coverage of uninspected content.

## Findings

For three or more findings, add an optional linked list inside this section:

- [1. Descriptive finding title](#1-descriptive-finding-title) — 🔴 High

### 1. Descriptive finding title

Priority: 🔴 High

**What**

Describe the observed issue.

**Where**

Name the path, heading, table, example, or workflow.

**Evidence**

Cite the source, implementation behavior, project rule, or inspected document content.

**Reader impact**

Explain the likely failure, risk, confusion, unnecessary work, or maintenance cost.

**Direction**

Give a focused direction without rewriting the documentation by default.

**Example**

Add a small example only when it makes the evidence or direction reviewable.

Repeat findings in source order. Report the highest-value findings by default; include broader coverage only when the Audit scope requires it.

## Good Decisions

- <Specific decision, reader benefit, and behavior to preserve>.

## Questions

Include only questions whose answers can change a finding, recommendation, evidence confidence, or outcome.

## Audit Outcome

- Outcome: No change | Revision recommended | Blocked on evidence | Defer
- Reason: <concise reason supported by the findings>.
- Next action: <one focused action or decision>.

This outcome records assessment state. It does not approve a proposal, source-document edit, migration, or implementation.

## Untested Areas

- <Source, renderer, environment, version, workflow, or document area not tested>.
```

## Adaptation Rules

- Use project-local property names and values when they differ.
- Omit `focus`, `Questions`, or other optional content when empty.
- Keep Audit Summary to no more than five bullets.
- Keep linked finding navigation inside `Findings`.
- Preserve safety and correctness context; brevity is not the only goal.
- Tie findings to concrete reader friction and end with one focused next action.
- Do not claim medical or accessibility guarantees.
