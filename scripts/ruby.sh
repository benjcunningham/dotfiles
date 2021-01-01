#!/bin/bash

set -eo pipefail

source "scripts/util.sh"

note "Installing Ruby gems."

sudo gem install \
    github-pages \
    jekyll
