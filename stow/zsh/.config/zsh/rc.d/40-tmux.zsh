# alias
alias ts='tmux-switch'
alias td='tmux-dev-layout'
alias tk='tmux-kill'


tmux-reload() {
  tmux source-file ~/.tmux.conf
  tmux list-sessions -F "#{session_name}" | while read -r session; do
    tmux send-keys -t "$session" "source ~/.zshrc" C-m
  done
}

tmux-kill() {
  local session="$1"
  if [[ -z "$session" ]]; then
    session=$(tmux list-sessions | fzf | sed 's/: .*//g')
  fi
  if tmux has-session -t "$session" 2>/dev/null; then
    if [[ -n "$TMUX" ]]; then
      # If the current session is the one being killed, switch to another session first
      if [[ "$(tmux display-message -p '#S')" == "$session" ]]; then
        local other_session=$(tmux list-sessions | grep -v "^$session:" | head -n 1 | sed 's/: .*//g')
        if [[ -n "$other_session" ]]; then
          tmux switch-client -t "$other_session"
        else
          tmux detach-client -s "$session"
        fi
      fi
    fi
    tmux kill-session -t "$session"
  else
    echo "Session '$session' does not exist."
    return 1
  fi
}

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
