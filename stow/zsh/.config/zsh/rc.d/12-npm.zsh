# User-level npm globals for Nix-managed systems.
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local/npm-global}"

typeset -U path PATH
path=("$NPM_CONFIG_PREFIX/bin" ${path:#$NPM_CONFIG_PREFIX/bin})
export PATH
hash -r
