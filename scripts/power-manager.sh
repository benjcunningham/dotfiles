#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Applying xfce4-power-manager settings."

customize() {
    xfconf-query -c xfce4-power-manager -p "/xfce4-power-manager/$1" -s "$2"
    echo "- $1: $(xfconf-query -c xfce4-power-manager -p "/xfce4-power-manager/$1")"
}

if [ -n "${DISPLAY}" ]; then

    customize brightness-switch-restore-on-exit 1
    customize brightness-switch 0
    customize show-tray-icon false
    customize general-notification false
    customize inactivity-on-battery 16
    customize inactivity-on-ac 16
    customize critical-power-action 1
    customize critical-power-level 10
    customize presentation-mode false
    customize lid-action-on-battery 1
    customize logind-handle-lid-switch true
    customize brightness-level-on-ac 20
    customize brightness-on-battery 120
    customize blank-on-ac 0
    customize dpms-on-ac-sleep 0
    customize dpms-on-ac-off 0
    customize dpms-on-battery-off 0
    customize dpms-on-battery-sleep 30

else

    warn "Skipping applying settings because \$DISPLAY isn't set."
    echo "Maybe this is CI or you are on a headless server?"

fi
