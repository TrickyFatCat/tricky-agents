# Researcher Evidence and Artifact Workflow

Status: Accepted
Date: 2026-08-31

## Context

Researcher used one evidence workflow and persistent-by-default package contract for quick factual checks, substantial investigations, and decisions requiring different levels of rigor. The workflow preferred a linked research vault, required `README.md`, and did not fully define AI-generated evidence, human-facing section ownership, continuation checks, or two-way composition with Rubber Duck.

A full Skill Audit, source-backed research, usage reports, and proposal review found that research depth and persistence should be proportional. Exact template review also established project-first storage, role-first semantic files, mandatory navigation, and a prospective compatibility boundary for existing packages.

## Decision

Adopt four Researcher shapes:

- **Quick evaluation:** Smallest sufficient inspected source set; conversational by default.
- **Focused research:** Bounded comparison with visible evidence and limitations; saved only when requested or required.
- **Substantial research:** Explicit questions, stopping criteria, claim mapping, and optional source ledger; resolve an approved destination before writing.
- **Systematic or regulated research:** Applicable domain methods or specialists only when explicitly required; no unsupported compliance claim.

Treat AI-generated claims, quotations, summaries, citations, and confidence as unverified leads. Verify citation identity separately from claim support. Record material AI assistance and human checks for substantial work without retaining private prompts, credentials, or sensitive context unnecessarily. Human judgment retains authority for interpretation, recommendations, and consequential decisions.

Replace vault-first persistence with project-first optional persistence. Use an explicit destination, then active project conventions, then an existing project-root `researches/`. Ask when no destination exists; use the nearest applicable `researches/` fallback only for an ambiguous answer and after required approval.

When no stronger project convention exists, use:

```text
researches/<research-slug>/
├── research-<research-slug>.md
└── source-ledger-<research-slug>.md  # when justified
```

Keep immutable identity separate from title, slug, directory, and filename. Check question, scope, criteria, expected conclusion, and identity before creating a new artifact.

Add adaptable Researcher-owned templates for the human-facing artifact and source ledger. The main artifact owns conclusion, evidence synthesis, recommendations, method, limitations, and concise sources. The ledger owns source-level detail. Every saved research artifact requires compatible table-of-contents navigation; ledgers require it above two source entries.

Route to Rubber Duck before research when the decision frame is exploratory and back after research when evidence is sufficient but preference trade-offs remain. Researcher retains evidence authority; Rubber Duck retains exploratory decision-support authority. Recommendations do not become adopted decisions or implementation authority.

Apply this contract prospectively. Existing research packages, `README.md` artifacts, source files, directory layouts, and immutable IDs remain valid and are not migrated automatically.

## Reasons

- Proportional modes avoid imposing substantial-research ceremony on quick questions.
- AI-generated references and summaries require explicit verification and disclosure boundaries.
- Project authority should determine storage before a global vault or output fallback.
- Role-first filenames expose artifact purpose while immutable IDs preserve continuity.
- Section ownership and navigation improve reviewability without duplicating conclusions.
- Two-way Rubber Duck composition separates external evidence from preference-based exploration.
- Prospective compatibility avoids unapproved migration of existing user data.

## Consequences

- **Benefits:** Research depth, evidence handling, persistence, and output structure match the task more reliably.
- **Costs:** Agents must select a research shape, check continuation, and apply conditional template and TOC rules.
- **Risks:** Agents may over-apply substantial workflow fields or mistake recommendations for decisions; proportional routing and authority language mitigate this.
- **Compatibility:** Existing packages and IDs remain valid. New fallback artifacts use project-first `researches/` layout and role-first filenames.
- **Safety:** External content and AI output remain evidence rather than authority; sensitive data transmission and persistent writes require applicable authorization.
- **Maintenance:** Researcher owns its two templates and storage contract. Project rules and domain-specific systematic methods remain authoritative.

## Alternatives

- Keep persistence as the default — rejected because it adds unnecessary ceremony to quick and focused work.
- Prefer a linked research vault automatically — rejected because project and explicit user authority should determine destination.
- Keep required `README.md` packages — rejected because individual research artifacts need semantic role-first names; `README.md` remains reserved for genuine overviews.
- Apply systematic-review methods broadly — rejected because rigor and compliance methods depend on explicit domain requirements.
- Move the Pi package research reference — declined; its current Researcher location remains unchanged.
- Migrate existing packages — rejected because automatic migration would change external user data without separate approval.

## Traceability

- Source: accepted Researcher Skill Audit, completed General and AI-Assisted Research Practices research and source ledger, approved seven-file proposal, and related usage reports in the external task and reports vaults.
- Supersedes: [Research Persistence Workflow](0006-research-persistence-workflow.md).
- Related: [Global Artifact Naming and Path Presentation](0009-global-artifact-naming-and-path-presentation.md).
- Related: [Skill Artifact Assessment and Proposal Guidance](0015-skill-artifact-assessment-and-proposal-guidance.md).

## Related Changes

- `.agents/skills/researcher/SKILL.md`
- `.agents/skills/researcher/references/research-method.md`
- `.agents/skills/researcher/references/research-storage.md`
- `.agents/skills/researcher/assets/research-artifact-template.md`
- `.agents/skills/researcher/assets/source-ledger-template.md`
- `docs/decisions/0006-research-persistence-workflow.md`
