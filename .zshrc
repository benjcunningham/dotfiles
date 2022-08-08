export EDITOR="vim"
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="dracula"
TERM=xterm-256color

skip_global_compinit=1

source "${ZSH}/oh-my-zsh.sh"

# Search history with up / down keys
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# Pyenv
export PYENV_ROOT="${HOME}/.pyenv"
command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
