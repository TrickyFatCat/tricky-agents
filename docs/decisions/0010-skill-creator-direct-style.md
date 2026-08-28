# Skill Creator Direct Writing Style

Status: Accepted
Date: 2026-08-28

## Context

`skill-creator` still produced prose-heavy proposal and skill wording after the template foundation work. The user reported that skill descriptions and references need clearer instructions with less prose.

The existing `i-have-adhd` skill contains useful writing rules: action first, numbered steps, suppressed tangents, concise overviews, and no preamble. Those rules overlap with Agent Skills guidance for concise routing descriptions, context economy, and progressive disclosure.

## Decision

Incorporate selected `i-have-adhd` writing rules into `skill-creator` for skill artifacts.

Apply these rules to skill descriptions, references, reviews, and proposals:

- lead with the instruction, trigger, decision, or next action;
- use imperative verbs for required behavior;
- keep rationale only when it changes a design, approval, or validation decision;
- prefer short paragraphs, bullets, and numbered steps over explanatory prose;
- delete preambles, motivational prose, repeated rationale, and generic benefits.

Do not import full ADHD session mode, persistent activation behavior, time-estimate requirements, or personal productivity framing.

## Reasons

- Direct instructions reduce ambiguity in skill descriptions and references.
- Built-in style rules reduce the need to invoke `i-have-adhd` for every skill-writing pass.
- The selected rules match `skill-creator` responsibilities and Agent Skills-style context economy.
- Keeping only artifact-writing rules avoids turning `skill-creator` into a general chat-output style skill.

## Consequences

- Future `skill-creator` proposals and reviews should flag prose-heavy wording as a quality issue.
- Some rationale remains appropriate in proposals and decision records, but it must affect a decision or trade-off.
- `i-have-adhd` remains useful for session-wide reader support, but not required for routine skill writing checks.

## Alternatives

- Keep calling `i-have-adhd` for style checks. Rejected because users may forget and it adds repeated skill-loading overhead.
- Copy all `i-have-adhd` behavior into `skill-creator`. Rejected because session persistence, time estimates, and productivity framing do not belong in skill artifact design.
- Leave current `skill-creator` wording rules unchanged. Rejected because recent usage still required user correction for heavy prose.

## Related Changes

- `~/.agents/skills/skill-creator/SKILL.md`
- `~/.agents/skills/skill-creator/references/skill-design.md`
- `~/.agents/skills/skill-creator/references/skill-validation.md`
- `~/.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- Usage report: `linked-vaults/reports-vault/skill-usage/reports/global/skill-creator/2026/2026-08-28-203644-direct-writing-style-needed.md`
