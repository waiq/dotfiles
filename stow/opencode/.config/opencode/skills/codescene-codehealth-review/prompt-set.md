# Prompt Set: CodeScene Code Health Reviews

Use these prompts with the `codescene-codehealth-review` skill.

## 1) Project Baseline Review

```text
Use skill `codescene-codehealth-review`.
Mode: project
Target: <repo-path>
Profile: clean_code_collective
Depth: deep

Review this project for code health and maintainability using CodeScene-aligned gates.
Prioritize hotspots/high-churn risk areas first.
Produce output using report-template.md.
Give concrete refactoring suggestions with minimal-change path + verification command.
```

## 2) Branch Review (before PR)

```text
Use skill `codescene-codehealth-review`.
Mode: branch
Target: diff <base-branch>...HEAD
Profile: bare_minimum
Depth: standard

Review this branch as a CodeScene-style PR gate.
Focus on: critical_health_rules, new_code_health, hotspot_decline.
Return merge recommendation and top 3-7 actionable findings.
Use report-template.md.
```

## 3) Staged/Uncommitted Changes Review

```text
Use skill `codescene-codehealth-review`.
Mode: changes
Target: staged + unstaged local diff
Profile: clean_code_collective
Depth: quick

Review current local changes and flag any maintainability risks that should be fixed before commit.
Give smallest safe patch suggestions and one verification step per finding.
Use report-template.md (compactly).
```

## 4) Targeted Paths Review (legacy + new code split)

```text
Use skill `codescene-codehealth-review`.
Mode: changes
Target: <path1> <path2> <path3>
Profile: custom
Depth: standard

Apply stricter gates to new modules and bare-minimum gates to legacy modules.
Call out where custom-quality-gates.json could encode this policy.
Return quick wins and structural improvements.
Use report-template.md.
```

## 5) Post-fix Recheck

```text
Use skill `codescene-codehealth-review`.
Mode: branch
Target: diff <base-branch>...HEAD
Profile: <same-as-before>
Depth: quick

Re-evaluate previously reported findings.
List: resolved, partially resolved, still open.
Give final safe-to-merge decision with conditions.
Use report-template.md.
```
