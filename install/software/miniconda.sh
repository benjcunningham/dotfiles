#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing Miniconda"

CONDA_PATH="${HOME}/miniconda"

case "${DOTFILES_TARGET}" in

    macos/full)
        CONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
        ;;

    ubuntu-18.04/full | ubuntu-18.04/minimal | ubuntu-20.04/full | ubuntu-20.04/minimal)
        CONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
        ;;

    *)
        warn "Dotfiles target does not match an option"
        ;;

esac

if [ ! -d "${CONDA_PATH}" ]; then

    CONDA_URL="https://repo.anaconda.com/miniconda/${CONDA_INSTALLER}"
    curl -OL "${CONDA_URL}"

    bash "${CONDA_INSTALLER}" -b -p "${CONDA_PATH}"
    rm "${CONDA_INSTALLER}"

    source "${HOME}/miniconda/bin/activate"
    conda init zsh

    echo "Completed Miniconda installation"

else

    warn "Skipping Miniconda install since ${CONDA_PATH} already exists"

fi
