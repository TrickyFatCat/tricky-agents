# Tech Docs Reviewer Review and Audit Workflow

Status: Accepted
Date: 2026-08-30

Related:

- [Tech Docs Writer Documentation Architecture](0014-tech-docs-writer-documentation-architecture.md)
- [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md)

## Context

Tech Docs Reviewer used one review workflow for concise chat feedback and detailed saved assessment. Saving, embedding comments, retaining Review Notes, and applying findings were not clearly separated. Formal recurring assessment lacked a target-owned template, while useful reader-friction guidance remained isolated in an optional ADHD-specific reference.

The Reviewer also needed to consume Writer's accepted documentation modes and Markdown conventions without merging review and writing responsibility.

## Decision

Adopt a two-mode Reviewer workflow:

- Quick Review is the default conversational assessment and is saved only when requested.
- Documentation Audit is a formal, bounded assessment with explicit scope, evidence, exclusions, outcome, and untested areas. It is always saved after its destination is resolved.
- Reviewer owns one adaptable Documentation Audit template; Quick Review remains instruction-based without an asset.
- Saved Quick Reviews and Audits share property concepts while project-local metadata, storage, naming, renderer, formatting, and validation rules take precedence.
- Saving an assessment, inserting Writer-owned `REVIEW` markers, retaining Review Notes, and applying accepted recommendations remain separate operations.
- Reviewer may assess a documentation directory, propose a target tree, and describe migration direction without moving or rewriting files by default.
- Writer retains ownership of documentation modes, Markdown conventions, editorial markers, and approved content changes.
- Broadly useful reader-friction guidance applies to ordinary Review and Audit output. Remove the separate `adhd-friendly-review.md` reference after migration.
- Keep the `tech-docs-reviewer` name because Quick Review remains the default responsibility and Audit is one mode.
- Defer MCP-specific guidance until actual project practice, such as a project using Confluence through an authorized MCP tool, provides evidence.

## Reasons

- Distinct modes make scope, evidence, persistence, and outcome claims truthful.
- A target-owned template stabilizes recurring formal output without imposing one project convention.
- Separate operation boundaries prevent assessment approval from becoming edit or migration approval.
- Consuming Writer authority avoids competing documentation and Markdown contracts.
- Applying concrete reader-friction guidance generally is more useful than retaining an opt-in medical framing.
- Directory assessment belongs to documentation review, while file movement and rewriting belong to planning and Writer workflows.

## Consequences

- **Benefits:** Users receive proportional chat feedback by default and a predictable durable Audit when formal coverage matters.
- **Costs:** Reviewer gains one optional reference and one template asset.
- **Risks:** Agents may overclassify detailed Review as Audit or create storage without authority; explicit triggers and destination rules mitigate both.
- **Compatibility:** Existing source-accuracy guidance remains unchanged. Existing saved reviews are not renamed or rewritten.
- **Migration:** Useful `adhd-friendly-review.md` content moves into the normal format and Audit template before the old reference is deleted.
- **Maintenance:** Reviewer must keep its Writer links and shared property vocabulary consistent with project-local precedence.
- **Deferred evidence:** Fresh-session routing, live artifact saving, and project MCP use require later trials.

## Alternatives

- Keep one Review mode — rejected because formal coverage and persistence would remain ambiguous.
- Rename the skill to Auditor — rejected because conversational Review remains the default.
- Merge Reviewer into Writer — rejected because assessment and approved implementation need distinct boundaries.
- Keep the ADHD-specific reference — rejected because its broadly useful guidance should apply to ordinary assessment.
- Add a Quick Review template — rejected because conversational output should scale without rigid scaffolding.
- Add MCP integration now — rejected until real project evidence establishes useful and safe behavior.

## Traceability

- Source: approved `Update Tech Docs Reviewer` Audit and proposal in the external task vault.
- Related decisions: [Decision 0014](0014-tech-docs-writer-documentation-architecture.md) and [Decision 0015](0015-skill-artifact-assessment-and-proposal-guidance.md).
- Decisions `0014` and `0015` remain accepted and unmodified.

## Related Changes

- `.agents/skills/tech-docs-reviewer/SKILL.md`
- `.agents/skills/tech-docs-reviewer/references/review-format.md`
- `.agents/skills/tech-docs-reviewer/references/review-persistence.md`
- `.agents/skills/tech-docs-reviewer/assets/documentation-audit-template.md`
- `.agents/skills/tech-docs-reviewer/references/adhd-friendly-review.md` removed after migration.
