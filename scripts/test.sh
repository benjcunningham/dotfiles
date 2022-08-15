#!/bin/bash

set -eo pipefail

echo "==> Checking the following files with ShellCheck:"

mapfile -t paths < <(find "scripts" -name "*.sh")
paths+=("install.sh")

issues=0

for path in "${paths[@]}"; do

    error=$(shellcheck -x "${path}" || true)

    if [ -z "${error}" ]; then
        echo "OK   ${path}"
    else
        echo "FAIL ${path}"
        echo "${error}"
        issues=$((issues + 1))
    fi

done

echo "ShellCheck: Checked ${#paths[@]}, Issues: ${issues}"

if [ "$issues" -gt "0" ]; then
    exit 1
fi
