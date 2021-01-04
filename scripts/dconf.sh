#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing dconf settings."

if [ -n "${DISPLAY}" ]; then
    cd dconf
    dconf load "/org/gnome/terminal/" < "gnome-terminal"
else
    warn "\$DISPLAY is not set. Skipping dconf install."
fi
