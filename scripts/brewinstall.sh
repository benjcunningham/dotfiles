#!/bin/bash

echo "🍻 Installing macOS libraries with Homebrew"

which brew &> /dev/null

if [ $? -ne 0 ]; then

    echo | ruby -e \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
        > /dev/null

    if [ $? -ne 0 ]; then
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

        which $prog &> /dev/null

        if [ $? -ne 0 ]; then
            not_installed+=(${prog})
        else
            already_installed+=(${prog})
        fi

    done

    echo "Already installed: ${already_installed[@]}"
    echo "Installing: ${not_installed[@]}"

}

install \
    curl \
    git \
    make \
    tmux

echo "✔️  Done with Homebrew installations"
