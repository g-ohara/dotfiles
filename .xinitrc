#!/bin/sh
# shellcheck enable=all

userresources="${HOME}/.config/X11/Xresources"
xrdb="xrdb"

# Merge user Xresources if the file exists
if [ -f "${userresources}" ]; then
  if [ -x /usr/bin/cpp ]; then
    "${xrdb}" -merge "${userresources}"
  else
    "${xrdb}" -nocpp -merge "${userresources}"
  fi
fi

# Enable Japanese input method
fcitx5 &

# Start xmonad window manager
exec xmonad
