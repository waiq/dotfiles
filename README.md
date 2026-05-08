# dotfiles

- Home Manager (`home-manager/`) for installs/runtime/services
- GNU Stow (`stow/`) for dotfile/config symlinks

## Repository Layout

- `home-manager/`: Nix flake + Home Manager modules
- `stow/`: source of truth for dotfile/config symlinks

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

Bootstrap host structure first (creates `~/.my`, `~/.local/bin`, `~/.config`, `~/.gitconfig.local`):

```bash
./bootstrap.sh
```

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

Restow all stow packages dynamically:

```bash
stow --dir stow --target "$HOME" --restow $(find stow -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | grep -v '^local.example$')
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
```

Optional one-line setup for tmux `sudo htop` popup (passwordless for this command only):

```bash
printf '%s\n' 'waiq ALL=(root) NOPASSWD: /home/waiq/.nix-profile/bin/htop' | sudo tee /etc/sudoers.d/tmux-htop >/dev/null && sudo chmod 0440 /etc/sudoers.d/tmux-htop && sudo chown root:root /etc/sudoers.d/tmux-htop && sudo visudo -cf /etc/sudoers.d/tmux-htop
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
- Set default Jira epic locally (untracked), e.g. `export JIRA_DEFAULT_EPIC="DISCO-53"` in `stow/local/.zshrc.local`.
- Sign in before running wrappers:

```bash
op signin
```

- Validate after apply:

```bash
op whoami
op account list
```

Create and assign a new Jira task in your default epic:

```bash
jnt "Fix tmux popup flicker" "Popup closes immediately when command path is missing"
jnt -e DISCO-99 -t Bug "Fix popup flicker" "Repro: prefix+k"
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

## Global Git Hooks (Jira Prefix)

This dotfiles setup includes a global `prepare-commit-msg` hook at:

- `~/.config/git/hooks/prepare-commit-msg`

It auto-prefixes commit messages with a Jira key extracted from the current branch name.

Examples:

- Branch `DISCO-1488-add-categories` + message `refactor categories path`
  becomes `DISCO-1488: refactor categories path`
- Branch `ABC-42` works the same way.

Key pattern is generic:

- `[A-Z][A-Z0-9]+-[0-9]+`

Behavior notes:

- No prefix is added if message already starts with a Jira key.
- Merge/squash/commit-source auto messages are skipped.
- `fixup!`, `squash!`, and `revert ` messages are skipped.

## Dotfiles Repo Anonymous Identity Policy

This repository is intentionally anonymized in commit metadata.

- Required in this repo: `user.name=dotfiles`
- Required in this repo: empty `user.email`

Enforcement:

- `bootstrap.sh` sets repo-local git identity when run from this repo.
- Global hook `~/.config/git/hooks/pre-commit` blocks commits in `dotfiles` when identity is not anonymized.

Manual fix if needed:

```bash
git config user.name dotfiles
git config user.email ""
```

## Git Workspace Helper

Use `git-workspace` to create a new branch and a matching git worktree workspace from a name.

Examples:

```bash
git-workspace feature-auth
git-workspace -b main DOT-1008
git-workspace --root "$HOME/dev/workspaces/dotfiles" feature-shell-cleanup
git-workspace -p DOT-2001
git-workspace -B DOT-2001
```

Behavior:

- slugifies the input name
- creates branch as `<slug>`
- creates worktree under `../workspaces/<repo-name>/<repo-name>-<slug>` by default
- creates new branch from `main` (falls back to `master` if `main` is missing)
- use `--force` to reuse an existing branch with a new worktree path
- `-p/--print-path` prints only the workspace path (for piping)
- `-B/--print-branch` prints only the branch name

Chaining example:

```bash
gw -p DOT-2001 | td --create-only
```

`td --create-only` (or `td -d`) creates the tmux session detached and does not switch/attach.

## Source Of Truth Policy

- Package/runtime/service management: `home-manager/`
- Config files and shell wrappers: `stow/`
