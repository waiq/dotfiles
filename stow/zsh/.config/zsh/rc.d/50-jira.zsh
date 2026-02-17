export JIRA_API_TOKEN="op://Readly/Atlassian/api_key"

_require_op_account() {
  if [ -z "${OP_ACCOUNT:-}" ]; then
    echo "OP_ACCOUNT is not set. Configure it in stow/local/.config/zsh/profile.d/20-1password-account.zsh" >&2
    return 1
  fi
}

jira() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira "$@"
}

jimy-issues() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira issues list -a"$(jira me)" --order-by created "$@"
}

jimy-epics() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira epics list --order-by created "$@"
}

jiw() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira issues view "$@"
}

jil() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira issues list "$@"
}

jimo() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira issues move "$@"
}

if command -v compdef >/dev/null 2>&1 && typeset -f _jira >/dev/null 2>&1; then
  compdef _jira jira jimy-issues jimy-epics jiw jil jimo
fi
