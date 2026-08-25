# Pi Extension Package Research

Use this reference when the user asks about published Pi extensions, Pi packages, package alternatives, or whether to add a Pi capability that may already exist online.

The goal is to find and evaluate existing published options before proposing local implementation or installation.

## Workflow

1. Search published sources first.
2. Check popularity and maintenance signals.
3. Check general consensus and user feedback.
4. Review safety before recommending installation.
5. Give candidate links and findings to the user first.
6. Do not install packages, create local extensions, or modify Pi configuration unless the user directly asks for that follow-up action.

## Search Order

Start with sources that are most likely to contain Pi-specific packages:

- Pi package gallery: <https://pi.dev/packages>
- npm packages tagged or described as Pi packages, especially packages with the `pi-package` keyword.
- GitHub repositories that expose Pi package manifests, `extensions/`, `skills/`, `prompts/`, `themes/`, or documentation for Pi.
- Existing installed packages only as local context, not as a substitute for published-package search.

When useful, also inspect Pi's local package documentation:

- `/home/tricky-fat-cat/.local/lib/node_modules/@earendil-works/pi-coding-agent/docs/packages.md`
- `/home/tricky-fat-cat/.local/lib/node_modules/@earendil-works/pi-coding-agent/docs/extensions.md`

## Popularity and Maintenance Signals

Compare candidates using available signals, such as:

- npm downloads, version history, package age, and publish recency.
- GitHub stars, forks, watchers, open issues, closed issues, and recent commits.
- Release tags and changelog quality.
- Maintainer identity and whether the package appears connected to Pi's ecosystem.
- Documentation completeness and working examples.

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

Check whether the package or extension:

- Runs shell commands or starts processes.
- Reads, writes, deletes, or watches files.
- Uses network access or downloads code/data.
- Handles credentials, API keys, tokens, SSH, Git, or browser/session data.
- Registers global hooks that intercept tools, inputs, sessions, or provider requests.
- Starts long-lived resources such as daemons, servers, timers, or file watchers.
- Has install scripts or unusual dependency behavior.

State the observed risk level and the evidence. If source cannot be inspected, do not recommend installation without that limitation.

## Recommendation Rules

Prefer this order of recommendations:

1. Use an existing published package if it is source-reviewable, maintained, and fits the user's request.
2. Adapt a simple existing package or official example when it nearly fits.
3. Create a local extension only when published options are missing, unsafe, stale, or over-scoped.

Always provide links first and ask what the user wants to do next. Do not run `pi install`, edit `~/.pi/agent/settings.json`, create local extensions, or modify Pi package configuration unless the user directly asks for implementation.

## Response Shape

For package research, use a compact structure like:

1. Best candidates or current finding.
2. Links for user review.
3. Popularity/maintenance signals.
4. Safety notes.
5. Recommendation and next step.

Keep uncertainty visible. Distinguish searched-and-not-found from not-yet-searched.
