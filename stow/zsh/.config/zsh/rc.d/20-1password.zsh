# 1Password integration defaults.
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Optional local account values.
if [ -f "$HOME/.zshrc.local" ]; then
  source "$HOME/.zshrc.local"
fi

# Backward-compatible account variable mapping.
if [ -n "${ONE_PASSWORD_ACCOUNT:-}" ] && [ -z "${OP_ACCOUNT:-}" ]; then
  export OP_ACCOUNT="$ONE_PASSWORD_ACCOUNT"
fi
if [ -n "${OP_ACCOUNT:-}" ] && [ -z "${ONE_PASSWORD_ACCOUNT:-}" ]; then
  export ONE_PASSWORD_ACCOUNT="$OP_ACCOUNT"
fi
