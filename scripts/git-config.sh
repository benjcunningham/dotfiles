#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

if [ "${DEBIAN_FRONTEND}" != "noninteractive" ]; then

    note "Enter your Git credentials to populate ~/.gitconfig.local"

    echo -n 'user.name: '
    read -r user_name
    git config --file ~/.gitconfig.local user.name "${user_name}"

    echo -n 'user.email: '
    read -r user_email
    git config --file ~/.gitconfig.local user.email "${user_email}"

fi
