# Skill Creator Template Foundation

Status: Accepted
Date: 2026-08-27

## Context

The skill tooling refactor uses `skill-creator` as the foundation for later global skill updates. The user identified that documentation, reports, stdout formats, and repeated artifact structures should move into templates where appropriate. The user also reported that generic filenames such as `README.md` reduce artifact discoverability when the file is not a real directory overview.

Agent Skills guidance supports focused skill directories with `SKILL.md`, optional `references/`, optional `scripts/`, and `assets/` for templates or static resources. It also emphasizes progressive disclosure, concrete output templates, concise script output, grounding skills in real expertise, context economy, calibrated control, and refinement from real usage.

## Decision

Add a template foundation to `skill-creator`:

- keep `SKILL.md` focused on routing, approval, safety, workflow, and validation;
- keep detailed methods in `references/`;
- add reusable templates under `assets/` for skill cores, references, change proposals, skill review reports, script output contracts, and decision records;
- make mandatory frontmatter constraints visible in templates and validation guidance;
- ground proposals in source material such as user corrections, usage reports, project artifacts, and execution traces;
- use semantic filenames that state artifact subject and type;
- reserve `README.md` for true directory or package overviews unless an external format requires it and the exception is approved;
- keep `skill-reviewer` as `skill-creator` Review mode for now instead of creating a separate skill;
- strengthen the foundation with explicit default guidance to keep the main `SKILL.md` under 500 lines, optimize frontmatter descriptions for routing, and prefer action-first, short-paragraph writing in templates and reviews.

## Reasons

- Templates make repeated output contracts visible and easier to apply consistently.
- Wording-change proposals are easier to review when they show old wording before new wording for exact replacements.
- Reusable output-pattern proposals are easier to review when they include compact examples and avoid known hard-to-read patterns.
- Source-material prompts reduce generic skill generation and preserve user corrections.
- Assets load only when needed, preserving progressive disclosure.
- Semantic filenames improve search, quick-open results, and review clarity.
- Keeping review behavior inside `skill-creator` avoids premature skill splitting while review volume is still limited.
- The foundation supports later refactors without creating broad shared tooling first.
- The added line-count and description checks make future skill reviews faster, but they remain heuristics rather than automatic permission to edit or reject a skill.

## Consequences

- `skill-creator` gains more files, but the always-loaded core can stay focused.
- Future skill proposals should include source material, artifact role, and naming rationale, not only paths.
- Review/report and script/stdout formats become easier to reuse and validate.
- Templates may become too rigid if agents fill every section mechanically, so each template must say to adapt and omit irrelevant sections.
- A separate `skill-reviewer` can be reconsidered later if review work develops a distinct lifecycle or routing need.

## Alternatives

- Keep all formats as prose in references. Rejected because concrete templates are easier for agents to follow and users to review.
- Create a separate `skill-reviewer` now. Rejected because current Review mode is adequate and splitting would add routing overhead.
- Put templates in global references immediately. Rejected because the first foundation should prove itself in `skill-creator` before cross-skill generalization.
- Use `README.md` as generic package entry files. Rejected as a default because it weakens filename-based discoverability for non-overview artifacts.

## Related Changes

- `.agents/skills/skill-creator/SKILL.md`
- `.agents/skills/skill-creator/references/skill-design.md`
- `.agents/skills/skill-creator/references/skill-validation.md`
- `.agents/skills/skill-creator/references/review-format.md`
- `.agents/skills/skill-creator/references/decision-records.md`
- `.agents/skills/skill-creator/assets/skill-core-template.md`
- `.agents/skills/skill-creator/assets/skill-reference-template.md`
- `.agents/skills/skill-creator/assets/skill-change-proposal-template.md`
- `.agents/skills/skill-creator/assets/skill-review-report-template.md`
- `.agents/skills/skill-creator/assets/script-output-contract-template.md`
- `.agents/skills/skill-creator/assets/decision-record-template.md`
- `.agents/skills/skill-creator/scripts/skill-audit.nu`
