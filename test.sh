#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

ERRORS=()
FILE_LIST=$(find . -type f \
    -not -iwholename "*.git*" \
    -not -iwholename "./dotbot/*" \
    | sort -u)

note "Checking the following files with Shellcheck:"

for f in ${FILE_LIST}; do

	if file "${f}" | grep --quiet shell; then
		{
			shellcheck -x "${f}" && echo "${f}"
		} || {
			ERRORS+=("${f}")
		}
	fi

done

if [ ${#ERRORS[@]} -eq 0 ]; then
    note "Shellcheck finished successfully"
else
    warn "These files failed Shellcheck:"
    echo "${ERRORS[*]}"
	exit 1
fi
