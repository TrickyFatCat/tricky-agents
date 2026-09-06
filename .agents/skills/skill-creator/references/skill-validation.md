# Skill Validation

Read this reference when reviewing, completing, migrating, or renaming a skill.

Validation confirms that the current or implemented skill satisfies its selected design, approved decisions, and active technical, safety, and authority requirements. It covers discovery, content, outcomes, references, dependencies, formatting, and repository scope; Markdown checks alone do not prove correct routing or behavior.

## Design Conformance

Skill Creator's Create, Review, or Audit mode selects or reconsiders the design. Validation checks that the implementation matches it without repeating the initial capability-worthiness assessment.

If design evidence is absent, contradictory, unsafe, outdated, or invalidated by a failed outcome check, report the failed assumption and return it to design or assessment. Do not silently redesign, broaden approval, or declare completion. Escalate broad or uncertain effects to full Skill Audit; a small design question need not become a formal Audit.

Approval is not proof of correctness and cannot override stronger rules. Preserve safety, content, outcome, and regression checks even when the implementation literally matches an approved design.

## Pre-Change Inventory

Before editing:

- resolve the skill location and repository root;
- inspect repository status;
- read the complete core and relevant references;
- list scripts, assets, and nested resources;
- use `scripts/skill-audit.nu` for bounded inventory or links when useful;
- search for names, paths, titles, commands, and aliases; and
- separate active dependencies from historical records.

Do not scan sensitive or unrelated directories without permission.

## Frontmatter Checks

Confirm:

- `SKILL.md` begins with valid YAML frontmatter;
- `name` and `description` are present and non-empty;
- the name uses 1–64 lowercase letters, digits, or hyphens;
- the name has no leading, trailing, or consecutive hyphens;
- the name matches the directory;
- the description is at most 1024 characters, uses imperative phrasing by default, and states capability plus activation context;
- optional fields are supported and necessary; and
- `disable-model-invocation: true` remains intact for explicit-only skills.

Malformed frontmatter or a missing description can prevent discovery.

## Routing Checks

Ask:

- Does the description activate for intended requests and avoid unrelated ones?
- Can one matching request and one near-miss boundary request test substantial routing changes?
- Are material ownership overlaps resolved through explicit handoffs?
- Does every named handoff change ownership, required workflow, approval or safety behavior, necessary context transfer, or a stopping condition?
- Are `audit-workflow` and `decision-record` loaded only when their artifact mechanics are relevant?
- Does the skill avoid generic helper-skill catalogs and repeated global or local routing rules?
- Can any handoff be removed without losing an ownership, safety, approval, context-transfer, or stopping boundary?
- Does the skill distinguish assessment, research, planning, approval, and implementation?
- Do all named skills exist in the configured registry?
- Are renamed or removed resources absent from active routing dependencies?

Search configured skill locations instead of assuming dependencies exist.

## Core and Reference Checks

Confirm:

- the core contains always-needed purpose, workflow, approval, safety, and material routing boundaries without requiring a dedicated routing section;
- the core remains under 500 lines by default or has an explained exception;
- optional detail is moved to references;
- every reference exists and has a clear loading condition;
- relative paths resolve;
- references do not contradict the core or project instructions;
- critical rules are not available only in optional references; and
- shared mechanics are referenced rather than copied without a boundary reason.

A shorter core is not automatically better. Always-loaded correctness is the criterion.

## Shared Artifact Checks

Use `audit-workflow` to validate generic Review, Audit, proposal, lifecycle, persistence, metadata, TOC, section ownership, and base-template mechanics.

Use `decision-record` to validate record worthiness, content, status, storage, supersession, traceability, and record links.

Skill Creator validates the domain additions:

- Skill Audits include the required resource and capability evaluation.
- Usage Report Audits assess every selected report and materially related resource, list exclusions, and escalate broad or uncertain effects.
- Skill proposals expose exact global-resource scope, artifact roles, naming, handoffs, migration effects, validation, and the decision-record outcome when the core's trigger applies.
- Project-local conventions override shared defaults.
- Shared guidance loads only when the request enters the relevant mode.

## Target-Skill Audit and Review Capability

When the selected design includes domain assessment, confirm:

- implemented Review/Audit triggers match the selected runtime responsibility;
- the implementation supplies the design's domain evidence, criteria, and judgment;
- Review and Audit remain proportional and distinct under `audit-workflow`;
- assessment cannot silently become proposal or implementation;
- project-local persistence and lifecycle rules remain authoritative;
- shared templates are used directly by default; and
- any target-owned template matches the selected distinct output contract and its supporting evidence.

Use [audit-review-capability.md](audit-review-capability.md) if design reassessment is needed; follow its conditional architecture-loading route.

## Target-Skill Proposal Capability

When the selected design includes domain proposals, confirm:

- implemented proposal triggers match the selected runtime responsibility;
- the target supplies the design's domain decisions, evidence, and validation additions rather than copying shared mechanics;
- advice, Review, proposal, approval, and implementation remain distinct;
- proposals cannot approve themselves or expand implementation scope;
- project-local storage and lifecycle rules remain authoritative; and
- any target-owned template matches the selected output contract rather than copying a shared or Skill Creator asset.

Use [proposal-capability.md](proposal-capability.md) if design reassessment is needed; follow its conditional architecture-loading route.

## Decision-Record Handoff

Do not add target-owned decision-record mechanics or templates by default. Confirm the skill hands relevant domain context to `decision-record`, including:

- the decision question or confirmed outcome;
- evidence, constraints, and alternatives;
- consequences and compatibility effects;
- owner authority; and
- source tasks, reports, Audits, proposals, or related decisions.

Apply the core's [Decision-Record Trigger](../SKILL.md#decision-record-trigger). When it applies, verify that the outcome and reason are reported and any recommended record is included in approved exact-file scope. Routine work without a broader decision does not need a `not recommended` announcement. Use the shared owner for substantive assessment and all persistent record work.

## Content Review

Review in source order when practical. Prioritize behavior-changing findings.

Check for:

- mandatory preambles that add no value;
- long paragraphs or ungrouped lists that hide action;
- descriptions that explain benefits rather than routing;
- repeated rationale or generic motivational prose;
- fixed response structures that do not scale down;
- undefined status, confidence, priority, or severity labels;
- workflows without stopping criteria;
- recommendations presented as decisions;
- missing approval, safety, handoff, rollback, or validation rules;
- contradictions with shared skills or active instructions;
- stale names, paths, examples, dates, or unavailable skills; and
- generic guidance where concrete task or report evidence exists.

Preserve useful decisions and explain material trade-offs.

## Skill Audit Checks

For a full Skill Audit, confirm:

- every owned reference is evaluated for need, quality, and writing;
- every owned template is evaluated for need and quality;
- missing recurring template capability is assessed;
- scripts are inspected and tested only with approval;
- directly linked shared dependencies are included only when behaviorally relevant; and
- unrelated global resources are excluded.

For a Usage Report Audit, confirm:

- every selected report has an evidence-backed judgment and next lifecycle state;
- every materially related resource is assessed;
- unrelated owned resources are explicitly excluded;
- broad routing, safety, responsibility, architecture, migration, or uncertain interaction triggers escalation; and
- lifecycle-only correction uses lightweight triage when no behavior change is proposed.

Use [audit-format.md](audit-format.md) for Skill Creator domain criteria and `audit-workflow` for shared output mechanics.

## Proposal Preflight

Before asking the user to approve a tracked skill proposal:

1. Account for every exact file and action.
2. Give each material decision one primary review location.
3. Include current and proposed wording when exact text affects approval.
4. Include reusable structures only when shape affects approval.
5. Preserve defaults, precedence, paths, roles, naming, boundaries, migration, compatibility, safety, validation, lifecycle, and authority when they change the decision.
6. For every exact block, identify the approval decision it can change; remove or summarize blocks that cannot change one.
7. Link accepted evidence instead of repeating it.

Do not require a human-facing coverage grid or use artifact length as a pass/fail rule.

## Script and Asset Checks

For scripts:

- read before execution;
- verify inputs, outputs, dependencies, side effects, and errors;
- prefer help, check, or dry-run paths;
- inspect portability and relative-path assumptions; and
- use `code-reviewer` for implementation quality.

For assets:

- confirm every asset is intentionally referenced;
- ensure generated output cannot overwrite the source asset;
- reject private paths, credentials, or project-specific secrets;
- require adaptation and omission guidance;
- use semantic filenames; and
- avoid local copies of shared templates without distinct recurring need.

## Rename and Migration Checks

Treat a rename as a migration. Confirm approved scope covers:

1. old and new directories;
2. frontmatter name and visible title;
3. relative links and routing mentions;
4. prompts, instructions, and documentation;
5. active tasks and inventories;
6. commands, scripts, aliases, or settings;
7. approved historical updates; and
8. alias retention or removal.

Search for stale variants after migration. Do not rewrite historical wording without approval.

## Formatting and Static Validation

Format changed Markdown with the intended project formatter. Then check:

- trailing whitespace and conflict markers;
- broken relative references;
- frontmatter and directory agreement;
- unexpected machine-specific paths;
- missing scripts or assets;
- stale active links to deleted resources; and
- exact approved Git scope.

For Git-backed repositories, inspect `status`, `diff --check`, and exact-path diffs. Untracked files need direct inspection or exact-path staging only after commit approval.

## Runtime Discovery

When appropriate, start a fresh session or skill scan and confirm:

- no startup warnings or collisions;
- the skill appears under the expected name;
- explicit invocation works when supported; and
- matching and near-miss requests route correctly.

Do not claim runtime testing when only files were inspected. Report trial or execution-trace limitations.

## Final Report

Report:

- files created, modified, moved, or deleted;
- routing and behavior changes;
- dependencies and records updated;
- formatting and validation performed;
- scripts, runtime discovery, renderer behavior, or trials not tested;
- remaining repository changes; and
- commit hash only when a commit was requested.
