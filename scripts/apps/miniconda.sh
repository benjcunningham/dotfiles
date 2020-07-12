#!/bin/bash

echo "🐍 Installing Miniconda"

if [ `uname` = "Darwin" ]; then
    CONDA_INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
elif [ `uname` = "Linux" ]; then
    CONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
else
    echo "❌ Couldn't find matching Miniconda version for kernel"
    exit 1
fi

URL="https://repo.anaconda.com/miniconda/${CONDA_INSTALLER}"

which conda &> /dev/null

if [ $? -ne 0 ]; then
    echo "Installing Miniconda..."
    curl -OL ${URL}
    bash ${CONDA_INSTALLER} -b -p $HOME/miniconda
    rm ${CONDA_INSTALLER}
    source $HOME/miniconda/bin/activate
    conda init zsh
else
    echo "Miniconda already installed"
fi

echo "✔️ Done with Miniconda installation"
