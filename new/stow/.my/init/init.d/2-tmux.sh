function tmux-default-layout() {
  local SESSION=default

  if [[ -z "$SESSION" ]]; then
    echo "Usage: start_tmux_development <session-name>"
    return 1
  fi

  if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already exists."
  else
    echo "Creating tmux session: $SESSION"

    # Window 1 (due to base-index 1)
    tmux new-session -d -s "$SESSION" -n doc
    tmux split-window -v -t "$SESSION":1

    # Window 2 (next one)
    tmux new-window -t "$SESSION":2 -n commands

    # Select pane 1 in window 1 (due to pane-base-index 1)
    tmux select-window -t "$SESSION":1
    tmux select-pane -t "$SESSION":1.1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$SESSION"
  else
    tmux attach -t "$SESSION"
  fi
}

function tmux-dev-layout() {
  local SESSION=$1

  if [[ -z "$SESSION" ]]; then
    SESSION="$(basename "$PWD")"
  fi

  if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already exists."
  else
    echo "Creating tmux session: $SESSION"

    # Window 1 (due to base-index 1)
    tmux new-session -d -s "$SESSION" -n edit
    tmux split-window -v -t "$SESSION":1

    # Window 2 (next one)
    tmux new-window -t "$SESSION":2 -n commands

    # Select pane 1 in window 1 (due to pane-base-index 1)
    tmux select-window -t "$SESSION":1
    tmux select-pane -t "$SESSION":1.1
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$SESSION"
  else
    tmux attach -t "$SESSION"
  fi
}
