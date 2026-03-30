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
