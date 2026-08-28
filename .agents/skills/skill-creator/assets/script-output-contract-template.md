# Script Output Contract Template

Use this template when proposing or documenting a skill-bundled script.

## Template

````markdown
# <Script Name> Contract

## Purpose

<Deterministic task the script performs and why instructions alone are not enough.>

## Source Material

- Repeated agent workaround or execution trace:
- Existing tool checked:
- User correction or usage report:
- Reason a script is better than instructions alone:

## Invocation

```bash
<runtime> scripts/<script-name> <command-or-args> --format json
```

## Inputs

| Input   | Required | Meaning     | Validation                                   |
| ------- | -------- | ----------- | -------------------------------------------- |
| `<arg>` | yes/no   | `<meaning>` | `<accepted values, path rules, size limits>` |

## Outputs

- Data goes to stdout.
- Diagnostics go to stderr.
- JSON is the default when an agent consumes output.
- Human table/text output is optional for quick inspection.

Example JSON:

```json
{
  "schema_version": 1,
  "tool": "<tool-name>",
  "command": "<command>",
  "status": "ok",
  "summary": "<bounded summary>",
  "counts": {},
  "items": []
}
```

## Side Effects

- Filesystem reads:
- Filesystem writes:
- Network:
- Subprocesses:
- Credentials/environment:

Default to read-only. Require explicit output paths and dry-runs for state-changing behavior.

## Exit Behavior

| Exit | Meaning                                        |
| ---- | ---------------------------------------------- |
| 0    | Success.                                       |
| 1    | Operation failed.                              |
| 2    | Invalid invocation or input.                   |
| 3    | Denied effect or approval required.            |
| 4    | Missing dependency or unavailable environment. |

Use the script/runtime's supported exit controls. Document limitations when custom codes are not practical.

## Safety and Limits

- No interactive prompts.
- Bounded output by default.
- Home paths are rendered as `~` in human-facing output.
- Secrets are redacted or omitted.
- External commands use argument arrays, not shell strings.

## Validation

- Help output works.
- Valid input fixture passes.
- Invalid input fixture fails clearly.
- Boundary/path fixture is tested when relevant.
- JSON parses and matches the documented shape.
- State-changing behavior has dry-run and approval tests.
````
