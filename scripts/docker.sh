#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Docker..."

if [ is_darwin ]; then

    brew install --cask docker

else

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io

fi
