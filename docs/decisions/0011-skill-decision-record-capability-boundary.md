# Skill Decision Record Capability Boundary

Status: Accepted
Date: 2026-08-29

## Context

`skill-creator` already uses `references/decision-records.md` and `assets/decision-record-template.md` to assess and create repository decision records documenting skill changes.

A proposal to add generic decision types, record structures, statuses, fields, project layouts, and templates to that reference would give it a second responsibility: designing decision-record behavior that target skills provide during normal use. The user identified that combining these purposes could make the actor, output, storage, and approval workflow ambiguous.

## Decision

Separate the responsibilities inside `skill-creator`.

- Keep `references/decision-records.md` focused on repository records documenting skill changes.
- Add `references/decision-record-capability.md` for designing or reviewing a target skill that creates or manages decision records during normal use.
- Route the capability reference only when the target skill may own that behavior.
- Keep generic types, content concepts, statuses, fields, project layout, template ownership, and validation in the capability-design reference.
- Keep concrete output templates with the target skill that repeatedly produces them.
- Do not create a centralized generic output template now.
- Do not rename the existing skill-change reference or template unless later evidence shows continued routing ambiguity.

## Reasons

- Separate references make the subject and actor explicit.
- Conditional loading keeps unrelated skill work free of decision-record capability guidance.
- Target-skill template ownership supports the per-skill approach and avoids centralized output coupling.
- Keeping existing filenames stable avoids an unnecessary migration.
- A design reference gives future target-skill proposals a consistent minimum contract without imposing runtime behavior globally.

## Consequences

- `skill-creator` gains one focused reference and one conditional route.
- The existing decision-record workflow and template retain their current operational purpose.
- Future decision-record-capable skills require their own approved runtime instructions and templates.
- Some generic concepts may be repeated in target skills, but only where their normal behavior needs them.
- A shared global reference or centralized template can be reconsidered if real duplication later outweighs per-skill clarity.

## Alternatives

- Expand the existing reference. Rejected because it creates the dual purpose identified by the user.
- Rename the existing reference and template. Rejected for now because the migration cost exceeds the observed filename problem.
- Put all design guidance only in target skills. Rejected because `skill-creator` needs a consistent evaluation contract.
- Add a centralized generic output template. Rejected until multiple target skills demonstrate the same stable output contract.

## Related Changes

- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/decision-records.md`
- `.agents/skills/skill-creator/references/decision-record-capability.md`
