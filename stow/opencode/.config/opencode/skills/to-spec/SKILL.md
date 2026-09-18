---
name: to-spec
description: to-spec turns settled conversation and codebase context into an Obsidian-backed implementation spec. Use after grill-with-docs when the work spans multiple sessions or must survive context clearing.
---

# To Spec

## Purpose

Create a decision-record spec from what is already settled. This skill does not reopen design unless critical context is missing. It synthesizes the conversation, codebase findings, ADRs, glossary, and current plan into a spec that a fresh agent can trust.

Use this only on the multi-session branch:

```text
grill-with-docs -> to-spec -> to-tickets -> implement -> code-review
```

If the change fits one context window, skip this skill and use `implement` directly.

## Storage

Follow [workflow.md](workflow.md). By default, write the spec to:

```text
${VAULT_AGENTS_ROOT:-${VAULT_PATH:-$HOME/vaults/Brains}/agents}/<repo-name>/issues/<feature-slug>/spec.md
```

Also update `activity.md` in the same feature folder.

## Before Writing

Inspect enough context to avoid inventing requirements:

- Current conversation and approved plan.
- Relevant code boundaries.
- `${VAULT_AGENTS_ROOT}/<repo-name>/AGENTS.md`, glossary, and ADRs.
- Global workflow glossary/ADRs only when the spec concerns agent workflow.

Then propose the test seams before drafting the full spec. Prefer the highest existing seam that can observe behavior:

- Go package API.
- HTTP handler or route.
- Repository interface.
- Command boundary.
- CLI boundary.

Use as few seams as possible. One good seam is better than several brittle ones.

## Spec Template

```markdown
# <Feature Name> Spec

## Status
- State: draft|approved|superseded
- Created: <YYYY-MM-DD>
- Source: <conversation/plan/ticket references>

## Goal
<What outcome this work creates.>

## Non-Goals
- <Explicitly rejected scope.>

## Decisions Captured
- <Settled decision and why.>

## User/System Behavior
- <Observable behavior, not internal steps.>

## Implementation Boundaries
- <Likely packages, services, commands, or interfaces. Avoid stale line-number detail.>

## Test Seams
- <Seam>: <behaviors to prove here.>

## Risks And Edge Cases
- <Failure modes, migration risks, compatibility risks.>

## Acceptance Criteria
- [ ] <Criterion that would fail before implementation.>

## Follow-Up Docs
- <ADR/glossary entries created or needed.>
```

## Quality Bar

- Every assertion traces to the conversation, codebase, or docs.
- The spec uses the repo's nouns, not generic product boilerplate.
- Out-of-scope items are concrete.
- Acceptance criteria are observable and not already true at the base commit.
- The spec is dense enough for `to-tickets` to slice without re-interviewing the user.
