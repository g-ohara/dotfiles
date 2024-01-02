#!/bin/bash

sudo apt update

# install TexLive
sudo apt install -y texlive-full

# install xdg-util & evince to view PDF file on vimtex
sudo apt install -y xdg-utils evince
