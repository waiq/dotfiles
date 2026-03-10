# Dotfile Core (Deprecated)

`core/` is legacy Ansible orchestration and is deprecated.

## Status

- Do not use `core/install.sh` or `ansible-playbook` workflows from this repository.
- Canonical apply path is Home Manager + stow.

## Canonical Apply Path

From repo root:

```bash
home-manager switch --flake ./home-manager#waiq
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin local
```
