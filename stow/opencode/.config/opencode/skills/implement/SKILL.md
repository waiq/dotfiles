---
name: implement
description: implement builds one approved spec or Obsidian ticket without reopening design. Use when the user points at a ticket/spec or asks to execute settled work, especially after to-tickets.
---

# Implement

## Purpose

Turn settled work into code. Do not redesign the plan. Read the ticket or spec, claim the work when applicable, implement one vertical slice, verify it, and update the issue artifacts.

Implementation sits here:

```text
grill-with-docs -> to-spec -> to-tickets -> implement -> code-review
```

## Inputs

Accept one of:

- A ticket path under `${VAULT_AGENTS_ROOT}/<repo-name>/issues/<feature-slug>/issues/`.
- A spec path under `${VAULT_AGENTS_ROOT}/<repo-name>/issues/<feature-slug>/spec.md` when the work is small enough for one session.
- A settled plan from the current conversation.

If the user gives a short ticket number, resolve it against the active feature folder and confirm the title before editing code.

## Claiming

Follow [workflow.md](workflow.md). For ticket-based work:

- Confirm all blockers are `done`.
- Set `Status: claimed` or `Status: in-progress`.
- Set `Claimed by` to `OPENCODE-RAGNAR` plus any visible session identifier if available.
- Set `Claimed at` to the current timestamp.
- Add an `activity.md` entry.

Do not claim multiple tickets in one run.

## Build Loop

1. Read the ticket/spec and restate the target behavior.
2. Identify the agreed test seam.
3. Use the `tdd` skill for red-green-refactor when tests are meaningful.
4. Run targeted checks repeatedly as code changes.
5. Run broader checks near the end when feasible.
6. Update acceptance criteria and ticket status.
7. Run or recommend `code-review` against the appropriate fixed point.

For Go work, prefer behavior tests at package APIs, HTTP handlers, repositories behind interfaces, command boundaries, or CLI boundaries. Avoid tests that pin private helper structure.

## Git Discipline

- Do not commit unless the user explicitly asks for a commit.
- Preserve unrelated worktree changes.
- If committing is requested, inspect status, diff, and recent log first; stage only intended files.
- In parallel-agent workflows, prefer separate worktrees when practical. Never assume the checkout is private.

## Completion

Before reporting done:

- Mark completed acceptance criteria.
- Set ticket `Status: review` or `done` depending on whether review has happened.
- Append verification commands and outcomes to `activity.md`.
- Summarize remaining risks or skipped checks.
