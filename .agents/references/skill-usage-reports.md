<h1>Skill Usage Reports</h1>

Use this reference for persistent reports about reusable agent, skill, setup, or workflow issues and improvements.

## Quick Workflow

1. Check matching reports.
2. Ask before amending an `open` report.
3. Confirm persistence for a new report.
4. Resolve scope and path.
5. Draft or amend from the matching template.
6. Validate privacy, fields, path, and links.
7. Set or update status.
8. Perform follow-up work separately.

Report creation, proposal, implementation, commit, and push are separate effects.

## When to Use a Report

Create or amend a report only when the user asks for one or confirms persistence. Do not assume that “report” means a persistent skill usage report when chat output, a review, research, a task status, a summary, or another artifact is plausible.

Suggest a report when feedback is:

1. about reusable agent, skill, setup, or workflow behavior;
2. substantial enough to defer, hand off, or add to later work; and
3. outside the user's accepted active-task scope.

Do not prompt for routine current-artifact corrections, minor preferences, illustrative examples, or requirements already accepted inside the active task scope. A task note or step log may preserve progress, but it does not replace a confirmed report.

## Matching Reports

Check the applicable report location before writing:

- If a matching report has `status: open`, ask whether to amend it.
- Amend an `open` report only after confirmation.
- Never amend or reopen a `planned`, `implemented`, `declined`, or `obsolete` report.
- After persistence is confirmed, create a new numbered report when no matching report is `open`.

Preserve the user's wording when short and useful. Summarize long, sensitive, or mixed input. Separate user statements from agent interpretation, and do not promote examples or historical context into active issues without confirmation.

## Scope and Location

Use this precedence:

1. Explicit user destination or stronger project-local report convention.
2. Global report: `~/.agents/skill-usage-reports/<skill-name>/<report>`.
3. Local report: `<project>/skill-usage-reports/<skill-name>/<report>`.
4. If project root, scope, tracking, or privacy is unclear, ask before writing.

Use a global report for a global skill, global agent subject, or reusable global setup behavior. Use a local report for project-local skills, setup, or workflow behavior. Project-local instructions own local storage, privacy, tracking, metadata extensions, template overrides, and validation rules.

Do not silently create a different persistent location when an expected project location is unavailable. Ask where to save the report or return it inline.

## Storage and Naming

Use this global shape:

```text
~/.agents/skill-usage-reports/
├── <skill-name>/
│   └── report-<yyyymmdd>-<skill-name>-<number>.md
└── templates/
    ├── skill-usage-report-issue-template.md
    └── skill-usage-report-improvement-template.md
```

Use the same report shape under `<project>/skill-usage-reports/` for local reports.

Filename rules:

- Use the creation date as eight digits: `yyyymmdd`.
- Use the skill directory name or approved agent subject in lowercase kebab-case.
- Use the smallest unused two-digit number for the same subject and date, starting at `01`.
- Keep the filename stable when status changes.

Example:

```text
report-20260831-skill-creator-01.md
```

Do not modify `.gitignore` automatically. Explain the current tracking effect when creating the first report in a Git-backed location, then follow the user's choice or project-local policy.

Do not suggest or prompt for archive or deletion operations. Handle either operation only after an explicit user request and under applicable project-local approval, safety, and link-inspection rules.

## Metadata

Keep the first seven fields. Omit optional fields when they add no value.

```yaml
---
type: skill-usage-report
status: open # open | planned | implemented | declined | obsolete
created: YYYY-MM-DD
updated: YYYY-MM-DD
report_kind: issue # issue | improvement
report_scope: global # global | local
skill_name: <skill-or-agent-name>
# Optional fields below; omit when empty or irrelevant.
project: <project-name>
skill_path: <path>
trigger: <short reason>
occurrence_count: 1
---
```

Keep details, quotations, evidence, impact, desired behavior, and trade-offs in the body rather than expanding metadata by default. Do not require report backlinks to proposals, decisions, commits, or tasks. Downstream artifacts may cite reports when useful.

## Statuses

- `open`: Captured and awaiting a decision.
- `planned`: Accepted for separate follow-up work.
- `implemented`: Addressed by a completed change.
- `declined`: Considered and intentionally not pursued.
- `obsolete`: No longer applies because context or behavior changed.

`implemented`, `declined`, and `obsolete` are terminal. All statuses except `open` are protected from amendment and reopening under the default workflow. When a non-open issue recurs, create a new numbered report after persistence is confirmed.

A report status does not authorize a proposal, implementation, commit, push, move, archive, or deletion.

## Template Selection

Use the [issue template](../skill-usage-reports/templates/skill-usage-report-issue-template.md) for observed problems, failures, omissions, or recurring friction.

Use the [improvement template](../skill-usage-reports/templates/skill-usage-report-improvement-template.md) for reusable enhancements, workflow refinements, or capability ideas without a demonstrated failure.

Global and local reports use the same intent templates. Change metadata and path routing for scope; do not duplicate the full template family.

Omit optional body sections when empty. Do not add mandatory Traceability, Resolution, or Next Action sections. Keep reports focused:

- lead with the issue or improvement;
- keep paragraphs focused and steps numbered;
- suppress tangents and make completed work visible; and
- keep lists bounded or split immediate and later work.

These prose rules adapt useful attention-friendly writing practices. They do not claim medical treatment, ADHD suitability, accessibility conformance, or guaranteed reader outcomes.

## Compatibility

Apply this contract prospectively. Existing report paths, schemas, metadata, statuses, links, and history remain valid. Do not migrate, flatten, rename, move, archive, delete, or rewrite existing reports without separate explicit approval.

A stronger project-local reporting contract may use different Markdown metadata or a machine-only JSON schema. Keep Markdown as the global default.

## Validation

After creating or amending a report:

- re-read the changed report;
- confirm persistence or amendment approval;
- confirm the path, date, subject, number, scope, kind, and status;
- confirm required metadata is present and optional metadata is useful;
- confirm user wording is separated from interpretation;
- confirm examples and historical context are not presented as active issues without approval;
- confirm no secrets, credentials, unrelated personal information, or exposed absolute home paths;
- confirm links resolve when links are present;
- check Markdown formatting, trailing whitespace, conflict markers, and unresolved editorial markers;
- confirm no unrelated report, archive, tracking, or project file changed; and
- use direct inspection when Git validation does not apply.

State any formatter, renderer, link, or Git validation that was unavailable. Manual checks do not equal formatter or renderer verification.
