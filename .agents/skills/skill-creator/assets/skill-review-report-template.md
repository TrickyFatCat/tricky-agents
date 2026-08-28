# Skill Review Report Template

Use this template for a normal or follow-up skill review. Scale down for small reviews.

```markdown
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

<Smallest useful change direction and key trade-off if needed. For concrete wording replacements, show old wording before new wording in vertical blocks, not a grid/table. For reusable output patterns, add one compact example when it improves reviewability.>

### 2. <Accepted, declined, or optional-polish note>

Status: ✅ Pass | 🟢 Optional polish | ⛔ Declined

**Evidence**

<Concise reason.>

**Recommended action**

<Smallest useful action. Omit when no action is needed.>

## Best-Practice Check

Use this section only when reviewing against Agent Skills or another baseline.

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

Ask only questions whose answers can change the recommendation, scope, or migration path.

- <Question>?

## Update Scope or Decision Check

Use `Update Scope` when implementation is ready:

- Create:
- Modify:
- Move/rename/delete:
- Validate:

Use `Decision Check` when an unresolved choice changes file scope or behavior.
```
