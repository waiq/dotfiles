#!/usr/bin/env python3
"""Scaffold a 101 learning track from a topic and mode."""

from __future__ import annotations

import argparse
import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path


def slugify(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value)
    return value.strip("-") or "topic"


@dataclass
class Lesson:
    id: str
    title: str
    concept: str
    steps: list[dict[str, str]]


def default_lessons(topic: str) -> list[Lesson]:
    return [
        Lesson(
            id="01",
            title="Foundations",
            concept=f"Core framing of {topic}",
            steps=[
                {
                    "id": "01.01",
                    "goal": f"Define what {topic} is and is not.",
                    "you_do": "Write a 3-line boundary definition.",
                    "run": "Self-check against one concrete example.",
                    "concept_note": "Boundaries prevent fuzzy understanding.",
                }
            ],
        ),
        Lesson(
            id="02",
            title="Core Mechanics",
            concept=f"Main moving parts in {topic}",
            steps=[
                {
                    "id": "02.01",
                    "goal": "Map the core mechanism in sequence.",
                    "you_do": "Write a 5-step flow.",
                    "run": "Check that each step has one input and output.",
                    "concept_note": "Mechanics beat memorization.",
                }
            ],
        ),
        Lesson(
            id="03",
            title="Applied Practice",
            concept=f"Using {topic} on a small real case",
            steps=[
                {
                    "id": "03.01",
                    "goal": "Apply the model to one practical case.",
                    "you_do": "Solve one tiny scenario end-to-end.",
                    "run": "Check outcome against one expected result.",
                    "concept_note": "Application cements transfer.",
                }
            ],
        ),
    ]


def render_overview(topic: str, mode: str, lessons: list[Lesson]) -> str:
    lines = [
        f"# {topic} 101",
        "",
        "## Intent",
        f"- Mode: {mode}",
        "- Outcome: Build practical understanding through tiny verified steps.",
        "",
        "## Lesson Sequence",
    ]
    for lesson in lessons:
        lines.append(f"{int(lesson.id)}. {lesson.title} - {lesson.concept}")
    lines += [
        "",
        "## Verification Strategy",
        "- One check per step.",
        "- Stay on concept until green.",
    ]
    return "\n".join(lines) + "\n"


def render_lesson(lesson: Lesson) -> str:
    lines = [
        f"# Lesson {lesson.id}: {lesson.title}",
        "",
        "## Concept Focus",
        lesson.concept,
        "",
        "## Steps",
        "",
    ]
    for step in lesson.steps:
        lines += [
            f"### Step {step['id']}",
            f"1. Goal (one sentence): {step['goal']}",
            f"2. You do (exact target): {step['you_do']}",
            f"3. Run (one command/check): {step['run']}",
            "4. Review checklist (3-5 bullets):",
            "- Correctness",
            "- Boundary clarity",
            "- Readability",
            f"5. Concept note (short): {step['concept_note']}",
            "",
        ]
    return "\n".join(lines)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate a 101 learning scaffold")
    parser.add_argument("topic", help="Big topic to decompose")
    parser.add_argument(
        "--mode",
        choices=["beginner", "intermediate", "advanced"],
        default="beginner",
        help="Target learner mode",
    )
    parser.add_argument(
        "--output-root",
        default="workspace/101",
        help="Root folder for generated materials",
    )
    args = parser.parse_args()

    slug = slugify(args.topic)
    track_dir = Path(args.output_root) / slug
    track_dir.mkdir(parents=True, exist_ok=True)

    lessons = default_lessons(args.topic)

    (track_dir / "00_overview.md").write_text(
        render_overview(args.topic, args.mode, lessons), encoding="utf-8"
    )

    for lesson in lessons:
        lesson_path = track_dir / f"{lesson.id}_{slugify(lesson.title)}.md"
        lesson_path.write_text(render_lesson(lesson), encoding="utf-8")

    progress = {
        "topic": args.topic,
        "mode": args.mode,
        "current_lesson": "01",
        "current_step": "01.01",
        "current_concept": lessons[0].concept,
        "lessons": [asdict(lesson) for lesson in lessons],
        "concept_graph": [
            {"from": "01", "to": "02"},
            {"from": "02", "to": "03"},
        ],
        "blockers": [],
        "next_step": "Emit lesson step 01.01",
        "notes_path": str(track_dir),
    }
    (track_dir / "progress.json").write_text(
        json.dumps(progress, indent=2) + "\n", encoding="utf-8"
    )

    checkpoint = (
        "# Checkpoints\n\n"
        "- Step: 00\n"
        "- Done: Generated 101 plan scaffold\n"
        "- Verified: generate_plan.py completed + files exist\n"
        "- Concept: Topic decomposition and sequencing\n"
        "- Next: Start lesson 01 step 01.01\n"
    )
    (track_dir / "CHECKPOINTS.md").write_text(checkpoint, encoding="utf-8")

    print(f"Created 101 scaffold at: {track_dir}")


if __name__ == "__main__":
    main()
