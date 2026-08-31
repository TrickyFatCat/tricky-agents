# Global Shell Selection Policy

Status: Accepted
Date: 2026-08-31

## Context

During validation of an approved global skill change, a one-shot pipeline used Nushell and then added `jq` to process its JSON output. The added query layer assumed a nonexistent `.skills` field instead of the actual `.items` field and failed. Nushell could have inspected and filtered the structured values directly.

The Nushell skill already prefers Nushell for structured data and preserves Bash-specific use, but that skill loads conditionally. Canonical global instructions had no always-loaded shell-selection default, so they could not govern command choices made before skill routing.

## Decision

Use Nushell as the default language for shell commands, pipelines, and structured-data processing when it is available and compatible with the task and execution contract.

When Nushell already produces or consumes structured values, keep filtering and transformation in Nushell. Add `jq` or another processor only for a specific requirement or material advantage.

Use Bash or a POSIX shell as a fallback when a script, command, repository tool, or harness requires it; Nushell is unavailable; higher-priority instructions require another shell; or Bash is materially better suited to the task.

Treat the rule as a tool-selection preference rather than a prohibition. A harness tool or wrapper name does not by itself require its shell language, but an explicit execution contract remains authoritative.

Global instructions own always-loaded shell selection. The Nushell skill continues to own conditional Nushell syntax, scripting, and structured-data guidance. The repo-backed Pi instruction path remains an alias to the canonical global file rather than a second policy target.

## Reasons

- Always-loaded instructions govern shell selection before conditional skill routing.
- Keeping structured values in one processing model avoids unnecessary serialization, quoting, dependency, and schema boundaries.
- Explicit fallback conditions preserve compatibility with existing scripts, tools, harnesses, projects, and environments.
- A preference with exceptions improves defaults without banning justified processors or shell languages.

## Consequences

- **Benefits:** Agents have a consistent shell default and fewer unnecessary structured-data transitions.
- **Costs:** Agents must assess compatibility and material suitability before choosing a fallback or adding another processor.
- **Risks:** Agents may over-apply Nushell or treat the preference as a ban; explicit execution-contract, precedence, and non-prohibition language mitigates this.
- **Compatibility:** Bash/POSIX scripts, required shell syntax, repository tooling, harness contracts, project instructions, unavailable Nushell, and justified processors remain supported.
- **Maintenance:** Global instructions own selection policy; the Nushell skill owns language-specific methods.

## Alternatives

- Change only the Nushell skill — rejected because conditional routing cannot govern earlier command choices.
- Ban Bash or `jq` — rejected because explicit requirements and material advantages may justify them.
- Edit both global and Pi instruction paths — rejected because they resolve to the same canonical repository file.
- Add a detailed optional reference — rejected because the complete rule is concise and must remain always loaded.
- Add only a project-local rule — rejected because the requested behavior applies across sessions and projects.

## Traceability

- Source: accepted `Assessment Global Shell Selection Policy` and approved `Proposal Add Global Shell Selection Policy` in the external task vault.
- Report: `nushell-default-shell-policy-missing` in the external skill-usage reports vault.
- Canonical path: `.agents/AGENTS.md`.
- Related skill: `.agents/skills/nushell/SKILL.md`, unchanged.
- Related Pi path: `.pi/agent/AGENTS.md`, unchanged alias to the canonical file.

## Related Changes

- `.agents/AGENTS.md`
