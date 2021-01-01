#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

IS_WORK="${DOTFILES_WORK_INSTALL:-0}"
IS_PERSONAL="${DOTFILES_PERSONAL_INSTALL:-1}"

note "Installing Homebrew software."

brew update

if [ ! -f "$(which ruby)" ]; then
    brew upgrade ruby
else
    brew install ruby
fi

brew install \
    colordiff \
    croc \
    curl \
    ffmpeg \
    git \
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

if [ "${IS_WORK}" -eq 1 ]; then

    note "Installing optional Homebrew software for work."

    brew install \
        kubernetes-cli

    brew install --cask \
        keycastr \
        microsoft-teams

else

    warn "Skipping optional Homebrew software for work."

fi

if [ "${IS_PERSONAL}" -eq 1 ]; then

    note "Installing optional Homebrew software for personal use."

    brew install --cask \
        brave-browser \
        lulu \
        private-internet-access \
        transmission

else

    warn "Skipping optional Homebrew software for personal use."

fi
