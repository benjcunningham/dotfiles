#!/bin/bash

# macOS
#
# NOTE: This script should not be invoked directly, but rather through the main installer.

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Running macOS installation"

export DOTFILES_TARGET="macos/full"
DOTFILES_PERSONAL="${DOTFILES_PERSONAL:-0}"
DOTFILES_WORK="${DOTFILES_WORK:-0}"

if [ -f "/usr/local/bin/2to3" ]; then
    rm "/usr/local/bin/2to3"
fi

brew update
brew upgrade
brew bundle --file homebrew/Brewfile

if [ "${DOTFILES_PERSONAL}" -eq 1 ]; then
    note "Installing software for personal"
    brew bundle --file homebrew/Brewfile.personal
else
    warn "Skipping software for personal"
fi

if [ "${DOTFILES_WORK}" -eq 1 ]; then
    note "Installing software for work"
    brew bundle --file homebrew/Brewfile.work
else
    warn "Skipping software for work"
fi

install/software/miniconda.sh
install/software/ohmyzsh.sh
install/software/ruby.sh
install/software/dotbot.sh
install/software/tpm.sh
install/software/vundle.sh
install/software/dracula.sh

note "Completed macOS installation"
