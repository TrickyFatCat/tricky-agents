# Skill Artifact Assessment and Proposal Guidance

Status: Accepted
Date: 2026-08-30
Amends:

- [Skill Creator Template Foundation](0008-skill-creator-template-foundation.md)
- [Global Artifact Naming and Path Presentation](0009-global-artifact-naming-and-path-presentation.md)
- [Skill Audit and Proposal Workflow](0012-skill-audit-and-proposal-workflow.md)

Related: [Skill Proposal Artifact Name Order](0013-skill-proposal-artifact-name-order.md)

## Context

Formal Skill Creator Audits could inventory owned references and templates without evaluating their need, quality, writing, or missing recurring template capability. The proposal template preserved exact scope but used dense opening sections, separated evidence from actions poorly, and flattened action discovery.

Target skills also lacked reusable guidance for deciding whether domain-specific Audit/Review or Proposal capability belongs in normal runtime behavior. Rename and move proposals exposed full paths but could hide the changed basename or parent directory.

## Decision

Refine Skill Creator's artifact guidance:

- Evaluate every skill-owned reference in a substantial formal Audit for need, quality, and writing.
- Evaluate every skill-owned template for need and quality, including whether missing recurring template capability is justified.
- Include behaviorally relevant shared dependencies and exclude unrelated global resources.
- Structure substantial proposals around Proposal Snapshot, Overview, Reasoning, Recommended Approach, optional Rejected Alternatives, one linked Actions section, Source Material, scope, validation, and one Decision Record section.
- Keep human-facing orientation concise and place exact wording, paths, examples, and migrations under their relevant actions.
- Add separate optional references for target-skill Audit/Review capability and Proposal capability.
- Keep concrete output templates with the target skill and create them only when recurring or fragile output justifies one.
- Do not add universal Audit/Review or Proposal output assets.
- For human-facing rename or move proposals, compare changed components old before new and end with the resulting full path.
- Apply the rename/move pattern to files and directories while keeping routine in-place modifications concise.

Preserve the tracked `proposed → approved → implemented` lifecycle and the role + action + subject proposal naming rule.

## Reasons

- Resource inventory does not prove that optional resources are necessary, complete, well written, or missing.
- Concise orientation and linked actions make exact proposals easier to review without removing agent-facing precision.
- Separate capability references let a target skill own one responsibility without inheriting the other.
- Target-owned templates preserve domain context and project-local overrides.
- Component-based path presentation makes rename and move effects visible before approval.
- Amending accepted decisions preserves chronology and still exposes the active contract.

## Consequences

- Substantial formal Audits require explicit resource evaluation.
- Skill Creator gains two conditionally loaded capability references.
- The proposal template becomes easier to scan but retains exact-file, approval, lifecycle, and validation gates.
- Global instructions, Agents Maintainer, Skill Creator, and Task Manager share one rename/move presentation default.
- Target-skill proposals must justify capability and template ownership instead of copying generic assets.
- Fresh-session routing and target-skill runtime behavior still require later trial evidence.

## Alternatives

- Keep resource evaluation implicit. Rejected because link and inventory checks do not assess design quality.
- Keep the prior proposal hierarchy. Rejected because dense orientation and flat actions obscure approval scope.
- Add universal Audit/Review and Proposal assets. Rejected because domain output contracts differ.
- Combine both capabilities into one reference. Rejected because a skill may need one without the other.
- Update only Skill Creator's rename wording. Rejected because the same approval behavior spans global instructions and three skills.
- Supersede earlier decisions. Rejected because decisions `0008`, `0009`, and `0012` remain valid outside these amendments.

## Related Changes

- `.agents/AGENTS.md`
- `.agents/skills/agents-maintainer/SKILL.md`
- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/skill-design.md`
- `.agents/skills/skill-creator/references/skill-validation.md`
- `.agents/skills/skill-creator/references/audit-format.md`
- `.agents/skills/skill-creator/references/audit-review-capability.md`
- `.agents/skills/skill-creator/references/proposal-capability.md`
- `.agents/skills/skill-creator/assets/skill-audit-report-template.md`
- `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- `.agents/skills/task-manager/references/saved-task-workflow.md`
- [Decision 0008](0008-skill-creator-template-foundation.md)
- [Decision 0009](0009-global-artifact-naming-and-path-presentation.md)
- [Decision 0012](0012-skill-audit-and-proposal-workflow.md)

## Related Reports

- `linked-vaults/reports-vault/skill-usage/reports/global/skill-creator/2026/2026-08-29-162542-audits-omit-skill-owned-resource-evaluation.md`
- `linked-vaults/reports-vault/skill-usage/reports/global/skill-creator/2026/2026-08-30-085628-proposal-structure-obscures-actions.md`
- `linked-vaults/reports-vault/skill-usage/reports/global/task-manager/2026/2026-08-30-075736-rename-move-path-changes-hard-to-scan.md`
