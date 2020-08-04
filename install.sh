#!/bin/bash

if [ "$(uname)" = "Darwin" ]; then

    # macOS libraries
    scripts/brewinstall.sh

elif [ "$(uname)" = "Linux" ]; then

    # Ubuntu libraries
    scripts/keysinstall.sh
    scripts/aptinstall.sh

    # Fonts
    scripts/fontinstall.sh

    # Scripted settings
    scripts/conf/power-manager.sh

fi

# Apps
scripts/apps/docker.sh
scripts/apps/miniconda.sh
scripts/apps/ohmyzsh.sh
scripts/apps/vundle.sh

# Dotfiles
scripts/dotbotinstall.sh

# Themes
scripts/apps/dracula.sh

echo "[DONE] Installed benjcunningham/dotfiles!"
