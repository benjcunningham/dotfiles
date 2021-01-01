#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing wallpapers."

WALLPAPERS_DIR="${HOME}/wallpapers"
WALLPAPERS_URL="https://zip.imgur.com/0e1d1705d9c998e062d975fa5c0f336be0ef0924d35ff8e85c2da38031c5f265"

if [ ! -d "${WALLPAPERS_DIR}" ]; then
    mkdir "${WALLPAPERS_DIR}"
fi

curl -s -o "${WALLPAPERS_DIR}/archive.zip" "${WALLPAPERS_URL}"
unzip -oq "${WALLPAPERS_DIR}/archive.zip" -d "${WALLPAPERS_DIR}"
rm "${WALLPAPERS_DIR}/archive.zip"
