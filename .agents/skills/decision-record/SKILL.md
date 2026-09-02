---
name: decision-record
description: Use when evaluating, drafting, reviewing, updating, linking, superseding, or validating durable decision records, ADRs, decision logs, statuses, storage conventions, or decision traceability. Provides shared record mechanics while users and domain workflows own the actual decision and implementation authority.
---

# Decision Record

Use this skill for durable decision-record and ADR mechanics.

The skill owns record-worthiness checks, record structure, lifecycle/status guidance, storage and naming precedence, supersession mechanics, traceability, and record validation. It does not choose the user's decision, implement decisions, approve changes, commit files, or replace project-local conventions.

## Reference Files

Read the reference before creating, reviewing, updating, superseding, or validating records:

| Reference                                                        | Read when                                                                                        |
| ---------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| [references/decision-records.md](references/decision-records.md) | Working with decision triggers, content, statuses, storage, naming, supersession, or validation. |

Use the template as an adaptable output pattern, not a mandatory form:

| Asset                                                                    | Use                                                                  |
| ------------------------------------------------------------------------ | -------------------------------------------------------------------- |
| [assets/decision-record-template.md](assets/decision-record-template.md) | Starting a decision record when no stronger project template exists. |

## When to Use

Use this skill when the user asks to:

- decide whether a choice should be recorded;
- draft, review, update, link, supersede, or validate a decision record;
- work with ADRs, decision logs, decision statuses, storage conventions, or decision traceability;
- convert a confirmed decision into a durable record; or
- preserve why an approved choice was made, what alternatives were considered, and what consequences follow.

Do not use this skill merely because a conversation includes options, advice, or a recommendation. Use it when durable decision traceability is requested or required.

## Boundaries

Keep these responsibilities outside this skill:

- **Decision authority:** The user or authorized domain owner chooses the decision.
- **Domain judgment:** The originating workflow supplies domain criteria, evidence, risks, alternatives, and consequences.
- **Implementation:** A decision record does not authorize or perform implementation.
- **Approval:** Creating or updating a persistent record needs user or project approval when required by active rules.
- **Repository operations:** Commits, pushes, deployments, destructive changes, and repository-wide validation belong to the responsible workflow.
- **Project conventions:** Follow project-local status, metadata, storage, naming, and template conventions before fallback defaults.

Do not mark an agent recommendation as accepted without user or owner confirmation.

## Operating Modes

### Worthiness Check

Assess whether a choice is durable enough to record. Use the reference when reversibility, cost, alternatives, architectural impact, governance, or future rationale value matters.

### Draft Record

Draft a decision record from a confirmed decision or from a proposed decision that the user wants to review. Separate unconfirmed recommendations from accepted decisions.

### Review Record

Review an existing record for status accuracy, rationale, alternatives, consequences, traceability, supersession links, and project convention fit.

### Update or Supersede Record

Update approved records only within the user's approved scope. When a decision changes, prefer supersession over rewriting history when the old record's chronology matters.

### Validate Record

Validate metadata or body fields, required sections, links, supersession relationships, project convention fit, and absence of placeholder or unrelated private information.

## Workflow

1. Identify whether the request is worthiness check, draft, review, update, supersession, or validation.
2. Identify the decision owner, project context, and active decision-record convention.
3. Separate confirmed decisions from recommendations, open questions, and implementation plans.
4. Read [references/decision-records.md](references/decision-records.md).
5. Gather only the source material needed to record the decision accurately.
6. Resolve storage, naming, status, metadata format, and approval requirements before writing.
7. Create or update only approved records.
8. Validate status, date, title, content, links, supersession, formatting, and exact changed paths.
9. Report changed files, validation performed, and anything not tested.

## Default Response Shape

Use only the parts that help:

1. Current state or recommendation.
2. Decision-record scope or proposed record location.
3. Open questions, missing evidence, or approval needed.
4. Validation or next step.

Keep small worthiness checks in chat unless persistence is requested or required.

## Validation

For decision-record work, confirm:

- The decision is confirmed, proposed, or rejected according to the record status.
- The record does not turn an agent recommendation into an accepted decision.
- Project-local conventions override fallback defaults.
- Required concepts are present: title, status, date, context, decision outcome, reasons, and consequences.
- Optional sections are omitted when empty.
- Superseded and superseding records link to each other when applicable.
- Source links and related changes resolve when locally available.
- Metadata and prose do not duplicate each other unless prose adds meaning.
- Implementation, approval, commits, and pushes remain separate.
- Runtime discovery is reported as untested unless a fresh skill scan or session verified it.
