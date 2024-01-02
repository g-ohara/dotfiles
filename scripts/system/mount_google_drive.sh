#!/bin/bash

sudo add-apt-repository ppa:alessandro-strada/ppa
sudo apt update && sudo apt install -y google-drive-ocamlfuse
google-drive-ocamlfuse
mkdir ~/GoogleDrive
google-drive-ocamlfuse ~/GoogleDrive

