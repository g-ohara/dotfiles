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
