export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  zsh-vi-mode # add this first
  zsh-256color
  git
  direnv
  docker
  fzf
  fzf-tab
  fzf-zsh-plugin
  zsh-autosuggestions
)

# needs to be set before oh-my-zsh is sourced
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# my dotfiles stuff
autoload -U compinit; compinit
autoload bashcompinit; bashcompinit

# load stow-managed zsh modules first
if [ -d "$HOME/.config/zsh/rc.d" ]; then
  for f in "$HOME"/.config/zsh/rc.d/*.zsh; do
    [ -r "$f" ] && source "$f"
  done
fi

eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/themes/my.omp.json)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(op completion zsh)"; compdef _op op

# history settings
HISTORYSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTORYSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# some keybindings
bindkey -e
bindkey '^p' history-serch-backward
bindkey '^n' history-serch-forward
