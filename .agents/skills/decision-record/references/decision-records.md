# Decision Records

Use this reference for durable decision-record mechanics. The user or authorized domain owner chooses the decision; this skill records and validates decision artifacts.

## Decision Boundary

A decision record preserves why a durable choice was made. It is not a task, proposal, implementation plan, or approval by itself.

Keep these states separate:

- **Exploration:** options are being discussed.
- **Recommendation:** an agent or reviewer suggests a choice.
- **Proposed decision:** a record drafts a decision for review.
- **Accepted decision:** the user, owner, or existing project history confirms the choice.
- **Implementation:** separate work applies the choice.

Do not mark an agent recommendation as accepted without user or owner confirmation.

Do not amend accepted historical decisions to change their outcome, original rationale, consequences, or decision date. Use a new record and supersession instead. Allow only non-substantive typo, formatting, or broken-link repairs and approved status or reciprocal-link updates for supersession.

## Worthiness Check

Recommend a decision record when a choice is durable or useful to future maintainers, especially when it involves:

- architecture, design, interfaces, workflows, governance, safety, security, migration, compatibility, or tooling policy;
- irreversible or costly-to-reverse consequences;
- several viable options or a rejected option likely to recur;
- cross-skill, cross-project, or shared-contract effects;
- approval, ownership, lifecycle, status, or validation rules;
- future rationale that would be hard to recover from a diff or task note.

Do not require a record for routine wording, typo, formatting, trivial cleanup, obvious low-risk maintenance, or decisions already captured clearly by a stronger project artifact.

## Record Concepts

Follow project-local templates first. When no stronger convention exists, use [../assets/decision-record-template.md](../assets/decision-record-template.md), based on MADR.

A normal record should contain:

- title;
- status;
- date;
- context and problem statement;
- decision outcome;
- reasons or decision drivers;
- considered options when more than one option mattered; and
- consequences.

Use optional concepts only when they preserve useful context:

- decision type;
- deciders or owner;
- source artifact;
- assumptions or constraints;
- related decisions;
- related changes;
- supersedes or superseded-by links;
- review date;
- links to reports, research, proposals, commits, or affected paths.

Do not keep empty optional sections.

## Statuses

Follow project-local status vocabulary first. When no stronger vocabulary exists, use:

- `Proposed`: drafted for review and not adopted.
- `Accepted`: confirmed by the user, owner, or reliable implementation history.
- `Rejected`: considered but not selected.
- `Superseded`: replaced by another record.
- `Deprecated`: no longer recommended without one direct replacement.

Use local capitalization and metadata style when a project has one. Do not migrate records solely to normalize status spelling.

## Metadata Format

Follow the project's established metadata format.

Use YAML frontmatter when the project uses frontmatter:

```yaml
---
status: accepted
date: YYYY-MM-DD
deciders: [name-or-role]
supersedes: docs/decisions/0001-example.md
---
```

Use body fields when the project uses body-field decisions:

```markdown
Status: Accepted
Date: YYYY-MM-DD
Supersedes: [Prior decision](0001-example.md)
```

Do not duplicate metadata in prose unless the prose adds interpretation, reasoning, or a decision that metadata cannot express.

## Storage and Naming

Resolve storage before writing:

1. User-provided destination.
2. Project-local rules or established repository/vault convention.
3. `<project>/docs/decisions/`.
4. If no project context exists, ask the user where to save the record.

Use repository or vault naming conventions first. When no stronger convention exists:

- Use `NNNN-<decision-slug>.md` for numbered decision sets.
- Use the next available four-digit number, starting at `0001`.
- Use lowercase kebab-case slugs.
- Use `decision-<concise-subject>-<yymmdd-hhmm>.md` only when the project does not use numbered records and chronology-in-filename is clearer.
- Keep filenames stable after acceptance unless a supersession or approved rename changes them.

Do not create an index, archive, or new directory convention unless the user or project approves it.

## Supersession

Create a new record when a material decision changes and old rationale remains useful.

When one record supersedes another:

1. Link the new record to the record it supersedes.
2. Change only the older record's status and reciprocal supersession link when the project permits those updates.
3. Preserve the old decision's outcome, date, rationale, and consequences.
4. Validate both links and statuses.

Do not rewrite history to make old records look as if the new decision always existed.

## Drafting Workflow

1. Confirm the decision owner and current status.
2. Inspect project-local decision conventions and nearby records.
3. Identify the decision question or confirmed outcome.
4. Gather context, decision drivers, options, consequences, and links.
5. Resolve storage, naming, metadata format, and write approval.
6. Draft from the project template or fallback MADR template.
7. Omit empty optional sections.
8. Validate links, status, date, and supersession relationships.

## Review Workflow

When reviewing an existing record, check:

- title states the solved problem or decision;
- status matches the real lifecycle state;
- context explains why the decision was needed;
- decision outcome is clear and not merely a recommendation;
- drivers and options are sufficient for future readers;
- consequences include material benefits, costs, risks, and obligations;
- related links resolve when locally available;
- supersession links are reciprocal when applicable;
- metadata and prose do not duplicate each other without adding meaning;
- optional sections are not empty scaffolding.

## Validation

After creating or updating a record:

- confirm path and filename follow the active convention;
- confirm title, status, date, context, decision outcome, reasons, and consequences are internally consistent;
- confirm accepted decisions have user, owner, or historical support;
- confirm rejected and superseded decisions preserve useful rationale;
- confirm source links, related decisions, and affected paths resolve when locally available;
- confirm superseded records and replacements link to each other;
- confirm no placeholder text remains outside intentional template examples;
- confirm no secrets, credentials, unrelated personal information, or unsafe absolute home paths were introduced;
- format Markdown; and
- report implementation, runtime, commit, or push checks that were not performed.
