#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

paths=($(find "scripts" -name "*.sh"))
issues=0

note "Checking the following files with Shellcheck:"

for i in "${!paths[@]}"; do

    iter="$((i + 1))/${#paths[@]}"
    path="${paths[$i]}"

    error=$(shellcheck -x "${path}" || true)

    if [ -z "${error}" ]; then
        printf "${path} ${tty_green}OK${tty_reset}\n"
    else
        printf "${path} ${tty_red}FAIL${tty_reset}\n"
        printf "${error}\n"
    fi

done

echo "shellcheck: Checked ${#paths[@]}, Issues: ${issues}"

if [ "$issues" -gt "0" ]; then
    exit 1
fi
