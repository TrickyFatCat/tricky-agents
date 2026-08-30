# Skill Audit and Review Format

Read this reference before producing a full Skill Audit, Usage Report Audit, or substantial informal Review.

## Mode Boundary

Use **Review** for informal critique, user feedback on an Audit or proposal, and lightweight report triage. Keep it proportional and normally conversational.

Use **Usage Report Audit** for a formal, saved assessment of selected usage reports and the resources that can materially change their judgments.

Use **full Skill Audit** for a formal, saved whole-skill assessment. Prefer it when the user explicitly requests full coverage or the candidate change has broad or uncertain impact.

Both formal Audit modes record evidence, prioritized findings, preserved behavior, limitations, a preliminary decision-record signal, and one outcome: `no change`, `research`, `defer`, or `proposal required`.

For a tracked skill change:

1. Save the selected Audit before creating a proposal.
2. Let the user review the Audit and add corrections or skipped checks.
3. Record one Audit outcome.
4. Create a separate proposal only after a reviewed Audit records `proposal required`.

Do not put exact implementation approval in an Audit.

## Choose the Assessment Scope

### Lightweight Report Triage

Use Review instead of formal Audit when conclusive evidence shows that only usage-report lifecycle metadata or traceability needs correction and no behavior change is proposed.

Record the evidence and correction without creating Audit or proposal ceremony. Follow report-state approval rules.

### Usage Report Audit

Use Usage Report Audit when one or more usage reports may lead to a skill or global-agent change.

Focus on:

- each report's user-pointed issue and interpretation;
- observed behavior and supporting evidence;
- validity, overlap, duplication, and current lifecycle state;
- improvement candidates and affected resources;
- the smallest reliable next state.

Evaluate only core sections, references, templates, scripts, instructions, decisions, commits, execution traces, and dependencies that can materially change the report judgment. Explicitly list unrelated owned resources as excluded and do not imply whole-skill coverage.

Escalate to full Skill Audit when:

- the user explicitly requests full or whole-skill assessment;
- findings affect broad routing, safety, responsibility, architecture, or resource-wide migration;
- interactions outside the focused resource set can materially change the recommendation; or
- focused evidence cannot support a confident outcome.

Use [../assets/skill-usage-report-audit-template.md](../assets/skill-usage-report-audit-template.md) for substantial saved Usage Report Audits.

### Full Skill Audit

Use full Skill Audit for whole-skill quality, architecture, routing, resource, migration, or capability assessment.

Evaluate the core, every owned reference and template, missing recurring template capability, scripts, and behaviorally relevant shared dependencies. Exclude unrelated global resources.

Use [../assets/skill-audit-report-template.md](../assets/skill-audit-report-template.md) for substantial saved full Skill Audits.

## Common Audit Structure

Use only sections that help:

1. Audit Summary.
2. Scope and Evidence.
3. Skill Resource Evaluation for full Skill Audit, or Usage Report Triage and Related Resource Evaluation for Usage Report Audit.
4. Findings, with numbered linked navigation for three or more findings.
5. Good Decisions.
6. Best-Practice Check, only when comparing against an explicit baseline.
7. Questions, only when answers would change the outcome.
8. Decision Record.
9. Audit Outcome.
10. Untested Areas.
11. Proposal Handoff, only for `proposal required`.

Keep visible section names concise. Put ordering, priority, and status details inside sections rather than appending them to headings.

## Section Ownership and Final Pass

Give each concept one primary location:

- `Scope and Evidence`: targets, sources, methods, exclusions, and evidence limits.
- Resource evaluation or report triage: concise judgments about assessed items.
- `Findings`: evidence, impact, and recommended action for material problems.
- `Good Decisions`: preserved behavior not already recorded as a pass finding.
- `Audit Outcome`: outcome, report states when applicable, and next action.
- `Proposal Handoff`: candidate areas and unresolved dependencies without repeating findings or proposal content.

Before finalizing a formal Audit:

1. Remove repeated rationale across the summary, evaluation, findings, outcome, and handoff.
2. Link accepted source evidence instead of restating it.
3. Remove paragraphs that do not change evidence, confidence, scope, impact, action, outcome, or authority.
4. Omit optional sections that do not help the judgment.

Repeat a boundary briefly only when omission would make a local judgment misleading about safety, confidence, scope, or authority. Do not use line, heading, sentence, or paragraph counts as pass/fail limits.

## Audit Summary

Begin a substantial saved Audit with no more than five short bullets:

```markdown
## Audit Summary

- Outcome: Proposal required
- Findings: 2 high, 3 medium
- Main concern: The saved proposal is not required before implementation.
- Preserve: Existing findings formatting and exact-file approval.
- Next: User reviews this Audit before proposal creation.
```

Use the whole-artifact summary for orientation, not as a duplicate of finding navigation. Reference findings instead of repeating their evidence. Omit it for a small informal Review.

## Skill Resource Evaluation

Use this section for full Skill Audit.

For every owned reference, assess:

- **Need:** Separate loading is justified and has a clear trigger.
- **Quality:** Guidance is accurate, sufficiently complete, consistent, and aligned with the core.
- **Writing:** Text is direct, scannable, proportional, and not duplicative.

For every owned template, assess:

- **Need:** Recurring or fragile output justifies it.
- **Quality:** It is adaptable, semantically named, locally overridable, safe to copy, and explicit about optional sections.

Also assess missing recurring template capability. Include directly linked shared dependencies only when they materially affect behavior. Use concise prose when the skill has no owned resources or only one trivial resource.

## Usage Report Triage

Use this section for Usage Report Audit.

For each selected report, record:

| Report | User issue | Evidence-backed judgment | Related resources | Next lifecycle state |
| ------ | ---------- | ------------------------ | ----------------- | -------------------- |

Check whether the report is valid, duplicated, already implemented, stale, superseded, rejected, or still actionable. Preserve the user's issue separately from agent interpretation.

Use report lifecycle accurately:

- Keep new reports `open` before triage.
- Mark confirmed reports `triaged` after assessment.
- Mark a report `proposed` only when a separate proposal links it.
- Mark a report `decided` only when a decision links it.
- Mark `implemented`, `rejected`, `stale`, or `superseded` only with a clear final reason and traceability.

## Related Resource Evaluation

Use this section for Usage Report Audit.

Evaluate every resource that can materially change the report judgment. For each resource, state why it is related, what was checked, and the result.

Explicitly list unrelated owned resources as excluded. If exclusions or uncertain interactions weaken confidence, escalate to full Skill Audit.

Inventory and link checks support both Audit modes but do not replace qualitative evaluation.

## Findings

Report no more than five highest-value findings unless the user requests exhaustive coverage or the bounded scope requires more.

For three or more findings, begin the parent section with a numbered linked navigation list:

```markdown
## Findings

1. [Routing](#routing) — ✅ Pass
2. [Approval gate](#approval-gate) — 🔴 High
3. [Safety section](#safety-section) — 🟢 Optional polish

### Routing

Status: ✅ Pass
```

Keep each navigation line to the finding link plus priority or status. Keep detailed headings descriptive and free of numeric prefixes. Ensure headings produce unique anchors in the target renderer. For one or two findings, omit navigation when it would duplicate the details.

Present findings in source or application order when that makes the artifact easier to apply. For multi-file work, group findings by file in a stable order. Let priority labels communicate severity without reordering findings.

## Finding Priority and Status

Use one metadata line after the heading. Never put priority or status in the heading.

Use `Priority` for problems:

- `🔴 High`: likely to break discovery or routing, weaken approval or safety, leave broken references, or make migration incomplete.
- `🟡 Medium`: likely to create unclear responsibility, maintenance problems, validation gaps, or ineffective progressive disclosure.
- `🟢 Low`: wording, organization, naming, consistency, or other low-risk polish.

Use `Status` for non-problem notes:

- `✅ Pass`: checked behavior is correct and should stay unchanged.
- `🟢 Optional polish`: low-risk readability or organization improvement that is not a blocker.
- `⛔ Declined`: the user rejected or overrode the suggestion; do not repeat it without new evidence.

## Finding Format

Use a concise noun phrase for the heading:

```markdown
### Marker discovery

Priority: 🔴 High

**Evidence**

The workflow defines supported marker formats, but the initial search failed to find two `> REVIEW` blocks.

**Why it matters**

Missed markers can make an Audit appear complete while user feedback remains unresolved.

**Recommended action**

Use a broad whole-word search before classifying exact marker syntax.
```

Keep headings short and unnumbered. Use `**Evidence**` for the observation and support. Use `**Why it matters**` for impact, failure modes, maintenance cost, and risks. Omit it for pass notes or simple optional polish when it adds noise. Use `**Recommended action**` for the smallest useful change and key trade-off.

For concrete wording replacements, show old wording before new wording in compact vertical blocks. For reusable output patterns, add one compact positive example when it improves reviewability. Add an avoid example only for a likely mistake.

Omit labels that do not help a simple finding.

## Accepted and Declined Notes

Keep pass notes concise:

```markdown
### Approval gate

Status: ✅ Pass

**Evidence**

The gate names exact files and requires separate approval for expanded scope. Preserve it.
```

Keep declined findings equally direct. Do not apply the full finding structure unless the note teaches something important.

## Best-Practice Check

Use a compact best-practice table only when comparing against Agent Skills or another explicit baseline. Check relevant areas such as source material, progressive disclosure, context economy, calibrated control, templates, validation, and routing.

Do not add this section when it would repeat the findings.

## Good Decisions

Name concrete decisions worth preserving, explain their benefit, and state what should remain unchanged when useful. Do not duplicate pass findings.

## Questions

Ask only questions whose answers can change the recommendation, scope, escalation, migration path, lifecycle judgment, or Audit outcome. Keep them few and decision-oriented.

## Follow-Up Audits and Reviews

When previous history matters:

1. Verify resolved findings instead of presenting them as new.
2. Preserve accepted and declined decisions when they prevent repetition.
3. Identify newly discovered issues as new findings.
4. Do not change a previous status without user confirmation or new evidence.

## Decision Record

Use one compact heading for the preliminary signal:

```markdown
## Decision Record

- Stage: Preliminary
- Signal: Recommended

**Reason**

- The candidate change affects a shared format and approval workflow.
- Confirm the final outcome and path in the proposal.
```

Use `Recommended` or `Not recommended` and state why. For `proposal required`, leave the final outcome and exact path to the proposal.

## Audit Outcome

Record one outcome and the next action in every formal Audit:

```markdown
## Audit Outcome

- Outcome: Proposal required
- Next: Create a separate proposal only after user review of this Audit.
```

Allowed outcomes:

- `no change`: preserve audited behavior; no proposal follows.
- `research`: gather named evidence before deciding.
- `defer`: preserve the finding and state the condition for resuming.
- `proposal required`: create a separate exact-file proposal after user review.

## Proposal Handoff

For `proposal required`, identify only candidate areas, dependencies, and unresolved scope. Do not duplicate exact proposal tables, final wording, approval request, or lifecycle state.

Use [../assets/skill-change-proposal-template.md](../assets/skill-change-proposal-template.md) later when the proposal phase begins.
