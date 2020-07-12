#!/bin/bash

echo "🧛 Installing Dracula themes"

# gnome-terminal
if [ `uname` = "Linux" ]; then
    TERMINAL_THEME=$HOME/gnome-terminal
    git clone https://github.com/dracula/gnome-terminal $TERMINAL_THEME
    (cd $TERMINAL_THEME && ./install.sh)
fi

# iTerm2
if [ `uname` = "Darwin" ]; then
    git clone https://github.com/dracula/iterm.git
fi

# Zsh
echo "Adding to Zsh"
ZSH_THEME=$HOME/.oh-my-zsh/custom/themes/dracula
git clone https://github.com/dracula/zsh.git $ZSH_THEME
ln -s $ZSH_THEME/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme

echo "✔️  Done installing Dracula themes"
