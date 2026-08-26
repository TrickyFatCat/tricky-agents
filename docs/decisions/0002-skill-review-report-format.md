# Skill Review Report Format

Status: Accepted
Date: 2026-08-26

## Context

Skill reviews required priority, evidence, impact, and direction but did not define their placement. Reports could append priority to long finding headings, introduce inconsistent subsections, and make risks difficult to scan.

The code and documentation reviewers already provided more consistent report conventions.

## Decision

Skill reviews will use:

- Concise numbered finding headings without priority or status in the title.
- A separate `Priority` line.
- A concise problem-and-evidence paragraph immediately after priority, without a default `What` or `Evidence` label.
- A brief `Why it matters` section covering impact, failure modes, and potential risks.
- A focused `Direction` section.
- Defined High, Medium, and Low priorities plus Accepted and Declined statuses.
- No more than five high-value findings by default, presented in source order when practical.
- A maximum three-bullet Overview for reviews with three or more findings.
- Good Decisions, Questions, and Update Scope only when they add value.

Detailed formatting lives in a reference so the core skill remains concise.

## Reasons

A concrete format improves consistency and scanability while still scaling down for small reviews. Keeping the detailed protocol in a reference follows the skill's progressive-disclosure principles.

## Consequences

- Skill reviews align with other reviewer styles without sharing one coupled implementation.
- Evidence remains visible without adding unnecessary subsection labels.
- Risks receive an explicit place in every substantial finding.
- Review mode loads one additional reference.
- Small reviews must omit unnecessary structure rather than fill the template mechanically.

## Alternatives

- Keep the existing flexible instructions in `SKILL.md`. Rejected because they allowed inconsistent report layouts.
- Copy the code-reviewer format exactly. Rejected because skill reviews do not always need `What`, `When this shows up`, or `Look into` sections.
- Create one shared format for every reviewer. Rejected to avoid cross-skill coupling and preserve domain-specific impact language.

## Related Changes

- Commit `2834082` — added the skill review format and routed Review mode to it.
- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/review-format.md`
