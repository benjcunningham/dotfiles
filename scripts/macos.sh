#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

DOTFILES_WORK="${DOTFILES_WORK:-0}"
DOTFILES_PERSONAL="${DOTFILES_PERSONAL:-0}"

note "Installing Homebrew software."

if [ -f "/usr/local/bin/2to3" ]; then
    rm "/usr/local/bin/2to3"
fi

brew update

if [ ! -f "$(which git)" ]; then
    brew install git
else
    brew upgrade git
fi

if [ ! -f "$(which ruby)" ]; then
    brew install ruby
else
    brew upgrade ruby
fi

brew install \
    colordiff \
    croc \
    curl \
    exa \
    ffmpeg \
    jq \
    make \
    node \
    python \
    shellcheck \
    tmux \
    vim \
    zsh

brew install --cask \
    docker \
    iterm2 \
    spotify \
    vlc

if [ "${DOTFILES_WORK}" -eq 1 ]; then

    note "Installing optional Homebrew software for work."

    brew install \
        kubernetes-cli

    brew install --cask \
        keycastr \
        microsoft-teams

else

    warn "Skipping optional Homebrew software for work."

fi

if [ "${DOTFILES_PERSONAL}" -eq 1 ]; then

    note "Installing optional Homebrew software for personal use."

    brew install --cask \
        brave-browser \
        lulu \
        private-internet-access \
        transmission

else

    warn "Skipping optional Homebrew software for personal use."

fi
