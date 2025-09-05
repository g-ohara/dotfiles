#!/bin/bash
# shellcheck enable=all

# execute .bashrc if it exists and can be read
if test -r ~/.bashrc; then
  . "${HOME}"/.bashrc
fi

# hide mouse cursor
if command -v unclutter &> /dev/null; then
  unclutter -idle 3 &
fi

# OS-specific settings
if [[ -f /etc/os-release ]]; then
  # Load OS information
  . /etc/os-release
  if [[ ${NAME} == "Ubuntu" ]]; then
    # Disable dash-to-dock
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
    gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
    # Remove trash icon from dash-to-dock
    gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
    # Remove home folder icon from desktop
    gsettings set org.gnome.shell.extensions.ding show-home false
    gsettings set org.gnome.shell.extensions.ding show-trash false
    # Remove icons in home directory from desktop
    gnome-extensions disable ding@rastersoft.com
  fi
fi
