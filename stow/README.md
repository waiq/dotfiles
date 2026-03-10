# stow packages

This directory contains GNU Stow packages for user config files.
It is the authoritative source of truth for repository-managed dotfiles and shell wrappers.

Current starter packages:
- `zsh`
- `git`
- `tmux`
- `nvim`
- `wezterm`
- `bin`
- `local` (local-only, untracked; created from `local.example`)

Use from repo root:

```bash
stow --dir stow --target "$HOME" --simulate zsh git tmux nvim wezterm bin
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin
```

Local overrides setup:

```bash
cp -a stow/local.example stow/local
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin local
```

`stow/local` is gitignored and should hold machine/profile-only values (for example `OP_ACCOUNT` and git identity at `~/.gitconfig.local`).

Ownership:
- package/runtime install -> `home-manager/`
- config files/shell wrappers -> `stow/`
- legacy/reference only (non-authoritative) -> `core/`, `custom/`
