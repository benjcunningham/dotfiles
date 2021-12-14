#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Installing Ruby gems"

sudo gem install -N \
    github-pages \
    jekyll

echo "Completed Ruby gems installation"
