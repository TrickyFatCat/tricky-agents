# Code Audit Template

Use this adaptable template for a bounded formal Code Audit when active project rules do not define another contract.

Apply project-local metadata, terminology, storage, naming, and lifecycle first. Omit optional or empty properties and sections. Do not preserve placeholder text in a completed Audit.

```markdown
---
type: code-assessment
mode: audit
status: complete
created: YYYY-MM-DD
target:
  - path/to/target
snapshot: <commit, version, or stable identifier when available>
focus: <optional focus>
confidence: <high | medium | low>
outcome: <no-material-findings | changes-recommended | blocked-on-evidence | defer>
---

# Code Audit: <Subject>

## Audit Summary

- Outcome: <outcome>
- Scope: <bounded target and snapshot>
- Findings: <count or distribution when useful>
- Main concern: <highest-value issue or none within scope>
- Next: <one focused action or decision>

## Scope and Evidence

**Purpose**

<Assessment purpose, audience, and questions.>

**Included**

- `<path, component, diff, or interface>`

**Excluded**

- `<explicit exclusion>`

**Evidence**

- Directly inspected: <source, configuration, tests, interfaces, history, or output>
- Supplied but not reproduced: <author, project, CI, test, build, or runtime evidence>
- Tools and specialists: <name, version, configuration, scope, and result>
- Checks performed: <static or runtime checks actually run>
- Unavailable evidence: <missing, unsafe, or out-of-scope evidence>

## Findings

### <Finding title>

Priority: 🔴 High
Confidence: High
Location: `<path:line>`
Status: Open

**Evidence**

<Observed behavior and evidence origin.>

**Impact**

<What can break, become unsafe, or increase maintenance cost.>

**When this appears**

<Triggering input, state, environment, or future change.>

**Recommendation**

<Focused direction without silent implementation.>

### <Accepted behavior>

Status: ✅ Accepted
Location: `<path:line>`

<Specific good decision and why it should remain.>

## Good Decisions

- <Specific decision, benefit, and habit to preserve.>

## Questions

- <Only a question that can change a finding, confidence, scope, or next action.>

## Audit Outcome

- Outcome: <no material findings | changes recommended | blocked on evidence | defer>
- Confidence: <high | medium | low, when useful>
- Next: <one focused action, evidence request, or decision>

<Clarify that the outcome applies only to the stated scope and does not imply comprehensive assurance, implementation approval, merge readiness, certification, or legal judgment.>

## Untested Areas

- <Behavior, environment, path, tool, or specialist check not tested.>

## Sources

- <External source used for a material claim, when applicable.>
```

## Template Rules

- Keep Audit Summary to no more than five short bullets.
- Resolve target snapshot and explicit exclusions before claiming formal coverage.
- Use one parent `Findings` section.
- For three or more findings, use numbered linked navigation followed by descriptive unnumbered headings.
- Keep priority or status separate from finding headings.
- Include exact source locations when available.
- Distinguish supplied evidence from reproduced results.
- Record checks actually performed, specialists, tools, confidence, unavailable evidence, and untested areas when material.
- Add security, supply-chain, licensing-signal, comment, AI, or platform limitations only when relevant.
- Do not claim penetration testing, formal verification, exhaustive coverage, security certification, supply-chain assurance, legal review, merge approval, or implementation authority.
- Do not add Skill Creator proposal or decision-record scaffolding.
