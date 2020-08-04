#!/bin/bash

echo "Installing Vundle"

DIR="$HOME/.vim/bundle/Vundle.vim"

if [ ! -d "$DIR" ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$DIR"
    echo "[OK] Downloaded and installed Vundle"
else
    echo "[OK] Vundle already installed"
fi

vim +'PluginInstall' +qa
echo "[OK] Updated Vundle plugins"

echo "[DONE] Done installing Vundle"