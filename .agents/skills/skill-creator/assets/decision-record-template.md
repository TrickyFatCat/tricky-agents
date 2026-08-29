# Decision Record Template

Use this template when `references/decision-records.md` says a skill decision record is recommended or the user directly requests one.

Delete optional fields and sections that do not apply. Do not leave empty placeholders in a completed record.

```markdown
# <Decision Title>

Status: Proposed | Accepted | Rejected | Superseded | Deprecated
Date: YYYY-MM-DD

## Context

<What prompted the decision and what problem needed resolution.>

## Decision

<The chosen behavior, boundary, convention, migration, or contract.>

## Reasons

- <Reason 1>.
- <Reason 2>.
- <Reason 3>.

## Consequences

- Benefits:
- Costs:
- Risks:
- Compatibility or migration impact:
- Maintenance obligation:

## Alternatives

- <Alternative> — <why it was not chosen>.

## Traceability

- Source task, proposal, review, report, research, or issue:
- Related decisions:
- Supersedes:
- Superseded by:

## Related Changes

- `<path>`
- Commit `<hash>` — <summary>, when available.
```
