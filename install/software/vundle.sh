#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing Vundle"

VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

if [ ! -d "${VUNDLE_DIR}" ]; then

    git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"
    echo | vim +'PluginInstall' +qa >/dev/null

    echo "Completed Vundle installation"

else

    warn "Skipping Vundle install since ${VUNDLE_DIR} already exists"

fi
