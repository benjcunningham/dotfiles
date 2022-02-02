#!/bin/bash

# Ubuntu 20.04
#
# NOTE: This script should not be invoked directly, but rather through the main
# installer.

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Running Ubuntu 20.04 minimal installation"

export DOTFILES_TARGET="ubuntu-20.04/minimal"
export DOTFILES_PERSONAL="${DOTFILES_PERSONAL:-0}"
export DOTFILES_WORK="${DOTFILES_WORK:-0}"

note "Installing software for minimal"

sudo apt-get update
sudo apt-get install -y $(cat "pkglist/ubuntu-20.04")

install/software/ohmyzsh.sh
install/software/dotbot.sh dotbotconf/minimal.conf.yaml
install/software/tpm.sh
install/software/vundle.sh
install/software/dracula.sh

note "Completed Ubuntu 20.04 minimal installation"
