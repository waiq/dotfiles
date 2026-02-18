# Ensure npm global binaries take precedence in every zsh mode
# (interactive, login, and non-interactive).
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local/npm-global}"

case ":$PATH:" in
  *":$NPM_CONFIG_PREFIX/bin:"*) ;;
  *) export PATH="$NPM_CONFIG_PREFIX/bin:$PATH" ;;
esac

# Preserve Rust toolchain environment initialization.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
