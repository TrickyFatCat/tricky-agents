# Skill Proposal Artifact Name Order

Status: Accepted
Date: 2026-08-29
Amends: [Skill Creator Template Foundation](0008-skill-creator-template-foundation.md)

## Context

Decision `0008` established role + subject + action for saved proposal artifact names. The user changed the active Skill Creator guidance to put the action before the subject. Inspection found that the proposal template, examples, and accepted decision still recorded the old order.

## Decision

Use role + action + subject for saved proposal artifact names:

```text
<artifact-role>-<concise-action>-<concise-subject>
```

Keep the role word once and first. Follow the active project's filename style.

Examples:

- `proposal-add-readable-output-examples.md`
- `Proposal Define Artifact Naming.md`

Apply this order to new proposal artifacts. Preserve existing historical proposal filenames and links.

## Reasons

- Putting the action immediately after the role makes the artifact's requested operation visible earlier.
- One active order prevents examples and templates from routing agents differently.
- Preserving historical filenames avoids unnecessary migration and broken links.

## Consequences

- Skill Creator guidance and its proposal template use role + action + subject.
- The proposal naming detail in decision `0008` is amended; its other template-foundation decisions remain accepted.
- Existing proposal artifacts retain their current names.

## Alternatives

- Keep role + subject + action. Rejected because the user prefers action-first proposal names.
- Rename historical proposals. Rejected because the migration cost and link risk provide no matching benefit.

## Related Changes

- `.agents/skills/skill-creator/references/skill-design.md`
- `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- [Decision 0008](0008-skill-creator-template-foundation.md)
