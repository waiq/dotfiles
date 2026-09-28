---
name: delegated-implement
description: delegated-implement orchestrates spec-ticket implementation by delegating each ticket to a fresh implement subagent and risk-based reviews to fresh code-review subagents. Use after to-tickets when the user wants autonomous multi-ticket execution.
---

# Delegated Implement

## Purpose

Orchestrate settled ticket execution without reopening design. This skill is an alternative to `implement` for multi-ticket or long-running work where each implementation and review pass should happen in a fresh context.

Workflow position:

```text
grill-with-docs -> to-spec -> to-tickets -> delegated-implement -> code-review
```

`delegated-implement` coordinates the loop. It does not replace the existing implementation or review skills:

- Implementation subagents must load and follow `implement`.
- Review subagents must load and follow `code-review`.

## Inputs

Accept one of:

- A spec path under `${VAULT_AGENTS_ROOT}/<repo-name>/issues/<feature-slug>/spec.md`.
- A feature folder containing `spec.md`, `activity.md`, and `issues/` tickets.
- A ticket path when the user wants the orchestrator to continue from that ticket and its connected spec.

If the spec or ticket set is ambiguous, ask one short clarifying question before delegating.

## Approval Scope

Before mutating files for a feature/spec with multiple tickets, always offer the user these approval scopes:

- Approve one ticket: implement and review only the next unblocked frontier ticket, then stop and report status.
- Approve all tickets for this spec: run the full connected ticket loop until every ticket is `done` or no unblocked ticket remains.

Use explicit approval tokens that name both the plan and scope, for example:

- `APPROVE: <PLAN_NAME>, Scope: one-ticket`
- `APPROVE: <PLAN_NAME>, Scope: all-tickets`

If the user approves without a scope, ask one short follow-up question instead of assuming. This approval scope does not permit parallel claims; claim only one ticket at a time unless the user separately approves parallel claims.

## Orchestration Loop

For `one-ticket` approval, run the loop once for the next unblocked frontier ticket and run review before stopping. For `all-tickets` approval, repeat until every connected ticket is `done` or no unblocked ticket remains:

1. Read the spec, feature `activity.md`, and tickets under `issues/`.
2. Select the next frontier ticket whose blockers are `done`.
3. Confirm only one ticket is being claimed in the active checkout unless the user explicitly approved parallel claims.
4. Delegate implementation to a fresh subagent context.
5. Require the implementation subagent to use the `implement` skill.
6. Require the implementation subagent to return:
   - Ticket handled.
   - Summary of behavior changed.
   - Files touched.
   - Verification commands and outcomes.
   - Ticket/activity updates made.
   - Risks, skipped checks, or blockers.
7. Decide whether this ticket needs immediate review or whether review can be deferred under Review Cadence.
8. For immediate review, delegate review to a separate fresh subagent context and require the review subagent to use the `code-review` skill.
9. Review the findings and decide which fixes are required.
10. Apply or delegate only necessary fixes. Not every suggestion must be implemented.
11. Run a fresh review subagent again after accepted fixes when required fixes materially changed the reviewed diff.
12. Mark the ticket `done` only when implementation, verification, accepted fixes, and review are complete. If review is deferred, keep the ticket in `review` and record the deferral in `activity.md`.

Before ending any approved scope, run a final review over all unreviewed or deferred changes in that scope. Deferred tickets may be marked `done` only after that final review covers them and required fixes are complete.

If review still has material findings after the second pass, continue fix-review cycles when the path is clear. Stop and ask the user when a finding conflicts with the spec, requires product judgment, or would expand scope.

## Review Cadence

A review subagent is required after the final ticket or final code change in the approved scope.

Per-ticket review is optional based on risk. Before skipping a per-ticket review, the orchestrator must record the reason in the feature `activity.md` and keep the ticket out of `done` until a later review covers it.

Run immediate review when the ticket changes storage format, verification or integrity behavior, public CLI/API behavior, broad shared abstractions, or when tests are failing/skipped, scope is ambiguous, or the change is large enough that delayed review would be hard to isolate.

Review may be deferred for documentation-only, narrow mechanical, test-only, or low-risk dependent slices.

A ticket with deferred review may be marked `review`, but not `done`. Mark it `done` only after a review has covered that ticket's diff and required fixes are complete.

## Implementation Delegation Prompt

When delegating implementation, include:

```text
Load and follow the `implement` skill. You are in a fresh context. Implement exactly this ticket against the connected spec without redesigning the plan.

Inputs:
- Spec: <path>
- Ticket: <path>
- Feature activity log: <path>
- Repo root: <path>

Rules:
- Preserve unrelated worktree changes.
- Claim only this ticket.
- Update ticket metadata, acceptance criteria, and activity log as required by `implement`.
- Run targeted verification and broader checks when feasible.
- Do not commit unless explicitly requested.

Return only:
- Ticket handled.
- Change summary.
- Files touched.
- Verification run and outcomes.
- Ticket/activity updates.
- Risks, blockers, skipped checks.
```

## Review Delegation Prompt

When delegating review, include:

```text
Load and follow the `code-review` skill. You are in a fresh context. Review the implementation for this ticket against both repo standards and the connected spec.

Inputs:
- Fixed point/ref for the diff: <ref>
- Spec: <path>
- Ticket: <path or list of deferred ticket paths>
- Implementation summary: <summary>
- Repo root: <path>

Rules:
- Keep Standards and Spec findings separate.
- Cite file/line and spec/ticket references.
- Do not modify files.
- Do not spawn recursive review calls.

Return the normal `code-review` output shape plus a short required-fixes list.
```

## Fix Triage

Classify review findings before changing code:

- Required: correctness bugs, spec misses, broken tests, regressions, unsafe behavior, or clear repo-standard violations.
- Optional: naming, style, minor refactors, or broader cleanup that does not affect acceptance.
- Reject: suggestions that conflict with the spec, expand scope, or churn unrelated code.

Apply required fixes. Apply optional fixes only when cheap and clearly beneficial. Record rejected or deferred findings in the ticket or final summary when material.

## Guardrails

- Do not redesign the spec or tickets.
- Do not create new tickets unless the spec is blocked and the user approves the split.
- Do not claim multiple tickets concurrently in one checkout unless explicitly approved.
- Preserve unrelated user or agent changes.
- Stop for user input on merge conflicts, ambiguous blockers, unclear product choices, or review findings that change scope.
- Do not commit, stage, push, or create PRs unless explicitly requested.

## Completion

When the loop ends, report:

- Tickets completed.
- Tickets blocked, skipped, or left in deferred review, with reasons.
- Reviews run and worst remaining finding per ticket.
- Verification commands run.
- Remaining risks.

If all connected tickets are complete, update the feature `activity.md` with the final outcome.
