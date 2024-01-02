#!/bin/bash

# install neovim
sudo apt update && sudo apt install -y neovim

# install node.js for coc.nvim
sudo curl -sL install-node.vercel.app/lts | sudo bash
