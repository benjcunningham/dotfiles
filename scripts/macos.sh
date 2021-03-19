#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

DOTFILES_WORK="${DOTFILES_WORK:-0}"
DOTFILES_PERSONAL="${DOTFILES_PERSONAL:-0}"

note "Installing Homebrew software."

echo "Doing 2to3"
if [ -f "/usr/local/bin/2to3" ]; then
    rm "/usr/local/bin/2to3"
fi

echo "Updating"
brew update

echo "Upgrading"
brew upgrade

echo "Checking Git version"
if [ ! -f "$(command -v git)" ]; then
    echo "Installing Git from Brew"
    brew install git
else
    echo "Upgrading Git from Brew"
    brew upgrade git
fi

echo "Finished Git, doing Brew for Ruby"
if [ ! -f "$(command -v ruby)" ]; then
    echo "Brew installing Ruby"
    brew install ruby
else
    echo "Brew upgrading Ruby"
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
