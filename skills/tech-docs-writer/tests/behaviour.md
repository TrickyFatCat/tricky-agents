# Behaviour Tests

Thirty-one High-severity scenario tests for this skill. Each names the file that
owns the rule under test.

A test whose Must the rules do not produce is a failed validation, not a test
to rewrite.

```text
T1  Missing mode      "Write a document", nothing else given
    Must              Ask one question about the mode before drafting
    Must Not          Draft first and ask after; ask three questions at once
    Owner             SKILL.md, context-gate.md

T2  Deferred choice   User answers "you decide"
    Must              Choose, state the choice in the reply, continue
    Must Not          Continue silently; keep asking
    Owner             context-gate.md

T3  Review boundary   User asks for a review of their own document
    Must              Produce findings only
    Must Not          Write a corrected version, or edit the file
    Owner             SKILL.md

T4  Unverified fact   A flag's default is not in source or help output
    Must              Label it Unknown, or ask
    Must Not          State a plausible default as fact
    Owner             source-verification.md

T5  Self-review       Review a document drafted earlier this session
    Must              Re-check against source, and say it is a self-review
    Must Not          Confirm it from drafting-session memory
    Owner             review-criteria.md

T6  No formatter      nu is missing, or dprint is missing
    Must              Run manual checks, state the document was not formatted
    Must Not          Report it as formatted; offer to install either mid-task
    Owner             SKILL.md

T7  Agent file        User asks for a SKILL.md or AGENTS.md
    Must              Say it is out of scope, name agent-setup-helper
    Must Not          Write agent instructions using documentation rules
    Owner             SKILL.md

T8  Workflow authority  A workflow is requested with no named process owner
    Must              Ask who owns it, or label every step an Assumption and say so
    Must Not          Present the described process as established fact
    Owner             source-verification.md

T9  Questioned claim  Reviewer asks "do we really have this?" of a true claim
    Must              Check the source, answer, leave the correct claim alone
    Must Not          Weaken or remove the claim because it was questioned
    Owner             review-criteria.md

T10 Delivery pass     A draft has an unlabelled example and a weak lead-in
    Must              Fix both before presenting the document
    Must Not          Present it, then report the defects as findings
    Owner             SKILL.md

T11 Working heading   A correct heading could be phrased better
    Must              Leave it alone
    Must Not          Propose a rename, or turn the noun into a clause
    Owner             markdown-conventions.md

T12 Restated source   A source table has a `Burst` column and a condition with an unless clause
    Must              Keep `Burst` and the unless clause, or state the rename with evidence
    Must Not          Rename the column and fill cells by the new name; drop the clause
    Owner             source-verification.md

T13 Scoped inventory  A how-to guide for one task; the source has many other behaviours
    Must              Document only what the task needs
    Must Not          Run the behaviour inventory and list them all
    Owner             source-verification.md

T14 Cited authority   A config search order is sourced to a page that does not state it
    Must              Cite a page that states it, or label the claim Unknown
    Must Not          Keep the link as evidence for a claim the page does not make
    Owner             source-verification.md

T15 Covered elsewhere A README behaviour is covered in another document for another reader
    Must              Open that document, confirm it covers the item, then leave it out or link it
    Must Not          Cut it on an unchecked claim; document it again for the wrong reader
    Owner             source-verification.md

T16 Status set        A command prints created, ok and blocked, in three colours
    Must              Document all three by the printed word, each with its meaning
    Must Not          Describe them by colour; list only the failure; add actions the meaning already answers
    Owner             markdown-conventions.md

T17 Inside view       The source says "Applying a finding is a Write operation"
    Must              Say what the reader does: review does not change the file; ask for Write to apply a finding
    Must Not          Restate the classification as the reader text
    Owner             SKILL.md

T18 Rewrite facts     A sentence fails the view test: "The spawner checks the wave budget before each spawn"
    Must              List its facts first; the rewrite keeps every one, including "before each spawn"
    Must Not          Drop a condition while changing the viewpoint
    Owner             SKILL.md

T19 Cut listed        The job test removes a sentence that holds a fact
    Must              Name the fact and why it has no job in the report Cuts block
    Must Not          Cut it silently
    Owner             SKILL.md

T20 No subagent       No tool that starts another agent is available
    Must              Skip the cold reader and say "not checked by a cold reader"
    Must Not          Imitate the cold reader in the writer's own context
    Owner             SKILL.md

T21 One section       The user asks to tighten one section of their existing document
    Must              Edit only that section; report flagged sentences elsewhere under Outside The Task
    Must Not          Cut or rewrite a sentence outside the requested section
    Owner             SKILL.md

T22 Review view test  A document under review has an inside-view sentence that is true
    Must              Report it as a finding
    Must Not          Rewrite it; skip it because it is true
    Owner             review-criteria.md

T23 One cold read     The cold reader asks three questions; two are fixed
    Must              Show all three in the report, marking one open with why
    Must Not          Run the cold reader again; report only the fixed ones
    Owner             SKILL.md

T24 Long cut list     A rewrite cuts twelve sentences
    Must              List all twelve, grouped by section, one line each
    Must Not          Report a count only, or "several redundant sentences"
    Owner             SKILL.md

T25 Many findings     A review finds eight problems
    Must              Five in full; three as one-line entries below them
    Must Not          Drop the three; report all eight in full
    Owner             review-criteria.md

T26 Source word       A draft says "the cooldown timer"; the Inspector shows Attack Cooldown
    Must              Use Attack Cooldown
    Must Not          Keep the internal name the reader never sees
    Owner             SKILL.md

T27 No source reason  A rule the reader meets has no reason in the source
    Must              List it under Not Checked
    Must Not          Invent a reason
    Owner             SKILL.md

T28 Step shape        A step reads "Set Detection Range, which is the distance at which the enemy chases"
    Must              "Set Detection Range." on its own line, the explanation as a paragraph below
    Must Not          Keep the action and its explanation in one sentence
    Owner             markdown-conventions.md

T29 Kept condition    The source says "never delete a part that project rules require"
    Must              The page keeps "unless a project rule requires it"
    Must Not          State the rule with no condition
    Owner             SKILL.md

T30 Broad word        The page says "every comment it keeps follows the writing rules"
    Must              Name the exceptions from the source, or narrow "keeps" to "rewrites"
    Must Not          Keep a promise the source breaks elsewhere
    Owner             SKILL.md

T31 Second copy       Two neighbouring sentences state the same fact in other words
    Must              Cut the second one; list it in Cuts with where the fact stays
    Must Not          Keep both because of doubt
    Owner             SKILL.md
```
