export JIRA_API_TOKEN="op://Readly/Atlassian/api_key"

_require_op_account() {
  if [ -z "${OP_ACCOUNT:-}" ]; then
    echo "OP_ACCOUNT is not set. Configure it in stow/local/.zshrc.local" >&2
    return 1
  fi
}

jira() {
  _require_op_account || return 1
  op run --account "$OP_ACCOUNT" -- jira "$@"
}

list-epics() {
  _require_op_account || return 1

  if [ -z "${1:-}" ]; then
    echo "Usage: list-epics <PROJECT_KEY> [JQL]" >&2
    return 1
  fi

  local project_key="$1"
  local jql="${2:-}"

  if [ -n "$jql" ]; then
    op run --account "$OP_ACCOUNT" -- jira epic list -p "$project_key" --plain --columns key,summary,status --jql "$jql"
  else
    op run --account "$OP_ACCOUNT" -- jira epic list -p "$project_key" --plain --columns key,summary,status
  fi
}

create-issue-in-epic() {
  _require_op_account || return 1

  if [ $# -lt 4 ]; then
    echo "Usage: create-issue-in-epic <PROJECT_KEY> <EPIC_KEY> <ISSUE_TYPE> <SUMMARY> [DESCRIPTION]" >&2
    return 1
  fi

  local project_key="$1"
  local epic_key="$2"
  local issue_type="$3"
  local summary="$4"
  local description="${5:-}"

  if [ -n "$description" ]; then
    op run --account "$OP_ACCOUNT" -- jira issue create -p "$project_key" -t "$issue_type" -P "$epic_key" -s "$summary" -b "$description" --no-input
  else
    op run --account "$OP_ACCOUNT" -- jira issue create -p "$project_key" -t "$issue_type" -P "$epic_key" -s "$summary" --no-input
  fi
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
