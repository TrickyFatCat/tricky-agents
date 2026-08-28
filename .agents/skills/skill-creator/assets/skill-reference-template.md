# Skill Reference Template

Use this template for optional skill detail loaded by a clear condition in `SKILL.md`.

Add only what the agent would likely get wrong, miss, or waste time rediscovering without this reference.

## Template

````markdown
# <Reference Title>

Read this reference when <specific condition>.

Keep this file focused on <one topic, mode, checklist, protocol, or artifact type>.

## Purpose

<What this reference helps the agent do that does not belong in the always-loaded core.>

## Inputs and Scope

Use this reference for:

- <input/situation>.
- <input/situation>.

Do not use it for:

- <boundary or handoff>.

## Source Material

Ground this reference in concrete evidence when available:

- user corrections;
- project artifacts;
- runbooks or reports;
- review comments;
- failure cases;
- execution traces.

## Method

1. <Step with observable outcome>.
2. <Step with decision or validation point>.
3. <Step with stop or handoff condition>.

Make steps strict when the task is fragile. Give judgment room when safe alternatives exist.

## Template or Output Shape

Use this shape when the task needs it. Adapt or omit irrelevant sections.

```markdown
# <Output Title>

## <Section>

<Content guidance.>
```

## Validation

Confirm:

- <check>.
- <check>.
- The output does not contradict `SKILL.md` or active project/global instructions.
- Optional detail still belongs in this reference rather than the core.

## Notes

- Keep durable rules in `SKILL.md` when they are needed before this reference would be loaded.
- Keep examples short unless they prevent likely mistakes.
- Prefer a clear default with brief alternatives over a large menu.
````
