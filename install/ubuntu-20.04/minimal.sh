#!/bin/bash

# Ubuntu 20.04
#
# NOTE: This script should not be invoked directly, but rather through the main installer.

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Running Ubuntu 20.04 minimal installation"

export DOTFILES_TARGET="ubuntu-20.04/minimal"
DOTFILES_PERSONAL="${DOTFILES_PERSONAL:-0}"
DOTFILES_WORK="${DOTFILES_WORK:-0}"

note "Install software for minimal"
sudo apt-get update
sudo apt-get install -y $(cat "pkglist/ubuntu-20.04")

install/software/dotbot.sh dotbotconf/minimal.conf.yaml
install/software/tpm.sh
install/software/vundle.sh

note "Completed Ubuntu 20.04 minimal installation"
