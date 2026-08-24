# Source-Accuracy Documentation Review

Read this reference when reviewing documentation for commands, scripts, configuration, APIs, generated interfaces, setup procedures, or behavior that can be checked against an implementation or authoritative source.

Accuracy review complements reader-experience review. A document must be both usable and correct.

## Establish the Source of Truth

Identify the most authoritative current source available:

1. Current implementation or configuration schema.
2. Generated or built-in help from the installed version.
3. Tests and direct call sites that demonstrate intended behavior.
4. Version-matched upstream documentation.
5. Existing local documentation.

Project instructions or the user may identify a different authority. State the assumption when authority is ambiguous.

Do not treat an older README as proof that current behavior still matches it.

## Inspection Workflow

Before writing accuracy findings:

1. Read the relevant documentation completely enough to inventory its claims.
2. Read the corresponding source files.
3. Inventory public or exported commands, functions, options, and configuration fields.
4. Inspect current signatures, types, defaults, return shapes, side effects, and errors.
5. Inspect help metadata and direct call sites when they clarify intended usage.
6. Compare the documented interface with the current interface.
7. Validate uncertain behavior safely when practical.
8. Record anything that could not be verified.

Prefer static inspection, built-in help, validation modes, dry runs, or mocked dependencies before state-changing tests.

Do not run destructive or state-changing commands solely to improve a review without explicit approval.

## Command and Script Checks

Check whether documentation accurately represents:

- Exported command inventory.
- Command names and aliases.
- Required and optional arguments.
- Flag names, value types, and repeatability.
- Defaults and precedence.
- Pattern matching, including regex versus exact matching.
- Return values and output shapes.
- Errors for missing or invalid input.
- File, process, network, or application-state side effects.
- Discovery and utility commands.

Compare documented commands against exported commands after the review. Note missing, removed, or renamed commands.

## Configuration and Setup Checks

Check whether documentation accurately represents:

- Current file locations.
- Required and optional files.
- Default values.
- Search paths and environment variables.
- Configuration precedence.
- Validation commands.
- Reload or restart requirements.
- Persistent side effects.
- Version, platform, and permission constraints.

Do not recommend package, service, or privilege commands without checking the relevant environment when those details affect correctness.

## API and Extension Checks

Check whether documentation accurately represents:

- Public inputs and required fields.
- Output or return contracts.
- Registration, discovery, or dispatch points.
- Error behavior.
- Compatibility expectations.
- Safe extension validation.

Inspect at least one direct usage when it clarifies the contract.

## Evidence in Findings

Use an `Evidence` label when a source-backed detail is important or disputed:

```markdown
### 1. Documented flag no longer exists

Priority: 🔴 High

**What**

The reference documents `--FocusBack`, but the current command exports `--focus-back`.

**Evidence**

`path/to/script.nu` exports `mwm-focus-client [id: int, --focus-back]`.

**Reader impact**

The documented invocation fails with an unknown flag.

**Direction**

Update the syntax and examples to use `--focus-back`.
```

Use precise local paths or relevant source links. Do not add evidence labels to every wording or structure finding.

## Facts, Assumptions, and Unknowns

Keep confidence visible:

- Fact: confirmed by current source, help output, a safe test, or authoritative documentation.
- Assumption: inferred from context but not confirmed.
- Unknown: unavailable or unsafe to verify in the current task.

Do not turn assumptions into definitive findings. Ask a question or make the recommendation conditional when uncertainty changes the result.

## Final Accuracy Check

Before finalizing the review:

1. Confirm each accuracy finding cites or names its basis.
2. Recheck command names, paths, flags, defaults, and quoted behavior.
3. Confirm source and documentation versions are compatible.
4. Separate implementation problems from documentation problems.
5. Report source areas or runtime behavior that were not checked.

If the implementation itself appears incorrect, identify that separately. Do not recommend documenting a bug as intended behavior without confirming the user's goal.
