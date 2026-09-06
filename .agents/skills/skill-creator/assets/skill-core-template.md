# Skill Core Template

Use this template when creating or substantially restructuring a `SKILL.md` core. Adapt it to the target; do not migrate existing skills merely to match these headings.

## Authoring Notes

Read [Skill Design](../references/skill-design.md) for evidence, frontmatter, routing, and placement rules, and [Skill Validation](../references/skill-validation.md) for authoring checks. Use concrete tasks, corrections, artifacts, or traces when available rather than inventing domain behavior. These notes guide the author; do not copy them into the generated skill.

Replace every angle-bracket placeholder. Omit optional sections that add no behavior, but retain always-needed safety, authority, material handoffs, and domain validation in the core even when headings are merged. Keep the core under 500 lines by default. Generated skills must not need Skill Creator's references to operate safely.

Add compatibility metadata only for real supported requirements; keep its value within 1–500 characters. Preserve explicit-only metadata when required. Domain-specific gotchas, use-case tables, response guidance, scripts, and additional modes are optional, not mandatory sections.

Keep authoring-only frontmatter and discovery checklists outside generated runtime instructions unless skill authoring or discovery is the target's own domain. Preserve evidence requirements and output checks that the target needs during normal use.

## Template

```markdown
---
name: <skill-name>
description: Use when <specific activation context>. <Recurring capability>.
---

# <Skill Title>

<Purpose, intended requests, and negative boundary.>

## References

<Optional: relative links with specific loading conditions.>

## Scripts and Modes

<Optional: bounded script effects, prerequisites, modes, and material handoffs.>

## Approval and Safety

<Always-needed domain safeguards and protected state. Follow active authority;
explain material effects and obtain required exact-scope approval before acting.
Stop on material scope change.>

## Workflow

1. <Inspect inputs and establish the task boundary.>
2. <Apply the domain method only within authorized scope.>
3. <Validate the result; stop or hand off when evidence is insufficient.>

## Validation

- <Domain output check and observable success criterion.>
- Confirm only authorized files or state changed.
- Report failed or unavailable checks; do not claim untested behavior passed.
```
