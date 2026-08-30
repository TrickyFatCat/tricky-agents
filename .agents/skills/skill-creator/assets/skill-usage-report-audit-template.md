# Skill Usage Report Audit Template

Use this template for a formal saved Audit of selected skill usage reports and the resources materially related to their findings. Follow project-local storage, metadata, naming, approval, and validation rules first. Omit optional or empty sections.

Do not use this template to imply whole-skill coverage. Escalate to full Skill Audit when findings have broad or uncertain impact.

```markdown
## Audit Summary

Use no more than five short bullets.

- Outcome: No change | Research | Defer | Proposal required
- Reports: <count and current states>
- Main concern: <highest-value report finding or none>
- Preserve: <behavior that should remain unchanged>
- Next: <first action after user review>

## Scope and Evidence

- Reports audited:
- Related resources:
- Sources and execution evidence:
- Unrelated owned resources excluded:
- Escalation check: Focused scope sufficient | Escalate to full Skill Audit

## Usage Report Triage

| Report | User issue | Evidence-backed judgment | Related resources | Next lifecycle state |
| ------ | ---------- | ------------------------ | ----------------- | -------------------- |

For each report, preserve the user-pointed issue separately from agent interpretation. Check validity, duplication, current implementation evidence, and lifecycle accuracy.

## Related Resource Evaluation

| Resource | Why related | Evidence checked | Audit result |
| -------- | ----------- | ---------------- | ------------ |

Evaluate every resource that can materially change a report judgment. Explicitly list unrelated owned resources under Scope and Evidence rather than copying a full owned-resource inventory.

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

<Impact, failure mode, lifecycle risk, or maintenance cost.>

**Recommended action**

<Smallest useful change and key trade-off.>

### <Pass, declined, or optional-polish note>

Status: ✅ Pass | 🟢 Optional polish | ⛔ Declined

**Evidence**

<Concise reason.>

Keep detailed finding headings descriptive and free of numeric prefixes. Ensure headings produce unique anchors in the target renderer.

## Good Decisions

- <Decision or behavior worth preserving> — <why it matters>.

## Questions

Ask only questions whose answers can change a report judgment, related-resource scope, escalation, lifecycle state, recommendation, or outcome.

- <Question>?

## Decision Record

- Stage: Preliminary
- Signal: Recommended | Not recommended

**Reason**

- <Why the candidate change does or does not need a repository decision record>.
- <For proposal required, confirm the final outcome and exact path in the proposal>.

## Audit Outcome

- Outcome: No change | Research | Defer | Proposal required
- Report states after Audit: <open, triaged, or other evidence-backed states>
- Next: <specific next action after user review>

## Untested Areas

- <Runtime, fresh-session, report source, related resource, or integration not tested>.

## Proposal Handoff

Use only for `Proposal required`. Name candidate resources, dependencies, report traceability, and unresolved scope without duplicating the exact proposal.

- Candidate resources:
- Dependencies:
- Reports requiring proposal links:
- Scope still to resolve:
```

## Scope Checks

Before finalizing:

- Use lightweight triage instead when only lifecycle or traceability metadata needs correction and no behavior change is proposed.
- Escalate when findings affect broad routing, safety, responsibility, architecture, resource-wide migration, or uncertain interactions.
- Confirm every selected report has an evidence-backed judgment and next lifecycle state.
- Confirm every materially related resource was evaluated.
- Confirm unrelated owned resources are explicitly excluded.
- Keep proposal approval and implementation outside the Audit.
