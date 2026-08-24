# Decision Lenses

Read this reference when a decision needs structured comparison, risk analysis, alternatives, or corner-case exploration.

Choose only lenses that can change the recommendation. Do not apply every prompt mechanically.

## Decision Criteria

Before comparing options, identify two to four criteria that matter most.

Common criteria include:

- Reader or user value.
- Correctness and safety.
- Effort and maintenance cost.
- Reversibility.
- Compatibility with existing workflows.
- Time, energy, or operational constraints.

State assumptions when the criteria are inferred rather than provided by the user.

Compare options against the same criteria. Do not recommend an option based on criteria that were never made visible when that would affect the decision.

## Value and Scope

Check:

- What problem the proposal solves.
- Who benefits and how often.
- What is intentionally included or excluded.
- Whether the proposed scope matches the actual need.
- Whether a smaller change would deliver most of the value.

## Complexity and Maintenance

Check:

- New moving parts or dependencies.
- Ongoing maintenance and ownership.
- Hidden state or configuration precedence.
- Whether future changes become easier or harder.
- Whether the abstraction is justified by repeated use.

Do not reject complexity automatically. Explain what value must justify it.

## Safety and Reversibility

Check:

- Data loss, security exposure, downtime, or confusing failure modes.
- Whether the change can be tested safely.
- Whether rollback is practical and documented.
- Partial failure during setup, migration, or cleanup.
- Permissions, credentials, and sensitive data.

Prefer reversible experiments while the decision is still exploratory.

## Observability and Validation

Check:

- How the user will know the approach works.
- How failure becomes visible.
- Whether success criteria are specific enough to test.
- Whether a small experiment can resolve the largest uncertainty.
- Whether logs, status output, validation commands, or tests exist.

A proposed experiment should target a decision-changing unknown, not create busywork.

## Dependencies and Migration

Check:

- External tools, services, formats, versions, or conventions.
- Existing users, files, workflows, habits, or call sites.
- Compatibility and transition costs.
- Required documentation or training.
- What happens to legacy behavior.

Use the `researcher` skill when external facts or current upstream information determine the decision.

## Corner Cases

Prioritize plausible cases:

- Empty, missing, malformed, duplicate, or stale input.
- Read-only files, symlinks, permissions, and cross-filesystem behavior.
- Multiple users, machines, shells, platforms, or tool versions.
- Offline state, timeouts, partial responses, or retries.
- Caches, environment variables, and hidden configuration precedence.
- Concurrent operations or interrupted migration.

Do not invent edge cases merely to make the analysis look complete.

## Alternatives

Present realistic alternatives rather than strawmen.

Include a minimal-change or do-nothing option when plausible. Prefer reversible options while uncertainty remains.

Useful comparison format:

| Option                | Best when                          | Main trade-off                              |
| --------------------- | ---------------------------------- | ------------------------------------------- |
| Minimal change        | The problem is small or uncertain. | Lowest effort, but limited standardization. |
| Standardized approach | The workflow will recur.           | More setup and maintenance.                 |

For a simple choice, prose may be clearer than a table.

## Pros and Cons

When using pros and cons:

- Tie each point to a decision criterion.
- Explain why it matters.
- Include mitigations for important downsides when available.
- Avoid generic filler.
- Group related points rather than producing long unranked lists.

## Naming and Documentation

Check whether names communicate purpose and ownership.

Identify documentation needed for:

- Setup and validation.
- Defaults and extension points.
- Migration or rollback.
- Future maintenance.

Documentation cost is part of implementation and maintenance cost, not an afterthought.
