#!/bin/bash

# download deb file
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 

# install chrome from deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb

# remove deb file
rm google-chrome-stable_current_amd64.deb
