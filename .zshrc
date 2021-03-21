export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="dracula"
TERM=xterm-256color

skip_global_compinit=1

export EDITOR="vim"
export ZSH="${HOME}/.oh-my-zsh"

source "${HOME}/.bash_aliases"
source "${ZSH}/oh-my-zsh.sh"

# Search history with up / down keys
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
