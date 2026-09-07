# Skill Design

## Authority

Distinguish between:

- **specification requirements** — rules required by the Agent Skills specification;
- **authoring policy** — rules intentionally adopted for this agent setup;
- **recommendations** — preferred practices with legitimate exceptions;
- **project conventions** — established choices authoritative within their project scope.

Do not present a recommendation or convention as a specification requirement.

Supporting references, assets, templates, and tools inherit authority from the Skill that owns them. They support the Skill but do not independently override its behavior. Treat contradictions with the parent Skill as internal inconsistencies to resolve.

## Skill Structure and Frontmatter

A Skill has a directory containing a required `SKILL.md`.

A common local structure is:

```text
<skill>/
├── SKILL.md
├── references/   # optional
├── assets/       # optional
└── tools/        # optional
```

`tools/` is the preferred project convention for Skill-local executable utilities. It is not an Agent Skills specification requirement.

Do not create empty supporting directories.

Required `SKILL.md` frontmatter:

- `name`;
- `description`.

Optional frontmatter may include:

- `license`;
- `compatibility`;
- `metadata`;
- `allowed-tools`.

Use optional fields only when they serve a concrete purpose.

When using `allowed-tools`, ensure the constraint is intentional, narrow enough to be meaningful, and does not prevent legitimate Skill behavior.

## Description Design

Treat `description` as part of Skill triggering behavior.

It should describe:

- what the Skill does;
- when it should be used.

Prefer intent and task boundaries over implementation details.

Include important implicit triggering cases when users may need the Skill without naming it directly.

Avoid wording broad enough to trigger on adjacent capabilities that belong elsewhere.

A useful form is:

> Use this skill when...

Treat unclear triggering boundaries that are likely to cause incorrect activation as **🔴 Required**.

When multiple reasonable scope choices would materially change behavior, treat the choice as **🟡 Decision needed**.

Descriptions do not need to enumerate every possible prompt.

When description changes could materially affect triggering, use the parent Skill's evaluation workflow.

## Skill Size and Progressive Disclosure

Treat roughly **5000 tokens** or **500 lines** for `SKILL.md` as strong authoring limits, not specification validity requirements.

When the main file becomes large, consider:

- moving conditional knowledge into references;
- removing duplicated instructions;
- removing rationale that does not affect application;
- moving large examples or reusable material into assets;
- keeping core routing and consequential behavior in `SKILL.md`.

Exceed the limits when splitting would materially harm correctness, discoverability, or maintainability. Make that trade-off explicit when consequential.

Do not optimize for shortness at the expense of behavioral clarity.

## Reference Design and Structure

Use references for supporting knowledge that should be loaded conditionally.

Each reference should have:

- a distinct responsibility;
- a clear reason to load it;
- a direct route from the parent Skill where practical.

Prefer shallow structure:

```text
SKILL.md → reference
```

Allow a nested reference only for a clearly specialized subtopic when it is more coherent than loading it directly from the parent.

Do not hide consequential behavior solely inside a reference when the parent Skill needs that rule to route or behave correctly.

References inform behavior; they are not an independent authority layer.

## Assets and Templates

Use `assets/` for reusable material such as:

- templates;
- boilerplate;
- schemas;
- reusable examples;
- static output material.

A **template** is intended to be reused or adapted for real output.

An **example** is illustrative material intended to clarify behavior or expected form.

Keep small examples inline when that improves understanding. Move larger reusable examples to assets.

When useful, make clear which parts of an asset are:

- fixed;
- customizable;
- optional;
- normative.

References inform behavior; assets provide reusable material.

## Tools

Use Skill-local tools for reliable, efficient, or deterministic operations that do not benefit from repeated model reasoning.

Useful roles include:

- validation;
- transformation;
- extraction;
- generation;
- repeated stable operations;
- wrappers around domain libraries or CLIs;
- mutation of already-authorized state.

Example: a frontmatter utility may read, update, remove, or validate specific fields without requiring the model to open and rewrite an entire file.

### Interfaces and Output

Apply the parent Skill's Information Format and Output Design rules when designing tool interfaces.

Design the tool interface for its actual consumer, not merely for convenient implementation.

For each tool, define a stable contract covering:

- expected inputs;
- output shape;
- success and failure states;
- important side effects;
- assumptions the caller must know.

Prefer predictable structured output when another agent, Skill, or tool consumes the result.

Expose only information needed by the consumer. The calling Skill decides how an agent-facing result should be presented to the user.

Prefer explicit contracts over free-form output that requires downstream inference.

### Authorization

Tools automate execution, not authorization.

A mutating tool may perform changes already authorized by the user or workflow, but must not independently expand authorized scope.

Do not hide policy or consequential decision-making inside a utility merely to make the workflow more automatic.

## Model Requirements

Assess model requirements for the individual Skill based on:

- reasoning complexity;
- ambiguity and judgment;
- context size and cross-artifact reasoning;
- tool complexity;
- required precision and reliability;
- latency and cost;
- how much tools, contracts, or validation reduce model reasoning.

Prefer the least capable model that reliably performs the Skill.

Simpler models are often appropriate for:

- extraction;
- transformation;
- constrained classification;
- deterministic or tool-driven work;
- template application;
- repetitive validated operations.

Stronger models may be justified for:

- complex ambiguity;
- consequential trade-offs;
- cross-artifact reasoning;
- novel architecture;
- subtle conflicts;
- high-context synthesis.

Do not use a stronger model merely to compensate for unclear instructions, weak contracts, or missing tools.

Make model requirements explicit when they materially affect reliability, latency, cost, or compatibility.

Workflow-stage model allocation belongs in `orchestration.md`.

## Evaluation Routing

Use structural validation for:

- frontmatter;
- file structure;
- reference paths;
- assets;
- tools and their contracts;
- dependencies.

Use behavioral evaluation when changing:

- Skill triggering or description;
- decision rules;
- workflow behavior;
- outputs;
- orchestration or handoffs;
- consequential interactions with other instructions.

Do not require behavioral evaluation for trivial documentation or formatting-only changes.

For triggering changes, test positive and near-miss negative cases.

For behavioral changes, use realistic tasks and observable assertions.

Keep evaluation proportional to the risk and breadth of the change.

Use the parent Skill's evaluation workflow rather than creating separate evaluation policy inside this reference.

## Skill Behavior Design

A Skill should make its responsibility and capability boundaries clear.

As relevant, define:

- what the Skill owns;
- when it applies;
- required inputs;
- consequential decisions;
- when the user must be consulted;
- supporting artifacts;
- expected output;
- interactions with other Skills or instructions.

Use vague terms only when surrounding context makes the intended behavior sufficiently clear.

Design ambiguous-request handling intentionally. A previous similar request should not automatically become the default interpretation of a new ambiguous request when consequential alternatives remain.

Do not absorb nearby capabilities merely because they are related.

Do not make a Skill artificially self-contained when project rules or shared references already provide the authoritative information.

## Examples and Supporting Content

Keep behavior distinct from:

- rationale;
- reference knowledge;
- examples;
- templates.

Examples should clarify or test a rule, not replace it.

Keep small examples inline. Put large reusable examples in assets.

Write the underlying rule so it remains understandable without the examples.

Do not imply that examples are exhaustive, default, or normative unless that is intentional.

Include rationale only when it materially improves correct application of the rule.

Keep consequential behavior explicit.

## Artifact Relationships

For related artifacts, determine:

- which artifact owns each responsibility;
- which behavior is inherited;
- which behavior intentionally specializes another rule;
- which supporting artifacts are optional or required;
- what handoffs exist;
- which location remains authoritative when duplication is deliberate.

Supporting references, assets, templates, and tools inherit authority from the Skill that owns them. They support the Skill but do not independently override its behavior.

Avoid:

- overlapping ownership;
- stale related artifacts;
- unclear specialization;
- hidden dependency between files.

When a Skill composes with another Skill, keep each capability's responsibility clear rather than merging them unnecessarily.

## Dependencies and Compatibility

Identify dependencies that materially affect Skill operation, including:

- tools;
- libraries;
- runtimes;
- operating systems;
- network access;
- external services;
- project files;
- other Skills.

Make required dependencies explicit.

Describe compatibility constraints when they matter.

Detailed installation or setup instructions may live elsewhere when they would unnecessarily enlarge the Skill.

For optional dependencies, define the resulting capability, failure behavior, or fallback when relevant.

Do not rely on hidden dependencies.

## Output Expectations

Define an explicit output contract when the result is not obvious or when downstream behavior depends on it.

This is especially useful when:

- another agent, Skill, or tool consumes the result;
- specific fields are required;
- success and partial completion differ;
- later decisions depend on the result;
- the user needs specific information to continue.

Do not create a formal output contract for a simple Skill whose result is already obvious.

Define only what is needed:

- content or fields;
- format;
- status;
- intentional omissions;
- failure or partial-completion behavior.

Apply the parent Skill's Output Design rules.
