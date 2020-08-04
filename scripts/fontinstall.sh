#!/bin/bash

echo "Installing Fonts"

cd /tmp || exit 1

FONTS="$HOME/.fonts"
if [ ! -d "$FONTS" ]; then
    mkdir -p "$FONTS"
fi

FILE="$FONTS/NotoColorEmoji.ttf"
if [ ! -f "$FILE" ]; then
    URL="https://noto-website-2.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip"
    curl -OL ${URL}
    unzip NotoColorEmoji-unhinted.zip
    mv NotoColorEmoji.ttf "$FONTS"
    echo "[OK] NotoColorEmoji installed"
else
    echo "[OK] NotoColorEmoji already installed"
fi

sudo fc-cache -fv

echo "[DONE] Done installing fonts"
