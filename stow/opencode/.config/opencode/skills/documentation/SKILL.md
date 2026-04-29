---
name: documentation
description: Produce readable, structured documentation with Diataxis mapping, Markdown style gates, and quality scoring.
license: MIT
compatibility: opencode
metadata:
  audience: engineers, maintainers, learners
  role: documentation-writer
  depends_on: none
---

## Purpose

- Generate docs people can scan, trust, and apply quickly.
- Enforce one doc purpose per page using Diataxis.
- Keep Markdown style consistent and maintainable.

## Trigger Conditions

Use this skill when task asks to:

- write or rewrite docs, guides, runbooks, README sections, notes
- improve readability/structure/style of existing docs
- standardize docs output quality across a repo or vault

## Core Contract

1. Classify each output as exactly one Diataxis type: `tutorial`, `how-to`,
   `reference`, or `explanation`.
2. Every substantive doc must state audience + goal + expected outcome.
3. Keep one page focused on one primary purpose; link out for depth.
4. Use Markdown style gates before finalizing.
5. Return a short quality report with checklist status and rubric score.

## Inputs

- `topic`: subject of the document
- `doc_type`: `tutorial|how-to|reference|explanation|auto`
- `audience`: target reader profile
- `context`: project/tool/domain constraints
- `length_mode`: `short|standard|deep` (default: `standard`)
- `source_material`: optional links or notes

## Workflow

1. **Classify**
   - If `doc_type=auto`, choose one Diataxis type and state why.
2. **Outline**
   - Build section structure from matching template.
3. **Draft**
   - Write concise sections with minimal runnable examples where relevant.
4. **Style pass**
   - Apply Markdown rules from `standards-matrix.md`.
5. **Quality pass**
   - Run checklist in `checklist.md` and score with `rubric.md`.
6. **Finalize**
   - Return output + quality summary + follow-up improvements if needed.

## Output Contract

For substantive outputs (not tiny ad-hoc answers), include:

1. YAML front matter with metadata.
2. One H1 title and clear H2 hierarchy.
3. Explicit audience and outcome sections.
4. At least one example block for tutorial/how-to when applicable.
5. `See also` links for deeper references.
6. Quality report:
   - checklist pass/fail
   - rubric score (0-100)
   - top 1-3 improvements if score < 85

## Modes

- `short`: compact output for quick notes; still enforce headings + clarity +
  descriptive links.
- `standard`: default; full structure + checklist + rubric.
- `deep`: extended explanation, references, edge cases, migration notes.

## Files

- `standards-matrix.md`
- `checklist.md`
- `rubric.md`
- `templates/tutorial.md`
- `templates/how-to.md`
- `templates/reference.md`
- `templates/explanation.md`
- `templates/vault-note.md`
- `validation/samples.md`
- `validation/results.md`

## Success Criteria

- Reader can identify purpose in <= 10 seconds.
- Structure is skimmable with consistent headings and short sections.
- Checklist passes all required checks.
- Rubric score is >= 85 for release-quality docs.
