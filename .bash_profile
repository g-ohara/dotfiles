# execute .bashrc if it exists and can be read
if test -r ~/.bashrc; then
    . ~/.bashrc
fi

# hide mouse cursor
if command -v unclutter; then
    unclutter -idle 3 &
fi

# Use NeoVim in gh command such as 'gh issue create'
export VIM_EDITOR=nvim

# Disable dash-to-dock
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
