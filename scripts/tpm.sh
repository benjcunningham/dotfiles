#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing TPM..."

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "${TPM_DIR}" ]; then
    git clone https://github.com/tmux-plugins/tpm "${TPM_DIR}"
fi

tmux source "${HOME}/.tmux.conf"
