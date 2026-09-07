# Skill Evaluation

## Evaluation Scope

Use evaluation proportionally to the change.

Distinguish:

- **structural validation** — conformance to defined requirements, file structure, paths, contracts, and dependencies;
- **trigger evaluation** — whether the Skill activates for the right requests;
- **behavioral evaluation** — whether the Skill behaves correctly and effectively after activation;
- **regression comparison** — whether a revision improves behavior without losing important existing behavior.

Use realistic tasks and observable evidence.

Do not treat structural validity as evidence that the Skill behaves well.

## Structural Validation

Check as relevant:

- required `SKILL.md` exists;
- YAML frontmatter is valid;
- required fields are present;
- field constraints are satisfied;
- Skill name matches its directory where required;
- referenced paths and files exist;
- dependencies and compatibility constraints are documented when necessary;
- tools expose their intended contracts;
- supporting files have a clear purpose;
- links and references are not stale.

Prefer deterministic tools for checks that can be validated mechanically.

Classify findings using the parent Skill's review labels.

Do not turn structural validation into unrelated style review.

## Trigger Evaluation

Evaluate both:

- **positive cases** — prompts that should activate the Skill;
- **near-miss negative cases** — similar prompts that should not.

Vary:

- phrasing;
- tone;
- explicit and implicit intent;
- available context;
- task complexity;
- direct terminology versus indirect need.

For substantial trigger evaluation, around 8–10 positive prompts and 8–10 negative prompts is a useful starting point.

Repeat representative cases when trigger stability matters. Three runs per case is often enough to expose instability without excessive cost.

Record whether the Skill actually loads rather than inferring success from the description.

Classify failures as:

- false negative;
- false positive;
- unstable triggering.

Fix the underlying trigger category or boundary rather than patching isolated keywords.

For substantial description optimization, use separate development and validation cases. A roughly 60/40 split is reasonable.

Do not repeatedly tune against the validation set until it passes. Use fresh sanity cases when useful.

Smaller changes may use a proportionally smaller set.

## Behavioral Evaluation

Use realistic tasks representative of actual use.

Include as relevant:

- a typical task;
- an edge case;
- a consequential decision boundary.

Assess observable behavior such as:

- correct scope;
- appropriate decisions;
- correct clarification behavior;
- precedence and convention handling;
- correct use of references, assets, and tools;
- required output;
- avoidance of unrelated behavior.

Derive assertions from intended behavior.

Examples of useful assertions:

- the Skill asks before making an unauthorized consequential architectural change;
- the Skill does not ask for redundant confirmation on an explicitly requested low-risk edit;
- a local Skill specialization is not mistaken for permission to override global safety;
- the Skill preserves accepted constraints during simplification.

Do not evaluate only whether the prose appears plausible.

## Regression Comparison

For material revisions, compare against:

- the previous Skill version; or
- a no-Skill baseline when that comparison is useful.

Use the same representative tasks when possible.

Check for:

- improvements;
- regressions;
- trigger regressions;
- lost constraints;
- unnecessary complexity;
- excess verbosity;
- unnecessary latency or tool use;
- new trade-offs.

A different result is not automatically an improvement.

When a trade-off remains genuinely unresolved and materially affects the design, treat it as **🟡 Decision needed**.

## Evidence and Assertions

Prefer observable assertions tied to intended behavior.

Evidence should be:

- specific;
- attributable to an actual task, trigger, artifact, or tool result;
- diagnosable when it fails.

Useful assertion outcomes include:

- pass;
- fail;
- inconclusive.

Do not mark an assertion as passed merely because the intended rule exists in the instructions.

When an assertion fails, fix the underlying behavior rather than only rewriting the test.

## Proportionality and Completion

Use the smallest evaluation set that provides reasonable confidence.

A narrow change may need:

- structural validation;
- one or two focused behavioral cases;
- targeted trigger cases when the description changed.

A broad change may justify:

- positive and negative trigger sets;
- multiple behavioral cases;
- regression comparison;
- integration or orchestration checks.

Do not manufacture comprehensiveness where it adds little confidence.

Evaluation is complete when the relevant structure, triggering, behavior, assertions, and regressions have been considered proportionally.

If evaluation is incomplete, state:

- what was checked;
- what remains unverified.

Do not imply success for unverified behavior.

Treat material failures affecting correctness, triggering, safety, or intended behavior as **🔴 Required**.
