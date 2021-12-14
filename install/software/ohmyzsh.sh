#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing Oh My Zsh"

if [ ! -d "${ZSH}" ]; then

    ZSH_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    sh -c "$(curl -fsSL ${ZSH_URL})" "" --unattended

else

    warn "Directory ${ZSH} already exists."
    echo "Oh My Zsh installer would have exited with an error."
    echo "If you really need to reinstall, you can:"
    echo "- Unset the ZSH variable."
    echo "- Move or delete the directory."

fi

echo "Completed Oh My Zsh installation"
