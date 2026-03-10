# Home Manager

This directory contains the Home Manager flake used for package/runtime/service management.
Home Manager is authoritative for packages/services; `stow/` is authoritative for config files.

## Outputs
Current Home Manager targets:
- `waiq` (legacy/default stable target)
- `waiq-nix` (migration target, currently same behavior as `waiq`)
- `waiq-config` (migration target, currently same behavior as `waiq`)
- `waiq-work` (profile scaffold)
- `waiq-home` (profile scaffold)

## Prerequisites
- Nix installed
- Home Manager available (globally or via `nix run`)

## Apply Commands
From repo root:

```bash
home-manager switch --flake ./home-manager#waiq
```

Migration targets:

```bash
home-manager switch --flake ./home-manager#waiq-nix
home-manager switch --flake ./home-manager#waiq-config
home-manager switch --flake ./home-manager#waiq-work
home-manager switch --flake ./home-manager#waiq-home
```

Without global Home Manager installation:

```bash
nix run github:nix-community/home-manager -- switch --flake ./home-manager#waiq
```

## Recommended Migration Apply Flow
From repo root:

```bash
home-manager switch --flake ./home-manager#waiq-nix
cp -a stow/local.example stow/local  # first time only
# edit stow/local/.gitconfig.local and set your user.name/email
# edit stow/local/.zshrc.local and set OP_ACCOUNT
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin local
```

Then verify shell and secret-dependent wrappers:

```bash
zsh -lc 'command -v git tmux nvim op jira'
op whoami
```

Local git identity setup:
- configure `stow/local` to provide `~/.gitconfig.local`
- keep `user.name` and `user.email` out of tracked git config

## Update flake inputs
From `home-manager/`:

```bash
nix flake update
```

Or from repo root:

```bash
nix flake update --flake ./home-manager
```

## File Layout
- `flake.nix`: flake outputs and configuration targets
- `home.nix`: compatibility entrypoint importing module tree
- `modules/base.nix`: shared base configuration
- `profiles/work.nix`: work-only overlay (scaffold)
- `profiles/home.nix`: home-only overlay (scaffold)
- `flake.lock`: pinned inputs
