# Maintenance Audit

Use this reference for formal Audits of global agent resources or agents-repository maintenance behavior.

## Shared Workflow

Read [`audit-workflow/references/audit.md`](../../audit-workflow/references/audit.md) for generic Audit structure, lifecycle, persistence, findings, and section ownership. Use its [artifact Audit template](../../audit-workflow/assets/artifact-audit-template.md) when no stronger project convention exists.

Agents Maintainer supplies the maintenance evidence, criteria, risk judgment, recommendations, and repository boundaries below. An Audit does not authorize a proposal or implementation.

## Mode Selection

Use a formal Maintenance Audit when:

- the user requests a formal or saved Audit;
- the user explicitly requests an Audit of project-specific `AGENTS.md` files;
- scope spans multiple resources or uncertain repository boundaries;
- work involves migration, reorganization, deletion, or broad compatibility effects;
- repository authority, approval history, safety, or rollback is unclear;
- cross-skill or runtime interactions may materially change the recommendation; or
- durable evidence is needed before a proposal.

Keep bounded inspection and critique conversational by default. Escalate to research, a specialist, or clarification instead of forcing an Audit when key evidence is unavailable.

## Scope and Evidence

For the approved Audit scope:

- Resolve the user-facing agents path, owning Git repository, target paths, and symlink boundaries.
- For project-specific `AGENTS.md`, resolve the project root and inspect only the context needed for the Audit or proposal.
- Inspect repository status and distinguish approved targets from unrelated changes.
- Read each relevant resource and its active routing, reference, script, template, configuration, or documentation dependencies.
- Check applicable global and project instructions, accepted decisions, proposals, tasks, and usage reports.
- Separate active authority from historical evidence that should not be rewritten.
- Inspect executable, third-party, networked, credentialed, sensitive, or high-impact resources through the shared safety workflow.
- Identify available formatting, link, schema, runtime-discovery, test, rollback, and repository validation.
- Keep credentials, sessions, trust state, generated stores, package state, and unrelated runtime settings excluded unless the user explicitly authorizes them.

Project-specific `AGENTS.md` files outside the agents repository are read-only Audit and proposal targets. Do not modify, move, delete, stage, commit, or push them; hand implementation to the project-local workflow.

Do not recursively inspect unrelated or sensitive directories merely to make the Audit appear comprehensive.

## Maintenance Criteria

Assess only criteria relevant to the bounded scope:

- **Authority and routing:** Triggers, ownership, handoffs, stopping conditions, and explicit-only behavior are clear.
- **Repository containment:** Global-resource implementation paths and symlinks remain inside the approved agents repository; external project `AGENTS.md` targets remain read-only.
- **Approval traceability:** Exact effects, prior approvals, proposal state, and scope changes remain distinguishable.
- **Safety and capability:** Scripts, dependencies, networks, credentials, destructive effects, permissions, persistence, and external resources have appropriate boundaries.
- **Architecture and maintenance:** Always-loaded rules, optional references, duplication, progressive disclosure, and cross-skill dependencies remain coherent.
- **Portability and compatibility:** Paths, names, aliases, migrations, runtime assumptions, and machine-specific details are intentional.
- **Validation and recovery:** Completion evidence, rollback or recovery, exact diffs, and final repository state are adequate for the expected effect.

Preserve behavior that correctly protects authority, safety, portability, or compatibility even when shorter wording is possible.

## Priority and Escalation

Apply shared finding labels with these maintenance meanings:

- `🔴 High`: approval bypass, repository escape, credential exposure, unsafe or destructive behavior, broken routing, incomplete migration, or another issue likely to invalidate the outcome.
- `🟡 Medium`: unclear ownership, duplicated mechanics, weak validation, portability risk, or maintainability problems likely to cause drift.
- `🟢 Low`: wording, organization, naming, or low-risk consistency improvements.
- `✅ Pass`: a correct boundary or decision worth preserving.

Stop and report the blocker when provenance, scope, repository ownership, authorization, or a required safety property cannot be established.

## Outcomes and Handoffs

Use one of these domain outcomes when no stronger project vocabulary exists:

- `no change`: the audited behavior is adequate;
- `research`: decision-changing evidence is missing;
- `defer`: the issue is valid but should not proceed now; or
- `proposal required`: a separate exact-scope proposal should be prepared after Audit review.

Keep ownership explicit:

- Use `audit-workflow` for shared artifact mechanics.
- Use `skill-creator` for skill architecture, routing quality, and skill migration completeness.
- Use `task-manager` for persistent task state.
- Return approved global-resource implementation, repository validation, commits, and pushes to Agents Maintainer.
- Hand proposed project-specific `AGENTS.md` implementation to the project-local workflow.

Do not turn findings or recommendations into edits without the applicable proposal and approval workflow.

## Validation and Limits

Before presenting or saving the Audit:

- verify scope, exclusions, evidence, risk criteria, preserved decisions, and outcome;
- validate local links and artifact formatting when saved;
- state whether runtime discovery, renderer behavior, tests, networks, external sources, or commands were exercised;
- identify unrelated repository changes without opening or modifying them unnecessarily; and
- confirm the Audit does not imply proposal approval or implementation completion.
