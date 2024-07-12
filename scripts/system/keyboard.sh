#!/bin/bash
# shellcheck enable=all

# install ibus-skk
sudo apt update && sudo apt install -y ibus-skk skkdic

# set keyboard layout to English
sudo sed -i 's/<layout>jp<\/layout>/<layout>en<\/layout>/' \
  /usr/share/ibus/component/skk.xml

echo 'Reboot (perhaps twice) to apply the changes'
