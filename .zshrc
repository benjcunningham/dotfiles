export EDITOR="vim"
export PAGER="less"
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
export ZSH="${HOME}/.oh-my-zsh"

DISABLE_AUTO_UPDATE=true
TERM="xterm-256color"
ZSH_THEME="dracula"

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

ln -sf /usr/local/bin/python3 /usr/local/bin/python

# Aliases

alias rgf="rg --files | rg"

function rgr {
    rg "${1}" --files-with-matches -0 | xargs -0 sed -i '' "s/${1}/${2}/g"
}

function rgfr {
    find . | rg "${1}" -0 | while read SRC_FILE; do
        DEST_FILE=$(echo $SRC_FILE | sed "s/${1}/${2}/g")
        mv $SRC_FILE $DEST_FILE
    done
}

autoload -U +X bashcompinit && bashcompinit
