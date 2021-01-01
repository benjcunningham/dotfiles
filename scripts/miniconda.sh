#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Miniconda..."

CONDA_PATH="${HOME}/miniconda"

if is_darwin; then
    CONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
else
    CONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
fi

if [ ! -d "${CONDA_PATH}" ]; then

    CONDA_URL="https://repo.anaconda.com/miniconda/${CONDA_INSTALLER}"
    curl -OL ${CONDA_URL}

    bash ${CONDA_INSTALLER} -b -p "${HOME}/miniconda"
    rm ${CONDA_INSTALLER}

fi

# shellcheck disable=SC1090
source "$HOME/miniconda/bin/activate"
conda init zsh
