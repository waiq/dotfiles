#!/usr/bin/env bash
set -euo pipefail

DEV_ROOT="${DEV_ROOT:-$HOME/dev}"
VAULT_ROOT="${VAULT_ROOT:-$HOME/vaults/Brains/agents}"

if [[ ! -d "$DEV_ROOT" ]]; then
  echo "DEV root not found: $DEV_ROOT" >&2
  exit 1
fi

mkdir -p "$VAULT_ROOT"

applied=0
skipped=0

for project_dir in "$DEV_ROOT"/*; do
  [[ -d "$project_dir" ]] || continue
  project_name="$(basename "$project_dir")"

  vault_project_dir="$VAULT_ROOT/$project_name"
  vault_agents_file="$vault_project_dir/AGENTS.md"
  repo_agents_file="$project_dir/AGENTS.md"

  mkdir -p "$vault_project_dir"

  if [[ ! -f "$vault_agents_file" ]]; then
    cat > "$vault_agents_file" <<EOF
# AGENTS

Canonical agent instructions for project \`$project_name\`.

This file is authoritative.
EOF
  fi

  cat > "$repo_agents_file" <<EOF
# Agent Instructions Pointer

Canonical instructions for this project live in the Obsidian vault:

\`$vault_agents_file\`

If this file conflicts with vault content, vault content is authoritative.
EOF

  applied=$((applied + 1))
done

echo "Applied pointer pattern to $applied projects under $DEV_ROOT"
echo "Vault canonical root: $VAULT_ROOT"
echo "Skipped: $skipped"
