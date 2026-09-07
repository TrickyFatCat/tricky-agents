# AGENTS.md Design

## Purpose and Authority

Use `AGENTS.md` to define agent behavior, conventions, constraints, decision rules, and workflow for its scope.

An `AGENTS.md` is an authoritative source for project- or scope-level agent conventions and workflow unless a more specific applicable instruction intentionally specializes them.

Do not use ownership and authority interchangeably:

- **ownership** identifies the primary home for a responsibility;
- **authority** identifies the source allowed to establish behavior within its scope.

## Global and Local AGENTS.md

### Global AGENTS.md

Use global `AGENTS.md` for broadly applicable behavior such as:

- non-overridable safety rules;
- explicit user working preferences;
- default decision behavior;
- response and interaction preferences;
- conventions intended to apply across projects.

Project-specific workflow, tooling, naming, or repository structure normally belongs locally unless the user intentionally wants the convention everywhere.

Global safety rules are non-overridable.

Other global rules act as defaults and may be intentionally specialized by global Skills or local configuration.

### Local AGENTS.md

Use local `AGENTS.md` for project- or scope-specific:

- behavior;
- conventions;
- constraints;
- workflow;
- tool expectations;
- repository structure;
- decision boundaries.

A local `AGENTS.md` may specialize or override non-safety global defaults within its scope.

Keep important rules directly in `AGENTS.md` or route to references depending on their detail and loading needs.

Do not duplicate global rules merely for completeness unless the local copy changes them or materially improves visibility, reliability, or understandability.

### Interaction with Skills

Outside global safety, local Skills may specialize local `AGENTS.md` behavior within their capability scope.

Do not treat specificity alone as proof that a conflicting Skill rule is intentional.

Preserve project-wide conventions unless the specialization is clearly intentional and valid under the project's instruction model.

References and other supporting artifacts inherit authority from the `AGENTS.md` or Skill that owns them. They are not an independent precedence layer.

When the relationship is ambiguous, apply the parent Skill's conflict-resolution rules rather than silently choosing.

Any local instruction that conflicts with global safety is a **🚨 Critical safety conflict**.

## Scope and Applicability

Design each `AGENTS.md` so agents can determine:

- **scope** — where the instructions apply;
- **applicability** — when a particular rule or workflow within that scope applies.

Local scope may correspond to:

- a project;
- subtree;
- component;
- workspace;
- another explicit structural boundary.

Conditional rules should state relevant applicability, such as:

- task type;
- artifact type;
- environment;
- workflow situation.

Prefer boundaries that correspond to actual project structure and workflow.

When multiple `AGENTS.md` files apply, narrower instructions may intentionally specialize broader ones, subject to global safety.

Do not rely on hidden conversational assumptions to establish scope.

When an unclear boundary could materially change behavior, treat it as **🟡 Decision needed**.

## Instruction Placement

Place instructions according to scope, responsibility, and loading frequency.

Keep directly in `AGENTS.md` when the rule concerns:

- project- or scope-level behavior;
- local workflow;
- conventions;
- constraints;
- decision boundaries;
- precedence;
- safety that must remain visible.

Use a reference when:

- guidance is detailed or conditional;
- keeping it inline would make `AGENTS.md` unnecessarily large;
- conditional loading materially reduces context cost.

When `AGENTS.md` depends on a reference:

- state when it should be consulted;
- keep consequential routing or behavior visible in `AGENTS.md` when omission would materially change behavior;
- prefer direct `AGENTS.md` → reference routing;
- avoid deep chains except for clearly specialized subtopics.

References owned by an `AGENTS.md` inherit its authority. They may provide detailed guidance but must not independently redefine or override behavior established by the owning `AGENTS.md`.

Use a local Skill when there is a distinct capability with its own triggering, workflow, decisions, or supporting artifacts.

Use project documentation for primarily human-facing information.

Do not move content merely to shorten `AGENTS.md`, hide consequential rules in references, or duplicate information merely for completeness.

Keep one authoritative owner for consequential behavior.

## Project Conventions and Workflow

Use local `AGENTS.md` as the authority for confirmed project-level conventions and workflow.

Do not infer that a repeated observed pattern is an established convention.

When a pattern appears intentional and materially affects work but is undocumented:

- surface the ambiguity;
- ask the user when necessary.

If confirmed, recommend formalizing the convention under `AGENTS.md` authority.

Depending on project structure:

- concise conventions may live directly in `AGENTS.md`;
- detailed conditional guidance may live in a reference.

Do not create a competing convention system.

For project workflows, make clear as relevant:

- applicability;
- sequence or handoffs;
- mandatory versus situational steps;
- user decision points;
- involved tools, Skills, and artifacts.

Do not turn incidental project history into a permanent rule without confirmation.

## Ambiguity and Decision Boundaries

Design `AGENTS.md` so agents can tell when to proceed and when to ask.

Consequential decision boundaries may include changes to:

- behavior;
- scope;
- architecture;
- ownership;
- compatibility;
- workflow;
- conventions;
- destructive project state.

Do not make instructions so concise that important decision boundaries disappear.

Do not design a repeated ambiguous request to inherit the interpretation of a previous similar request automatically.

Use current context and explicit decisions. Require clarification when consequential alternatives remain unresolved.

Avoid vague rules such as "ask when needed" or "use judgment" when materially different interpretations would change behavior.

When unresolved project context is necessary, design focused clarification rather than broad questioning.

Design direct-action rules for cases where intended behavior is sufficiently defined by:

- explicit user intent;
- established project context;
- an agreed plan or workflow;
- low-risk or reversible scope.

## Size and Maintainability

Keep `AGENTS.md` concise and findable.

Reduce size by:

- removing unnecessary duplication;
- moving detailed conditional knowledge to references;
- removing rationale or examples that do not affect behavior;
- consolidating overlapping rules;
- keeping only project workflow that agents actually need.

Do not optimize for brevity at the expense of behavior.

Keep safety, precedence, decision boundaries, workflow routing, authority, scope, and other expected behavior directly visible when hiding them would create material risk.

Extract detail based on conditional loading value, not line count alone.

Prefer a few high-value rules over exhaustive low-value guidance.

## Cross-File Consistency

When reviewing related `AGENTS.md`, Skills, and references, check for:

- multiple artifacts claiming the same responsibility;
- local Skills that unintentionally contradict project conventions;
- references containing hidden behavioral authority;
- inconsistent terminology;
- unclear workflow ownership;
- stale instructions.

Not every difference is a conflict. Intentional specialization is valid when its scope and relationship are clear.

When two local sources describe the same behavior differently and intent is ambiguous, surface the conflict.

Keep one authoritative owner for each consequential responsibility.

When a convention changes, check dependent artifacts that may encode the old convention.
