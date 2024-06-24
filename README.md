# dotfiles
My dotfiles and some setup scripts for my environment.
## About
Here are some details about my environment:
|  |  |
|--|--|
| OS | [Ubuntu](https://ubuntu.com/) 22.04.4 |
| Shell | /bin/bash |
| Editor | [Neovim](https://neovim.io/) 0.9.4 |
## Getting Started
To clone this repository:
```sh
git clone https://github.com/g-ohara/dotfiles.git
```
Then create links in your home directory to dotfiles in this repository:
```sh
cd dotfiles && ./install_links.sh
```
> [!WARNING]  
> Before installing links, you should back up the original dotfiles in your home directory.
## Scripts for setup
Some shell scripts for setup are in `scripts/apps` and `scripts/system` directories. They install some applications or set up environment.
> [!WARNING]  
> Running these scripts is not recommended because they are customized for personal use. If you absolutely must run these scripts, please read them carefully.
## Details
### Dotfiles
|File Path (`~/***`)|Details|
|---|---|
|`.aliases`|CLI command aliases.|
|`.bash_profile`|Loaded once at login.|
|`.bashrc`|Loaded when shell starts or `.bash_profile` is loaded.|
|`.colorrc`|Color configs for `dircolors`.|
#### Configs for Neovim
|File Path (`~/.config/nvim/***`)|Details|
|---|---|
|`init.lua`|Loads some files in `~/.config/nvim/lua/`|
|`lua/*.lua`|Config files for Neovim, which is loaded by `init.lua`.|
|`after/syntax/*.vim`|Syntax files for built-in semantic highlight.|
