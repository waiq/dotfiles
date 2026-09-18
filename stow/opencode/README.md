# opencode stow package

This package manages OpenCode local config assets under `~/.config/opencode`.

Current contents:
- `~/.config/opencode/AGENTS.md`
- `~/.config/opencode/opencode.json`
- `~/.config/opencode/skills/*`

Local architecture skills:
- `~/.config/opencode/skills/improve-codebase-architecture`
- `~/.config/opencode/skills/codebase-design`
- `~/.config/opencode/skills/domain-modeling`
- `~/.config/opencode/skills/grilling`

These are dotfiles-managed local imports, not `skills.paths` references to an
external checkout. Upstream material was adapted for opencode and Go-oriented
examples where examples were needed.

Not tracked (runtime/local):
- `~/.config/opencode/node_modules/`
- `~/.config/opencode/pending-feedback-queue.md`
- `~/.config/opencode/AGENTS.md.pre-stow-backup-*`

Apply package from dotfiles repo root:

```bash
stow --dir stow --target "$HOME" --restow opencode
```

Validation:

```bash
ls -la ~/.config/opencode/skills/coop-task
ls -la ~/.config/opencode/AGENTS.md
ls -la ~/.config/opencode/opencode.json
test -f ~/.config/opencode/skills/improve-codebase-architecture/SKILL.md
test -f ~/.config/opencode/skills/codebase-design/SKILL.md
test -f ~/.config/opencode/skills/domain-modeling/SKILL.md
test -f ~/.config/opencode/skills/grilling/SKILL.md
```
