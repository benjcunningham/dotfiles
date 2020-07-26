#!/bin/bash

echo "Installing Miniconda"

if [ "$(uname)" = "Darwin" ]; then
    CONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
elif [ "$(uname)" = "Linux" ]; then
    CONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
else
    echo "[ERROR] Couldn't find matching Miniconda version for kernel"
    exit 1
fi

URL="https://repo.anaconda.com/miniconda/${CONDA_INSTALLER}"

if which conda &> /dev/null; then
    echo "Installing Miniconda..."
    curl -OL ${URL}
    bash ${CONDA_INSTALLER} -b -p "$HOME/miniconda"
    rm ${CONDA_INSTALLER}

    # shellcheck disable=SC1090
    source "$HOME/miniconda/bin/activate"

else
    echo "[INFO] Miniconda already installed"
fi

conda init zsh

echo "[DONE] Done with Miniconda installation"
