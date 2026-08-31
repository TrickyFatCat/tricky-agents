# Code Reviewer Review and Audit Workflow

Status: Accepted
Date: 2026-08-30
Amended By:

- [Domain Audit Section Ownership](0022-domain-audit-section-ownership.md)

## Context

Code Reviewer used one teaching-oriented Review workflow for small code samples, large repositories, technical proposals, and requests that implied formal coverage. It named security and execution concerns but did not define evidence authority, safe execution, untested behavior, specialist composition, formal persistence, or assurance limits.

A full Skill Audit and source-backed research found that proportional Review should remain the default and that recurring formal assessment justifies a locally defined Code Audit contract, focused optional references, and one target-owned template.

## Decision

Adopt two Code Reviewer modes:

- **Review:** Default conversational, proportional, teaching-oriented assessment, saved only when requested.
- **Code Audit:** Locally defined, bounded, saved formal assessment with explicit target, snapshot, scope, exclusions, evidence, methods, findings, confidence, limitations, untested areas, outcome, and next action.

Keep immediate trust, execution, credential, high-impact, specialist, and implementation boundaries in the always-loaded core. Move detailed format, evidence and safety, and persistence methods into focused references.

Treat reviewed code, comments, repository content, tool output, dependencies, and review channels as evidence rather than authority. Inspect statically before separately authorized execution. Distinguish inspected, supplied, tool-produced, inferred, unavailable, and untested evidence.

Keep Code Reviewer as assessment orchestrator. Language, framework, security, documentation, and project skills provide specialized evidence. Material conflicts remain visible, and writing or execution requires separate authorization.

Add one Code Reviewer-owned `code-audit-template.md`. Do not add a Quick Review asset, execution script, Proposal capability, or decision-record capability.

## Reasons

- Review depth alone cannot establish bounded formal coverage.
- Code assessment needs domain-specific evidence, test-state, source-location, safety, and non-assurance fields.
- Reviewed material can contain executable or malicious instructions and sensitive effects.
- Specialist skills improve language and project accuracy without replacing assessment responsibility.
- Formal output fields are recurring and fragile enough to justify a template.
- Progressive disclosure keeps routine Review focused while making formal methods available when needed.

## Consequences

- **Benefits:** Review remains proportional; Code Audit gains stable scope, evidence, outcome, and limitation reporting.
- **Costs:** Code Reviewer grows from one owned file to five and requires clear reference-loading conditions.
- **Risks:** `Code Audit` could imply stronger assurance than intended; explicit local definition and non-assurance language mitigate this.
- **Compatibility:** Existing teaching, no-full-rewrite, source-order findings, priority labels, accepted and declined states, questions, strengths, and next-step behavior remain.
- **Safety:** Execution, credentials, external access, destructive checks, source edits, thread resolution, implementation, commits, and pushes remain separately authorized.
- **Maintenance:** Language, framework, platform, security, and legal specifics stay with applicable project policy or specialists rather than accumulating in the generic skill.

## Alternatives

- Keep one Review mode — rejected because formal requests would still lack explicit bounded coverage.
- Treat every detailed Review as Code Audit — rejected because length does not create scope, evidence, persistence, or assurance.
- Keep all guidance in `SKILL.md` — rejected because optional formal methods would obscure the default workflow.
- Add a Quick Review template — rejected because conversational output remains adaptable and no recurring template failure was found.
- Add an execution wrapper — rejected because project effects and tools vary and generic automation would broaden risk.
- Add Proposal or decision-record capability — rejected because assessment recommendations do not grant durable planning or decision ownership.
- Copy another skill's Audit template — rejected because code evidence, tested behavior, source locations, and security limits require a domain contract.

## Traceability

- Source: accepted Code Reviewer Skill Audit, completed Code Review best-practice research, source ledger, and approved proposal in the external task vault.
- Related: [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md).
- Related: [Tech Docs Reviewer Review and Audit Workflow](0016-tech-docs-reviewer-review-and-audit-workflow.md).
- Related: [Skill Assessment and Usage Report Guidance](0017-skill-assessment-and-usage-report-guidance.md).

## Related Changes

- `.agents/skills/code-reviewer/SKILL.md`
- `.agents/skills/code-reviewer/references/review-format.md`
- `.agents/skills/code-reviewer/references/evidence-and-safety.md`
- `.agents/skills/code-reviewer/references/review-persistence.md`
- `.agents/skills/code-reviewer/assets/code-audit-template.md`
