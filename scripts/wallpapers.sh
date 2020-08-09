#!/bin/bash

echo "Downloading wallpapers"

URL="https://zip.imgur.com/0e1d1705d9c998e062d975fa5c0f336be0ef0924d35ff8e85c2da38031c5f265"
DIR="$HOME/wallpapers"

if [ ! -d "$DIR" ]; then
    mkdir "$DIR"
    echo "[OK] Created \$HOME/wallpapers"
else
    echo "[OK] Found \$HOME/wallpapers"
fi

curl -s -o "$DIR/archive.zip" "$URL"
echo "[OK] Downloaded archive"

unzip -oq "$DIR/archive.zip" -d "$DIR"
echo "[OK] Extracted wallpapers from archive"

rm "$DIR/archive.zip"
echo "[OK] Removed archive"

echo "[DONE] Wallpapers downloaded"
