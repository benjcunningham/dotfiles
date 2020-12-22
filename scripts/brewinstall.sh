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

function install {

    not_installed=()

    for prog in "$@"; do
        not_installed+=("${prog}")
    done

    echo "Installing: ${not_installed[*]}"

    # shellcheck disable=SC2068
    brew install ${not_installed[@]}

}

install \
    curl \
    git \
    jq \
    make \
    node \
    python \
    ruby \
    shellcheck \
    tmux \
    vim

brew install --cask \
    docker \
    iterm2 \
    spotify \
    vlc

brew install --cask \
    brave-browser \
    lulu \
    private-internet-access \
    transmission

echo "[DONE] Done with Homebrew installations"
