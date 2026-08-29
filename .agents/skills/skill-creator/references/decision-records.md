# Skill Decision Records

Read this reference for every skill creation, review, update, refactor, rename, or task that creates or backfills a repository decision record documenting a skill change.

This reference governs records **about skill changes**. It does not define whether a target skill should create or manage decision records during normal use. Read [decision-record-capability.md](decision-record-capability.md) for that separate design responsibility.

A skill-change decision record preserves why a durable skill choice was made. Git remains the source for line-level history; the record explains context, reasoning, alternatives, and consequences that a diff does not capture clearly.

Use [../assets/decision-record-template.md](../assets/decision-record-template.md) when drafting a skill-change decision record.

## Required Assessment

Always assess whether the task needs a decision record and report the reason.

Use one of these outcomes:

```text
Decision record: recommended — this changes a shared review contract.
```

```text
Decision record: not recommended — this is a routine wording correction with no durable trade-off.
```

When a record is recommended, creation is mandatory within the approved change scope. Do not ask separately whether the user wants it. Include its exact path in the approval proposal and create it with the approved skill changes.

When the user directly requests a record, treat it as recommended and proceed through the creation workflow. Repository approval, exact-file scope, and path-safety rules still apply.

If the need for a record becomes clear only after approval, pause and request approval for the additional exact file before creating it.

## Recommend a Record

Recommend and create a record when a skill change establishes or changes:

- Skill creation, removal, split, merge, or rename.
- Discovery, routing, activation, or responsibility boundaries.
- Approval, safety, permission, or protected-state behavior.
- Shared contracts, conventions, report formats, or validation rules.
- Cross-skill dependencies or handoffs.
- A migration with compatibility or rollback consequences.
- A rejected alternative likely to be proposed again.
- A non-obvious trade-off whose reasoning would be difficult to recover from the diff.

Also recommend a record when several small changes together establish a durable workflow policy.

## Do Not Recommend a Record

A separate record is normally unnecessary for:

- Typo, grammar, and formatting corrections.
- Example updates that do not change a contract.
- Routine reference maintenance with an obvious reason.
- Mechanical path or name corrections after an already recorded decision.
- Low-risk cleanup with no meaningful alternative or future trade-off.

Always state why the record is not recommended. Do not use only `not needed` without the reason.

## Storage and Naming

Follow the repository's existing decision-record convention when one exists.

When no convention exists, propose:

```text
docs/decisions/NNNN-<decision-slug>.md
```

Use the next available four-digit number and a concise lowercase kebab-case slug. Keep the filename stable after acceptance.

Do not create an index unless the repository already uses one or the user approves it separately.

## Record Format

Keep a normal record under one page when practical. Use [../assets/decision-record-template.md](../assets/decision-record-template.md) as the copyable starting point:

```markdown
# Decision title

Status: Accepted
Date: YYYY-MM-DD

## Context

What prompted the decision and what problem needed resolution.

## Decision

The chosen behavior, boundary, or convention.

## Reasons

Why this option was chosen.

## Consequences

Benefits, costs, risks, compatibility effects, and maintenance obligations.

## Alternatives

Rejected alternatives worth remembering and why they were not chosen.

## Related Changes

- Commit `<hash>` — summary.
- `path/to/affected-file`
```

Use `Proposed`, `Accepted`, `Superseded`, or `Deprecated` as the status when relevant. Do not mark a recommendation as accepted until the user confirms or implementation history proves the decision was adopted.

Add only sections that preserve useful reasoning. Omit empty sections rather than padding the record.

Decision filenames should be semantic and stable. Follow the repository's existing numbered convention when available, such as `docs/decisions/NNNN-<decision-slug>.md`. Do not use `README.md` for a decision record.

## Backfill

For a historical record:

1. Inspect the relevant commits and current files.
2. Use the adoption or finalization date, not the backfill date, when it can be established reliably.
3. State only reasoning supported by the conversation, commit history, or current artifact.
4. Link the commits and affected files that implement the decision.
5. Do not rewrite historical commits or imply that the record existed at the time.

When several commits refine one decision, cite all material commits and use the date of the final behavior unless another decision date is documented.

## Validation

After creating or updating a record:

- Confirm its path follows the active repository convention.
- Confirm the filename is semantic and not a generic `README.md`.
- Confirm the title, status, date, decision, and consequences are internally consistent.
- Confirm cited commits exist and affected paths are correct.
- Confirm the record does not duplicate line-level diff details unnecessarily.
- Format the Markdown.
- Include the record in repository diff and scope validation.

A decision record does not grant commit permission. Commit only when the user explicitly asks and the responsible repository workflow permits it.
