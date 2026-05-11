---
name: lesson
description: Run domain-agnostic micro-step learning sessions with learner-first pacing and one-checkpoint-per-step flow.
license: MIT
compatibility: opencode
metadata:
  audience: learners
  mode: learner-first
  pacing: micro-step
---

## Purpose
- Prioritize understanding over speed.
- Keep momentum with tiny, verifiable steps.
- Work across coding and non-coding domains.

## Core Contract
1. Learner does the step first; coach reviews.
2. One concept focus per step.
3. One verification check per step.
4. Explain deeply once; then use short reminders.
5. Always leave a resume-ready checkpoint.

## Commands
- `lesson start <topic>`
- `lesson next`
- `lesson pause`
- `lesson resume`
- `lesson recap`

## Step Output Template
For each step, output exactly:
1. Goal (one sentence)
2. You do (exact target)
3. Run (one command/check)
4. Review checklist (3-5 bullets)
5. Concept note (short)

## Delivery Levels (Universal)
- `example`: minimal assignment artifact showing core pattern.
- `guided`: partial assignment artifact with clear integration path.
- `full`: complete assignment artifact for the current micro-step scope.
- `none`: explicitly no artifact (planning/setup-only step).

## Delivery Level Scope Rule
- Delivery level controls only the learner task artifact in **You do**.
- Context and explanation quality are always full-depth.
- The selected level must not reduce conceptual completeness.

## Domain Applicability
- Delivery levels apply across all domains.
- Treat a task as coding-capable when artifacts include source/config/code-like assets (for example Rust, Terraform, YAML, SQL, CI configs), unless user overrides.
- For coding-capable tasks, artifact examples are code/config snippets/files.
- For non-coding tasks, artifact examples are domain-equivalent outputs (sentences, proofs, solution outlines, and similar).

## Step Output Extension
- Add this line to every step output: `Delivery level: <example|guided|full|none>`.

## Defaults and Progression
- Default delivery level: `guided`.
- User request can set level directly.
- Auto-escalation after 2 failed verifications on same step/concept: escalate one level only (`example -> guided -> full`).
- No auto-deescalation; lower level only on explicit user request.

## Verification Invariance Rule
- Verification strictness is identical across levels.
- Pass/fail criteria do not change with delivery level.
- Only artifact size/scaffolding changes by level.

## State To Track
- topic
- mode (`beginner`|`intermediate`|`advanced`)
- current_step
- current_concept
- user_action
- verify_command
- success_criteria
- blockers
- next_step
- notes_path

## Recovery Rules
- If verification fails: identify one root cause, apply one tiny fix, rerun one check.
- Do not jump scope while failing.
- Keep one concept focus until green.
- Do not widen scope to future steps during failure recovery.

## Domain Adapters
### Coding
- Action: small code edit.
- Verify: one test/build/run command.
- Review: correctness, boundaries, readability.

### Language Learning
- Action: one sentence/dialog pattern.
- Verify: one correction/comprehension check.
- Review: grammar target + pronunciation cue.

### Math / Problem Solving
- Action: solve one small sub-problem.
- Verify: one numeric/proof check.
- Review: method choice + error pattern.

## Checkpoint Format
- Step: identifier
- Done: what changed
- Verified: command/check + result
- Concept: what was learned
- Next: exact next micro-step

## Success Criteria
- Learner can explain current concept in 1-2 lines.
- Verification passes.
- Next micro-step is clear.
