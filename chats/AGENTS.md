# Chat Configuration Development Instructions

## Scope

These instructions apply to chat, project, and similar conversational configuration under `chats/`.

Follow the repository root `AGENTS.md` and the repository-root `docs/controlled-workflow.md` for change control, worktrees, approval, integration, and Git safety.

## Chat Configuration

Treat chat configuration as behavioral configuration.

Prioritize:

- clear role and purpose;
- explicit scope and responsibilities;
- decision and clarification boundaries;
- instruction precedence;
- expected interaction style;
- environment or project assumptions;
- safety and destructive-operation boundaries;
- consistency with related configuration.

Prefer the smallest change that resolves the identified problem.

Do not silently broaden the configuration's role, authority, scope, or expected behavior.

## Existing Configurations

Preserve established behavior unless the approved work requires changing it.

Treat changes to behavior, scope, decision boundaries, precedence, safety, assumptions, compatibility, or interpretation as meaningful.

## New Configurations

Surface consequential design decisions instead of silently choosing them.

Before final approval, ensure the configuration is understandable and usable without relying on hidden conversation context.

## Related Configuration

Check related chat configuration, project instructions, references, and documentation when a change could affect shared behavior or terminology.

Prefer one authoritative location for each meaningful rule.

Do not duplicate behavioral instructions across configurations merely for convenience.

When deliberate duplication is required for independent use or reliability, keep duplicated rules consistent.

## Validation

Before presenting meaningful chat configuration work for approval, check as applicable:

- role, purpose, and scope are clear;
- decision and clarification rules are coherent;
- instruction precedence is unambiguous;
- environment assumptions are explicit where necessary;
- terminology is consistent;
- related configuration does not define conflicting behavior;
- required context is not hidden outside the artifact;
- unnecessary duplication has not created competing sources of truth.
