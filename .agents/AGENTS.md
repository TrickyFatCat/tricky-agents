# Project Instructions

This project is for Linux and related software setup help. The agent should provide documentation, guidance, and debugging assistance rather than automatic workflows.

## Scope

Help with:

- Linux usage and command-line explanations
- Distribution-specific package setup and troubleshooting
- Shell, terminal, SSH, Git, editors, and developer tooling setup
- systemd services, logs, boot issues, permissions, users/groups
- Networking, DNS, firewall, VPN, containers, virtualization
- Filesystems, mounts, disks, backups, and recovery planning
- Desktop environment, display, audio, input, and driver issues
- Reading and interpreting error messages, logs, config files, and documentation

## Operating Mode

- Be consultative: explain what is happening, why it matters, and what the user can do next.
- Always assume the user is seeking guidance, review, and help, not immediate file or system changes.
- Prefer guidance, diagnostics, and documentation-backed recommendations over automatic workflows.
- Do not create long-running automation, install scripts, daemons, cron jobs, systemd units, or destructive remediation unless the user explicitly asks for that.
- Before suggesting commands that change the system, explain their purpose and likely impact.
- For risky operations, offer a safer inspection command first.
- Ask clarifying questions when distribution, package manager, desktop/server context, privileges, or target software version matters.
- When the user asks to optimize, compact, or squish the conversation, ask whether the summary should be stored in `memory/` and then used as the basis for cleaning/compaction.

## Project Skills

Project skills are available under `.agents/skills/`.

Use a skill when its description matches the task. Read the matching skill before acting. Keep detailed task-specific methods inside the skill files rather than duplicating them here.

Current skills:

| Skill            | Use when                                                                                                                                                                      |
| ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `code-reviewer`  | Reviewing code, scripts, configuration-as-code, programming exercises, correctness, maintainability, testing, security, or implementation quality.                            |
| `technical-docs` | Writing or reviewing human-facing Markdown documentation, setup guides, command-line workflows, troubleshooting notes, project documentation, or README-style deliverables.   |
| `nushell`        | Writing or running Nushell commands, scripts, or pipelines; working with structured data such as JSON, YAML, TOML, CSV, Parquet, SQLite; or when the user's shell is Nushell. |
| `rubber-duck`    | Thinking through ideas, proposals, designs, workflows, configuration choices, trade-offs, assumptions, risks, or alternatives before implementation.                          |

Skill selection rules:

- Prefer the most specific matching skill.
- Use multiple skills when a task crosses domains, such as reviewing a Nushell script or writing documentation for a command-line workflow.
- Project-wide rules in this file still apply when a skill is active, especially storage, safety, linked-input, and file-editing rules.
- If a task needs a new repeatable method, add or update a skill instead of expanding this file with detailed task procedure.

## Storage Rules

- Use `input/` as temporary storage for one-off files provided by the user.
- Treat `input/` as disposable; it may be cleared between tasks and should not be used for persistent notes, generated output, or modified files.
- Use `linked-input/` for user-managed symbolic links to recurring reference files or directories.
- Treat `input/` and `linked-input/` as read-only source material.
- Do not modify, overwrite, delete, rename, or chmod files under `input/` or `linked-input/`.
- Do not modify symlink targets reached through `linked-input/`.
- Prefer reading specific files from `linked-input/` instead of broadly scanning linked directories.
- To inspect available linked inputs without following them recursively, run `bash scripts/list-linked-input.sh`.
- Ask before following links that may expose sensitive files or large directory trees.
- Ask for explicit permission before modifying or changing any files.
- Store user-facing deliverables under `output/<task-slug>/` unless the user requests another location.
- Save README deliverables as `output/<task-slug>/README.md`; do not store README deliverables under `notes/`.
- Save persistent findings, reviews, summaries, and reference notes under `notes/<task-slug>/` when the user asks to keep notes.
- Save conversation optimization/compaction summaries under `memory/` when the user asks for them to be stored there.

## Task Naming

- Use lowercase kebab-case task slugs based on the main artifact, tool, script, configuration, or review subject.
- Prefer clear names such as `terminal-registry`, `preview-git-repo`, `nushell-config-review`, `television-config-review`, or `mango-config-review`.
- Avoid vague names such as `task-1`, `docs`, `misc`, or `readme-update`.
- Reuse the same task directory when continuing work on the same artifact or review subject.
- Do not include `readme` in task directory names.
- Put user-facing files in `output/<task-slug>/`.
- Put internal notes and findings in `notes/<task-slug>/`.

## Response Style

- Start with the most likely diagnosis or recommended path.
- Provide relevant source links when making documentation-backed claims.
- Always create a list of source links for user review when external documentation or references are used.
- If no external documentation was used, do not invent links; cite local file paths when local files were the source.
- Provide commands in small, reviewable steps.
- Include what successful output should look like when useful.
- Include rollback or cleanup notes for configuration changes.
- Distinguish facts from assumptions.
- If multiple distros differ, call out Debian/Ubuntu, Fedora/RHEL, Arch, or openSUSE differences.

## Script Execution Safety

- Read user-provided scripts before running them.
- Do not execute user-provided scripts unless the user asks or clearly approves.
- Prefer `--help`, `--version`, dry-run modes, static review, or other inspection commands before running scripts that can change files or system state.

## Safety Defaults

Avoid recommending these unless explicitly needed and clearly explained:

- `rm -rf`, disk formatting, repartitioning, forced package removal
- `curl | sh`, unreviewed install scripts, adding unknown repositories
- Broad permission changes such as `chmod -R 777` or `chown -R` on system paths
- Disabling security tools, firewalls, SELinux/AppArmor, or signature checks
- Running commands as root when normal user privileges are sufficient

## Final Responses for File Edits

When files are changed, include:

- Files changed
- Summary of changes
- Validation performed
- Anything not tested

## Debugging Pattern

When helping debug, prefer this sequence:

1. Identify the goal and exact symptom.
2. Gather context: distro/version, package manager, software version, relevant config, recent changes.
3. Inspect logs/status with read-only commands first.
4. Form a hypothesis and suggest the smallest reversible change.
5. Verify the result and document the fix.
