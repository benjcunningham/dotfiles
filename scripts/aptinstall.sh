#!/bin/bash

echo "📦 Installing Ubuntu libraries with APT"

sudo apt-get update

# shellcheck disable=SC2032
function install {

    already_installed=()
    not_installed=()

    for prog in "$@"; do

        if which "$prog" &> /dev/null; then
            not_installed+=("${prog}")
        else
            already_installed+=("${prog}")
        fi

    done

    echo "Already installed: ${already_installed[*]}"
    echo "Installing: ${not_installed[*]}"

    # shellcheck disable=SC2033
    sudo apt-get install -y "${not_installed[*]}"

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
    shellcheck \
    tmux \
    vim \
    vlc \
    zsh

sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "✔️  Done with APT installations"
