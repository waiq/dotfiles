---
name: coop-task
description: Flexible pair-programming with user-driven coding, fast feedback, and delegated micro-subtasks.
---

# Skill: coop-task

Purpose: run feature work as flexible cooperative pair-programming where user codes, agent navigates/reviews, and small delegated subtasks run in parallel.

## When to use

- User asks for pair/co-op mode.
- User wants to keep coding ownership while getting rapid solution suggestions and feedback.
- User wants to delegate small scoped tasks while they continue editing.

## Inputs

- `task_goal`: one sentence outcome.
- `constraints`: compatibility, API, perf, security constraints.
- `files_in_scope`: likely files/packages to touch.
- `done_criteria`: measurable acceptance checks.
- `driver`: `user` or `agent` (required, default `user`).
- `delegation_mode`: `off`, `on_request`, or `proactive_small` (default `on_request`).
- `verification_mode`: `strict`, `targeted`, or `defer_until_stable` (default `targeted`).

## Core protocol (mandatory)

Agent works in two parallel lanes:

1. **Navigation lane (always on)**
   - Give concise solution options (1-3 options + tradeoff).
   - Suggest the next user-owned edit in small chunks (10-40 LOC).
   - Provide tiny code examples when useful.

2. **Delegation lane (optional)**
   - Accept and execute small scoped subtasks while user keeps coding.
   - Subtasks can be incomplete/non-buildable in isolation if intentionally scoped.
   - Typical delegated units: one method implementation, one test, one docs section, one refactor in a single file.

Do not force rigid one-step templates unless user explicitly asks for strict micro-step mode.

Every step must start with ownership:

- `Driver: user` or `Driver: agent`
- `Navigator: agent`

## Roles

- User (driver): primary coder and decision owner.
- Agent (navigator): proposes options, reviews changes fast, executes delegated micro-tasks safely.

## Driver guardrails

- If `driver=user`, agent should default to suggestions/review only, but may edit when delegated a specific subtask.
- If `driver=agent`, agent can apply edits but should keep changes small and reviewable.
- Driver can be switched mid-task only by explicit user instruction.

## Step sizing

- Aim for 10-40 LOC or equivalent spec delta.
- Keep one concept focus per suggestion.
- Prefer targeted verification; allow deferred full build while user branch is in-progress.

## Delegation policy

- Keep delegated tasks small, scoped, and explicitly bounded.
- State what is in scope and out of scope before editing.
- Return fast with: files changed, concise diff summary, and verification status.
- Verification status must be one of:
  - `verified-targeted`
  - `not-run-by-design` (when branch intentionally unstable)
  - `blocked` (with exact blocker)

## Feedback policy

- On user diffs, provide feedback in this order:
  1) correctness/bugs
  2) API/compatibility risk
  3) tests/verification gaps
  4) style/nitpicks
- Keep feedback concise and actionable; include tiny patch/snippet examples when helpful.
- If no issues: say so explicitly and suggest one meaningful next check.

## Stop and escalate

Pause and request feedback if any apply:

- API contract ambiguity would materially change behavior.
- Action is destructive/irreversible or production-sensitive.
- Secret/credential is required.
- Same scoped attempt fails verification twice.

## Output format defaults

Use compact plain text. For each response, include only what is needed:

- If user asks for solution guidance: give `Options` + `Recommended`.
- If user asks for feedback: give `Findings` + `Suggested fix/snippet`.
- If user delegates a subtask: give `Scope`, `Result`, `Verification status`.
- If user asks for strict pacing, switch to micro-step template on request.

## Completion artifact

- What changed and why.
- Files changed.
- Verification commands run and outcomes.
- Follow-ups and known risks.

## Quality gates

- Backward compatibility preserved unless explicitly intended.
- New behavior covered by targeted test(s).
- Existing behavior verified by at least one regression/sanity command, unless explicitly deferred during in-progress pairing.

## Delegated subtask examples for this repository

- "Implement only page sorting switch in `search/es_service_factories.go`; do not touch proto."
- "Add one focused test to `search/search_test.go` for publish-date-desc ordering."
- "Update `README` API section with new `PageSorting` enum values."
