#!/bin/bash
# shellcheck enable=all

sudo apt update

# install docker CE
sudo apt install -y \
  apt-transport-https ca-certificates curl software-properties-common
publix_key=$(curl -fsSL https://download.docker.com/linux/ubuntu/gpg)
sudo apt-key add - <<< "${publix_key}"
codename=$(lsb_release -cs)
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${codename} stable"
sudo apt update && sudo apt install -y docker-ce
sudo groupadd docker
sudo gpasswd -a "${USER}" docker
sudo systemctl restart docker
