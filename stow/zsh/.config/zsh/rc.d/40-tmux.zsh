# alias
alias ts='tmux-switch-session'
alias td='tmux-dev-layout'
alias tk='tmux-kill-session'
alias tn='tmux-read-notifications'

tmux-reload() {
  tmux start-server

  if ! tmux source-file ~/.tmux.conf; then
    echo "Failed to reload ~/.tmux.conf"
    return 1
  fi

  tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' \
    | while read -r target cmd; do
        [[ "$cmd" == "zsh" ]] || continue
        tmux send-keys -t "$target" 'source ~/.zshrc' C-m
      done
}

tmux-dev-layout() {
  local create_only=0
  local target_path=""
  local session=""
  local positional=""

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --create-only|-d)
        create_only=1
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "td: unknown option: $1" >&2
        return 1
        ;;
      *)
        positional="$1"
        shift
        ;;
    esac
  done

  if [[ -n "$positional" ]]; then
    if [[ -d "$positional" ]]; then
      target_path="$positional"
    else
      session="$positional"
    fi
  elif [[ ! -t 0 ]]; then
    target_path="$(cat)"
  fi

  target_path="${target_path//$'\n'/}"

  if [[ -n "$target_path" ]]; then
    if [[ ! -d "$target_path" ]]; then
      echo "td: path does not exist: $target_path" >&2
      return 1
    fi
    session="$(basename "$target_path")"
  fi

  if [[ -z "$session" ]]; then
    session="$(basename "$PWD")"
  fi

  if tmux has-session -t "$session" 2>/dev/null; then
    echo "Session '$session' already exists."
  else
    echo "Creating tmux session: $session"
    if [[ -n "$target_path" ]]; then
      tmux new-session -d -s "$session" -n edit -c "$target_path"
    else
      tmux new-session -d -s "$session" -n edit
    fi
    if [[ -n "$target_path" ]]; then
      tmux split-window -v -t "$session":1 -c "$target_path"
      tmux new-window -t "$session":2 -n commands -c "$target_path"
    else
      tmux split-window -v -t "$session":1
      tmux new-window -t "$session":2 -n commands
    fi
    tmux select-window -t "$session":1
    tmux select-pane -t "$session":1.1

    if [[ -n "$target_path" ]]; then
      local quoted_path
      quoted_path="${(q)target_path}"
      tmux list-panes -t "$session" -F '#{session_name}:#{window_index}.#{pane_index}' \
        | while read -r pane; do
            tmux send-keys -t "$pane" "cd -- $quoted_path" C-m
          done
    fi
  fi

  if [[ "$create_only" -eq 1 ]]; then
    return 0
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach -t "$session"
  fi
}
