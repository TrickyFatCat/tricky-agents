# Full Skill Audit Report Template

Use this template for a substantial saved full Skill Audit. Evaluate the whole skill and all owned resources. Omit sections that do not help. Do not use it mechanically for Usage Report Audit or lightweight informal Review.

Use [skill-usage-report-audit-template.md](skill-usage-report-audit-template.md) when selected usage reports and materially related resources define the scope.

```markdown
## Audit Summary

Use no more than five short bullets.

- Outcome: No change | Research | Defer | Proposal required
- Findings: <count by priority when useful>
- Main concern: <highest-value issue or none>
- Preserve: <behavior that should remain unchanged>
- Next: <first action after user review>

## Scope and Evidence

- Audited:
- Sources:
- Excluded:

## Skill Resource Evaluation

### References

| Reference | Need | Quality | Writing | Audit result |
| --------- | ---- | ------- | ------- | ------------ |

### Templates

| Template or missing capability | Need | Quality | Audit result |
| ------------------------------ | ---- | ------- | ------------ |

Use concise prose instead when the skill has no owned resources or only one trivial resource. Include directly linked shared dependencies when they materially affect behavior; exclude unrelated global resources.

## Findings

For three or more findings, add a numbered linked navigation list. Omit it when one or two findings are already easy to scan.

1. [<Short title>](#short-title) — <priority or status>
2. [<Short title>](#another-short-title) — <priority or status>
3. [<Short title>](#third-short-title) — <priority or status>

### <Concise noun phrase>

Priority: 🔴 High | 🟡 Medium | 🟢 Low

**Evidence**

<Observed problem and concise evidence.>

**Why it matters**

<Impact, failure mode, safety/routing/maintenance risk. Omit for pass notes or simple optional polish when it would add noise.>

**Recommended action**

<Smallest useful change direction and key trade-off if needed. For concrete wording replacements, show old wording before new wording in vertical blocks, not a grid. For reusable output patterns, add one compact example when useful.>

### <Accepted, declined, or optional-polish note>

Status: ✅ Pass | 🟢 Optional polish | ⛔ Declined

**Evidence**

<Concise reason.>

**Recommended action**

<Smallest useful action. Omit when no action is needed.>

Keep detailed finding headings descriptive and free of numeric prefixes. Ensure headings produce unique anchors in the target renderer.

## Best-Practice Check

Use only when auditing against Agent Skills or another explicit baseline.

| Area                           | Status | Notes                                                  |
| ------------------------------ | ------ | ------------------------------------------------------ |
| Real expertise/source material | ok/gap | <hands-on tasks, user corrections, artifacts, reports> |
| Progressive disclosure         | ok/gap | <core vs references/assets>                            |
| Context economy                | ok/gap | <what to cut or move>                                  |
| Calibrated control             | ok/gap | <strict where fragile, flexible where safe>            |
| Templates/output formats       | ok/gap | <concrete reusable shapes>                             |
| Validation/refinement loop     | ok/gap | <trial tasks, routing checks, execution traces>        |

## Good Decisions

- <Decision worth preserving> — <why it helps routing, safety, portability, maintainability, or progressive disclosure>.

## Questions

Ask only questions whose answers can change the recommendation, scope, migration path, or outcome.

- <Question>?

## Decision Record

- Stage: Preliminary
- Signal: Recommended | Not recommended

**Reason**

- <Why the candidate change does or does not need a repository decision record>.
- <For proposal required, confirm the final outcome and exact path in the proposal>.

## Audit Outcome

- Outcome: No change | Research | Defer | Proposal required
- Next: <specific next action after user review>

## Untested Areas

- <Runtime, fresh-session, rendering, integration, or other check not performed>.

## Proposal Handoff

Use only for `Proposal required`. Name candidate areas and dependencies without duplicating the exact proposal.

- Candidate areas:
- Dependencies:
- Scope still to resolve:
```
