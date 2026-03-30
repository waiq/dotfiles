---
name: learn-101
description: Break a large topic into a practical 101 syllabus, docs, and lesson micro-steps.
license: MIT
compatibility: opencode
metadata:
  audience: learners
  role: meta-orchestrator
  depends_on: lesson
---

## Purpose

- Convert big topics into a coherent beginner-to-advanced path.
- Keep lesson quality from the `lesson` skill while scaling to multi-lesson tracks.
- Produce docs + checkpoints so progress is resumable.

## Command Surface

- `101 start <topic> [mode]`
- `101 next`
- `101 pause`
- `101 resume`
- `101 recap`
- `101 export`

## Orchestrator Contract

1. Plan first, teach second.
2. One lesson = one core concept.
3. One step = one action + one verification check.
4. Reuse `lesson` step output format exactly during execution.
5. Always leave a checkpoint after each step.

## Inputs

- `topic`: large learning target (example: distributed systems)
- `mode`: `beginner` | `intermediate` | `advanced` (default: beginner)

## Required Outputs

- `00_overview.md`: syllabus, concept map, prerequisite order.
- `NN_<lesson-slug>.md`: one file per lesson with micro-steps.
- `progress.json`: machine-readable state.
- `CHECKPOINTS.md`: append-only checkpoint log.

Default output root:

- `workspace/101/<topic-slug>/`

## State To Track

- topic
- mode
- current_lesson
- current_step
- current_concept
- lessons
- concept_graph
- user_action
- verify_command
- success_criteria
- blockers
- next_step
- notes_path

## Planning Pipeline (`101 start`)

1. Build concept inventory for topic.
2. Identify prerequisites and construct a concept graph.
3. Order concepts by dependency depth.
4. Bundle concepts into lessons (3-7 steps each).
5. Generate overview doc, lesson files, and progress state.
6. Set current position to lesson 1 step 1.

## Execution Pipeline (`101 next`)

1. Read current lesson and step from `progress.json`.
2. Emit next step using the exact 5-part lesson template.
3. Wait for learner completion signal + verification result.
4. If green: checkpoint + advance index.
5. If red: apply recovery rules and retry same concept.

## Recovery Rules

- If verification fails, find one root cause.
- Apply one tiny fix only.
- Run one check again.
- Do not move to the next concept until current is green.

## Templates

- Overview template: `templates/overview.md`
- Lesson template: `templates/lesson-step.md`
- Checkpoint template: `templates/checkpoint.md`

## Optional Helper

- `scripts/generate_plan.py`
- Use to scaffold files from topic + mode quickly.

## Success Criteria

- Learner can explain each current concept in 1-2 lines.
- Every step has exactly one verification result.
- Progress can be resumed without missing context.
