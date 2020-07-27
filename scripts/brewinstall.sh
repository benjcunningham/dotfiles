#!/bin/bash

echo "Installing macOS libraries with Homebrew"

if which brew &> /dev/null; then

    if echo | ruby -e \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
        > /dev/null; then
        echo "[ERROR] Failed to install Homebrew"
        exit 1
    else
        echo "[OK] Installed Homebrew"
    fi

else

    echo "[OK] Homebrew already installed"

fi

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

    echo "[INFO] Already installed: ${already_installed[*]}"
    echo "Installing: ${not_installed[*]}"

    # shellcheck disable=SC2068
    brew install ${not_installed[@]}

}

install \
    curl \
    git \
    make \
    shellcheck \
    tmux

echo "[DONE] Done with Homebrew installations"
