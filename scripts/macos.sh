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
brew upgrade

brew bundle -f homebrew/Brewfile

if [ "${DOTFILES_WORK}" -eq 1 ]; then

    note "Installing optional Homebrew software for work."

    brew bundle -f homebrew/Brewfile.work

else

    warn "Skipping optional Homebrew software for work."

fi

if [ "${DOTFILES_PERSONAL}" -eq 1 ]; then

    note "Installing optional Homebrew software for personal use."

    brew bundle -f homebrew/Brewfile.personal

else

    warn "Skipping optional Homebrew software for personal use."

fi
