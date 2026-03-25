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

jira-new-task() {
  _require_op_account || return 1

  local epic_key="${JIRA_DEFAULT_EPIC:-}"
  local issue_type="Task"

  while getopts ":e:t:" opt; do
    case "$opt" in
      e) epic_key="$OPTARG" ;;
      t) issue_type="$OPTARG" ;;
      :) echo "Option -$OPTARG requires a value." >&2; return 1 ;;
      \?) echo "Usage: jira-new-task [-e EPIC_KEY] [-t ISSUE_TYPE] <SUMMARY> [DESCRIPTION]" >&2; return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ -z "$epic_key" ]]; then
    echo "Epic key missing. Set JIRA_DEFAULT_EPIC in stow/local/.zshrc.local or pass -e <EPIC_KEY>." >&2
    return 1
  fi

  if [[ -z "${1:-}" ]]; then
    echo "Usage: jira-new-task [-e EPIC_KEY] [-t ISSUE_TYPE] <SUMMARY> [DESCRIPTION]" >&2
    return 1
  fi

  local summary="$1"
  local description="${2:-}"
  local me
  me="$(jira me)"

  if [[ -n "$description" ]]; then
    jira issue create -t "$issue_type" -P "$epic_key" -s "$summary" -b "$description" -a "$me" --no-input
  else
    jira issue create -t "$issue_type" -P "$epic_key" -s "$summary" -a "$me" --no-input
  fi
}

alias jnt='jira-new-task'

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

jimy-move() {
  _require_op_account || return 1

  local me issue_line issue_key target_state custom_state
  me="$(jira me)" || return 1

  issue_line="$(
    op run --account "$OP_ACCOUNT" -- jira issue list \
      -a"$me" \
      -s~Done \
      --order-by updated \
      --reverse \
      --plain \
      --no-headers \
      --columns key,summary,status,priority \
      | fzf --prompt="My Jira > " --height=70% --border --no-sort --tiebreak=index
  )" || return 0

  issue_key="${issue_line%%$'\t'*}"
  if [[ -z "$issue_key" ]]; then
    echo "No issue key selected." >&2
    return 1
  fi

  target_state="$(printf '%s\n' \
    "To Do" \
    "In Progress" \
    "Blocked" \
    "Done" \
    "Custom..." \
    "Back" \
    | fzf --prompt="Move $issue_key to > " --height=40% --border
  )" || return 0

  case "$target_state" in
    "Back"|"")
      return 0
      ;;
    "Custom...")
      read -r "custom_state?Custom state: "
      [[ -z "$custom_state" ]] && return 0
      jimo "$issue_key" "$custom_state"
      ;;
    *)
      jimo "$issue_key" "$target_state"
      ;;
  esac
}

if command -v compdef >/dev/null 2>&1 && typeset -f _jira >/dev/null 2>&1; then
  compdef _jira jira jira-new-task jnt jimy-issues jimy-epics jiw jil jimo jimy-move
fi
