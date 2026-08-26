<h1>Skill Usage Reports</h1>

Use this reference when the user asks for a skill usage report, skill feedback report, or report about issues observed while a skill was active.

## Purpose

Skill usage reports preserve user-observed issues and improvement signals so future `skill-creator` and `agents-maintainer` work can create focused proposals and trace decisions back to the feedback that prompted them.

Create a report only when the user asks for one. Do not create reports automatically just because a skill was used or a user gave feedback.

## Report Location

Use the active project's linked reports vault when it exists:

```text
linked-vaults/reports-vault/skill-usage/
```

Treat `linked-vaults/reports-vault/` as external user data. Do not create, rename, replace, delete, or retarget the symlink unless the user explicitly asks.

If the project uses a different reports-vault path, ask before using it. Do not assume that similarly named directories, generated output directories, or unrelated vaults are valid substitutes.

## Missing Vault Workflow

If no reports vault is available in the active project, do not silently create a persistent report elsewhere.

Tell the user that the reports vault is missing and ask where to save the report. Offer practical options:

1. Provide or create a project link to a reports vault.
2. Save a one-off report under the project's normal output directory, such as `output/skill-usage-reports/`, when project instructions permit it.
3. Return the report inline only.

Follow the active project approval and storage rules for the selected option.

## Directory Structure

Use this structure inside the reports vault:

```text
skill-usage/
├── README.md                         # optional human index
├── templates/
│   └── skill-usage-report.md         # optional reusable template
├── reports/
│   ├── global/
│   │   └── <skill-name>/
│   │       └── <yyyy>/
│   │           └── <yyyy-mm-dd-hhmmss>-<report-slug>.md
│   └── local/
│       └── <project-slug>/
│           └── <skill-name>/
│               └── <yyyy>/
│                   └── <yyyy-mm-dd-hhmmss>-<report-slug>.md
└── archive/
    ├── global/
    │   └── <skill-name>/
    │       └── <yyyy>/
    │           └── <yyyy-mm-dd-hhmmss>-<report-slug>.md
    └── local/
        └── <project-slug>/
            └── <skill-name>/
                └── <yyyy>/
                    └── <yyyy-mm-dd-hhmmss>-<report-slug>.md
```

Use `global` for skills under `~/.agents/skills/`. Use `local` for project-local skills under `.agents/skills/` or another project-local skill directory.

Use lowercase kebab-case for `<skill-name>`, `<project-slug>`, and `<report-slug>`. Include the year directory to keep large report sets navigable.

Do not encode status in the active report path. Status changes belong in metadata so links remain stable.

## Report Metadata

Start each report with YAML frontmatter. Prefer this schema unless an existing reports-vault convention is more specific:

```yaml
---
type: skill-usage-report
schema_version: 1
status: open
created: <yyyy-mm-dd>
updated: <yyyy-mm-dd>
skill_name: <skill-name>
skill_scope: global # global | local
skill_path: <path-when-known>
project: <project-slug-or-null>
report_slug: <report-slug>
trigger: <why-the-report-was-requested>
user_issue_count: <number>
related_proposals: []
related_decisions: []
addressed_by: []
superseded_by: []
archived: null
archive_reason: null
---
```

Keep metadata concise and queryable. Put detailed evidence, quotations, and interpretation in the Markdown body.

## Report Body

Use this body structure for normal reports:

```markdown
# Skill Usage Report: <skill-name> — <short title>

## Context

What work was happening, why the skill was active, and why the user requested a report.

## Skill Used

- Name: `<skill-name>`
- Scope: global/local
- Path: `<path-when-known>`
- Trigger: short routing reason

## User-Pointed Issues

| Source | User wording or summary | Interpretation | Impact |
| ------ | ----------------------- | -------------- | ------ |

## Observed Skill Behavior

What the skill did well or poorly in the reported interaction.

## Improvement Candidates

- Candidate change:
- Reason:
- Affected skill/resource:
- Risk or trade-off:

## Traceability

- Related proposals:
- Related decisions:
- Related tasks:
- Related commits:

## Resolution

Current state, outcome, and follow-up notes.
```

Scale the body down for small reports, but keep `User-Pointed Issues`, `Traceability`, and `Resolution` when the report identifies an issue.

## Capturing User-Pointed Issues

Include issues the user raised in:

- Direct chat messages.
- Explicit report requests.
- Editorial comments in reviewed material, including `REVIEW`, `TODO`, and `FIXME` markers when they point to skill behavior or workflow problems.
- Follow-up corrections, complaints, preferences, or rejected assumptions.

Preserve the user's wording when it is short and useful. Summarize when the original text is long, sensitive, or mixed with unrelated content. Distinguish user-stated issues from the agent's interpretation.

Do not include secrets, credentials, or sensitive personal data unless the user explicitly asks and the active safety rules permit storing it.

## Status Lifecycle

Use these statuses:

- `open`: Report created; no triage outcome yet.
- `triaged`: Reviewed and classified, but no proposal or decision exists yet.
- `proposed`: A proposal references the report.
- `decided`: A decision record references the report.
- `implemented`: The reported issue was addressed by a committed or otherwise completed change.
- `rejected`: The issue was considered and intentionally not acted on.
- `stale`: The report may no longer apply because context, skills, or workflows changed.
- `superseded`: A newer report or decision replaces this report.
- `archived`: The report has a final outcome and has been moved to `skill-usage/archive/`.

Do not mark a report implemented, rejected, superseded, or archived without a clear reason in the `Resolution` section. Follow active project approval rules before changing persistent report state.

## Traceability Rules

Reports are input to proposals and decisions. Proposals and decisions should cite the reports that motivated them when practical.

When a proposal is created from a report, update the report metadata:

```yaml
status: proposed
related_proposals:
  - <proposal-path-or-link>
updated: <yyyy-mm-dd>
```

When a decision record is created from a report, update the report metadata:

```yaml
status: decided
related_decisions:
  - <decision-path-or-link>
updated: <yyyy-mm-dd>
```

When a change addresses the report, update:

```yaml
status: implemented
addressed_by:
  - <commit-or-change-link>
updated: <yyyy-mm-dd>
```

If only part of a report is addressed, keep the status that best describes the whole report and explain the partial outcome in `Resolution`.

## Archiving Process

Archive reports to reduce active-report noise while preserving traceability.

A report is eligible for archiving when all of these are true:

1. It has a final status: `implemented`, `rejected`, `stale`, or `superseded`.
2. The `Resolution` section explains the outcome.
3. Related proposals, decisions, commits, or replacement reports are linked when they exist.
4. The user has approved archiving, or the user explicitly requested a batch archive workflow that covers the report.

Before archiving:

1. Inspect the report and any related proposal or decision links needed to confirm the outcome.
2. Explain why the report is eligible.
3. List the exact source and destination path.
4. Wait for approval unless already covered by an explicit batch archive request.

When archiving:

1. Move the report from `skill-usage/reports/...` to the matching path under `skill-usage/archive/...`.
2. Set metadata:

   ```yaml
   status: archived
   archived: <yyyy-mm-dd>
   archive_reason: <short reason>
   updated: <yyyy-mm-dd>
   ```

3. Preserve existing `related_proposals`, `related_decisions`, `addressed_by`, and `superseded_by` links.
4. Add a final note to `Resolution` if the archive reason is not already clear.

Do not delete archived reports. Do not archive open, triaged, proposed, or decided reports merely because they are old.

## Stale and Superseded Reports

Use `stale` when the report may no longer apply but no newer report directly replaces it. Add:

```yaml
status: stale
stale_reason: <why-it-may-no-longer-apply>
reviewed: <yyyy-mm-dd>
updated: <yyyy-mm-dd>
```

Use `superseded` when a newer report, proposal, or decision replaces the report. Add:

```yaml
status: superseded
superseded_by:
  - <new-report-proposal-or-decision-link>
updated: <yyyy-mm-dd>
```

Stale and superseded reports remain traceable. They may be archived after approval when the archiving eligibility rules are met.

## Validation

After creating, updating, or archiving a report:

- Re-read the changed report.
- Confirm the path matches the skill scope, project slug, skill name, year, timestamp, and slug.
- Confirm required metadata is present and internally consistent.
- Confirm user-pointed issues are separated from agent interpretation.
- Confirm traceability links are present or explicitly absent.
- Confirm no unapproved linked-vault files changed.
- Report if Git validation is unavailable for the external vault.
