# opencode stow package

This package manages OpenCode local config assets under `~/.config/opencode`.

Current contents:
- `~/.config/opencode/skills/coop-task/SKILL.md`

Apply package from dotfiles repo root:

```bash
stow --dir stow --target "$HOME" --restow opencode
```

Validation:

```bash
ls -la ~/.config/opencode/skills/coop-task
```
