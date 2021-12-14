#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing Dracula themes"

macos_install() {

    ITERM_THEME="${HOME}/.iterm"

    if [ ! -d "${ITERM_THEME}" ]; then
        echo "Adding to iTerm2"
        git clone https://github.com/dracula/iterm.git "${ITERM_THEME}"
    else
        warn "Skipping iTerm2 since ${ITERM_THEME} already exists"
    fi

}

ubuntu_install() {

    GNOME_THEME="${HOME}/gnome-terminal"

    if [ ! -d "${GNOME_THEME}" ]; then
        echo "Adding to GNOME Terminal"
        git clone https://github.com/dracula/gnome-terminal "${GNOME_THEME}"
    else
        warn "Skipping GNOME Terminal since ${GNOME_THEME} already exists"
    fi

}

case "${DOTFILES_TARGET}" in

    macos/full)
        macos_install
        ;;

    ubuntu-18.04/full | ubuntu-18.04/minimal | ubuntu-20.04/full | ubuntu-20.04/minimal)
        ubuntu_install
        ;;

    *)
        warn "Dotfiles target does not match an option"
        ;;

esac

echo "Adding to Zsh"

ZSH_THEMES="${HOME}/.oh-my-zsh/themes"
mkdir -p "${ZSH_THEMES}"

DRACULA_THEME="${HOME}/.oh-my-zsh/custom/themes/dracula"

if [ ! -d "${DRACULA_THEME}" ]; then
    git clone https://github.com/dracula/zsh.git "${DRACULA_THEME}"
fi

cd "${DRACULA_THEME}/zsh"
git pull

ln -fs "${DRACULA_THEME}/dracula.zsh-theme" "${ZSH_THEMES}/dracula.zsh-theme"

echo "Completed installing Dracula themes"
