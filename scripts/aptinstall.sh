#!/bin/bash

echo "📦 Installing Ubuntu libraries with APT"

sudo apt-get update

function install {

    already_installed=()
    not_installed=()

    for prog in "$@"; do

        which $prog &> /dev/null

        if [ $? -ne 0 ]; then
            not_installed+=(${prog})
        else
            already_installed+=(${prog})
        fi

    done

    echo "Already installed: ${already_installed[@]}"
    echo "Installing: ${not_installed[@]}"

    sudo apt-get install -y ${not_installed[@]}

}

install \
    sudo \
    apt-transport-https \
    arandr \
    ca-certificates \
    curl \
    dconf-cli \
    gcc \
    git \
    gnome-terminal \
    gnupg-agent \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    network-manager-openvpn \
    openvpn \
    pavucontrol \
    python \
    redshift \
    ruby \
    ruby-dev \
    software-properties-common \
    make \
    tmux \
    vim \
    vlc \
    zsh

sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "✔️  Done with APT installations"
