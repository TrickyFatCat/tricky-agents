# Command Reference Documentation

Read this reference when documentation describes commands, scripts, options, arguments, configuration validation, shell workflows, or an API-like collection of helper functions.

## Verify the Source Before Writing

Treat the current implementation as the source of truth unless the project identifies another authoritative source.

Before documenting commands:

1. Read the relevant source files completely enough to understand the public interface.
2. Inventory exported or public commands.
3. Inspect current signatures, flags, argument types, defaults, and help metadata.
4. Identify return values, output shapes, side effects, and error behavior.
5. Inspect direct call sites when they clarify intended usage or reveal compatibility requirements.
6. Check upstream help or documentation for passthrough options and external command behavior.

Distinguish verified behavior from assumptions. Do not document guessed defaults, options, precedence, return values, or version-specific behavior as facts.

Prefer static inspection, `--help`, `--version`, validation modes, dry runs, or mocked dependencies before commands that can change files, processes, services, or application state.

## Organize Commands by Reader Task

Group commands by what the reader wants to accomplish, not by source-file order.

Useful groups include:

- Discovery or utility commands.
- Lookup commands.
- Information or inspection commands.
- Configuration validation.
- State-changing actions.
- Troubleshooting or diagnostics.

Do not force a command into an unrelated section. Add a small utility section when that makes discovery clearer.

For a reference with several groups, a short linked section map can help readers choose where to go:

```markdown
Reference sections:

- [Client Lookup](#client-lookup) — find clients by app ID or title.
- [Client Actions](#client-actions) — focus, move, or close clients.
```

Do not repeat the entire table of contents. Include only links that help the reader choose between reference groups.

## Command Tables

Use the smallest table that communicates the interface clearly.

For query commands, prefer:

```markdown
| Syntax      | Returns                   |
| ----------- | ------------------------- |
| `tool list` | Table of available items. |
```

For state-changing commands, prefer:

```markdown
| Syntax             | Effect                     |
| ------------------ | -------------------------- |
| `tool remove <id>` | Removes the selected item. |
```

For options, use columns such as `Option`, `Type`, `Default`, and `Description` only when they add useful comparison.

Omit a `Command` column when it merely repeats the command already shown in `Syntax`.

Show user-provided values clearly:

- Required placeholder: `<input-file>`.
- Optional placeholder: `[output-file]` when that notation matches the tool.
- Repeated values: `[<field> ...]` or the syntax used by the documented tool.
- Literal value: write it without angle brackets.

Explain placeholder conventions locally when the syntax could be ambiguous.

## Arguments, Options, and Defaults

Document details near the command they affect:

- Required and optional arguments.
- Accepted types or value ranges.
- Defaults.
- Pattern matching, including whether values are regex or exact strings.
- Errors caused by missing or invalid values.
- Side effects.
- Repeatability and precedence.

For passthrough options such as `--term-args`, `--extra-args`, `--raw`, or similar fields:

- Explain that values are tool-specific and should be checked against upstream help.
- Explain whether the option is repeatable.
- If repeated values override earlier values, warn readers to pass all values in one list or invocation.
- Show one flag.
- Show a flag with a value.
- Show several values in one list when supported.
- Show passthrough values combined with regular options or command arguments.

Only document edge cases or precedence rules that were tested or documented upstream.

## Examples

Order examples by reader value:

1. Discovery or the shortest successful command.
2. Common read-only lookup or inspection.
3. Common workflow.
4. Safe validation.
5. State-changing or advanced usage.

Use short, self-contained examples. Explain the practical result before mechanics.

Concise comments are useful in dense command-reference blocks when they identify a return value, output shape, side effect, or fallback:

```nu
# Returns the first matching client ID, or null.
mwm-get-client-id firefox
```

Avoid comments that only repeat the command name or section heading.

Each example should include:

1. What the command does.
2. The command or configuration snippet.
3. Expected output or a verification note when it helps the reader recognize success.

Prefer safely testable examples such as inspect, list, dry-run, preview, build, or validation commands.

## Shell Command Safety

For shell commands:

- Use the correct fenced language, such as `bash` or `nu`.
- Explain the command before a risky action.
- State whether it changes the system or application state when that is not obvious.
- Put warnings beside the command or option they affect.
- Offer a safer inspection command before destructive actions when possible.
- Do not present credentials or remote-code execution patterns casually.

Example:

````markdown
Check whether the service is running:

```bash
systemctl status example.service
```

This command is read-only. It shows the service state and recent logs.
````

## Extension Contracts

When documenting how to extend a tool, explain the contract before implementation snippets:

- Required inputs or record fields.
- Expected return value or output shape.
- Registration, dispatch, or discovery point.
- Mechanism that enables the extension, such as search paths or autoloading.
- Safe validation method.

## Final Command Inventory Check

After drafting and formatting:

1. Compare documented commands with the current exported-command inventory.
2. Confirm names, flags, signatures, defaults, and examples still match the source.
3. Confirm each command belongs to an appropriate reference group.
4. Check that new discovery or utility commands are represented.
5. Report behavior that was not tested.
