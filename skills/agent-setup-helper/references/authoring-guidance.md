# Authoring Guidance

Load this reference when designing or reviewing a Skill, a reference or a
template.

## Boundary

Sections, in order: Skill; Skill Reference; Skill Template; Cross-Artifact
Rules; Instruction Design; Substantial Artefacts.

This file answers one question: what makes a Skill, a reference or a template
well designed?

It owns the criteria for each of those three, the rules that apply across
them, instruction design and the checks for a substantial artefact.

It does not own `AGENTS.md` design (`agents-md.md`), where content belongs
(`architecture-analysis.md`), unsafe patterns (`safety.md`), or when a stage
runs (`SKILL.md`).

This is knowledge, not permission. Nothing here authorises a change.

Identify the artefact type before applying any criterion below.

## Skill

Focus on:

- purpose;
- the conditions that trigger it, and the ones that must not;
- scope boundaries;
- workflow and behavioural rules;
- inputs and dependencies;
- decision points;
- exceptions;
- expected output;
- interaction with other skills and instructions.

A skill should be specific enough to produce reliable behaviour, without
constraining tasks it was never meant to cover.

The two failures are symmetrical. A skill too vague to change behaviour costs
context and gives nothing back. A skill too broad fires on work it does not
understand, and the user has to undo it.

## Skill Reference

Focus on:

- whether it holds reusable knowledge, rather than behavioural rules that
  belong in `SKILL.md`;
- whether the skill says clearly when to consult it;
- whether the information is complete enough to act on;
- whether it stays consistent with its parent skill;
- whether an important rule is hidden here, where it may never be read.

A reference supports a skill. It must not quietly redefine it.

The hidden-rule case is the one to watch. A rule in a reference only applies
when something loads that reference, so a rule that must always hold belongs
in `SKILL.md`, however well it fits the reference's topic.

## Skill Template

Focus on:

- what structure or behaviour must be preserved;
- what the author is expected to change;
- whether the placeholders are obvious;
- whether an example reads as a requirement by accident;
- inherited content that no instance needs;
- assumptions that will not hold for every use;
- whether the generated artefact still makes sense once the template's own
  context is gone.

A template should give a useful starting structure, without forcing an
irrelevant requirement into every instance.

## Cross-Artifact Rules

When related artefacts are available, review them as one system.

Check whether:

- an `AGENTS.md` and a skill assign conflicting behaviour;
- a skill duplicates or overrides project instructions unintentionally;
- a reference holds a behavioural requirement its skill never surfaces;
- a template contradicts the rules governing what it produces;
- a term means different things in different files;
- one decision is defined differently in two places;
- changing one artefact would leave another stale.

Prefer a single source of truth for important behaviour where that is
practical.

Do not remove deliberate duplication before understanding why it exists. It
may be there for discoverability, for reliability, or because the two copies
are meant to diverge.

### Supplied Sources

When the author provides existing files — an `AGENTS.md`, a skill, a
reference, a template, a specification, examples, project instructions or a
past discussion — use them as the primary basis for the work.

When supplied sources conflict: name the conflict, explain why it matters, and
ask the author to resolve it. Do not choose one silently.

An outside recommendation is allowed. Mark it clearly as an outside
recommendation, and never present it as a project requirement.

## Instruction Design

### Content Roles

Five kinds of content appear in these files, and they carry different weight.

| Role | What it is |
|---|---|
| Behavioural instruction | A rule the agent must follow |
| Rationale | Why the rule exists |
| Reference information | Supporting knowledge |
| Example | An illustration of intended behaviour |
| Template | A reusable starting structure |

Do not let rationale, an example or reference material introduce a
requirement by accident. An example written in the imperative reads as a rule.

Put a rule where the agent will meet it while deciding what to do.

Do not write a rule that stops being true on a date, such as "before August,
use the old API". It turns wrong without anyone editing it. A date that
records when a source was read is allowed.

### Specificity

Prefer a rule precise enough to guide behaviour, and no more restrictive than
it needs to be.

Watch vague terms: "when appropriate", "if needed", "normally", "where
possible", "use judgment", "complex", "significant", "relevant".

These are not automatically wrong. Challenge one only when two reasonable
readings would produce materially different behaviour. A vague word in a rule
about wording costs nothing; the same word in a rule about permissions is a
decision nobody made.

Match the freedom a rule gives to how fragile the step is. A fragile step, one
where a wrong variant breaks something, gets an exact command or a script. A
step that needs judgement stays advice.

### Examples

Treat an example as a test of a rule, not a replacement for it.

Check whether:

- the rule is understandable without the example;
- the example actually follows the rule;
- a reader could mistake the example for the complete list;
- a copied value could quietly become a default.

Prefer a clear rule followed by the smallest example that clarifies it.

### Plain Wording Checks

These checks come from ASD-STE100 Simplified Technical English, Issue 9. They
paraphrase STE and adapt it for agents. Each check names a wording defect that
can make two agents act differently.

Use the checks when you review a skill. Report a finding when two reasonable
readings of the text produce materially different behaviour, as Specificity
above says. Before you report a finding, read the section that holds the
sentence, up to the next heading of the same level. When a line in that section
settles the reading, the sentence passes. When the sentence points to another
file, read the section it names, or the whole file when it names none. Do not
follow a pointer in that file. Each finding names the lines that you read.

These checks rank below every other rule, such as the safety rules,
`skill-spec.md`, the project's and the user's instructions, and the other
rules of agent-setup-helper. When a check conflicts with another rule, report
the conflict instead of choosing.

The checks cover the body of `SKILL.md` and of each reference. They do not
cover `AGENTS.md`. The checks apply to English text.

Before a review, copy each check in the table into your task list or working
notes. Tick each check when it has run. A check that you
skip goes in the report, with the reason.

| Check | The defect | Example |
|---|---|---|
| Unclear reference | "it", "they", "this" or "that" can refer to two nouns in the sentence or the one before | "Copy the file to the folder, then delete it." |
| Two meanings | One word or term carries two meanings in the skill | "flag" for a listed line and for a command-line option |
| Late condition | A condition comes after another clause, or after an instruction that cannot be undone | "Delete the branch, and push the fix, when the tests pass." |
| Chained instructions | One sentence holds instructions with an order or a condition between them | "Run the tests, fix each failure, and commit when all pass." |
| Buried steps | One sentence covers two or more steps under one condition | "When a merge fails, reset the branch and report the conflict." |
| Hidden actor | Two actors in the skill can do the action, and the sentence names neither | "The file is updated before the merge." |
| Unclear modal | "should" or "may" has two readings that change what the agent does | "may" as a permission, or as a possibility |

A limit can stay after its instruction, and it is not a late condition, when the
limit holds must, never, only or ask. It can also stay when its sentence opens
with "do not" or "don't". This exception does not cover an instruction that
cannot be undone.

When two checks match one sentence, report one finding and name both checks.

A note, a reason or an example that gives an instruction falls under Content
Roles above. Report it, and the user decides whether it becomes a rule.

**Fixes**

- Change the sentence that has the finding, and keep its other words. A fix
  changes no text that passes, unless the user asks for a wider change.
- Before you change a sentence, list each condition, limit and exception in
  it. After the change, find each item of the list in the new text. When an
  item is missing, change the sentence again, or keep the original sentence.
- Never add a fact. A fix adds no reason, risk or example that the source does
  not give.
- Keep each word or phrase that makes the line a permission line, as
  Definitions in `SKILL.md` describes. Add none, except "Do not" when the fix
  for an unclear modal gives the command form of a ban. A fix to a permission
  line is a planned change, as Planning Triggers in `SKILL.md` says.
- Treat a fix to a line that bans or limits an agent action as a fix to a
  permission line. This holds whether or not the line is a permission line.
- For an unclear reference, write the noun.
- For two meanings, choose one term for each meaning. A new definition is a
  planned change.
- For a late condition, put the condition first, then the instruction.
- For chained instructions or buried steps, use the condition as a lead-in and
  the instructions as list items.
- For a hidden actor, name the agent, the user or the script.
- For an unclear modal:
    - for a permission, use `can`, with the actor as the subject;
    - for a possibility, use "possibly";
    - for advice, use "recommends" with a named actor, as in "This skill
      recommends a dry run first";
    - for an obligation, use the command form.

**Severity**

Rate each finding by what the agent does, as Severity in `review.md` says. A
finding is at least Medium. It is High when one reading leads to an action that
cannot be undone, or that breaks a safety rule. Name the concrete case in the
workflow of the skill under review.

## Substantial Artefacts

For a substantial artefact, check whether:

- purpose and scope are clear;
- important rules and exceptions are explicit;
- terminology is consistent;
- examples agree with their rules;
- references and templates agree with their parents;
- required context exists only outside the artefact;
- redundant content can go;
- the expected action is clear.
