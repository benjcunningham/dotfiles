#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing dconf settings."

cd dconf
dconf load "/org/gnome/terminal/" < "gnome-terminal"
