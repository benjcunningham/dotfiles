#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Vundle..."

VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

if [ ! -d "${VUNDLE_DIR}" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"
fi

echo | vim +'PluginInstall' +qa > /dev/null
