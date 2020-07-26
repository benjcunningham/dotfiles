#!/bin/bash

echo "🍻 Installing macOS libraries with Homebrew"

if which brew &> /dev/null; then

    if echo | ruby -e \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
        > /dev/null; then
        echo "❌ Failed to install Homebrew"
        exit 1
    fi

else

    echo "Homebrew already installed"

fi

function install {

    already_installed=()
    not_installed=()

    for prog in "$@"; do

        if which "$prog" &> /dev/null; then
            not_installed+=(${prog})
        else
            already_installed+=(${prog})
        fi

    done

    echo "Already installed: ${already_installed[*]}"
    echo "Installing: ${not_installed[*]}"

}

install \
    curl \
    git \
    make \
    tmux

echo "✔️  Done with Homebrew installations"
