# 101 Skill Quickstart

## What it does
`101` is a meta-skill that turns one large topic into:
- an overview document
- multiple lesson files
- resumable progress state
- checkpoints

## Fast start
```bash
python3 ~/.config/opencode/skills/101/scripts/generate_plan.py "distributed systems" --mode beginner
```

Output default:
- `workspace/101/distributed-systems/`

## Generated files
- `00_overview.md`
- `01_foundations.md`
- `02_core-mechanics.md`
- `03_applied-practice.md`
- `progress.json`
- `CHECKPOINTS.md`

## Runtime command intent
- `101 start <topic> [mode]`: scaffold syllabus + lessons + progress state
- `101 next`: emit next micro-step using lesson template
- `101 pause`: persist checkpoint and hold position
- `101 resume`: continue from saved state
- `101 recap`: summarize progress and concept coverage
- `101 export`: compile final notes into one document
