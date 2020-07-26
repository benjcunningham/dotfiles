#!/bin/bash

set -e
set -o pipefail

ERRORS=()

for f in $(find . -type f \
	-not -iwholename "*.git*" \
	-not -iwholename "./dotbot/*" \
	-not -iwholename "*.xinitrc*" \
	| sort -u); do


	if file "$f" | grep --quiet shell; then
		{
			shellcheck "$f" && echo "[OK]: sucessfully linted $f"
		} || {
			ERRORS+=("$f")
		}
	fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "[DONE] Shellcheck finished successfully"
else
	echo "[ERROR] These files failed Shellcheck: ${ERRORS[*]}"
	exit 1
fi
