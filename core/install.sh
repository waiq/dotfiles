#!/bin/bash

set -euo pipefail

cat <<'EOF'
[DEPRECATED] core/install.sh is no longer supported.

This repository no longer uses Ansible as an apply workflow.
Use the canonical Home Manager + stow path instead:

  home-manager switch --flake ./home-manager#waiq
  stow --dir stow --target "$HOME" --restow zsh git tmux nvim wezterm bin local

If you still depend on legacy Ansible externally, migrate that flow before removing core/.
EOF

exit 1
