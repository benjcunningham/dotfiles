#!/bin/bash

echo "🔍 Loading dconf settings"

function install {

    if dconf load "$1" < "$2"; then
        echo "❌ Failed to load ${2} (${1})"
        exit 1
    else
        echo "Installed ${1} (${2})"
    fi

}

cd dconf || exit 1
install "/org/gnome/terminal/" gnome-terminal

echo "✔️ Done with dconf installations"
