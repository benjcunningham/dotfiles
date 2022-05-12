#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Adding GPG keys for third-party APT sources."

echo "Installing brave-browser keys"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | \
    sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list

note "Installing Ubuntu (APT) software."

sudo apt-get update
sudo apt-get install -y \
    sudo \
    apt-transport-https \
    build-essential \
    arandr \
    ca-certificates \
    curl \
    dconf-cli \
    feh \
    g++ \
    gcc \
    git \
    gnome-terminal \
    gnupg-agent \
    i3 \
    i3status \
    irssi \
    libcurl4-gnutls-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    make \
    network-manager-openvpn \
    openvpn \
    pavucontrol \
    pulseaudio \
    pulseaudio-module-bluetooth \
    pulsemixer \
    python \
    redshift \
    ruby \
    ruby-dev \
    software-properties-common \
    shellcheck \
    tmux \
    vim \
    vlc \
    xclip \
    xfce4-power-manager \
    zsh

sudo apt-get upgrade -y
sudo apt-get autoremove -y
