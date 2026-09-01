# Task Design

Read this reference when work is vague, uncertain, multi-step, risky, or dependent on decisions that should be preserved.

Use only the guidance that improves execution or resumption. Do not add structure merely to make a plan look complete.

## Define the Task

Identify:

- The desired outcome.
- The definition of done or success evidence.
- Important scope boundaries.
- Confirmed decisions and assumptions.
- Decision-changing unknowns.
- Constraints such as time, tools, permissions, compatibility, or storage rules.

Restate these only when they clarify the plan or preserve context needed to resume.

## Break Work into Outcomes

Prefer tasks that represent meaningful progress:

- Decide an approach.
- Inspect relevant evidence or current state.
- Produce or update one coherent artifact.
- Validate behavior or content.
- Obtain approval for a risky or persistent change.
- Record a verified result or remaining blocker.

Avoid mechanical tasks such as opening a file, reading one line, typing one sentence, or saving a document.

Prefer one clear deliverable per task. For substantial tasks, use an Objective, Tasks, and Acceptance Criteria. Treat more than roughly 8–10 distinct subtasks, several independent deliverables, or work unlikely to fit one focused session as a split signal rather than an automatic rule.

Split a task when parts have different outcomes, owners, blockers, statuses, or validation requirements. Keep related actions together when splitting would add tracking overhead without making progress clearer.

## Handle Uncertainty

Add an investigation outcome before implementation when missing information can change the approach.

When the core approach is undecided:

1. Identify the smallest decision-changing unknown.
2. Research or inspect only enough to resolve it.
3. Return the result to the decision workflow.
4. Plan implementation only after the approach is confirmed.

Keep long-term ideas exploratory. Do not invent detailed implementation steps for choices the user has not made.

## Preserve Decision Handoffs

When another workflow establishes a decision, record only context useful for future execution:

- Chosen approach.
- Rationale.
- Constraints and success criteria.
- Rejected alternatives that may otherwise recur.
- Remaining risks or unknowns.
- Relevant evidence and source paths.

Distinguish recommendations from confirmed user decisions.

## Dependencies and Blockers

Make ordering visible when one outcome depends on another.

A useful blocker statement identifies:

- What cannot proceed.
- The blocking decision, artifact, dependency, or external event.
- Who or what can resolve it, when known.
- The next action available while waiting, if any.

Create a dependency only when the dependent task cannot realistically start without the predecessor's output. Use priority for preference ordering and tags for non-blocking relationships.

Do not create dependency links that add no practical navigation or scheduling value.

## taskmd Organization

Start persistent taskmd work with a flat task directory. Add groups when task volume or durable work areas make the flat view noisy; do not pre-build a hierarchy for a small or uncertain project.

Let taskmd allocate identity and derive group from directories when appropriate. Keep metadata proportional and use an applicable template to reduce repeated structure rather than adding speculative fields.

## Priority

Use priority only when it helps triage work.

Follow project-local metadata first. Otherwise prefer priority at the task or card level:

- `high`: blocks progress, prevents validation, avoids likely breakage, or is time-critical.
- `medium`: important but does not block immediate progress.
- `low`: optional follow-up, polish, or cleanup.

Add priority to individual todo items only when one artifact contains independently triaged work. Do not mark every item high.

## Effort, Difficulty, and Energy

Do not add effort or difficulty by default.

Use an effort, size, difficulty, or energy label only when:

- The user requests it.
- The active project requires it.
- The user wants to select work based on available time, energy, focus, or complexity.

Define labels in terms useful to that workflow. Do not confuse time-consuming work with reasoning difficulty or operational risk.

## Safety and Validation

Add explicit outcomes when relevant for:

- Backups or state inspection before destructive work.
- Permission or security review.
- Reversible testing.
- Compatibility checks.
- Migration and rollback.
- Automated tests, formatting, status output, logs, or manual verification.

Validation should prove the desired outcome, not merely confirm that commands ran.

## Usage Inventories

When implementation work needs a call-site or direct-usage inventory, keep it focused on the affected interface.

Capture:

- Relevant area or package.
- Precise path.
- Current usage.
- Compatibility or migration impact.

Use `code-reviewer` when the inventory requires evaluating implementation correctness or interface design. Do not expand a direct-usage check into a full dependency audit unless requested.

## Design Check

Before presenting the plan, confirm:

1. Every task contributes to the goal or reduces a meaningful risk.
2. The sequence respects real dependencies.
3. Decisions are not presented as settled when they remain open.
4. Validation and approval are included where needed.
5. Metadata is no heavier than the workflow requires.
6. Persistent taskmd work has one deliverable, proportional metadata, and only genuine blocking dependencies.
7. The next action is visible.
