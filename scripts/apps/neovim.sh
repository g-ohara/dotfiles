#!/bin/bash

# Uninstall Neovim installed via apt and install it via snap
sudo apt purge --autoremove -y neovim && sudo snap install nvim --classic

# Install external tools for Neovim
sudo apt update && sudo apt install -y ripgrep xclip
