# Orchestration

## Design Principles

Use orchestration when coordinating multiple agents, Skills, tools, models, or stages creates real value.

A **workflow** is the sequence of work, decisions, and handoffs that produces an outcome.

**Orchestration** is the coordination of multiple components within that workflow.

For each component, make clear as relevant:

- responsibility;
- trigger or entry condition;
- required input;
- expected output;
- consequential decisions;
- next stage.

Do not create stages merely for modularity.

Prefer a simpler workflow when separation adds handoffs, context cost, or failure modes without meaningful benefit.

Treat unclear ownership, duplicated responsibility, cycles, and unnecessary handoffs as design problems.

## Sequencing and Handoff Boundaries

Sequence stages only when their order materially matters.

For each handoff, determine:

- why the handoff exists;
- what triggers it;
- what the previous stage must complete;
- what information or artifact is transferred;
- whether responsibility transfers;
- what the receiver does next.

A **delegation** assigns work to another component while overall responsibility may remain with the caller.

A **handoff** transfers work, context, or responsibility to the next component.

Do not create handoffs merely because implementation is split across components.

Prefer direct handoffs over unnecessary intermediate routing.

Do not serialize independent work unless order is required.

Use branching only when distinct conditions genuinely require different paths.

Make user decision points explicit.

Treat hidden dependencies between stages as a workflow defect.

## Handoff Contracts

For material handoffs, define:

- what the sender must provide;
- what the receiver may assume;
- required context, artifacts, identifiers, or state;
- expected output;
- completion status;
- failure or partial-completion behavior;
- who owns consequential decisions.

### Structured Control Data

Strongly prefer structured control data for information such as:

- scope;
- identifiers;
- status;
- findings;
- classifications;
- accepted decisions;
- actions;
- validation results;
- errors;
- partial completion.

Avoid free-form prose when downstream work would otherwise need to infer compact control information.

Preserve native artifact formats when the artifact itself is intrinsic to the work.

For example, a writer may pass a prose document directly to a reviewer. The reviewer may then return structured findings when downstream action depends on those findings.

Do not encode hidden assumptions in handoff text.

When materially different handoff designs remain reasonable, treat the choice as **🟡 Decision needed**.

## Context and State

**Context** is information made available to a component for its current work.

**State** represents the current condition of a workflow or project and may need to persist or change across stages.

For each stage, determine:

- what context it actually needs;
- which state is authoritative;
- where durable state lives;
- who may update it.

Prefer:

- compact structured state;
- references to authoritative artifacts instead of copied content;
- reconstruction from authoritative sources when more reliable than carrying stale context.

Avoid:

- forwarding the entire conversation by default;
- duplicated state;
- relying on hidden model memory for durable state;
- carrying obsolete context into later stages.

### Context Isolation

Use deliberately limited context when independent judgment is valuable.

For example, an independent reviewer may receive:

- the artifact;
- review criteria;
- required project conventions;
- applicable specifications;
- safety constraints;
- accepted scope.

It may intentionally omit:

- the author's prior reasoning;
- previous conclusions;
- persuasive discussion history.

Provide additional context only when needed for correctness.

When a fresh perspective matters, minimize biasing context.

### Shared State

When multiple components share mutable state, define:

- the authoritative owner;
- which components may update it;
- how conflicting updates are handled.

Avoid competing copies of the same mutable state.

## Model Allocation

Assess model capability first at the individual Skill or stage level using the applicable Skill requirements.

Then allocate models across the workflow based on:

- responsibility;
- required reliability;
- latency and cost;
- context demands;
- tool support;
- failure impact;
- how much strong contracts and validation reduce reasoning needs.

Prefer the least capable model that reliably performs the stage.

Simpler models are often suitable for constrained, deterministic, repetitive, or tool-supported stages.

Stronger models may be justified for deep reasoning, ambiguity, synthesis, consequential trade-offs, or subtle cross-artifact conflicts.

Do not use a stronger model to compensate for weak workflow design.

When model allocation materially affects reliability, cost, latency, or behavior, treat it as a consequential design choice.

### Fallback Models

Define which stages may use a fallback model.

A fallback must still satisfy the required stage contract.

Make reductions in capability, quality, or reliability explicit when they matter.

Do not silently substitute a fallback that changes required behavior.

## Failure, Retry, and Fallback

Define failure handling explicitly for material stages.

Distinguish recoverable failures from terminal ones.

Retry only when the failure is plausibly transient or input-correctable and retry remains low-risk and authorized.

Keep retries bounded.

Use an automatic fallback only when it preserves required:

- behavior;
- constraints;
- authorization;
- output contract.

Ask the user when a fallback would materially change:

- behavior;
- scope;
- architecture;
- model or tool assumptions;
- output quality;
- cost or latency;
- project state.

Preserve useful partial work rather than discarding it unnecessarily.

Avoid:

- retry loops;
- repeated handoffs with no new information;
- silent quality degradation;
- throwing away valid partial results.

A fallback may be an implementation detail, but it must not expand authorization.

## Workflow Validation and Completion

Validate the affected workflow proportionally.

Check as relevant:

- stage responsibilities, contracts, and dependencies;
- routing and sequencing;
- handoffs, identifiers, and structured control data;
- shared state, state shape, and context flow;
- tool, agent, and stage integration;
- model allocation;
- retry and fallback behavior;
- the final user-visible outcome.

Successful internal stages do not by themselves mean the workflow succeeded.

Completion should be judged against the requested outcome, including as relevant:

- required artifacts or results;
- accepted decisions;
- validation signals;
- unresolved failures or partial completion;
- information the user needs.

When the workflow has not been fully validated, distinguish what was checked from what remains unverified.

For partial completion, preserve useful results and make the remaining work or failure explicit.
