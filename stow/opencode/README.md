# opencode stow package

This package manages OpenCode local config assets under `~/.config/opencode`.

Current contents:
- `~/.config/opencode/AGENTS.md`
- `~/.config/opencode/opencode.json`
- `~/.config/opencode/skills/*`

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
```
