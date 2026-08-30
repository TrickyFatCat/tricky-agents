# Skill Validation

Read this reference when reviewing, completing, or renaming a skill.

Validation should cover discovery, content, references, dependencies, formatting, and repository scope. Passing a Markdown check alone does not prove that a skill routes or behaves correctly.

## Pre-Change Inventory

Before editing:

- Resolve the skill location and repository root.
- Inspect repository status.
- Read the complete `SKILL.md` and relevant references.
- List scripts, assets, and nested resources.
- Use `scripts/skill-audit.nu inventory <skills-root> --exclude nushell --format json` when it can speed the inventory.
- Search for the skill name, command, directory path, title, and known aliases.
- Identify routing dependencies in other skills, prompts, instructions, documentation, and task records.
- Separate current dependencies from historical records before proposing changes.

Do not scan sensitive or unrelated directories without permission.

## Frontmatter Checks

Confirm:

- `SKILL.md` starts with valid YAML frontmatter.
- `name` and `description` are present and non-empty.
- The name uses 1-64 lowercase letters, digits, or hyphens.
- The name has no leading, trailing, or consecutive hyphens.
- The name matches the directory for portability.
- The description is no more than 1024 characters.
- The description uses imperative phrasing by default, such as `Use when...` or `Use this skill when...`, unless a clear reason supports another style.
- The description states both capability and activation context.
- The description describes user intent before implementation mechanics.
- The description includes specific routing keywords.
- The description avoids rationale, benefits, implementation history, and motivational prose unless needed for routing.
- `compatibility`, when present, is 1-500 characters and tied to real environment requirements.
- Most skills omit `compatibility` unless there is a real runtime, product, network, or tool requirement.
- `disable-model-invocation: true` is preserved for explicit-only skills.
- Optional fields are supported and necessary.

Malformed frontmatter or a missing description can prevent discovery.

## Routing Checks

Ask:

- Does the description activate for the intended requests?
- Is it likely to activate for unrelated requests?
- For substantial changes, can one matching request and one near-miss boundary request be tested or reasoned through?
- Does the description avoid overfitting to one prompt set?
- Are overlaps with adjacent skills resolved through clear handoffs?
- Does the skill distinguish review, planning, research, and implementation?
- Does it avoid routing to skills that do not exist?
- Are renamed skills updated in every active routing dependency?

Search the actual skill registry or configured locations rather than assuming another skill exists.

## Core and Reference Checks

Confirm:

- The core contains the always-needed purpose, routing, workflow, and safety rules.
- The main `SKILL.md` stays under 500 lines by default, or the proposal/review explains why an exception is justified.
- Optional detail is moved to references when it would obscure the default path.
- Every linked reference exists.
- Every reference has a clear load condition in the core.
- Relative paths resolve from the skill directory.
- References do not contradict the core or active project instructions.
- Critical rules are not available only in an optional reference.
- Templates do not impose one project's conventions globally.
- Templates live in `assets/` when they are copied or used as output patterns.
- Template filenames are semantic and avoid generic names such as `README.md`, `template.md`, or `notes.md` unless an approved exception applies.

A shorter core is not automatically better. The criterion is whether always-loaded content is necessary for correct behavior.

## Formal Audit Resource Checks

For full Skill Audit, confirm:

- Every skill-owned reference is evaluated for need, quality, and writing.
- Every skill-owned template is evaluated for need and quality.
- Missing recurring template capability is explicitly assessed.
- Directly linked shared dependencies are included only when they materially affect behavior.
- Unrelated global references and templates remain excluded.
- Small skills or skills without owned resources use proportional wording instead of empty tables.

For Usage Report Audit, confirm:

- Every selected report has an evidence-backed judgment and next lifecycle state.
- Every core section, reference, template, script, instruction, decision, commit, or dependency that can materially change the report judgment is evaluated.
- Unrelated owned resources are explicitly listed as excluded.
- The Audit does not imply whole-skill coverage.
- Broad routing, safety, responsibility, architecture, migration, or uncertain interactions trigger escalation to full Skill Audit.
- Lifecycle-only or traceability-only correction with no behavior change uses lightweight triage when formal Audit would add no value.

Inventory, report count, and link checks support these evaluations but do not replace qualitative judgment.

## Target-Skill Artifact Capability Checks

When the target skill may own decision-record, Audit/Review, or Proposal capability, confirm:

- The capability belongs to a recurring runtime responsibility rather than the current Skill Creator workflow.
- Each capability is assessed independently and loads only for relevant requests.
- Advice, assessment, proposal, approval, and implementation boundaries remain clear.
- Project-local storage, naming, lifecycle, approval, and validation rules remain authoritative.
- Concrete templates are justified, semantically named, and owned by the target skill.
- Skill Creator's own templates are not copied as universal target-skill assets.

## Content Review

Review in source order when practical and prioritize behavior-changing findings.

Check for:

- Mandatory restatements or preambles that add no value.
- Long paragraphs or ungrouped lists that hide the next action.
- Descriptions that explain benefits instead of routing triggers.
- Reference text that uses prose where direct instructions would be clearer.
- Repeated rationale, motivational prose, or generic benefits.
- Fixed response structures that do not scale down.
- Excessive questions, metadata, or mechanical task steps.
- Undefined confidence, status, priority, or severity labels.
- Workflows without stopping criteria.
- Recommendations treated as confirmed decisions.
- Missing approval, handoff, rollback, or validation rules.
- Contradictions with global or project-local instructions.
- Stale examples, dates, paths, tool names, or unavailable skills.
- Generic model-knowledge guidance where concrete source material is available.
- Missing source-material, user-correction, usage-report, or execution-trace context for substantial changes.
- Overly broad menus where one default should be chosen.
- Overly rigid template steps applied where judgment should remain flexible.

Preserve good decisions and explain the trade-off of each proposed change.

## Script and Asset Checks

For scripts:

- Read the script before running it.
- Verify inputs, outputs, dependencies, side effects, and error handling.
- Prefer help, version, check, or dry-run execution first.
- Check portability and relative-path assumptions.
- Review security-sensitive operations and credential handling.
- Use `code-reviewer` for implementation quality.

For assets:

- Confirm they are referenced intentionally.
- Check that generated output does not overwrite the asset.
- Verify templates contain no private paths, credentials, or project-specific secrets.
- Verify templates state when to adapt or omit irrelevant sections.
- Verify filename semantics: artifact role and subject should be understandable from the basename.

Do not execute user-provided or state-changing scripts without approval.

## Rename and Migration Checklist

Treat a rename as more than changing frontmatter.

Confirm the approved migration covers:

1. Old and new directories.
2. Frontmatter name and visible title.
3. References and relative links.
4. Routing mentions in other skills.
5. Prompt templates and instructions.
6. Documentation, source inventories, and active task records.
7. Commands, aliases, scripts, or settings that use the old name.
8. Historical records the user explicitly wants updated.
9. Removal or retention of compatibility aliases.

After migration, search for stale variants:

```bash
rg --hidden -n "old-skill|Old Skill|old skill" <approved-search-roots>
```

Do not update historical wording unless the user approves that trade-off.

## Formatting and Static Validation

Format changed Markdown with the project's intended formatter.

Then check:

- Trailing whitespace and conflict markers.
- Broken relative references.
- Frontmatter and directory agreement.
- Unexpected absolute or machine-specific paths.
- Missing scripts or assets.
- Broken local Markdown links; use `scripts/skill-audit.nu links <skill-dir> --format json` when useful.
- Only approved files changed.

For a Git-backed repository, use the resolved repository root:

```bash
git -C "$repo_root" status --short
git -C "$repo_root" diff --check
git -C "$repo_root" diff -- <approved-paths...>
```

Untracked files may not appear in an ordinary unstaged diff. Inspect them directly or stage exact paths only after commit approval and then validate the cached diff.

For non-Git storage, report that limitation and use direct content, whitespace, link, and stale-reference checks.

## Runtime Discovery

Pi scans skill locations and extracts frontmatter at startup.

When runtime testing is appropriate:

- Start a new session or otherwise trigger a fresh skill scan.
- Check startup warnings for malformed or colliding skills.
- Confirm the skill appears under the expected name.
- Invoke `/skill:<name>` when skill commands are enabled and explicit loading needs verification.
- Test one matching request and one boundary request when routing behavior matters.
- For substantial skill changes, review a trial task or execution trace when available, or report why that was not practical.

Do not claim runtime discovery was tested when only files were inspected. An active session may not reflect newly created or renamed skills until discovery runs again.

## Commit Validation

Commit only when explicitly requested and permitted by the repository workflow.

Before committing:

1. Inspect status and the complete relevant diff.
2. Stage exact approved paths.
3. Run:

    ```bash
    git -C "$repo_root" diff --cached --check
    ```

4. Confirm deletions, renames, and new references are all staged.
5. Commit with a focused message.
6. Verify repository state afterward.

Do not include unrelated changes or unapproved historical records.

## Final Report

Report:

- Files created, modified, moved, or deleted.
- Skill behavior and routing changes.
- Dependencies and records updated.
- Formatting and validation performed.
- Runtime discovery or scripts not tested.
- Repository limitations and remaining changes.
- Commit hash when a commit was requested.
