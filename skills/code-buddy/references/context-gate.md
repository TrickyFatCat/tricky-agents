# Context Gate

Read this file as soon as the context gate starts, before you detect or ask anything, in a review or in coaching that goes through code step by step.

Sections, in order: Gathering It; Context Block; Unknown Values; Pasted Code; During The Session.

A review, or coaching that goes through code step by step, needs five facts:

1. The language and its version.
2. The engine or framework and its version, when there is one.
3. The project stage: learning, prototype, early or production.
4. What the code is meant to do.
5. The session goal, including which files are in scope.

Also find out whether you can check claims: by running installed help, by reading docs, or not at all.
Never ask the user this, because you can find it out yourself.
Ask about target platform, performance budget or the user's skill level only when the answer depends on them.

## Gathering It

1. Detect first. Read the project files and run read-only tools, such as `nu --version` or the engine's project file.
   Read the project's own conventions too, such as `AGENTS.md` and style or linter settings.
   Findings about names and comments follow them. Report a conflict between them and this skill instead of choosing.
2. Send one message with every context question together, and no context block:
   - the stage, always, unless the request already states it, because code cannot show it;
   - each value you could not detect;
   - a framework you had to guess, to confirm;
   - a scope proposal, whenever you will not read every file in the target, such as "40 files. Start with `combat/enemy_ai.gd` and `combat/health.gd`?".

   Do not report what you detected or what you will read, because the context block shows it.
   The scope proposal and a guessed framework are the only exceptions.
   Put a reason for a question in its own paragraph below the question.
3. After the answers, show the context block with "Correct?".
4. Start the work once it is confirmed.

## Context Block

One fact per line, in this order:

```text
Review: combat/enemy_ai.gd
Stage: prototype
Lang: GDScript 4.3
Framework: Godot 4.3
Goal: find bugs

Correct?
```

The first line names the mode and the target: code, a file, a folder or a project.
Write `Framework: none` when there is none.
Write `?` for a value that is still unknown.
When checking is not possible in this session, say so once, in one sentence below the block.

## Unknown Values

When the user says "doesn't matter", "you decide", or gives no answer, pick the neutral value and continue:

- stage: no stage weighting and no Later group;
- version: the installed version.

Show each such value in an Assumptions block under the context block.
Write every finding that depends on it as a condition, and do not ask again.

When the user says "check the file", use what the files show.
Treat a value the files cannot show, such as the stage, as "doesn't matter".

## Pasted Code

For a pasted file or snippet with no request, or a request to assess it, ask no stage or goal questions.
Before the review, ask only two things, and only when they apply:

- the version, when a finding depends on it;
- whether a framework you guessed is right.

Write `?` for other unknown values in the block, and write dependent findings as conditions.
Show the block and continue in the same message. Do not ask "Correct?" for pasted code.

## During The Session

When the context changes, such as a prototype turning out to be production code, re-rank the findings and say so.
