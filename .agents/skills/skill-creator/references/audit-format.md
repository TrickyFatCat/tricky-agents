# Skill Audit and Review Domain Guidance

Read this reference when applying Skill Creator's domain criteria to a formal Skill Audit, Usage Report Audit, or substantial informal Review.

Pair it with the relevant shared workflow:

- Read [`audit-workflow/references/review.md`](../../audit-workflow/references/review.md) for conversational Review mechanics.
- Read [`audit-workflow/references/audit.md`](../../audit-workflow/references/audit.md) for formal Audit structure, lifecycle, findings, persistence, and section ownership.
- Use [`audit-workflow/assets/artifact-audit-template.md`](../../audit-workflow/assets/artifact-audit-template.md) as the saved Audit base.

This reference supplies skill-domain scope, evidence, judgment, and additions. It does not redefine the shared artifact format.

## Choose the Assessment Scope

### Review

Use Review for informal skill critique, user feedback on an Audit or proposal, implementation follow-up, and lightweight report triage when only lifecycle or traceability needs correction.

Keep Review proportional and normally conversational. Skill Creator supplies architecture, routing, progressive-disclosure, safety, migration, and validation criteria; `audit-workflow` supplies shared Review mechanics.

### Usage Report Audit

Use Usage Report Audit when selected skill usage reports may lead to a skill or global-agent change and their materially related resources define a reliable bounded scope.

Assess:

- each report's user issue separately from agent interpretation;
- observed behavior and supporting evidence;
- validity, overlap, duplication, and current lifecycle state;
- every resource that can materially change the report judgment;
- explicit exclusions; and
- the smallest reliable next state.

Escalate to full Skill Audit when findings affect broad routing, safety, responsibility, architecture, resource-wide migration, or uncertain interactions outside the focused set.

### Full Skill Audit

Use full Skill Audit for whole-skill quality, architecture, routing, resource, migration, or capability assessment, or whenever the user explicitly requests whole-skill coverage.

Evaluate:

- the complete core;
- every owned reference for need, quality, and writing;
- every owned template for need and quality;
- missing recurring template capability;
- every owned script and its documented contract;
- behaviorally relevant shared dependencies; and
- migration and routing dependencies that can change the judgment.

Exclude unrelated global resources. Inventory and link counts support but never replace qualitative evaluation.

## Skill-Domain Evidence

Use concrete evidence such as:

- user corrections and usage reports;
- task history and execution traces;
- current skill cores, references, assets, and scripts;
- direct routing dependencies;
- accepted decisions and proposals;
- harness documentation when discovery matters; and
- read-only inventory, link, and repository checks.

Separate observed facts, interpretation, and recommendations when confusion could change approval or scope.

## Shared Template Adaptation

Start a saved formal Audit from the shared artifact Audit template. Adapt it with only the Skill Creator sections needed for the selected mode.

### Full Skill Audit Additions

Add `Skill Resource Evaluation` when owned resources exist. Evaluate:

| Resource type      | Required judgment                                                              |
| ------------------ | ------------------------------------------------------------------------------ |
| References         | Need, quality, writing, loading condition, and duplication.                    |
| Templates          | Recurring need, quality, adaptability, naming, and overlap with shared assets. |
| Scripts            | Need, contract, side effects, safety, and validation evidence.                 |
| Missing capability | Whether recurring or fragile output justifies a new resource.                  |

Include target-skill Audit/Review and proposal capability only when normal runtime behavior may own it. Default decision-record mechanics to the shared `decision-record` skill.

### Usage Report Audit Additions

Add `Usage Report Triage`:

| Report | User issue | Evidence-backed judgment | Related resources | Next lifecycle state |
| ------ | ---------- | ------------------------ | ----------------- | -------------------- |

Add `Related Resource Evaluation` and list unrelated owned resources under scope exclusions. Do not imply whole-skill coverage.

### Skill Audit Outcome

Record one Skill Creator outcome after applying the shared Audit judgment:

- `no change`: preserve audited behavior;
- `research`: gather named evidence before deciding;
- `defer`: state the condition for resuming; or
- `proposal required`: prepare a separate exact-file proposal only after Audit review.

For `proposal required`, name candidate areas and unresolved dependencies without drafting implementation inside the Audit.

## Skill Finding Priorities

Use shared finding structure. Apply priorities to skill-domain impact:

- `🔴 High`: likely to break discovery or routing, weaken approval or safety, leave broken references, or make migration incomplete.
- `🟡 Medium`: likely to create unclear responsibility, maintenance problems, validation gaps, or ineffective progressive disclosure.
- `🟢 Low`: wording, organization, naming, consistency, or low-risk polish.

Use status for non-problem notes such as `✅ Pass`, `🟢 Optional polish`, or `⛔ Declined` when useful. Present findings in source or application order when that makes changes easier to review.

## Good Decisions

Preserve concrete behavior that prevents regression, including:

- focused routing descriptions;
- clear adjacent-skill handoffs;
- safety and approval rules in the core;
- justified progressive disclosure;
- domain criteria that remain outside shared mechanics;
- deterministic read-only validation; and
- project-local precedence.

Do not repeat pass findings as generic praise.

## Decision-Record Signal

For every skill task, state whether a decision record is recommended and why. Use `decision-record` for substantive worthiness checks and all persistent record work.

In a formal Audit, keep this signal preliminary. If the outcome is `proposal required`, confirm the final outcome and exact path in the proposal. Do not create a proposal merely to repeat a `no change`, `research`, or `defer` signal.

## Tracked Skill Changes

Use `audit-workflow` for lifecycle mechanics. Skill Creator adds these domain gates:

1. Save the selected Audit before a tracked proposal.
2. Let the user review and correct it.
3. Record one Skill Creator outcome.
4. If the outcome is `proposal required`, use the shared proposal template and add exact skill-resource scope, migration, validation, and decision-record context.
5. Run the Skill Creator proposal preflight from `skill-validation.md`.
6. Keep implementation separate from proposal approval.

## Final Domain Checks

Before presenting or saving the assessment, confirm:

- the selected mode matches the requested and required scope;
- domain criteria came from Skill Creator rather than the shared artifact workflow;
- full Skill Audit evaluated every owned resource and missing capability;
- Usage Report Audit evaluated all selected reports and materially related resources with explicit exclusions;
- broad or uncertain report effects triggered escalation;
- shared templates and lifecycle rules were applied without local duplication;
- recommendations did not become implementation approval;
- decision-record need and reason are visible; and
- runtime, renderer, source, or validation checks not performed are stated.
