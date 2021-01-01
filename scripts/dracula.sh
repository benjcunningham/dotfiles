#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Dracula themes..."

if is_darwin; then

    echo "Adding to iTerm2"

    ITERM_THEME="${HOME}/.iterm"

    if [ ! -d "${ITERM_THEME}" ]; then
        git clone https://github.com/dracula/iterm.git "${ITERM_THEME}"
    fi

else

    echo "Adding to GNOME Terminal"

    GNOME_THEME="${HOME}/gnome-terminal"

    if [ ! -d "${GNOME_THEME}" ]; then
        git clone https://github.com/dracula/gnome-terminal "${GNOME_THEME}"
    fi

fi

echo "Adding to Zsh"

ZSH_THEMES="${HOME}/.oh-my-zsh/themes"
DRACULA_THEME="${HOME}/.oh-my-zsh/custom/themes/dracula"

if [ ! -d "${ZSH_THEMES}" ]; then
    mkdir -p "${ZSH_THEMES}"
fi

if [ ! -d "${DRACULA_THEME}" ]; then
    git clone https://github.com/dracula/zsh.git "${DRACULA_THEME}"
fi

ln -fs "${DRACULA_THEME}/dracula.zsh-theme" "${ZSH_THEMES}/dracula.zsh-theme"
