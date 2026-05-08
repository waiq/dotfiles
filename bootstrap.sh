#!/usr/bin/env sh
set -eu

# Structure-only bootstrap. Does not move/clone dotfiles repo.
MY_ROOT="${MY_ROOT:-$HOME/.my}"

ensure_dir() { [ -d "$1" ] || mkdir -p "$1"; }
ensure_file() { [ -f "$1" ] || : > "$1"; }

ensure_dir "$MY_ROOT"
ensure_dir "$HOME/.local/bin"
ensure_dir "$HOME/.config"
ensure_file "$HOME/.gitconfig.local"

# Lock anonymous commit identity for this repo only.
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
  if [ -n "$repo_root" ] && [ "$(basename "$repo_root")" = "dotfiles" ]; then
    git config user.name "dotfiles"
    git config user.email ""
  fi
fi

printf '%s\n' "bootstrap ok"
printf '%s\n' "MY_ROOT=$MY_ROOT"
