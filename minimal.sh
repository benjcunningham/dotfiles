#!/bin/bash

set -eo pipefail

if [[ -t 1 ]]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi

tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_green="$(tty_mkbold 32)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"; do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

chomp() {
  printf "%s" "${1/"$'\n'"/}"
}

note() {
  printf "${tty_green}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")"
}

execute() {
  if ! "$@"; then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

is_darwin() {
    case "$(uname -s)" in
        *darwin*) true;;
        *Darwin**) true;;
        *) false;;
    esac
}

do_install() {

    note "Doing minimal install of benjcunningham/dotfiles..."
    cat <<-EOF
	This is useful for working on machines that aren't your own, for example a
	remote server. Use the ${tty_underline}install.sh${tty_reset} script if you prefer a full installation.
	${tty_red}Note${tty_reset}: This script strictly assumes you are running the installation on a
	Debian-like (incl. Ubuntu) system.
	EOF

    sudo apt-get install update
    sudo apt-get install -y \
        curl \
        git \
        make \
        tmux \
        vim

    DOTFILES_DIR="${HOME}/dotfiles"
    if [ ! -d "${DOTFILES_DIR}" ]; then
        note "Downloading benjcunningham/dotfiles to ${DOTFILES_DIR}."
        git clone https://github.com/benjcunningham/dotfiles "$HOME/dotfiles"
    else
        warn "Directory ${DOTFILES_DIR} already exists."
        echo "Assuming it is an existing clone of this project."
        echo "If this is not correct, you may want to move that directory."
    fi

    cd "${DOTFILES_DIR}"
    export DOTBOT_CONFIG="minimal-dotbot.conf.yaml"

    scripts/dotfiles.sh
    scripts/tpm.sh
    scripts/vundle.sh

    note "Installation successful!"
    note "Next steps:"
    cat <<-EOF
	Find more information here: ${tty_underline}https://benjcunningham.org/dotfiles${tty_reset}
	EOF

}

do_install
