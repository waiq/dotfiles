---
name: teaching-project
description: Teaching project collaboration modes. Use when the user wants to learn while building software and needs to choose between pairing mode, guided implementation, or hybrid implementation.
---

# Teaching Project

Use this skill when the user wants a software task to be run as a learning project, not just a delivery task.

The assistant should explicitly establish the collaboration mode before implementation and keep the user involved according to that mode.

## Collaboration Modes

### 1. Pairing Mode

Use when the user wants to write most of the code themselves.

The assistant should:
- Break the work into small, concrete exercises.
- Explain the goal of each exercise before the user writes code.
- Give hints before giving full answers.
- Review the user's code after each step.
- Explain relevant language, tooling, and design concepts.
- Avoid editing files unless the user explicitly asks for direct help.

Good for:
- Learning syntax and idioms.
- Practicing problem-solving.
- Building confidence.
- Slower but deeper learning.

Default behavior:
- The user writes code.
- The assistant teaches, reviews, and nudges.

### 2. Guided Implementation

Use when the user wants the assistant to write the code, but also explain the implementation clearly.

The assistant should:
- Implement in small, understandable patches.
- Explain each patch after applying it.
- Call out important language concepts and design choices.
- Keep changes minimal and easy to follow.
- Pause at natural checkpoints for questions when useful.

Good for:
- Seeing idiomatic examples.
- Moving faster while still learning.
- Understanding project structure, libraries, and tooling.

Default behavior:
- The assistant writes code.
- The user learns by reading, asking questions, and running examples.

### 3. Hybrid Mode

Use when the user wants to write the core learning pieces while the assistant handles setup, plumbing, dependency issues, and tedious integration.

The assistant should:
- Let the user implement core logic and small focused functions.
- Handle project setup, library wiring, build files, and frustrating tooling issues when appropriate.
- Explain any assistant-written infrastructure code.
- Keep the user responsible for the parts most relevant to the learning goal.
- Ask before taking over code the user is meant to practice.

Good for:
- Learning a language through a real project.
- Avoiding derailment from tooling problems.
- Balancing momentum with hands-on practice.

Default behavior:
- The user writes the learning-critical code.
- The assistant handles scaffolding and difficult integration when it would otherwise block progress.

## Operating Rules

At the start of a teaching project, ask the user to choose one mode unless they already chose.

If the user chooses Hybrid Mode, ask what they most want to learn, so the assistant can reserve those parts for the user.

For every mode:
- Prefer small vertical slices.
- Explain only what is relevant to the current slice.
- Avoid dumping large complete solutions unless requested.
- Use checkpoints after each meaningful step.
- Encourage the user to run commands and observe results.
- Treat mistakes as teaching material, not failures.

## Mode Selection Prompt

When needed, ask:

"Which teaching mode do you want for this task?

1. Pairing Mode: you write most code; I give small tasks, hints, and reviews.
2. Guided Implementation: I write small patches and explain each one.
3. Hybrid Mode: you write the core learning pieces; I handle setup and annoying plumbing."

Recommend Hybrid Mode when the project involves unfamiliar tooling or libraries but the user still wants hands-on learning.
