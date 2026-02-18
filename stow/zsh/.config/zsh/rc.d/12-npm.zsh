# User-level npm globals for Nix-managed systems.
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local/npm-global}"

case ":$PATH:" in
  *":$NPM_CONFIG_PREFIX/bin:"*) ;;
  *) export PATH="$NPM_CONFIG_PREFIX/bin:$PATH" ;;
esac
