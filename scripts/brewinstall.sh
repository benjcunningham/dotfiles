#!/bin/bash

echo "🍻 Installing macOS libraries with Homebrew"

echo | /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
    > /dev/null

if [ $? -ne 0 ]; then
    echo "❌ Failed to install Homebrew"
    exit 1
fi

echo "✔️  Done with Homebrew installations"
