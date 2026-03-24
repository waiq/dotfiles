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
