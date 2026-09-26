# Behaviour Tests

Forty-seven High-severity scenario tests for this skill. Each names the file that
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
    Owner             SKILL.md, delivery-checks.md

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
    Owner             delivery-checks.md

T27 No source reason  A rule the reader meets has no reason in the source
    Must              List it under Not Checked
    Must Not          Invent a reason
    Owner             delivery-checks.md

T28 Step shape        A step reads "Set Detection Range, which is the distance at which the enemy chases"
    Must              "Set Detection Range." on its own line, the explanation as a paragraph below
    Must Not          Keep the action and its explanation in one sentence
    Owner             markdown-conventions.md

T29 Kept condition    The source says "never delete a part that project rules require"
    Must              The page keeps "unless a project rule requires it"
    Must Not          State the rule with no condition
    Owner             delivery-checks.md

T30 Broad word        The page says "every comment it keeps follows the writing rules"
    Must              Name the exceptions from the source, or narrow "keeps" to "rewrites"
    Must Not          Keep a promise the source breaks elsewhere
    Owner             delivery-checks.md

T31 Second copy       Two neighbouring sentences state the same fact in other words
    Must              Cut the second one; list it in Cuts with where the fact stays
    Must Not          Keep both because of doubt
    Owner             SKILL.md

T32 Context claim     The cold reader asks about something the starting point does not name
    Must              Add the fact, or mark the question open
    Must Not          Mark it known from context
    Owner             SKILL.md

T33 Internal rule     The source says "picks the upload server by latency" and "skips files
                      over 2 GB because the API rejects them"
    Must              Cut the server rule; keep the 2 GB rule with its reason
    Must Not          Restore the server rule to satisfy Reasons or the Behaviour Inventory
    Owner             SKILL.md, delivery-checks.md

T35 Long condition    A restated source cell holds a 13-word condition with an unless clause
    Must              Keep every clause in the cell, or split it into columns
    Must Not          Move the unless clause into prose to meet the count
    Owner             delivery-checks.md

T36 Review context    A review of a Godot plugin page; the cold reader asks "What is a scene?"
    Must              No finding; list it as known from context, a standard Godot term
    Must Not          Report a finding for a missing definition
    Owner             review-criteria.md

T37 Small edit        A one-paragraph edit to a Markdown document
    Must              Load delivery-checks.md and run every check that applies
    Must Not          Skip them because the edit is small
    Owner             SKILL.md, delivery-checks.md

T38 Review checks     A review of a Markdown page with a 14-word table cell
    Must              Report the cell as a finding
    Must Not          Move the detail into prose
    Owner             delivery-checks.md, review-criteria.md

T39 Callout source    A new page; the README uses emoji callouts; no instruction defines callouts
    Must              Use the default alerts; name the README style under Assumptions
    Must Not          Adopt the README style as the project convention
    Owner             markdown-conventions.md, context-gate.md

T40 Neutral subject   The starting point names one editor; the source says "any editor with a plugin API"
    Must              Describe the condition: "when the editor has a plugin API"
    Must Not          Write "in <editor>" for behaviour the source does not limit to it
    Owner             markdown-conventions.md, SKILL.md

T41 Optional dep      The source has an optional package with a pinned install file; the reader uses the tool
    Must              Name the package and what is lost without it; link its install source if one exists
    Must Not          Copy install commands, platform notes or version coverage onto the page
    Owner             cli-reference.md, source-verification.md

T42 Callout close     A draft has a paragraph line directly after a callout line
    Must              Keep a one-sentence callout body and a blank line after it
    Must Not          Leave the paragraph inside the callout
    Owner             markdown-conventions.md

T43 Config label      No project dprint config; a user-global config exists
    Must              format-docs.nu reports the config as "discovered"
    Must Not          Report it as "project"
    Owner             scripts/format-docs.nu

T44 Review scope      Internal Review flags a true fact the named reader does not need
    Must              Decline it in the report, with the reader reason
    Must Not          Add it because the source confirms it
    Owner             review-criteria.md

T45 Review skip       The user asks to tighten one section of an existing document
    Must              Run the cold reader only; no Internal Review
    Must Not          Start the Internal Review subagent
    Owner             SKILL.md, review-criteria.md

T46 Source gap        The source gives no reason for a limit, and leaves a state the reader acts on undefined
    Must              List the missing reason under Not Checked; state the undefined state on the page
    Must Not          Put both on the page; or leave both out of the page
    Owner             source-verification.md

T47 Tracked checks    A Write reaches Before Delivering; the agent has a task or to-do tool
    Must              Add each applicable delivery check as a task; close each when it has run
    Must Not          Run the checks from memory with nothing tracked
    Owner             delivery-checks.md

T48 Review general    A review of a README whose page says "always" where the source has an exception
    Must              Run the General checks too; report the Broad words hit as a finding
    Must Not          Run only the Markdown Only checks in a review
    Owner             delivery-checks.md, review-criteria.md
```
