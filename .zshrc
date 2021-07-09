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

source <(k3d completion zsh)
source <(kompose completion zsh)
source <(kubectl completion zsh)

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

rec() {

    delete_cast=true

    for arg in "$@"; do
        case $arg in
            --keep-cast | -c)
                delete_cast=false
                shift
                ;;
        esac
    done

    fname="${1:-rec}"

    if [ -e "${fname}.gif" ]; then
        i=1
        while [ -e "${fname}-${i}.gif" ]; do
            let i++
        done
        fname="${fname}-${i}"
    fi

    fname="${fname}.gif"
    castfile="${fname}.cast"
    asciinema rec -i 1 "${castfile}"
    asciicast2gif -w 88 -h 20 "${castfile}" "'${fname}'"

    if ${delete_cast}; then
        rm "${castfile}"
    fi

}


