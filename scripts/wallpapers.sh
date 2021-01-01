#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing wallpapers."

WALLPAPERS_DIR="${HOME}/wallpapers"
WALLPAPERS_URL="https://imgur.com/a/i9tDIy3/zip"

if [ ! -d "${WALLPAPERS_DIR}" ]; then
    mkdir "${WALLPAPERS_DIR}"
fi

curl -svL -o "${WALLPAPERS_DIR}/archive.zip" "${WALLPAPERS_URL}"
unzip -oq "${WALLPAPERS_DIR}/archive.zip" -d "${WALLPAPERS_DIR}"
rm "${WALLPAPERS_DIR}/archive.zip"
