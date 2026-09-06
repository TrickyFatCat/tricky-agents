# Skill Reference Template

Use this template for one optional topic loaded by a clear condition in `SKILL.md`.

## Authoring Notes

Read [Skill Design](../references/skill-design.md) while authoring; use concrete source material when available. Keep instructions needed before this reference would load in the core. These notes are not part of the generated output.

Replace placeholders, adapt to the domain, and omit irrelevant sections. Keep domain evidence rules, failure handling, and output checks that change runtime behavior. Add an exact output example only when it prevents a likely mistake. Validate the finished reference under [Skill Validation](../references/skill-validation.md), including core consistency and conditional loading.

## Template

```markdown
# <Reference Title>

Read this reference when <specific loading condition>.

## Purpose and Scope

<Inputs, responsibility, exclusions, and material handoff.>

## Method

1. <Domain step with observable outcome.>
2. <Decision, stopping, or escalation condition.>

## Output Shape

<Optional: exact output structure only when it prevents likely mistakes.>

## Validation

- <Domain-specific check and failure handling.>
- Confirm the output respects the core and active project/global instructions.
```
