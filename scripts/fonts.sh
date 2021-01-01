#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Ubuntu fonts."

FONTS_DIR="${HOME}/.fonts"

if [ ! -d "${FONTS_DIR}" ]; then
    mkdir -p "${FONTS_DIR}"
fi

cd /tmp

NOTO_URL="https://noto-website-2.storage.googleapis.com/pkgs/NotoColorEmoji-unhinted.zip"
NOTO_FILE="${FONTS_DIR}/NotoColorEmoji.ttf"

if [ ! -d "${NOTO_FILE}" ]; then
    curl -OL "${NOTO_URL}"
    unzip NotoColorEmoji-unhinted.zip
    mv NotoColorEmoji.ttf "${FONTS_DIR}"
else
    warn "Noto Color Emoji font already installed."
fi

sudo fc-cache -fv
