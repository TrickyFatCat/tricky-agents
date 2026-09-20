# AGENTS.md Design

Load this reference when the artefact being designed or reviewed is an
`AGENTS.md` file.

## Boundary

This file says what makes an `AGENTS.md` well designed. It does not say what
makes a Skill well designed, where a piece of content belongs, or when a
change needs planning.

An `AGENTS.md` file must make expected behaviour clear on its own. A reader
who was not in the conversation that produced it should still be able to
follow it.

## Global and Local

A global `AGENTS.md` holds defaults that hold across every project on the
machine. A local one holds what is true of one repository.

A rule belongs in the global file when it would be restated in most projects,
and in the local file when it depends on this repository's layout, tooling or
conventions.

Two rules govern the pair.

- Global safety is never overridden by a local file.
- A local file specialises a non-safety global default within its scope. It
  does not repeat the default in order to look complete.

When a local rule contradicts a global one and nothing shows the contradiction
was intended, surface it. Do not let the narrower file win by being narrower.

## Scope

State where the file applies and where it stops. A file that covers a
repository says so; a file that covers one folder inside it says that instead.

Name the tools and environment the rules assume. A rule that depends on a
command, a shell or a service is only valid where that thing exists.

Say when the agent should ask rather than proceed. An `AGENTS.md` that never
names an asking point tends to produce either constant questions or none.

## Placement

Put a rule where an agent will meet it while deciding what to do, not where it
is tidiest to file.

**Example**

A rule about how to write commit messages belongs beside the commit workflow.
Filed under a general Style heading, it is read when nobody is committing and
missed when somebody is.

The general rule: placement follows the moment of decision.

## Conventions

Write conventions down. Do not expect the agent to infer them from the
existing files.

A pattern in a repository is evidence of what happened before, not a rule
about what must happen next. An agent that infers a convention cannot tell a
deliberate standard from an accident that was never cleaned up, and it will
copy both with equal confidence.

State the convention, and state what it covers. Where a file departs from it
on purpose, say so, or the exception will read as a mistake and get
"corrected".

## Decision Boundaries

Say which decisions belong to the user and which the agent may take alone.

An `AGENTS.md` that is silent here leaves the boundary to be guessed each
session. The two failure modes are equally costly: an agent that asks about
decisions it was meant to take, and an agent that takes decisions it was meant
to raise.

Three things make a boundary usable.

- Name the class of decision, not one instance of it.
- Give the observable test that puts a decision on one side or the other.
- Say what the agent does when the test is unclear.

## Behavioural or Static

The distinction decides whether a change to this file needs corner-case
discovery.

An `AGENTS.md` is behavioural when it defines workflows, interaction
behaviour, decision ownership, delegation or state transitions. It is static
when it records paths, commands, conventions or constraints and nothing more.

A static file may be long and still be static. The test is whether the file
tells the agent how to behave, not how much it says.

## Review Checks

When reviewing an `AGENTS.md`, check for:

- scope and applicability that a reader can act on;
- instruction precedence against global defaults;
- decision boundaries, and the asking point;
- tool and environment constraints;
- safety and destructive-operation rules;
- terminology that means one thing throughout;
- duplication that serves no purpose;
- instructions that contradict each other.
