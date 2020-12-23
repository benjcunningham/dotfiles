#!/bin/bash

echo "Installing macOS libraries with Homebrew"

if which brew &> /dev/null; then

    BREW_STATUS="$(echo | bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)")"

    if [ "$BREW_STATUS" -ne 0 ]; then
        echo "[ERROR] Failed to install Homebrew"
        exit 1
    else
        echo "[OK] Installed Homebrew"
    fi

else

    echo "[OK] Homebrew already installed"

fi

# Everywhere
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
    ruby \
    shellcheck \
    tmux \
    vim \
    zsh

brew install --cask \
    docker \
    iterm2 \
    spotify \
    vlc

# Personal
brew install --cask \
    brave-browser \
    lulu \
    private-internet-access \
    transmission

# Work
brew install --cask \
    keycastr \
    microsoft-teams

brew install \
    kubernetes-cli

echo "[DONE] Done with Homebrew installations"
