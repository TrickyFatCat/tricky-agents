# Pi Extension Package Research

Use this reference when the user asks about published Pi extensions, Pi packages, package alternatives, or whether to add a Pi capability that may already exist online.

The goal is to find and evaluate existing published options before proposing local implementation or installation.

## Workflow

1. Search published sources first.
2. Inventory an existing local implementation only after the published search, when one exists.
3. Check popularity and maintenance signals.
4. Check general consensus and user feedback.
5. Review runtime safety and behavioral influence before recommending installation.
6. Give candidate links and findings to the user first.
7. Do not install packages, create local extensions, or modify Pi configuration unless the user directly asks for that follow-up action.

## Search Order

Start with sources that are most likely to contain Pi-specific packages:

- Pi package gallery: <https://pi.dev/packages>
- npm packages tagged or described as Pi packages, especially packages with the `pi-package` keyword.
- GitHub repositories that expose Pi package manifests, `extensions/`, `skills/`, `prompts/`, `themes/`, or documentation for Pi.
- Existing installed packages only as local context, not as a substitute for published-package search.

When useful, also inspect Pi's current package and extension documentation:

- [Pi package documentation](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/packages.md)
- [Pi extension documentation](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/extensions.md)

## Popularity and Maintenance Signals

Compare candidates using available signals, such as:

- npm downloads, version history, package age, and publish recency.
- GitHub stars, forks, watchers, open issues, closed issues, and recent commits.
- Release tags and changelog quality.
- Maintainer identity and whether the package appears connected to Pi's ecosystem.
- Documentation completeness and working examples.

Qualify the signals:

- Distinguish package-specific stars from stars on a multi-package repository.
- Treat npm downloads as usage evidence that may include automation, mirrors, CI, or lockstep package installs.
- Distinguish package-specific maintenance from frequent monorepo-wide version publishing.
- Do not describe adoption evidence as general consensus when independent user evidence is sparse.

Do not treat popularity as proof of safety. A low-popularity package may still be the best option if it is simple, well-scoped, and source-reviewable.

## Consensus and Fit

Look for general agreement about the package or approach:

- Positive or negative issue discussions.
- Repeated user reports of breakage or success.
- Whether Pi docs/examples recommend the same API pattern.
- Whether the package solves the user's actual workflow or adds unnecessary scope.

If evidence is sparse, say so and reduce confidence.

## Safety Review

Before recommending install, inspect source or package contents when possible.

Prefer the exact published version over a repository's moving default branch:

- Inspect registry metadata and the published archive or file list without installing or executing it.
- Compare the published artifact with its linked source repository when provenance matters.
- Inspect the package manifest, lifecycle scripts, runtime dependencies, and relevant transitive dependencies.
- Inspect every Pi resource declared by the package manifest, including extensions, skills, prompts, and themes.
- Separate executable side effects from behavioral influence caused by tool descriptions, prompt guidance, bundled skills, or event hooks.

Check whether the package or extension:

- Runs shell commands or starts processes.
- Reads, writes, deletes, or watches files.
- Uses network access or downloads code/data.
- Handles credentials, API keys, tokens, SSH, Git, or browser/session data.
- Registers global hooks that intercept tools, inputs, sessions, or provider requests.
- Adds skills or prompt guidance that can force, suppress, or substantially redirect agent behavior.
- Starts long-lived resources such as daemons, servers, timers, or file watchers.
- Has install scripts or unusual dependency behavior.

State the observed risk level and the evidence. If source cannot be inspected, do not recommend installation without that limitation.

## Recommendation Rules

Prefer this order of recommendations after completing the published search:

1. Keep an existing local implementation when it already fits, has a smaller safety surface, and remains practical to maintain.
2. Use an existing published package if it is source-reviewable, maintained, and materially improves fit.
3. Adapt a simple existing package or official example when it nearly fits.
4. Create a local extension only when published options are missing, unsafe, stale, or over-scoped.

Always provide links first and ask what the user wants to do next. Do not run `pi install`, edit `~/.pi/agent/settings.json`, create local extensions, or modify Pi package configuration unless the user directly asks for implementation.

## Response Shape

For package research, use a compact structure like:

1. Best candidates or current finding.
2. Links for user review.
3. Popularity/maintenance signals.
4. Runtime and behavioral safety notes.
5. Comparison with an existing local implementation, when applicable.
6. Recommendation and next step.

Keep uncertainty visible. Distinguish searched-and-not-found from not-yet-searched.
