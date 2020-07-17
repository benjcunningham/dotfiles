#!/bin/sh

echo "😮 Installing Oh My Zsh"

INSTALL_URL="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
sh -c "$(curl -fsSL ${INSTALL_URL})" "" --unattended

echo "✔️  Done installing Oh My Zsh"
