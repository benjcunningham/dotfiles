#!/bin/bash

function install {

    echo "Installing: ${1}..."
    sudo gem install ${1} --no-rdoc --no-ri

}

install jekyll
install github-pages
