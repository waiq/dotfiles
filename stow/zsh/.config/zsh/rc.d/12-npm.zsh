# User-level npm globals for Nix-managed systems.
# PATH precedence is enforced in ~/.zshenv so it applies to all shell modes.
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local/npm-global}"
