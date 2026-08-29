# Decision Record Capability Design

Read this reference when designing or reviewing a target skill that may create, update, review, link, supersede, or validate decision records during normal use.

Do not read this reference merely because the current skill change may need its own repository decision record. Use [decision-records.md](decision-records.md) for records documenting skill changes.

## Capability Test

Add decision-record capability to a target skill only when all applicable conditions are met:

- Creating or managing durable decisions belongs to the skill's primary domain or a clear supporting responsibility.
- The behavior is likely to recur across real tasks.
- A short handoff to another skill would be less clear or would lose domain-specific context.
- The target skill can define storage, approval, status, linking, and validation without weakening project rules.
- The capability does not force decision-record instructions into ordinary requests that do not need persistent records.

Do not add the capability merely because:

- the skill itself has a repository decision record;
- the skill discusses options or recommendations;
- another skill already owns persistent task or document management;
- one project used an ADR once;
- a generic template could be copied into the skill.

## Responsibility Boundary

Define which operations the target skill owns:

- evaluate whether a domain decision is durable enough to record;
- draft or review a record;
- create or update an approved persistent artifact;
- link source tasks, research, reports, issues, changes, or superseding records;
- manage lifecycle status;
- validate the record and its local relationships.

Do not assign every operation automatically. Keep exploration, research, approval, persistence, implementation, and repository maintenance with their responsible workflows.

## Decision Types

Use types as classification aids, not automatic template or directory splits:

- `architecture`: system structure, interfaces, deployment boundaries, or architecturally significant requirements;
- `design`: APIs, data models, user experience, skill structure, or durable artifact design below the architecture level;
- `documentation`: audience, source of truth, information architecture, publication, generation, or maintenance;
- `workflow`: lifecycle, approvals, handoffs, validation, or operating process;
- `safety-security`: trust, permissions, sensitive data, containment, or security controls;
- `migration-compatibility`: transitions, deprecations, compatibility, or rollback behavior;
- `tooling-technology`: tools, libraries, platforms, or implementation technology choices;
- `governance-policy`: ownership, authority, standards, or durable policy;
- `other`: a project-defined type when none of the above fits.

Choose a primary type by the decision's main consequence. Allow local vocabularies. Do not assume one meaning for ambiguous acronyms such as `DDR`.

Do not require a type field when the repository contains one obvious kind of record or does not use classification metadata.

## Record Content Contract

Require these concepts in a normal record:

- title;
- status;
- date;
- context;
- decision;
- rationale or reasons;
- consequences.

Add these only when they preserve useful information:

- decision type;
- decision drivers;
- considered options or alternatives;
- assumptions;
- constraints;
- deciders or owner;
- source task, report, research, or issue;
- related decisions;
- related changes and commits;
- supersedes or superseded-by link;
- review date, outcome notes, or follow-up evidence.

Include alternatives when several viable choices existed or a rejected option is likely to recur. Do not require empty sections.

Section names may follow local conventions when they preserve the same meaning.

## Statuses and Fields

Follow the target repository or vault vocabulary first. Otherwise use:

- `Proposed`: under review and not adopted.
- `Accepted`: chosen and active.
- `Rejected`: considered but not selected.
- `Superseded`: replaced by another record.
- `Deprecated`: no longer recommended without one direct replacement.

Do not mark an agent recommendation accepted without user confirmation or implementation evidence.

Fallback required fields:

```text
Status: <status>
Date: YYYY-MM-DD
```

Optional fields:

```text
Type: <decision-type>
Deciders: <people or roles>
Source: <task, report, research, or issue>
Supersedes: <record>
Superseded By: <record>
Review Date: YYYY-MM-DD
```

Use local YAML or body-field syntax. Do not require migration solely to normalize metadata.

## Project Storage

Follow the active repository, project, or vault convention first.

When a project repository has no convention, propose:

```text
project/
└── docs/
    └── decisions/
        ├── 0001-<decision-slug>.md
        └── 0002-<decision-slug>.md
```

Use `docs/adr/` only when the project intentionally stores architecture-only ADRs.

Do not create one directory per decision type by default. Use metadata or titles until record volume proves that separate directories improve discovery.

Do not create an index unless the project already uses one or the user approves it.

For external vaults or user-provided destinations, follow active storage, naming, metadata, linking, approval, and validation rules. Do not copy one project's vault convention into a portable skill.

## Template Ownership

Keep concrete output templates with the skill that repeatedly produces them.

When a target skill needs a template:

- place it under that skill's `assets/` directory;
- use a semantic filename that identifies the decision domain or output role;
- include the accepted mandatory concepts;
- mark optional fields and sections clearly;
- tell agents to omit empty optional scaffolding;
- preserve project-local overrides.

Do not reuse `skill-creator/assets/decision-record-template.md` as a target-skill output template. That asset is reserved for repository records documenting skill changes.

Do not create a target-skill template when the skill only evaluates, reviews, or hands off decisions without repeatedly drafting records.

## Per-Skill Proposal Requirements

When proposing decision-record capability for a target skill, include:

1. The exact runtime responsibility and trigger.
2. Why the capability belongs in this skill instead of a handoff.
3. Supported decision types and operations.
4. Mandatory and optional record concepts.
5. Status and metadata behavior.
6. Storage priority and fallback layout.
7. Approval and lifecycle boundaries.
8. Template ownership, when applicable.
9. Links to source tasks, research, reports, and existing conventions.
10. Validation and anything that remains project-specific.

Use old-before-new wording blocks for modified skill instructions. Include exact paths, artifact roles, naming rules, and reserved-name exceptions for new or reorganized files.

## Validation

Confirm that:

- the target skill's normal-use responsibility genuinely includes decision records;
- unrelated requests do not load or apply the capability;
- exploration and recommendations do not become accepted decisions automatically;
- project-local storage and approval rules remain authoritative;
- statuses, fields, links, supersession behavior, and template ownership are internally consistent;
- any relative links and template paths resolve;
- no generic template is copied into unrelated skills;
- the proposal includes only approved files and reports runtime behavior not tested.
