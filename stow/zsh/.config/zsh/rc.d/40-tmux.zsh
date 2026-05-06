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
  "$HOME/.local/bin/tmux-dev-layout" "$@"
}
