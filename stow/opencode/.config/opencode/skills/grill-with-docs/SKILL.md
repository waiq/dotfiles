---
name: grill-with-docs
description: grill-with-docs interviews hard to sharpen a product or technical plan while producing durable Obsidian docs. Use when the user wants to stress-test a design, plan, workflow, ADR, glossary, or domain model before implementation.
---

# Grill With Docs

## Purpose

Use this skill to turn vague intent into settled decisions. Interview the user directly, find contradictions, expose tradeoffs, and capture durable knowledge while the decisions are fresh.

This is the upstream decision step for:

```text
grill-with-docs -> to-spec -> to-tickets -> implement -> code-review
```

## Operating Rules

- Ask pointed questions until the plan is coherent enough to hand to a fresh agent.
- Prefer one strong default and make the tradeoff explicit.
- Do not write implementation code from this skill.
- Do not create a spec until the user has settled the important decisions; use `to-spec` for that.
- Store durable notes under `${VAULT_AGENTS_ROOT:-${VAULT_PATH:-$HOME/vaults/Brains}/agents}`.
- Use the `documentation` skill for substantial Markdown polish when docs become user-facing or long-lived.
- Use `obsidian-notesmith` if the task turns into broad research or large Obsidian note production.

## What To Produce

Update or propose these artifacts as appropriate:

- `${VAULT_AGENTS_ROOT}/<repo-name>/glossary.md` for project terms.
- `${VAULT_AGENTS_ROOT}/<repo-name>/adr/ADR-<topic>.md` for project decisions.
- `${VAULT_AGENTS_ROOT}/global/glossary.md` for cross-project workflow terms.
- `${VAULT_AGENTS_ROOT}/global/adr/ADR-<topic>.md` for cross-project workflow decisions.
- The active plan file under `${VAULT_AGENTS_ROOT}` when the conversation is governed by an approved plan.

Promote project knowledge to global only when it clearly applies across repos.

## Interview Shape

Start by identifying the work type:

- Product behavior: who uses it, what changes for them, what must not change.
- Technical design: boundaries, invariants, data ownership, failure modes.
- Workflow/process: triggers, handoffs, state, storage, permissions, restart requirements.
- Refactor: motivation, blast radius, migration strategy, test seams.

Then pressure-test:

- What is the smallest useful outcome?
- What are we explicitly refusing?
- What breaks if this decision is wrong?
- Which existing boundary should carry the behavior?
- Which terms need a glossary entry before implementation?
- Which decision deserves an ADR rather than being buried in chat?

## Handoff To `to-spec`

Before ending, summarize:

- Settled decisions.
- Rejected options.
- Open questions, if any.
- Candidate test seams, especially for Go: package API, HTTP handler, repository interface, command boundary, or CLI boundary.
- Durable docs created or needing update.

If the work fits one session, tell the user they can skip `to-spec` and use `implement` directly.
