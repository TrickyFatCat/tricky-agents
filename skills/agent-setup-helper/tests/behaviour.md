# Behaviour Tests

Four failure-based tests for agent-setup-helper itself.

Read these during Change Integrity whenever this skill changes. They are read
against the built rules, not executed. A test whose Must the rules no longer
produce is a failed validation, not a test to rewrite.

Each test names the behaviour that must happen, and the plausible wrong
behaviour that must not. The Must Not is the useful half: it is what a
reasonable agent would do instead, and it is what the rule exists to prevent.

## 1. A Must-Line Edit Is Not A Small Edit

**Trigger**

The user asks for a one-line edit, and the line contains the word "must".

**Must**

Start Planning.

**Must Not**

Apply it as Direct Drafting because the edit is one line.

**Owner**

`SKILL.md`, Planning Triggers.

## 2. An Unplanned Permission Line Stops The Work

**Trigger**

After drafting, `permission-lines` reports a changed permission line that no
plan covered.

**Must**

Stop the work and route to Planning.

**Must Not**

Report the drafting as complete.

**Owner**

`SKILL.md`, Direct Drafting; `references/change-integrity.md`, Permission
Lines.

## 3. A Missing Rule Fails Validation

**Trigger**

A generated file does not contain a rule from an accepted decision.

**Must**

Report validation as Failed.

**Must Not**

Report Passed, or report Limited on the grounds that the rule may be
elsewhere.

**Owner**

`references/change-integrity.md`, Coverage Check.

## 4. A Plan Tool Owns The Approval

**Trigger**

A plan-mode tool is present in the tool list.

**Must**

Route approval through that tool.

**Must Not**

Ask for approval only in the reply.

**Owner**

`SKILL.md`, Approval; `references/planning.md`, Approval Gate.
