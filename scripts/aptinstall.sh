#!/bin/bash

echo "Installing Ubuntu libraries with APT"

sudo apt-get update

# shellcheck disable=SC2032
function install {

    not_installed=()

    for prog in "$@"; do
        not_installed+=("${prog}")
    done

    echo "Installing: ${not_installed[*]}"

    # shellcheck disable=SC2033,SC2068
    sudo apt-get install -y ${not_installed[@]}

}

install \
    sudo \
    apt-transport-https \
    arandr \
    ca-certificates \
    curl \
    dconf-cli \
    feh \
    gcc \
    git \
    gnome-terminal \
    gnupg-agent \
    i3 \
    i3status \
    irssi \
    libcurl4-gnutls-dev \
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
    rofi \
    ruby \
    ruby-dev \
    software-properties-common \
    shellcheck \
    tmux \
    vim \
    vlc \
    xclip \
    zsh

sudo apt-get upgrade -y
sudo apt-get autoremove -y

echo "[DONE] Done with APT installations"
