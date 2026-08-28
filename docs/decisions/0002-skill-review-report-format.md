# Skill Review Report Format

Status: Accepted
Date: 2026-08-26

## Context

Skill reviews required priority, evidence, impact, and direction but did not define their placement. Reports could append priority to long finding headings, introduce inconsistent subsections, and make risks difficult to scan.

The code and documentation reviewers already provided more consistent report conventions.

## Decision

Skill reviews will use:

- Short numbered finding headings that do not include priority, status, evidence, or proposed fixes.
- A separate `Priority` or `Status` line under each finding heading.
- A `Findings Overview` with links and labels for reviews with three or more findings.
- Separate `Evidence` and `Recommended action` blocks when a finding needs both.
- A brief `Why it matters` section for impact, failure modes, and potential risks when it adds value.
- Defined High, Medium, and Low priorities plus Pass, Optional polish, and Declined statuses.
- No more than five high-value findings by default, presented in source order when practical.
- Good Decisions, Questions, and Update Scope only when they add value.

Detailed formatting lives in a reference so the core skill remains concise.

## Reasons

A concrete format improves consistency and scanability while still scaling down for small reviews. Keeping the detailed protocol in a reference follows the skill's progressive-disclosure principles.

## Consequences

- Skill reviews align with other reviewer styles without sharing one coupled implementation.
- Evidence and recommended actions are easier to scan because they use separate blocks.
- Status and priority are easier to scan because they are not embedded in finding titles.
- Risks receive an explicit place in every substantial finding.
- Review mode loads one additional reference.
- Small reviews must omit unnecessary structure rather than fill the template mechanically.

## Alternatives

- Keep the existing flexible instructions in `SKILL.md`. Rejected because they allowed inconsistent report layouts.
- Copy the code-reviewer format exactly. Rejected because skill reviews do not always need `What`, `When this shows up`, or `Look into` sections.
- Create one shared format for every reviewer. Rejected to avoid cross-skill coupling and preserve domain-specific impact language.

## Related Changes

- Commit `2834082` — added the skill review format and routed Review mode to it.
- Current refinement — uses overview links, short headings, separate labels, and evidence/action blocks.
- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/review-format.md`
- `.agents/skills/skill-creator/assets/skill-review-report-template.md`
