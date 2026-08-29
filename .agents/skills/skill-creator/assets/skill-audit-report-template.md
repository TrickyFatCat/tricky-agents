# Skill Audit Report Template

Use this template for a substantial saved skill Audit. Omit sections that do not help. Do not use it mechanically for a lightweight informal Review.

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

## Findings Overview

Use only for three or more findings. Link each detailed finding.

- [1. <Short title>](#1-short-title) — <priority or status>
- [2. <Short title>](#2-short-title) — <priority or status>
- [3. <Short title>](#3-short-title) — <priority or status>

## Findings

### 1. <Concise noun phrase>

Priority: 🔴 High | 🟡 Medium | 🟢 Low

**Evidence**

<Observed problem and concise evidence.>

**Why it matters**

<Impact, failure mode, safety/routing/maintenance risk. Omit for pass notes or simple optional polish when it would add noise.>

**Recommended action**

<Smallest useful change direction and key trade-off if needed. For concrete wording replacements, show old wording before new wording in vertical blocks, not a grid or table. For reusable output patterns, add one compact example when it improves reviewability.>

### 2. <Accepted, declined, or optional-polish note>

Status: ✅ Pass | 🟢 Optional polish | ⛔ Declined

**Evidence**

<Concise reason.>

**Recommended action**

<Smallest useful action. Omit when no action is needed.>

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

Ask only questions whose answers can change the recommendation, scope, migration path, or audit outcome.

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
