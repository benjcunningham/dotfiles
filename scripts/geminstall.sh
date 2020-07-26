#!/bin/bash

# shellcheck disable=SC2032
function install {

    echo "Installing: ${1}..."

    # shellcheck disable=SC2033
    sudo gem install "${1}" --no-rdoc --no-ri

}

install jekyll
install github-pages
