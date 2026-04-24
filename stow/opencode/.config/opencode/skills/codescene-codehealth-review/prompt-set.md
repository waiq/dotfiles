# Prompt Set: CodeScene Code Health Reviews

Use these prompts with the `codescene-codehealth-review` skill.

## 1) Project Scan + Deep Dive (recommended)

```text
Use skill `codescene-codehealth-review`.
Mode: project
Target: <repo-path>
Profile: clean_code_collective
Depth: deep
Deep-dive hotspots: 3

Run a Code Health-first review in two phases:
1) scan whole project and rank hotspots,
2) deep-dive top hotspots only.

Exclude test-only code from analytics by default using language-agnostic patterns
(`test/`, `tests/`, `__tests__/`, `spec/`, `specs/`, `e2e/`, `integration-tests/`,
`testdata/`, `*_test.*`, `test_*.*`, `*.test.*`, `*.spec.*`, `*Spec.*`).

Use CodeScene smell taxonomy (module/function/implementation) and decline statuses.
Use weighted hotspot prioritization and explain risk drivers.
Produce output using report-template.md.
Give smallest safe refactor sequence + one verification command per hotspot.
```

## 2) Branch Gate Review (before PR)

```text
Use skill `codescene-codehealth-review`.
Mode: branch
Target: diff <base-branch>...HEAD
Profile: bare_minimum
Depth: standard
Deep-dive hotspots: 3

Run scan -> deep-dive flow over branch diff.
Focus on critical_health_rules, new_code_health, hotspot_decline.
Deep-dive only top hotspots in changed files.
Exclude test-only code by default using language-agnostic test/spec conventions.
Return merge recommendation with explicit must-fix conditions.
Use report-template.md.
```

## 3) Staged/Uncommitted Changes Fast Gate

```text
Use skill `codescene-codehealth-review`.
Mode: changes
Target: staged + unstaged local diff
Profile: clean_code_collective
Depth: quick
Deep-dive hotspots: 2

Run a compact scan of local changes, then deep-dive top 2 hotspots.
Flag maintainability risks to fix before commit.
Give smallest safe patch suggestions and one verification step per finding.
Exclude test-only code by default using language-agnostic test/spec conventions.
Use report-template.md compactly.
```

## 4) Targeted Hotspot Paths (legacy + new split)

```text
Use skill `codescene-codehealth-review`.
Mode: changes
Target: <path1> <path2> <path3>
Profile: custom
Depth: standard
Deep-dive hotspots: 3

Run scan -> deep-dive on these paths.
Apply stricter gates to new modules and bare-minimum gates to legacy modules.
Exclude test-only code by default using language-agnostic test/spec conventions.
Call out where .codescene/code-health-rules.json should encode this policy.
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
Deep-dive hotspots: 3

Re-run compact scan and deep-dive on previously flagged hotspots.
List: resolved, partially resolved, still open.
Exclude test-only code by default using language-agnostic test/spec conventions.
Give final safe-to-merge decision with conditions.
Use report-template.md.
```

## 6) Code Health Rules Awareness Check

```text
Use skill `codescene-codehealth-review`.
Mode: project
Target: <repo-path>
Profile: custom
Depth: standard
Deep-dive hotspots: 3

Run scan -> deep-dive flow.
Inspect .codescene/code-health-rules.json and report rule-weight/threshold impacts.
Detect @codescene(disable...) directives and call out missing rationale.
Exclude test-only code by default using language-agnostic test/spec conventions.
Do not recommend disabling critical rules.
Use report-template.md.
```
