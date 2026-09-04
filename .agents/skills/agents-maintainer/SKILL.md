---
name: agents-maintainer
description: Use only when the user explicitly asks to review or update global agent resources, audit or propose changes to project-specific AGENTS.md files, maintain the agents repository, or invokes /skill:agents-maintainer.
disable-model-invocation: true
---

# Agents Maintainer

Use this skill only for explicit requests to maintain the user's global agent setup or audit and propose changes to project-specific `AGENTS.md` files.

This skill is hidden from automatic model invocation. It exists as the user-requested command `/skill:agents-maintainer`.

## Reference Files

| Reference                                                                      | Read when                                                                                                                                                |
| ------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [references/maintenance-audit.md](references/maintenance-audit.md)             | Performing a formal Audit of global agent resources or repository-maintenance behavior; pair with `audit-workflow` for shared Audit mechanics.           |
| [references/maintenance-proposals.md](references/maintenance-proposals.md)     | Preparing or reviewing a durable maintenance proposal; pair with `audit-workflow` for shared proposal mechanics.                                         |
| [../../references/safety-inspection.md](../../references/safety-inspection.md) | Inspecting third-party or project-local agent resources with scripts, dependencies, network access, credentials, sensitive data, or high-impact effects. |

Use ordinary inspection and conversational Review for bounded maintenance requests. Use the maintenance Audit reference for a formal bounded assessment and the maintenance proposal reference for a durable exact-scope approval contract. An Audit or proposal does not authorize implementation.

## Scope

Maintain approved files inside the resolved agents Git repository, commonly exposed through:

- `~/.agents/AGENTS.md`
- `~/.agents/skills/`
- repo-backed `~/.pi/agent/AGENTS.md`
- repo-backed `~/.pi/agent/prompts/`

When explicitly requested, audit project-specific `AGENTS.md` files outside the agents repository and prepare exact proposed changes. Treat those files as read-only: do not edit, move, delete, stage, commit, or push them. Hand implementation to the project-local workflow under its active instructions.

The setup may use nested symlinks. Resolve the repository through Git instead of assuming a fixed directory layout:

```bash
agents_path="$(readlink -f ~/.agents)"
repo_root="$(git -C "$agents_path" rev-parse --show-toplevel)"
```

Before editing a target:

1. Resolve the existing target or its nearest existing parent.
2. Confirm the resolved location is inside `$repo_root`.
3. Confirm symlinks do not lead outside `$repo_root`.
4. Report user-facing and repository paths when both help identify the file.

Treat nearby Pi runtime state as out of scope by default, including:

- Credentials and authentication files.
- Session history.
- Trust state.
- Installed packages and generated stores.
- Active settings that are not repository-backed.

Do not modify runtime, credential, session, trust, package, or non-repository state unless the user explicitly names the target and approves the risks after inspection.

## Third-Party Resource Safety

Read [../../references/safety-inspection.md](../../references/safety-inspection.md) before enabling, copying, or updating a third-party or project-local skill, prompt, script, template, dependency, or other agent resource.

For each applicable resource, inspect:

- source, provenance, revision, and license when available;
- bundled scripts, dependencies, install hooks, symlinks, binaries, permissions, and persistence;
- network destinations, credential access, filesystem effects, and other side effects.

Do not execute third-party resources during inspection unless the user separately requests and approves the execution after its effects are visible.

Treat `allowed-tools` and similar metadata as compatibility declarations, not containment, unless the active harness verifies and enforces them.

Skip an unsafe optional resource when the approved outcome remains complete without it.

Stop before enabling a required resource when provenance, repository boundaries, credentials, network behavior, or side effects remain materially unresolved.

## Approval Gate

Before creating, modifying, deleting, moving, or reorganizing global agent resources:

1. Explain the proposed change.
2. Explain the reasoning and trade-offs.
3. List every exact file to create, modify, move, or delete.
4. Wait for explicit user approval.

For created, moved, renamed, or reorganized artifacts, include:

- each file's artifact role;
- naming rule;
- any reserved-name exception.

Use semantic filenames that describe the artifact subject and type. Reserve `README.md` for real directory, package, or collection overviews unless an external format requires it and the exception is explicitly approved.

For human-facing rename or move approval, show old values before new values. Compare basenames for renames and parent directories without filenames for moves. For a combined operation, compare both components, then show the resulting full path. Apply the same sequence to files and directories.

For detailed durable workflows, schemas, lifecycle rules, or cross-skill conventions, use a reference-first proposal:

- keep `AGENTS.md` to a concise routing rule;
- place the detailed process in a global reference or skill reference;
- state this split so the user can evaluate always-loaded instructions separately from optional detail.

Before implementing a saved maintenance proposal, follow [references/maintenance-proposals.md](references/maintenance-proposals.md) and confirm that the proposal exists, is linked from the owning task, records the exact file scope, and has `status: approved`. Do not create it retrospectively or combine proposal preparation and implementation. This check does not require a saved proposal for unrelated trivial work unless the user or active project requires one.

Approval applies only to the described scope. Pause and request approval again if new files, broader changes, or materially different behavior become necessary.

## Maintenance Workflow

1. Confirm the request concerns global instructions, skills, prompt templates, repo-backed Pi resources, the agents repository, or a read-only Audit or proposal for project-specific `AGENTS.md`.
2. Resolve `agents_path` and `repo_root` as shown above.
3. Inspect repository state before proposing changes:

    ```bash
    git -C "$repo_root" status --short
    ```

4. Read the relevant files and inspect target paths without changing state.
5. Perform the shared safety inspection when the work involves third-party resources, executable helpers, dependencies, sensitive data, networks, credentials, or high-impact effects.
6. Enter formal Audit mode when the user requests it or when broad scope, migration, repository authority, safety, or uncertain interactions require durable assessment. Complete Audit review before preparing its proposal.
7. Present the proposal required by the approval gate. Use a conversational exact-file proposal for proportional changes. Use the durable proposal workflow when the user, project, reviewed Audit, or change risk requires a saved approval contract.
8. Resume implementation only after the applicable approval gate is satisfied. Make only the approved changes. For project-specific `AGENTS.md` files outside the agents repository, stop after the proposal and hand implementation to the project-local workflow.
9. Keep durable project-wide behavior in `AGENTS.md`; keep task-specific methods in skills or their references.
10. Use targeted edits for existing files. Use full rewrites only when restructuring an approved file, and use new-file writes only for approved new files.
11. Preserve portability across machines. In human-facing output, show home-directory paths as `~/...` unless the full resolved path is needed for boundary evidence, debugging, incident scope, or a machine-consumed value.
12. Avoid absolute paths unless documenting an intentional local bootstrap layout.
13. Avoid scripts, install hooks, daemons, cron jobs, or destructive setup unless explicitly requested and approved.
14. Run artifact-specific validation and inspect the final diff.

## Skill Maintenance

For global skill changes, pair with `skill-creator`: it owns skill architecture, routing, artifact quality, and migration completeness; Agents Maintainer owns global-resource approval, repository and symlink boundaries, exact-path validation, staging, commits, and final repository state. Apply the Approval Gate before edits, and do not let skill guidance broaden the approved scope.

## Validation

Run artifact-specific validation from the owning workflow; use `skill-creator` for global skill validation. Agents Maintainer independently confirms:

- changed paths and effects match the exact approval;
- implementation targets and symlinks remain inside the approved repository boundary;
- applicable explicit-only, portability, and safety boundaries remain intact;
- required specialist validation completed; and
- unrelated changes remain untouched and unavailable checks are reported.

For all agent-repository changes, run:

```bash
git -C "$repo_root" status --short
git -C "$repo_root" diff --check
git -C "$repo_root" diff -- <approved-paths...>
```

## Commit Workflow

Follow stronger repository-local commit rules. Commit only when the user explicitly asks after reviewing or approving the changes.

Before committing:

1. Inspect repository status and the relevant diff.
2. Confirm only approved files will be staged.
3. Stage exact paths rather than all repository changes.
4. Validate the staged diff:

    ```bash
    git -C "$repo_root" diff --cached --check
    ```

5. Commit with a focused message that describes the approved change.
6. Verify repository state afterward:

    ```bash
    git -C "$repo_root" status --short
    ```

Do not amend, force-push, reset, or discard unrelated changes unless the user explicitly requests and approves that operation.

## Final Response

When files are changed, report:

- Files changed.
- Summary of changes.
- Validation performed.
- Anything not tested.
- Commit hash and message when a commit was requested.
- Remaining repository changes when the working tree is not clean.
