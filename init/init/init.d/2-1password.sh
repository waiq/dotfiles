
export SSH_AUTH_SOCK=/home/waiq/.1password/agent.sock

# Backward-compatible account variable mapping.
if [ -n "${ONE_PASSWORD_ACCOUNT:-}" ] && [ -z "${OP_ACCOUNT:-}" ]; then
  export OP_ACCOUNT="${ONE_PASSWORD_ACCOUNT}"
fi
if [ -n "${OP_ACCOUNT:-}" ] && [ -z "${ONE_PASSWORD_ACCOUNT:-}" ]; then
  export ONE_PASSWORD_ACCOUNT="${OP_ACCOUNT}"
fi

