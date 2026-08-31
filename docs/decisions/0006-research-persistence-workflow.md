# Research Persistence Workflow

Status: Superseded
Date: 2026-08-26
Superseded by: [Researcher Evidence and Artifact Workflow](0019-researcher-evidence-and-artifact-workflow.md)

## Context

The global `researcher` skill produces evidence-backed answers but did not define how durable research should be stored. The Helper project exposes an external Obsidian research vault through `linked-vaults/research-vault`, while other projects may provide an explicit destination, only a local `output/` directory, or no writable destination.

Without a shared workflow, agents could choose destinations inconsistently, create incompatible vault and output formats, search broadly for external vaults, or write local deliverables without required approval.

## Decision

The `researcher` skill will produce a persistent artifact by default and resolve its destination in this order:

1. A path the user supplies in the initial request or in response to a destination prompt.
2. The exact project path `linked-vaults/research-vault` when available.
3. A project-local `output/` destination after notifying the user and receiving confirmation.

When neither higher-priority destination exists, the agent will propose `output/<research-slug>/` and ask the user to confirm it or provide another save path. Declining persistence leaves the completed research in conversation without creating files.

Destination selection remains separate from authorization. Active global and project instructions govern protected paths, external data, output conventions, and approval. The agent asks for approval required by those rules; it does not ask whether authoritative rules should apply.

All destinations use one research-package contract:

```text
<research-slug>/
├── README.md
├── sources.md       # when needed
├── notes/           # when needed
└── attachments/     # when needed
```

The package uses stable YAML metadata plus adaptable, human-readable Markdown. Supporting files and directories are created only when useful. Linked-vault research is partitioned by year under `research/<year>/`; project and topic associations remain metadata so cross-cutting research does not require an arbitrary primary category.

Detailed destination, approval, schema, package, lifecycle, and validation rules live in the researcher reference rather than the always-loaded core.

## Reasons

A user-provided destination represents the clearest storage intent and therefore outranks defaults. A linked external vault provides centralized, durable research without requiring every project to own a vault. The confirmed local fallback gives projects without a link a consistent deliverable while preserving user control over file creation.

One leaf structure avoids maintaining separate vault and output templates. Stable metadata supports agent-assisted discovery and lifecycle updates, while ordinary Markdown and meaningful directory names keep artifacts readable without Obsidian plugins. Year partitioning scales without forcing research into mutually exclusive project or topic categories.

Keeping the detailed workflow in a reference preserves the researcher's primary focus on evidence quality and synthesis. Keeping destination authorization subject to active instructions prevents a skill default from weakening project safeguards.

## Consequences

- Research can persist consistently across explicit destinations, linked vaults, and project output directories.
- Projects without a linked vault prompt before the local fallback is created.
- Small factual checks may create only a `README.md`; substantial research can add sources, notes, or attachments without changing formats.
- Agents inspect only the expected linked-vault path and never create or repair vault links automatically.
- Projects retain control over approval and writable locations.
- Research declined or prohibited for persistence remains available in conversation.
- Existing output research is not migrated automatically if a linked vault later becomes available.
- The workflow adds artifact maintenance to researcher invocations, even for small questions, but scales the package down to limit noise.

## Alternatives

- Put a research vault inside every project. Rejected because it fragments discovery, schemas, and lifecycle maintenance.
- Hard-code one machine-specific central-vault path. Rejected because it is not portable and bypasses project boundaries.
- Prefer the linked vault over an explicit user path. Rejected because explicit destination intent should win.
- Create the local output fallback silently. Rejected because projects may require approval and the user may prefer another destination.
- Maintain separate vault and output structures. Rejected because they would drift and require parallel templates and validation.
- Organize research primarily by project or topic directories. Rejected because substantial research can cross several projects and topics; metadata and indexes represent those relationships without duplication.
- Ask whether mandatory local rules should apply. Rejected because authoritative instructions are not optional; only the approval or a compliant alternative is a user choice.

## Related Changes

- Superseded by [Researcher Evidence and Artifact Workflow](0019-researcher-evidence-and-artifact-workflow.md).
- `.agents/skills/researcher/SKILL.md`
- `.agents/skills/researcher/references/research-storage.md`
