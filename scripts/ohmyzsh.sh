#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Oh My Zsh..."

if [ -z "${ZSH}" ]; then
    INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    sh -c "$(curl -fsSL ${INSTALL_URL})" "" --unattended
else
    warn "Directory ${ZSH} already exists."
    echo "Oh My Zsh installer would have exited with an error."
    echo "If you really need to reinstall, you can:"
    echo "- Unset the ZSH variable."
    echo "- Move or delete the directory."
fi
