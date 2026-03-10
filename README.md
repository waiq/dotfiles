# dotfiles

This repo has migrated away from legacy Ansible automation to:
- Home Manager (`home-manager/`) for installs/runtime/services
- GNU Stow (`stow/`) for dotfile/config symlinks

Legacy Ansible paths are deprecated and must not be used.

## Repository Layout
- `home-manager/`: Nix flake + Home Manager modules
- `stow/`: source of truth for dotfile/config symlinks
- `init/`: compatibility shell bootstrap currently used in active environments
- `core/`: deprecated legacy Ansible orchestration (retained temporarily for reference)
- `custom/`: deprecated legacy role source material (reference only, not authoritative)

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
stow --dir stow --target "$HOME" --simulate zsh git tmux nvim wezterm
```

Apply:

```bash
stow --dir stow --target "$HOME" zsh git tmux nvim wezterm
```

Restow (safe re-link after file moves):

```bash
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm
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
stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin local
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
- Sign in before running wrappers:

```bash
op signin
```

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

## Git Workspace Helper
Use `git-workspace` to create a new branch and a matching git worktree workspace from a name.

Examples:

```bash
git-workspace feature-auth
git-workspace -b main DOT-1008
git-workspace --root "$HOME/dev/workspaces/dotfiles" feature-shell-cleanup
```

Behavior:
- slugifies the input name
- creates branch as `<repo-name>/<slug>`
- creates worktree under `../workspaces/<repo-name>/<repo-name>-<slug>` by default
- creates new branch from `main` (falls back to `master` if `main` is missing)
- use `--force` to reuse an existing branch with a new worktree path

## Legacy Ansible (Deprecated)
Ansible-based repo workflows are deprecated and no longer supported.
Do not run Ansible entrypoints from this repository.

- Deprecated orchestration reference: `core/`
- Legacy role source material (reference only): `custom/roles/`
- Compatibility shell bootstrap: `init/`

## Source Of Truth Policy
- Package/runtime/service management: `home-manager/`
- Config files and shell wrappers: `stow/`
- `core/` and `custom/` are deprecated reference paths and must not be used as authoritative sources.

Migration control doc:
- `AGENTS_MIGRATION.md`
