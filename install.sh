#!/bin/bash

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

clone_dotfiles() {

    DOTFILES_DIR="${HOME}/dotfiles"
    if [ -n "${DOTFILES_LOCAL}" ]; then
        note "Using local dotfiles from ${DOTFILES_DIR}."
        echo "Assuming the files you want to use exist at the location."
    elif [ ! -d "${DOTFILES_DIR}" ]; then
        note "Downloading benjcunningham/dotfiles to ${DOTFILES_DIR}."
        if [ ! -n "${DOTFILES_MINIMAL}" ]; then
            git clone \
                --depth=1 \
                --no-checkout \
                --shallow-submodules \
                --sparse \
                https://github.com/benjcunningham/dotfiles \
                "${DOTFILES_DIR}"
            cd "${DOTFILES_DIR}"
            git checkout HEAD \
                dotbot \
                dotbotconf/minimal.conf.yaml \
                scripts/dotfiles.sh \
                scripts/tpm.sh \
                scripts/vundle.sh
        else
            git clone https://github.com/benjcunningham/dotfiles "${DOTFILES_DIR}"
        fi
    else
        warn "Directory ${DOTFILES_DIR} already exists."
        echo "Assuming it is an existing clone of this project."
        echo "If this is not correct, you may want to move that directory."
    fi

}

usage() {

    cat <<-EOF
Name:

  benjcunningham/dotfiles -- Ben Cunningham's dotfiles

Usage:

  bash install.sh [-hlmpw]

Options:

  -h  Display this help message
  -l  Source local version of dotfiles repository
  -m  Minimal installation
  -p  Install software for personal use
  -w  Install software for work use

Notes:

  See https://github.com/benjcunningham/dotfiles to learn more about
  this script and the software and dotfiles it installs.
	EOF

    exit 1

}

do_install() {

    start_time=$(date +%s)

    note "Installing benjcunningham/dotfiles..."

    if is_darwin; then

        note "Running macOS installation."

        if [ ! -f "$(which brew)" ]; then
            echo | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        else
            warn "Homebrew installation already found."
        fi

        brew upgrade
        brew install curl git make

    else

        note "Running Linux installation."

        if ! type "add-apt-repository" > /dev/null; then
            sudo apt-get update
            sudo apt-get install -y software-properties-common
        fi

        sudo add-apt-repository ppa:git-core/ppa
        sudo apt-get update
        sudo apt-get install -y \
            curl \
            git \
            gnupg \
            make

    fi

    if [ -n "${DOTFILES_MINIMAL}" ]; then

        note "Doing minimal install."
        cat <<-EOF
		This is useful for working on machines that aren't your own, for example a
		remote server. Use the ${tty_underline}install.sh${tty_reset} script if you prefer a full installation.
		${tty_red}Note${tty_reset}: This script strictly assumes you are running the installation on a
		Debian-like (incl. Ubuntu) system.
		EOF

    else

        note "Doing full install."
        cat <<-EOF
		This is useful for machines you will use long-term, as it installs lots of software.
		If you want a more minimal installation, set the --minimal flag.
		EOF

    fi

    clone_dotfiles

    cd "${DOTFILES_DIR}"
    export DOTBOT_CONFIG="${DOTBOT_CONFIG:-dotbotconf/full.conf.yaml}"

    # Minimal install
    if [ -n "${DOTFILES_MINIMAL}" ]; then

        # Minimal install (macOS)
        if is_darwin; then

            warn "No minimal installer available for macOS."

        # Minimal install (Ubuntu)
        else

            sudo apt-get install -y \
                python \
                tmux \
                vim

            scripts/dotfiles.sh
            scripts/tpm.sh
            scripts/vundle.sh

        fi

    # Full install
    else

        # Full install (macOS)
        if is_darwin; then

            scripts/macos.sh

        # Full install (Ubuntu)
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

    fi

    end_time=$(date +%s)
    script_time=$((end_time-start_time))

    note "Installation successful! (${script_time}s)"
    note "Next steps:"
    cat <<-EOF
	Find more documentation here: ${tty_underline}https://benjcunningham.org/dotfiles${tty_reset}.
	EOF

}

while getopts ":hlmpw" flag; do
    case "${flag}" in
        h ) usage
            exit 1 ;;
        l ) export DOTFILES_LOCAL=1
            echo "\$DOTFILES_LOCAL set." ;;
        m ) export DOTFILES_MINIMAL=1
            DOTBOT_CONFIG=dotbotconf/minimal.conf.yaml
            echo "\$DOTFILES_MINIMAL set." ;;
        p ) export DOTFILES_PERSONAL=1
            echo "\$DOTFILES_PERSONAL set." ;;
        w ) export DOTFILES_WORK=1
            echo "\$DOTFILES_WORK set." ;;
    esac
done

do_install
