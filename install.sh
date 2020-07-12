#!/bin/bash

if [ `uname` = "Darwin" ]; then
    scripts/brewinstall.sh
elif [ `uname` = "Linux" ]; then
    scripts/keysinstall.sh
    scripts/aptinstall.sh
fi

scripts/apps/miniconda.sh
scripts/apps/docker.sh

scripts/dotbotinstall.sh

echo "🌱 Done! This is a new beginning..."
