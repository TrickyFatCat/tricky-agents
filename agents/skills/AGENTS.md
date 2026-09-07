# Skill Development Instructions

## Scope

These instructions apply to skills and supporting files under `agents/skills/`.

Follow the repository root `AGENTS.md` and the repository-root `docs/controlled-workflow.md` for change control, worktrees, approval, integration, and Git safety.

## Skill Authoring

Treat skills as behavioral configuration.

Prioritize:

- correct behavior and decision boundaries;
- clear triggering and applicability;
- explicit scope and responsibilities;
- interaction with repository and other skill instructions;
- dependencies, references, and required context;
- safety and destructive-operation boundaries;
- consistent terminology and sources of truth.

Prefer the smallest change that resolves the identified problem.

Do not silently broaden a skill's responsibilities, triggering, precedence, or behavioral scope.

## Existing Skills

Preserve established behavior unless the approved work requires changing it.

Treat changes to behavior, scope, triggering, responsibilities, precedence, safety, dependencies, outputs, or interpretation as meaningful.

## New Skills

Surface consequential design decisions instead of silently choosing them.

Before final approval, ensure the skill is understandable without relying on hidden conversation context.

## References and Supporting Files

Keep reusable supporting knowledge in references rather than duplicating it into the skill when practical.

Do not hide consequential behavioral requirements exclusively in references where they may be missed.

When changing a skill, check whether related references, templates, examples, or other skills become stale or contradictory.

Treat examples as illustrations or tests of a rule unless the project explicitly defines them as normative.

## Cross-Skill Changes

A skill change may include related changes to another skill when they belong to the same coherent unit of work.

Before modifying another skill, follow the cross-branch dependency rules in `docs/controlled-workflow.md`.

Do not duplicate the same behavioral decision independently across active skill branches.

## Validation

Before presenting meaningful skill work for approval, check as applicable:

- purpose and scope remain clear;
- triggering and non-triggering conditions are coherent;
- decision boundaries and exceptions are explicit;
- references and dependencies are available and consistent;
- related skills do not define conflicting behavior;
- examples agree with governing rules;
- required context is not hidden outside the artifact;
- unnecessary duplication has not introduced competing sources of truth.

Use the repository's authoring/review skill when applicable for deeper review.
