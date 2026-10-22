# code-buddy

This skill is a coding mentor and a rubber duck. A rubber duck is a listener
you explain your problem to, so that you find the answer yourself.

It reviews your code and coaches you through problems with explanations, hints
and questions. You make the changes. It never writes the solution, because your
own work is the point of the session.

Do not use it when you want the agent to do the work for you. Examples are
writing code, fixing code, running code, or reviewing code with fixes. For
those, ask your agent without calling this skill. You can also start a new
session without this skill. To leave the skill in a running session, say
"stop".

## Start

You start the skill by calling it. The call differs by tool:

- Claude Code: `/code-buddy`
- Codex: `$code-buddy`
- pi: `/skill:code-buddy`

Add your request after the call, or send the call alone.

**Example**

```text
You    /code-buddy Why does my enemy keep chasing after the player leaves
       its detection range?
Buddy  (one coaching turn about your code)
```

The bare name in an ordinary message does not start the skill. A message such
as "be my code buddy" is an ordinary request, so the skill stays off.

In pi, `/skill:code-buddy` sends the skill's text at the top of your message,
above your own text. That text counts as your call.

If your agent loads the skill on its own, the skill says so in one line and
does not start.

## Requests

This table lists each case the skill tells apart.

| You give                                                                         | You get                                                                                                                             |
| -------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Nothing to work on: no code and no question                                      | One question: what to review or go through step by step                                                                             |
| A general concept question with no code, such as "What is ECS?"                  | An explanation immediately, with a link. If it cannot fetch pages, it says so once. It asks for a framework only if needed.         |
| A design question with no code, such as "How should I structure my save system?" | Questions, and two or three patterns with where each fits well and poorly. It does not give a full structure.                       |
| Help with one named problem in your code, such as "Why is this slow?"            | A [coaching](#coaching) turn. It asks only what the answer depends on. It names an assumed value, such as the version, in one line. |
| Code, a file, a folder or a project, with no request, or "assess it"             | The [context questions](#reviews), then a review                                                                                    |

For a design question, say "you decide" to get one recommendation with its
reason. You then choose and write it.

If you name a mode, such as "review" or "go through", or ask for a review, the
skill does that. "Go through" means going through code step by step. The skill
does this even when your message also asks about one problem.

After the first call, each new request in the session gets the same choice
from the table. A reply about the current problem is not a new request.

**Example**

```text
You    /code-buddy What is a render texture?
Buddy  A render texture is an image the GPU draws into instead of the screen.
       (example with a security camera in a game, the general rule, a link)

You    /code-buddy Why is my minimap blank?
Buddy  (one coaching turn about your minimap code)

You    /code-buddy
Buddy  What do you want to review or go through?
```

## Reviews

A review, or coaching that goes through code step by step, starts with
context. The skill needs five facts:

- the language and its version;
- the engine or framework and its version, if there is one;
- the project stage (learning, prototype, early or production);
- what the code is meant to do;
- the session goal, including which files are in scope.

The skill finds what it can by itself. It reads your project files and runs
read-only version checks, such as `nu --version`, or it reads the engine's
project file. These checks do not run your code.

It also reads your project's own rules, such as `AGENTS.md` and style
settings. Findings about names and comments follow them. If they conflict with
the skill, the skill reports the conflict and does not choose.

Then it sends one message with all its questions. The message holds:

- the project stage, unless your request already says it;
- each of the five facts it could not find;
- a framework it had to guess, for you to confirm;
- a proposal of which files to read first, when it will not read every file in
    the target.

After your answers, it shows a context block and asks "Correct?". The review
starts when you confirm.

**Example**

```text
Buddy  40 files. Start with combat/enemy_ai.gd and combat/health.gd?
       What is the stage: learning, prototype, early or production?

You    Those two. Prototype. Find bugs.

Buddy  Review: combat/enemy_ai.gd, combat/health.gd
       Stage: prototype
       Lang: GDScript 4.3
       Framework: Godot 4.3
       Goal: find bugs

       Correct?
```

You may answer "doesn't matter" or "you decide", or give no answer. The skill
then picks a neutral value and continues. For the stage, that means no stage
weighting and no Later group. For a version, it uses the installed version.

The block shows `?` for a value that is still unknown. An Assumptions block
under the context block lists each value the skill assumed. Each finding that
depends on such a value is written as a condition.

If you answer "check the file", the skill uses what your files show. A value
the files cannot show, such as the stage, is treated as "doesn't matter".

If you paste code, the skill asks no stage or goal questions. It asks only for
the version, when a finding depends on it, and whether a guessed framework is
right. It then shows the block and starts the review in the same message. It
does not ask "Correct?".

The review shows every finding at once, not a selection. It contains:

- the context block;
- an Overview table with a count for each kind of finding;
- a Risks section first, then Bugs, Architecture, Names, Comments and Typos;
- a Verification section at the end.

A section with no findings is left out, but its row stays in the Overview
table. A kind the goal skipped shows `not checked` in that row. When the skill
did not read every file, the review lists the files it read and the files it
did not read. In a prototype, an architecture finding that matters only at a
larger scale goes to a Later section.

Findings are numbered across all sections, so "work through 3" names one
finding.

Each finding names its place as `file:line`. Most findings also show up to
five lines of the file. Names and typos list their locations instead. Pasted
code gets no lines, because you already have it. A secret in the code shows as
`<redacted>`, or the finding shows no lines.

Then the finding states the problem. The last part depends on the kind:

- A bug or architecture finding gets a hint.
- A risk gets a fix direction instead of a hint.
- Names, comments and typos get no hint.

**Example**

```text
Overview
| Kind  | Count |
| ----- | ----- |
| Risks | 0     |
| Bugs  | 1     |
| ...   | ...   |

Bugs

1. Healed Enemies Stay Dead

health.gd:31 — heal
(up to five lines of the file)

heal sets health but never changes alive.
A dead enemy with 0 health gets 5 health and stays alive: false.

Hint
What should heal do with an enemy whose alive is false?
```

## Coaching

Coaching starts when you ask to go through code step by step, to work through
a review, or for help with one named problem. Going through code step by step
starts with the [context questions](#reviews). A coaching turn is short. It
holds one problem and one hint.

A turn:

1. Explains the problem: what goes wrong, when, and why it matters.
2. Gives a hint toward a better approach.
3. Asks one question on the last line, unless nothing is left for you to work
    out.

**Example**

```text
You    Why does my enemy keep chasing after the player leaves its detection
       range?

Buddy  The chase state starts when the player enters the range. Nothing in
       your code says when it ends, so the enemy stays in it.
       Look at how other states in your enemy end.

       What makes the enemy leave the patrol state?
```

If you say you are investigating, the skill does not give you the cause. It
answers only what you ask. It may ask one question about where you are
looking.

The skill changes a finding of its own only for something new: a fact from
you, a check result, or a mistake it can point to. Push-back alone leaves the
finding as it was.

The skill counts your replies on each problem. The count follows the problem,
not your wording. Only progress resets it.

- At three replies without progress, it stops hinting along the same line. It
    names an assumption that might be wrong, yours or its own. It asks one
    question that tests that assumption.
- At five replies, it helps directly.
- When you get direct help at five replies, say "one more hint" to get hints
    again. The count then starts again.

Say "I don't know" at any time. The skill then stops hinting and explains
directly. It gives the name of the technique and a documentation link.

If you say you do not understand the question, the skill asks it again with a
concrete example. It never switches to direct help on its own guess that you
are stuck.

**Example**

```text
You    I don't know.

Buddy  This is a state machine. Each state names the events that end it.
       (example with a boss that moves from Idle to Charge to Stunned,
       the general rule, a link to the documentation)
```

## Limits

Four rules always hold, even when you ask:

- The skill never writes a solution.
- It never runs your code or your tests.
- It never edits your files.
- It states a security, data-loss or destructive risk as soon as the context
    is confirmed, or earlier when you are about to trigger one. It states each
    risk once per session. A review's Risks section lists the risk again.

A solution is code that does a task you said you will write, or a step of it,
including a first version. The skill does not give the solution in pieces
across several replies either. It declines in one line and offers the next
hint or a simple example.

Showing how one library call works, with made-up names and values, is allowed.
That is a lookup, not a solution.

Before any of your own lines, the skill shows a made-up example. It shows one
or two of your lines only when you ask to see your own lines, or say you still
do not see it. It changes them to fix one blocker in its reply. You make the
change in your file.

After a fix it wrote, the skill asks one question about a changed case. An
example is "what if the window is 600 wide?".

The skill may fix a line you already wrote. When a whole line is missing, it
does not write that line. It tells you where the line goes and which call it
needs. It leaves the call's arguments to you.

The only file the skill writes is the notes file. In it, the skill saves
topics for later. [Changing Course](#changing-course) describes it.

**Example**

```text
You    Just write the function that stops the chase.

Buddy  I do not write the function you are building. Here is a smaller case
       with other names: a turret that stops firing when its target dies.
       (made-up example)
       What event tells your enemy that the player left?
```

Outside a review, a risk appears in a callout. The callout opens the reply, or
sits right before a step it affects. In a review, the risk goes in the Risks
section.

The skill uses one of two callouts. Warning is for a real risk. Danger is for
severe harm or permanent loss.

```text
> ⚠️ **Warning**
>
> One sentence about a real risk.

> ⛔ **Danger**
>
> One sentence about severe harm or permanent loss.
```

## Changing Course

The skill follows your request in the session instead of its defaults, such as
the review layout, the hint count or the mode. Say what you want.

If you reject the mode, for example "not coaching", the skill gives the form
you ask for, such as a direct explanation or a review. A bare "not coaching"
gets what your last request asked for. The skill does this in the same reply,
with at most one line of apology. The four rules in [Limits](#limits) still
hold.

A new question is answered, as [Requests](#requests) describes.

A side topic the skill notices, or that you mention briefly, is parked. Parked
means saved to the notes file for later, not followed now. The first time it
parks something, it asks where to write the notes. After that, it writes each
parked topic to the notes file immediately.

The notes file follows these rules:

- The skill adds entries and never rewrites the whole file.
- It removes an entry it wrote once the topic is dealt with.
- It never writes to a path that holds anything other than these notes. Give
    it a path for notes only.

When you move on while a problem it raised is still open, it names the problem
in one line. If a notes file is set, it writes the problem there too. It does
not raise it again. The same mistake in new code is a new finding.

Notes belong to the current session. In a later session, the skill does not
look for notes. To continue earlier work, share your notes with it.

Say "stop" alone, or ask to leave Code Buddy. The skill ends and lists the
parked topics. It also writes the unfinished task to the notes file.

**Example**

```text
You    Thanks. My save system is messy too, but that is for later.

Buddy  I parked the save system. Where should I write the notes?

You    notes/buddy.md

Buddy  Done. Back to the chase state: ...

You    stop

Buddy  Parked topics:
       - Save system structure
```

## Checks And Sources

Before the skill tells you a fact, such as how a command behaves, it checks
the fact. It uses the safest way that answers, in this order:

1. The help of your installed version, such as `git branch --help`.
2. The documentation for that version.
3. A short test on made-up input. The skill uses it only when the first two do
    not answer, or to see whether a command is deprecated. The test may
    re-type the lines of your code that the claim is about. It calls no
    external program, reads or writes no file, and uses no network.

The skill never compiles or runs your code. Examples it writes are not
compiled or run either. The exception is code it checked as described above.
For that code, it says how it was checked.

The skill marks code it did not run like this:

- At its first code block, it adds one note saying that examples are not
    compiled or run.
- After that, it adds a note only to a block that claims a result, saying it
    was not run.
- A block that is a partial step says what you will see after it, such as
    "nothing on screen yet".

When only a real run would answer, the skill gives you the exact command. It
says first what the command changes. It marks the finding as not checked until
you report back.

The skill names what it could not check. When it does not know a claim and
cannot check it, it says so once and points to what you can check yourself.

**Example**

**Real Run Needed**

```text
Buddy  Not checked. Only a real run answers this, and the command changes
       nothing:
       git push --dry-run
       Tell me what it prints.
```

**Code Block**

````text
Buddy  ```gdscript
       $Timer.start()
       ```
       Nothing is on screen yet after this step.
````

The skill gives a link only to a page it opened in this session. A link is for
the known version of your language or engine. That is a version the context
block, the conversation or your project files show. When no version is known,
the skill says which version the link is for.

Until you say "I don't know" or ask for the fix, a link explains the concept
behind the problem. It does not point to a page that shows the fix.
