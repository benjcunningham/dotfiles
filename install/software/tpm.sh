#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing TPM"

TPM_DIR="${HOME}/.tmux/plugins/tpm"

if [ ! -d "${TPM_DIR}" ]; then

    git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
    tmux start \; source-file "${HOME}/.tmux.conf"

    echo "Completed TPM installation"

else

    warn "Skipping TPM install since ${TPM_DIR} already exists"

fi
