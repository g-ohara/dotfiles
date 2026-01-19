#!/bin/sh
# shellcheck enable=all

# Merge user Xresources if the file exists
userresources="${HOME}/.config/X11/Xresources"
xrdb="xrdb"
if [ -f "${userresources}" ]; then
  if [ -x /usr/bin/cpp ]; then
    "${xrdb}" -merge "${userresources}"
  else
    "${xrdb}" -nocpp -merge "${userresources}"
  fi
fi

# Enable Japanese input method
export GTK_IM_MODULE=xim
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
fcitx5 &

# Start xmonad window manager
exec xmonad
