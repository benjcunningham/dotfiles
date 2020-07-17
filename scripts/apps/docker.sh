#!/bin/bash

echo "🐳 Installing Docker"

if [ `uname` = "Darwin" ]; then

    # Docker Desktop for macOS
    brew cask install docker

elif [ `uname` = "Linux"]; then

    # Docker CLI on Ubuntu
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io

else

    echo "🙅 No installer available for your system (`uname`)"

fi

echo "✔️  Done installing Docker"
