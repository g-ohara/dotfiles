#!/bin/bash

# Install Neovim
sudo apt update && sudo apt install -y neovim

# Install plugins
nvim +PlugInstall +qall

# Install Node.js for GitHub Copilot
./nodejs.sh
