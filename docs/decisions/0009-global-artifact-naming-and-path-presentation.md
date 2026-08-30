# Global Artifact Naming and Path Presentation

Status: Accepted
Date: 2026-08-28
Amended By: [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)

## Context

Two user reports identified recurring global setup problems:

- generated artifacts can receive generic filenames such as `README.md` even when they are not directory overviews;
- human-facing reports and notes can expose full home-directory paths when `~/...` would be sufficient.

The existing global approval gate already required exact paths before agent setup changes. That exposed file locations, but it did not require the agent to explain each artifact's role, naming rule, or reserved-name exception. Existing safety guidance also protected credentials and sensitive data, but did not provide a clear presentation rule for home-directory paths in chat and persistent text artifacts.

## Decision

Add a global artifact contract:

- proposals for created, moved, renamed, or reorganized global agent artifacts include exact paths, artifact roles, naming rules, and reserved-name exceptions;
- semantic filenames should describe the artifact subject and type;
- `README.md` is reserved for real directory, package, or collection overviews unless an external format requires it and the exception is explicitly approved;
- human-facing chat, Markdown, reports, reviews, notes, summaries, and examples render paths inside the current user's home directory as `~/...`;
- full resolved home paths remain available when needed for safety evidence, debugging, incident scope, repository-boundary validation, symlink-target validation, containment, or machine-consumed values.

Update `agents-maintainer` so the same contract is enforced during global repository maintenance while preserving explicit-only invocation.

## Reasons

- Filename semantics are part of the user's reviewable artifact contract, not an incidental implementation detail.
- Reserving `README.md` for real overviews preserves quick-open and filename-search clarity.
- Rendering home paths as `~/...` reduces unnecessary local identity and machine-layout disclosure.
- Keeping full resolved paths available for validation avoids weakening repository-boundary and incident evidence.
- A short global rule prevents the same correction from being repeated across individual skills.

## Consequences

- Global agent setup proposals become slightly more explicit when files are created, moved, renamed, or reorganized.
- Agents must distinguish human-facing path presentation from internal path validation.
- Existing artifact-specific conventions still apply; this decision adds a default and review requirement rather than one universal filename pattern.
- Automated filename validation is not added now; filename semantics remain a human-reviewed proposal requirement.

## Alternatives

- Require only exact paths. Rejected because exact paths do not explain whether the basename accurately represents the artifact.
- Always replace full home paths blindly. Rejected because machine-consumed values and boundary evidence sometimes need exact resolved paths.
- Add a new validation script now. Rejected because the immediate need is a lightweight global rule; automation can be evaluated later if repeated misses continue.

## Related Changes

- `.agents/AGENTS.md`
- `.agents/skills/agents-maintainer/SKILL.md`
- `.agents/references/safety-inspection.md`
- `docs/decisions/0009-global-artifact-naming-and-path-presentation.md`

## Related Reports

- `linked-vaults/reports-vault/skill-usage/reports/global/skill-creator/2026/2026-08-27-193932-artifact-filename-semantics.md`
- `linked-vaults/reports-vault/skill-usage/reports/global/researcher/2026/2026-08-27-071633-home-path-redaction-in-text-artifacts.md`
