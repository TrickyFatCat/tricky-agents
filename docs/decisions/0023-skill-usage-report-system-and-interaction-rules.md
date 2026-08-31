# Skill Usage Report System and Interaction Rules

Status: Accepted
Date: 2026-08-31
Amends:

- [Skill Assessment and Usage Report Guidance](0017-skill-assessment-and-usage-report-guidance.md)

Related:

- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)
- [Global Artifact Naming and Path Presentation](0009-global-artifact-naming-and-path-presentation.md)

## Context

The global report workflow depended on a project-linked Obsidian vault, a 20-field metadata example, an eight-section issue body, and a broad lifecycle. That contract preserved evidence but was expensive for routine agent use and unavailable in projects without the linked vault.

Repeated interactions also exposed two always-loaded gaps: reusable workflow feedback could miss report routing, and presented choice menus could omit free-form user input. The accepted Audit and proposal selected a prospective global/local report system, two intent templates, concise states, and bounded interaction rules.

## Decision

Use these default report locations when no explicit destination or stronger project-local convention applies:

- global: `~/.agents/skill-usage-reports/<skill-name>/<report>`;
- local: `<project>/skill-usage-reports/<skill-name>/<report>`.

Name reports `report-<yyyymmdd>-<skill-name>-<number>.md`. Allocate the smallest unused two-digit number for the same subject and date, starting at `01`, and keep the filename stable across status changes.

Use two Markdown intent templates:

- issue reports for observed problems, failures, omissions, or recurring friction;
- improvement reports for reusable enhancements without a demonstrated failure.

Use the same templates for global and local scope. Scope changes metadata and path routing, not the complete body shape.

Require these metadata fields: `type`, `status`, `created`, `updated`, `report_kind`, `report_scope`, and `skill_name`. Allow `project`, `skill_path`, `trigger`, and `occurrence_count` when useful.

Use five statuses:

- `open`;
- `planned`;
- `implemented`;
- `declined`; and
- `obsolete`.

Only `open` reports are eligible for confirmed amendment. Never amend or reopen a `planned`, `implemented`, `declined`, or `obsolete` report. After persistence is confirmed, create a new numbered report when no matching report is `open`.

Keep report persistence user-controlled. Report creation, proposal, implementation, commit, and push remain separate effects. Task notes and step logs do not substitute for a confirmed report.

When presenting a choice menu, include a visible `Custom prompt` option without requiring a specific harness or menu tool.

Use concise, attention-friendly prose: lead with the issue or improvement, keep paragraphs focused, number real sequences, suppress tangents, make completed work visible, and bound or split long lists. These rules adapt relevant `i-have-adhd` principles without creating a runtime dependency or making medical, accessibility, or outcome guarantees.

## Boundaries

Project-local instructions control local storage, tracking, privacy, metadata extensions, template overrides, and validation. A project may define JSON for machine-only reporting, but Markdown remains the global default.

Do not change `.gitignore` automatically. Explain current tracking behavior and follow user or project-local policy.

Do not suggest or prompt for archive or deletion. Handle either only after an explicit user request and under applicable local approval and safety rules.

Do not require report backlinks to proposals, decisions, commits, or tasks. Downstream artifacts may cite reports when useful.

Apply this decision prospectively. Existing report paths, schemas, metadata, statuses, links, active or archive contents, and history remain valid. Migration, rewriting, flattening, moving, renaming, archiving, and deletion require separate approval.

This decision does not add Agents Maintainer formal Audit, Assessment, or formatter-fallback capabilities and does not change any skill core.

## Reasons

- Short global and local paths remove the linked-vault dependency.
- Two intent templates preserve useful prompting without duplicating scope variants.
- Concise metadata and bodies reduce agent maintenance cost.
- Confirmed open-report amendment prevents silent changes while new numbering protects non-open history.
- Project-local precedence preserves privacy, tracking, and machine-report requirements.
- A visible custom response keeps choice menus bounded without trapping user input.

## Consequences

- **Benefits:** Reports are portable, easier to draft, and easier to resume.
- **Costs:** New reports carry less reverse traceability by default.
- **Risks:** Similar reports may coexist when prior reports are non-open; stable numbering and matching checks make that behavior explicit.
- **Compatibility:** Historical reports and linked-vault contracts remain valid without migration.
- **Tracking:** Git policy remains an explicit user or project choice; tracked templates and ignored report instances may coexist.
- **Interaction:** Always-loaded guidance grows slightly to preserve report-routing and free-form choice behavior.

## Alternatives

- Keep the linked-vault-first default — rejected because it is project-specific.
- Use one universal template — rejected because issue and improvement prompts differ.
- Use four scope-and-intent templates — rejected because scope does not justify body duplication.
- Use JSON globally — rejected because reports need human prose and review.
- Define a global archive or deletion workflow — rejected because those operations are optional and locally governed.
- Migrate existing reports — rejected because migration and link repair need separate assessment and approval.
- Require `i-have-adhd` activation — rejected because report quality must not depend on a session mode.

## Traceability

- Source: approved `Audit Global Interaction and Workflow Report Routing` in the external task vault.
- Proposal: approved `Proposal Refine Skill Usage Report System and Global Interaction Rules` in the external task vault.
- Amends: [Decision 0017](0017-skill-assessment-and-usage-report-guidance.md).
- Separate prerequisite: commit `52ce6b416c43d70e5f026702345c2187e88ebeb3` ignores report instances while preserving tracked templates.

## Related Changes

- `.agents/AGENTS.md`
- `.agents/references/skill-usage-reports.md`
- `.agents/skill-usage-reports/templates/skill-usage-report-issue-template.md`
- `.agents/skill-usage-reports/templates/skill-usage-report-improvement-template.md`
- `docs/decisions/0017-skill-assessment-and-usage-report-guidance.md`
