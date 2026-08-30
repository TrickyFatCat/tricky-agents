# Skill Audit and Review Format

Read this reference before producing a formal skill audit or a substantial informal review of a skill and its supporting resources.

## Mode Boundary

Use **Audit** for a formal, bounded pre-change assessment that the active workflow saves and tracks. Record evidence, prioritized findings, preserved behavior, limitations, a preliminary decision-record signal, and one audit outcome.

Use **Review** for informal critique or for the user's act of reviewing an audit, proposal, or implementation result. Keep an informal Review proportional and normally conversational. Do not create a persistent Audit artifact unless the request or tracked workflow requires one.

For a tracked skill change:

1. Save the Audit before creating a proposal.
2. Let the user review the Audit and add corrections or skipped checks.
3. Record `no change`, `research`, `defer`, or `proposal required`.
4. Create a separate proposal only after a reviewed Audit records `proposal required`.

Do not put exact implementation approval in the Audit.

## Audit Structure

Use [../assets/skill-audit-report-template.md](../assets/skill-audit-report-template.md) for a substantial saved Audit.

Use only the sections that help:

1. Audit Summary.
2. Scope and Evidence.
3. Skill Resource Evaluation.
4. Findings Overview, for three or more findings.
5. Findings.
6. Good Decisions.
7. Best-Practice Check, only when comparing against an explicit baseline.
8. Questions, only when answers would change the outcome.
9. Decision Record.
10. Audit Outcome.
11. Untested Areas.
12. Proposal Handoff, only for `proposal required`.

Keep visible section names concise. Put ordering, priority, and status details inside sections rather than appending them to headings.

## Audit Summary

Begin a substantial saved Audit with no more than five short bullets:

```markdown
## Audit Summary

- Outcome: Proposal required
- Findings: 2 high, 3 medium
- Main concern: The saved proposal is not required before implementation.
- Preserve: Existing findings formatting and exact-file approval.
- Next: User reviews this audit before proposal creation.
```

Use the whole-artifact summary for orientation, not as a second Findings Overview. Reference findings instead of repeating their evidence. Omit it for a small informal Review.

## Skill Resource Evaluation

Evaluate every skill-owned reference and template during a substantial formal Audit.

For references, assess:

- **Need:** Separate loading is justified and has a clear trigger.
- **Quality:** Guidance is accurate, sufficiently complete, consistent, and aligned with the core.
- **Writing:** Text is direct, scannable, proportional, and not duplicative.

For templates, assess:

- **Need:** Recurring or fragile output justifies the template, and existing templates remain necessary.
- **Quality:** The template is adaptable, semantically named, locally overridable, safe to copy, and explicit about optional sections.

Also state whether missing recurring template capability is justified. Include directly linked shared dependencies only when they materially affect behavior. Exclude unrelated global references and templates.

Use a compact table for several resources. Use concise prose when the skill has no owned resources or only one trivial resource. Keep this section optional for informal Review.

## Findings Overview

For three or more findings, add a linked overview before the detailed findings:

```markdown
## Findings Overview

- [1. Routing](#1-routing) — ✅ Pass
- [2. Approval gate](#2-approval-gate) — 🔴 High
- [3. Safety section](#3-safety-section) — 🟢 Optional polish
```

Keep each line to the finding link plus priority or status. Do not repeat evidence or recommended actions. For one or two findings, use a one-sentence diagnosis or omit the overview when it would duplicate the findings.

## Findings

Report no more than five highest-value findings unless the user requests an exhaustive audit or review.

Present findings in source order when that makes the artifact easier to apply. For multi-file work, group findings by file in a stable order. Use priority labels without reordering findings by severity.

Number each finding and use a concise noun phrase for its heading:

```markdown
### 1. Reference loading
```

Do not include priority, status, evidence, or the proposed fix in the heading.

## Finding Priority and Status

Use one metadata line after the heading. Never put priority or status in the heading.

Use `Priority` for problems:

- `🔴 High`: likely to break discovery or routing, weaken an approval or safety boundary, leave broken references, or make a migration incomplete.
- `🟡 Medium`: likely to create unclear responsibility boundaries, maintenance problems, validation gaps, or ineffective progressive disclosure.
- `🟢 Low`: wording, organization, naming, consistency, or other low-risk polish.

Use `Status` for non-problem notes and optional polish:

- `✅ Pass`: checked behavior is correct and should stay unchanged.
- `🟢 Optional polish`: low-risk readability or organization improvement that is not a blocker.
- `⛔ Declined`: the user rejected or overrode the suggestion; do not repeat it unless new evidence changes the assessment.

Preserve source order and let the metadata line communicate importance.

## Finding Format

Use a numbered heading followed by priority or status on its own line:

```markdown
### 1. Marker discovery

Priority: 🔴 High

**Evidence**

The workflow defines supported marker formats, but the initial search failed to find two `> REVIEW` blocks.

**Why it matters**

Missed markers can make an audit appear complete while user feedback remains unresolved.

**Recommended action**

Use a broad whole-word search before classifying exact marker syntax.
```

Keep headings short. Use a noun phrase, not a sentence.

Use `**Evidence**` for the observation and support. Keep it to one short paragraph unless more detail is required.

Use `**Why it matters**` for impact, failure modes, maintenance cost, and risks. Omit it for pass notes or simple optional polish when it would add noise.

Use `**Recommended action**` for the smallest useful change. Explain a trade-off only when it affects the decision.

When recommending a concrete wording replacement, show the current wording before the proposed wording. Use compact `Old wording` and `New wording` blocks. Do not use a grid or table for wording replacements unless the user explicitly asks for one. Do not force old/new blocks for conceptual recommendations where exact text is not being replaced.

When recommending a reusable output pattern, include one compact positive example when it makes the recommendation easier to review or apply. Add a short “avoid this” example only when a likely wrong pattern needs contrast. Omit examples for routine wording edits or conceptual recommendations where they add ceremony.

Omit labels that add no value to a simple finding. Do not turn every sentence into a subsection.

## Accepted and Declined Notes

Keep pass notes concise:

```markdown
### 2. Approval gate

Status: ✅ Pass

**Evidence**

The gate names exact files and requires separate approval for expanded scope. Preserve it.
```

Keep declined findings equally direct:

```markdown
### 3. Shared audit skill

Status: ⛔ Declined

**Evidence**

The user prefers Audit inside Skill Creator. Do not keep recommending a shared abstraction without new evidence.
```

Do not apply the full problem, risk, and recommended-action format unless the note teaches something important.

## Best-Practice Check

Use a compact best-practice table when the Audit compares a skill to Agent Skills or another explicit baseline.

Check only areas relevant to the task:

- Real expertise and source material.
- Progressive disclosure.
- Context economy.
- Calibrated control.
- Templates and output formats.
- Validation or refinement loops.
- Description and routing quality.

Do not add this section when it would repeat the findings.

## Good Decisions

Identify concrete decisions worth preserving:

- Name the decision.
- Explain why it improves routing, safety, portability, maintainability, or progressive disclosure.
- State what should remain unchanged when useful.

Do not duplicate accepted findings in both Findings and Good Decisions.

## Questions

Ask questions only when the answers can change the recommendation, scope, migration path, or audit outcome. Keep them few and decision-oriented.

Do not disguise criticism as a question or add questions only to satisfy the format.

## Follow-Up Audits and Reviews

When previous history is relevant:

1. Verify resolved findings instead of presenting them as new problems.
2. Preserve accepted and declined decisions when they prevent repeated recommendations.
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

Use `Recommended` or `Not recommended` and state why. If the outcome is `proposal required`, leave the final outcome and exact path to the proposal.

## Audit Outcome

Record one outcome and the next action in every formal Audit:

```markdown
## Audit Outcome

- Outcome: Proposal required
- Next: Create a separate proposal only after user review of this audit.
```

Allowed outcomes:

- `no change`: preserve the audited behavior; no proposal follows.
- `research`: gather named evidence before deciding whether to propose changes.
- `defer`: preserve the finding and state the condition for resuming.
- `proposal required`: create a separate exact-file proposal after user review.

## Proposal Handoff

For `proposal required`, identify only the candidate areas, dependencies, and unresolved scope that the proposal must address. Do not duplicate the proposal's exact file tables, final wording, approval request, or lifecycle state.

Use [../assets/skill-change-proposal-template.md](../assets/skill-change-proposal-template.md) later when the proposal phase begins.
