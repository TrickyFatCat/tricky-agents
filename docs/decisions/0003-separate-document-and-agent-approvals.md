# Separate Document and Agent Approvals

Status: Accepted
Date: 2026-08-26

## Context

A documentation review can reveal both changes to the reviewed document and improvements to global agent skills. Combining both artifact types in one change list made a short approval response ambiguous about whether it covered the document, the global resources, or both.

Global agent resources also require exact-file approval before modification.

## Decision

When a documentation review also identifies workflow or skill improvements:

- Separate document changes from workflow or skill follow-ups in the response.
- Use separate approval scopes for the document and global agent resources.
- Name every exact global file to create, modify, move, or delete before editing.
- Do not treat approval for the reviewed document as approval for global skill changes, or the reverse.

## Reasons

Separate scopes make user intent explicit and preserve the stronger approval boundary for global resources. They also make later validation and commits easier to limit to the intended repository and files.

## Consequences

- Cross-artifact work may require an additional approval step.
- The user can accept document changes without changing global behavior.
- Global skill proposals remain reviewable before implementation.
- The workflow is slightly longer but reduces accidental scope expansion.

## Alternatives

- Use one combined approval for all findings. Rejected because short responses such as `Approve` do not identify which artifact types are authorized.
- Avoid proposing workflow improvements during document reviews. Rejected because review sessions can reveal reusable process problems worth preserving separately.

## Related Changes

- Commit `60cef41` — separated document and global skill approval scopes in the documentation reviewer workflow.
- `.agents/skills/tech-docs-reviewer/SKILL.md`
