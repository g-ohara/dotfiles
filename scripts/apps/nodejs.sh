#!/bin/bash

# Install curl if both curl and wget are not installed
if ! [ -x "$(command -v curl)" ] && ! [ -x "$(command -v wget)" ]; then
  sudo apt update && sudo apt install -y curl
fi

# Install Node.js
sudo apt update && sudo apt install -y nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge -y nodejs npm
sudo apt autoremove -y
