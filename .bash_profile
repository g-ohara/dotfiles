# execute .bashrc if it exists and can be read
if test -r ~/.bashrc; then
  . "$HOME"/.bashrc
fi

# hide mouse cursor
if command -v unclutter &>/dev/null; then
  unclutter -idle 3 &
else
  echo "unclutter command not found"
fi

# Disable dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false

# Remove home folder icon from desktop
gsettings set org.gnome.shell.extensions.ding show-home false
