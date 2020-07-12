#!/bin/bash

if [ `uname` = "Darwin" ]; then

    # macOS libraries
    scripts/brewinstall.sh

elif [ `uname` = "Linux" ]; then

    # Ubuntu libraries
    scripts/keysinstall.sh
    scripts/aptinstall.sh

fi

# Apps
scripts/apps/docker.sh
scripts/apps/miniconda.sh
scripts/apps/ohmyzsh.sh

# Dotfiles
scripts/dotbotinstall.sh

echo "🌱 Done! This is a new beginning..."
