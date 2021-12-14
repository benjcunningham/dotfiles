#!/bin/bash

set -eo pipefail

cd "${HOME}/dotfiles"
source "install/utils.sh"

note "Linking dotfiles with Dotbot"

DOTBOT_CONFIG="${DOTBOT_CONFIG:-dotbot.conf.yaml}"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${DOTBOT_CONFIG}" "${@}"

echo "Completed linking dotfiles"
