# local.example

Template for local, untracked machine/profile overrides.

Usage:

1. Copy `stow/local.example` to `stow/local`.
2. Fill your local values in files under `stow/local`.
3. Apply stow including the `local` package.

Example:

```bash
cp -a stow/local.example stow/local
stow --dir stow --target "$HOME" --restow zsh git tmux nvim bin local
```

`stow/local` is gitignored and must never be committed.

Files to customize locally:
- `.gitconfig.local` for git identity (`user.name`, `user.email`)
- `.zshrc.local` for `OP_ACCOUNT`
