---
name: lesson
description: Run spec-driven Rust lessons with user-first iterative steps, checklist tracking, and level-based prompt examples.
license: MIT
compatibility: opencode
metadata:
  audience: learners
  mode: user-first
  pacing: iterative
---

## Purpose
- Build from a well-defined spec.
- Teach through focused, iterative coding tasks.
- Keep progress visible via lesson markdown artifacts.

## Core Contract
1. User writes code first; assistant teaches/reviews.
2. One active step at a time.
3. Every step includes a code example and explanation of why.
4. Validate with tests/tooling and code review before marking done.
5. Keep lesson state accurate in markdown artifacts.

## Commands
- `lesson start <topic>`
- `lesson next`
- `lesson pause`
- `lesson resume`
- `lesson recap`

## Phase 1 - Spec Definition
- Finalize spec first (can use `qna`).
- Assume answers are in spec by default.
- Ask a question only if required detail is truly missing/conflicting in spec.
- If asking, make it targeted and specific.

## Phase 2 - Bootstrap Lesson Artifacts
- Create lesson folder with:
  - `spec.md` (agreed spec snapshot)
  - `lesson-plan.md` (master checklist + links)
  - `progress.md` (state log)
  - `step-<N>-<slug>.md` (all steps scaffolded at bootstrap)
- Bootstrap is complete only when all step files exist.

## Storage Location (Vault-First)
- Store lesson artifacts in vault project space, not repo by default.
- Canonical path template:
  - `${VAULT_PATH:-$HOME/vaults/Brains}/01 - Projects/<repo-name>/lesson/<lesson-name>/`
- If `<repo-name>` is unknown, infer from current git repo folder name.
- If user explicitly requests repo-local storage, honor it and note divergence.

## lesson-plan.md Rules
- Must use an easy-to-read checklist.
- Each checklist item links directly to its step file via markdown link.
- Status markers:
  - `[x]` done
  - `[~]` in progress (max one)
  - `[ ]` not started
- Include `delivery_level_default` (default: `guided`).

## step-<N>-<slug>.md Required Structure
Each step file must include:
- `## Goal`
- `## Task`
- `## Example`
- `## Why`
- `## Run`
- `## Done`
- `## Spec refs`

Optional for blocked steps:
- `## Open Question`
- `## Proposed Default`

Optional guidance field:
- `expected_change_scope` (qualitative text only)

## Lesson Loop (Per Step)
- Assistant provides prompt package for current step only.
- User writes code.
- Assistant validates using:
  - command results
  - direct code review of changed files
- If pass: mark done, update plan/progress, move next.
- If fail: keep step active, no scope jump.

## Delivery Levels (Prompt Code Depth)
- `example`: smallest code sample.
- `guided`: partial/expressive implementation guidance.
- `full`: near/full step implementation scaffold.
- Every step starts with what to do + example + why.
- Levels affect prompt depth only.

## Level Controls
- Default: `guided`.
- User can override globally or per step in prompt.
- Per-step override takes precedence.

## Rust Validation Standards
- Always strive for test coverage.
- Prefer narrow checks first:
  1. targeted test
  2. broader module test
  3. full suite when needed
- Per coding step validation chain (when applicable):
  1. test command
  2. `cargo fmt --check`
  3. `cargo clippy -- -D warnings`

## Failure Recovery (User-First)
1. Assistant identifies one root cause and explains it.
2. User applies fix.
3. Rerun same narrow validation chain.
4. Repeat until green; no scope jump.

## Editing Mode
- Default: user-first; assistant does not auto-edit code.
- Assistant may auto-edit only when user explicitly asks.

## Step Completion Gate
A step is complete only when all are true:
- Spec refs satisfied.
- Code implemented.
- Validation chain passes.
- Assistant code review passes.
- `lesson-plan.md` updated.
- `progress.md` log appended.
