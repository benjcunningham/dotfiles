#!/bin/bash

echo "Installing TPM"

DIR="$HOME/.tmux/plugins/tpm"

if [ ! -d "$DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$DIR"
    echo "[OK] Downloaded and installed TPM"
else
    echo "[OK] TPM already installed"
fi

tmux source ~/.tmux.conf
echo "[OK] Reloaded Tmux with TPM"

echo "[DONE] Done installing TPM"
