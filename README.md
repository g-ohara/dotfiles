# dotfiles
This repository contains dotfiles and some installation scripts for my environment (Ubuntu 22.04).

## Installation
To clone this repository:
```
$ git clone https://github.com/g-ohara/dotfiles.git
```
Then create links in your home directory to dotfiles in this repository:
```
$ cd dotfiles
$ ./install_links.sh
```
> [!WARNING]  
> Before installing links, you should back up the original dotfiles in your device.

## Scripts for setup
Some shell scripts for setup are in `scripts/apps` and `scripts/system` directories. They install some applications or set up environment.
> [!WARNING]  
> Running these scripts is not recommended because they are customized for personal use. If you absolutely must run these scripts, please read them carefully.
