export EDITOR="vim"
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
export ZSH="${HOME}/.oh-my-zsh"

ZSH_THEME="dracula"
TERM=xterm-256color

skip_global_compinit=1

source "${ZSH}/oh-my-zsh.sh"

# Set pager
export PAGER=less

# Search history with up / down keys
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# Pyenv
export PYENV_ROOT="${HOME}/.pyenv"
command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [ $(uname -s) = "Darwin" ] && is-at-least 12.5 $(sw_vers -productVersion); then
    echo "On macOS and >=12.5"
    ln -s /usr/local/bin/python3 /usr/local/bin/python
fi

# Aliases
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
