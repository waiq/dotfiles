# dotfiles

This repo is migrating from legacy Ansible automation to:
- Home Manager (`home-manager/`) for installs/runtime/services
- GNU Stow (`stow/`) for dotfile/config symlinks

Legacy paths still exist during migration to keep environments stable.

## Repository Layout
- `home-manager/`: Nix flake + Home Manager modules
- `stow/`: config packages (planned/ongoing migration target)
- `init/`: compatibility shell bootstrap currently used in active environments
- `core/`, `custom/`: legacy Ansible orchestration and roles

## Prerequisites
- Nix installed
- Home Manager available (global install or `nix run`)
- `stow` available (installed by Home Manager or system package manager)

## Home Manager Usage
From repo root:

```bash
home-manager switch --flake ./home-manager#waiq
```

Without global Home Manager install:

```bash
nix run github:nix-community/home-manager -- switch --flake ./home-manager#waiq
```

Update flake inputs:

```bash
nix flake update --flake ./home-manager
```

## Stow Usage
Stow is used to apply config packages to `$HOME`.

Preview changes first:

```bash
stow --dir stow --target "$HOME" --simulate zsh git tmux nvim
```

Apply:

```bash
stow --dir stow --target "$HOME" zsh git tmux nvim
```

Restow (safe re-link after file moves):

```bash
stow --dir stow --target "$HOME" --restow zsh git tmux nvim
```

Remove package links:

```bash
stow --dir stow --target "$HOME" --delete zsh
```

## Recommended Apply Flow
From repo root:

1. Apply packages/services with Home Manager.
2. Apply config links with stow.
3. Reload shell and verify commands/functions.

Example:

```bash
home-manager switch --flake ./home-manager#waiq
cp -a stow/local.example stow/local  # first time only
# edit stow/local/.gitconfig.local and set your user.name/email
# edit stow/local/.zshrc.local and set OP_ACCOUNT
stow --dir stow --target "$HOME" --restow zsh git tmux nvim bin local
source ~/.my/init/init.sh
```

## Work vs Home Profiles (Planned)
The migration plan defines shared base + small overlays (`work` and `home`).
Expected flake targets after rollout:
- `#waiq-work`
- `#waiq-home`

Until those outputs are added, use `#waiq`.

## 1Password / op Workflows
This setup is `op`-heavy by design.

- Keep secrets out of repo; commit only references like `op://...`.
- Keep command wrappers (`jira`, etc.) in stow-managed shell config.
- Set account IDs only in local untracked files under `stow/local`.
- Validate after apply:

```bash
op whoami
op account list
```

If SSH integration is used:

```bash
echo "$SSH_AUTH_SOCK"
```

Expected value is usually `~/.1password/agent.sock`.

## Local Git Identity
Git identity must be provided via local untracked config in `stow/local`.

Target path:
- `~/.gitconfig.local`

Shared git config will include that file, and it should define:
- `[user] name = ...`
- `[user] email = ...`

## Legacy Ansible (Transitional)
Legacy commands remain for compatibility, but are being phased out.

- Entrypoints and orchestration: `core/`
- Role implementations: `custom/roles/`
- Old bootstrap/init behavior: `init/`

Migration control doc:
- `AGENTS_MIGRATION.md`
