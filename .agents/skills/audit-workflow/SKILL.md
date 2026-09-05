---
name: audit-workflow
description: Use when designing, reviewing, or providing reusable Review, Audit, or proposal workflows, formats, templates, and lifecycle rules for domain skills or project workflows. Provides shared artifact mechanics while domain skills keep domain-specific evidence, judgment, and implementation authority.
---

# Audit Workflow

Use this skill for shared artifact workflow mechanics around Reviews, formal Audits, and proposals.

The skill owns structure, lifecycle boundaries, and template use. It does not own domain evidence, domain judgment, cross-skill migration, implementation, repository approval, commits, pushes, or decision-record workflow.

## Reference Files

Read the relevant reference before producing, reviewing, or providing artifacts:

| Reference                                          | Read when                                                                                         |
| -------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| [references/review.md](references/review.md)       | Creating, reviewing, saving, or providing conversational Review guidance, format, or templates.   |
| [references/audit.md](references/audit.md)         | Creating, reviewing, saving, or providing formal Audit guidance, format, or templates.            |
| [references/proposals.md](references/proposals.md) | Creating, reviewing, saving, or providing proposal guidance, exact-scope contracts, or templates. |

Use assets as adaptable output patterns, not mandatory forms:

| Asset                                                                        | Use                                                                    |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| [assets/artifact-audit-template.md](assets/artifact-audit-template.md)       | Starting a formal saved Audit when no stronger domain template exists. |
| [assets/artifact-proposal-template.md](assets/artifact-proposal-template.md) | Starting a saved proposal when no stronger domain template exists.     |

Use `tech-docs-writer` when drafting or editing human-facing documentation content in a Review, Audit, or proposal. Use the global Markdown formatter directly for formatting-only work. Audit Workflow continues to own artifact mechanics and does not authorize implementation.

## When to Use

Use this skill when the user asks to:

- design or update reusable Review, Audit, or proposal workflows;
- create or review formal artifact structures, shared templates, lifecycle states, or section ownership rules;
- provide Review, Audit, or proposal structures for another skill or project workflow; or
- check a Review, Audit, or proposal artifact for structure, lifecycle, and approval-boundary clarity.

Do not use this skill for ordinary domain review. Use the domain skill first when the request is about code quality, documentation quality, research evidence, skill architecture, task planning, or repository maintenance.

## Boundaries

Keep these responsibilities outside this skill:

- **Domain judgment:** The active domain skill supplies evidence standards, finding criteria, risk model, and recommendations.
- **Skill design:** Use `skill-creator` for creating, auditing, or changing skills.
- **Repository operations:** Use `agents-maintainer` for global agent-resource approval, path safety, validation, commits, and pushes.
- **Task state:** Use `task-manager` for persistent task planning and status.
- **Decision records:** Use the decision-record owner when available. This skill may show where a decision-record action belongs in a proposal, but it does not decide or manage ADR status.
- **Implementation:** A Review, Audit, or proposal does not authorize edits. Implementation needs separate approval under the responsible workflow.

## Operating Modes

### Review Support

Use Review for informal critique, user feedback on an Audit or proposal, and lightweight triage. Keep it conversational by default. Read [references/review.md](references/review.md) for substantial Review output.

### Audit Support

Use Audit for formal bounded assessment with explicit scope, evidence, limitations, findings, and judgment. Save an Audit only when the user or active workflow requires persistence. Read [references/audit.md](references/audit.md) before producing or revising a formal Audit.

### Proposal Support

Use proposal support for exact-scope approval contracts. A proposal requests a decision; it does not approve itself or prove implementation. Read [references/proposals.md](references/proposals.md) before producing or revising a proposal.

## Workflow

1. Identify whether the request concerns Review, Audit, proposal, or validation mechanics.
2. Identify the active domain skill or workflow that owns evidence and implementation.
3. Read the relevant reference and any domain artifact being reviewed.
4. Apply the smallest structure that makes the artifact reviewable and resumable.
5. Keep metadata and prose from duplicating each other.
6. Preserve project-local storage, naming, lifecycle, approval, and validation rules.
7. For saved artifacts, validate frontmatter, links, headings, TOC markers when present, lifecycle state, and exact scope.
8. Report what was changed, what was validated, and what was not tested.

## Default Response Shape

Use only the parts that help:

1. Current state or recommendation.
2. Findings, proposed structure, or exact scope.
3. Boundaries and trade-offs.
4. Validation or next step.

Do not force formal sections onto a small conversational Review.

## Validation

For artifact-workflow changes, confirm:

- Review, Audit, proposal, approval, implementation, and validation remain distinct.
- Domain skills keep domain evidence and judgment.
- Project-local conventions override shared defaults.
- Template sections are optional unless the active workflow makes them mandatory.
- Frontmatter does not duplicate easy-to-read prose.
- Links and TOC entries resolve in the target context.
- File-change lists are complete when an artifact requests approval.
- Runtime discovery is reported as untested unless a fresh skill scan or session verified it.
