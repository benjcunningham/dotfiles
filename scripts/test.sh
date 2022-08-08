#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

mapfile -t paths < <(find "scripts" -name "*.sh")
issues=0

note "Checking the following files with Shellcheck:"

for path in "${paths[@]}"; do

    error=$(shellcheck -x "${path}" || true)

    if [ -z "${error}" ]; then
        echo "${path} ${tty_green}OK${tty_reset}"
    else
        echo "${path} ${tty_red}FAIL${tty_reset}"
        echo "${error}"
        issues=$((issues + 1))
    fi

done

echo "shellcheck: Checked ${#paths[@]}, Issues: ${issues}"

if [ "$issues" -gt "0" ]; then
    exit 1
fi
