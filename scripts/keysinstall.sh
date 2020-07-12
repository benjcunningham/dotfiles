#!/bin/bash

echo "🔑 Adding GPG keys for third-party APT sources"

sudo apt-get update
sudo apt-get install -y curl

# Brave Browser
echo "Installing brave-browser keys"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | \
    sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | \
    sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# MKVToolnix
echo "Installing mkvtoolnix keys"
curl -s https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | \
    sudo apt-key add -

echo "deb https://mkvtoolnix.download/ubuntu/xenial/ ./" | \
    sudo tee /etc/apt/sources.list.d/bunkus.org.list

echo "✔️ Done with GPG keys"
