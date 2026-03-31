# Obsidian Notesmith Examples

## Example 1 - Research a topic

Command:

`obsidian research "Second Brain"`

Expected structure:

- `10 - MOCs/MOC - Second Brain.md`
- `20 - Sources/SRC - PARA Method - Forte - 2023.md`
- `20 - Sources/SRC - Zettelkasten Introduction - 2020.md`
- `20 - Sources/LIT - Second Brain - Synthesis.md`
- `30 - Evergreen/EVR-SEEDS - Second Brain.md`
- `03 - Resources/Second Brain/DIGEST - Second Brain.md`
- `03 - Resources/Second Brain/CONSUME - Second Brain.md`

Validation:

`python3 .config/opencode/skills/obsidian-notesmith/scripts/validate_frontmatter.py --vault "$HOME/vaults/Brains" --topic "Second Brain"`

## Example 2 - Summarize one source

Command:

`obsidian summarize "https://fortelabs.com/blog/para/"`

Expected output:

- one `SRC` note
- updated `MOC` source section
- optional `DIGEST` refresh

## Example 3 - Distill after lesson

Commands:

1. `101 next`
2. `obsidian distill "<lesson-topic>"`

Expected output:

- one updated `LIT` synthesis note
- one new or updated `EVR-SEEDS` note
- user writes final `EVR` note
- MOC links updated with rationale lines
