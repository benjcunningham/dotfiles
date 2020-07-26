#!/bin/bash

echo "Installing Dracula themes"

# gnome-terminal
if [ "$(uname)" = "Linux" ]; then
    echo "Adding to GNOME Terminal"
    TERMINAL_THEME=$HOME/gnome-terminal
    git clone https://github.com/dracula/gnome-terminal "$TERMINAL_THEME"
    (cd "$TERMINAL_THEME" && ./install.sh)
fi

# iTerm2
if [ "$(uname)" = "Darwin" ]; then
    echo "Adding to iTerm2"
    git clone https://github.com/dracula/iterm.git
fi

# Zsh
echo "Adding to Zsh"
ZSH_THEME="$HOME/.oh-my-zsh/custom/themes/dracula"
git clone https://github.com/dracula/zsh.git "$ZSH_THEME"
mkdir -p "$HOME/.oh-my-zsh/themes"
ln -s "$ZSH_THEME/dracula.zsh-theme" "$HOME/.oh-my-zsh/themes/dracula.zsh-theme"

echo "[DONE] Done installing Dracula themes"
