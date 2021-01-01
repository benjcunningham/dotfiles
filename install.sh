#!/bin/sh

set -eo pipefail

# Dotfiles installation script
#
# This script is meant for quick, easy install via:
#
#   $ curl -fsSL https://github.com/benjcunningham/dotfiles/installer.sh -o installer.sh
#   $ sh installer.sh
#
# Note: You should make sure to verify the contents of the script you
#       download matches the contents of the file at
#       https://github.com/benjcunningham/dotfiles/installer.sh before
#       executing it.
#
# See https://github.com/benjcunningham/dotfiles for more information.

SCRIPT_COMMIT_SHA=""

BRANCH=${BRANCH:-master}

# String formatting
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

    note "Installing benjcunningham/dotfiles..."

    if [ is_darwin ]; then

        echo "Running macOS installation."

        if [ ! -f "$(which brew)" ]; then
            echo | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        else
            warn "Homebrew installation already found."
        fi

        brew upgrade
        brew install curl git make

    else

        echo "Running Linux installation."

        sudo apt-get install curl git make

    fi

    DOTFILES_DIR="${HOME}/dotfiles"
    if [ ! -d ${DOTFILES_DIR} ]; then
        note "Downloading benjcunningham/dotfiles to ${DOTFILES_DIR}."
        git clone https://github.com/benjcunningham/dotfiles "$HOME/dotfiles"
    else
        warn "Directory ${DOTFILES_DIR} already exists."
        echo "Assuming it is an existing clone of this project."
        echo "If this is not correct, you may want to move that directory."
    fi

    cd ${DOTFILES_DIR}
    echo $(pwd)

    if [ is_darwin ]; then

        scripts/macos.sh

    else

        scripts/ubuntu.sh
        scripts/fonts.sh
        scripts/dconf.sh
        scripts/power-manager.sh

    fi

    scripts/docker.sh
    scripts/miniconda.sh
    scripts/ohmyzsh.sh
    scripts/ruby.sh
    scripts/dotfiles.sh
    scripts/tpm.sh
    scripts/vundle.sh
    scripts/dracula.sh
    scripts/wallpapers.sh

    note "Installation successful!"
    note "Next steps:"
    cat <<-EOF
	Find more documentation here: ${tty_underline}https://benjcunningham.org/dotfiles${tty_reset}.
	EOF

}

do_install
