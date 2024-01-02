#!/bin/bash


# install ibus-skk
sudo apt update && sudo apt install -y ibus-skk skkdic

# set keyboard layout to English
sudo sed -i 's/<layout>jp<\/layout>/<layout>en<\/layout>/' \
    /usr/share/ibus/component/skk.xml

echo 'Reboot (perhaps twice) to apply the changes'

# setup SandS (Shift and Space)
# sudo apt install -y xcape
# xmodmap -e 'keycode 255=space'
# xmodmap -e 'keycode 65=Shift_L'
# xcape -e '#65=space'
