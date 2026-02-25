tmux-switch() {
  local session="$1"
  if [[ -z "$session" ]]; then
    session=$(tmux list-sessions | fzf | sed 's/: .*//g')
  fi

  if tmux has-session -t "$session" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      tmux switch-client -t "$session"
    else
      tmux attach -t "$session"
    fi
  else
    echo "Session '$session' does not exist."
    return 1
  fi
}

tmux-default-layout() {
  local session="default"

  if tmux has-session -t "$session" 2>/dev/null; then
    echo "Session '$session' already exists."
  else
    echo "Creating tmux session: $session"
    tmux new-session -d -s "$session" -n doc
    tmux split-window -v -t "$session":1
    tmux new-window -t "$session":2 -n commands
    tmux select-window -t "$session":1
    tmux select-pane -t "$session":1.1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach -t "$session"
  fi
}

tmux-dev-layout() {
  local session="$1"

  if [[ -z "$session" ]]; then
    session="$(basename "$PWD")"
  fi

  if tmux has-session -t "$session" 2>/dev/null; then
    echo "Session '$session' already exists."
  else
    echo "Creating tmux session: $session"
    tmux new-session -d -s "$session" -n edit
    tmux split-window -v -t "$session":1
    tmux new-window -t "$session":2 -n commands
    tmux select-window -t "$session":1
    tmux select-pane -t "$session":1.1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach -t "$session"
  fi
}
