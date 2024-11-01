# dotfiles

Dotfiles and some setup scripts for [g-ohara](https://github.com/g-ohara)'s personal environment.

## About

Here are some details about my environment:

|  |  |
|--|--|
| OS | [Ubuntu](https://ubuntu.com/) 22.04.4 |
| Shell | /bin/bash |
| Editor | [Neovim](https://neovim.io/) 0.9.4 |

## Getting Started

1. Clone this repository:
   ```sh
   git clone https://github.com/g-ohara/dotfiles.git
   ```
1. Create links in your home directory to dotfiles in this repository:
   ```sh
   cd dotfiles && ./install_links.sh
   ```
> [!WARNING]
> Before installing links, you should back up the original dotfiles in your home directory.

## Files and Directories

### `.aliases`

CLI command aliases.

### `.bash_profile`

Loaded once at login.

### `.bashrc`

Loaded when shell starts or `.bash_profile` is loaded.

### `.colorrc`

Color configs for `dircolors`.

### `.editorconfig`

Formatter configs for [shfmt](https://github.com/mvdan/sh#shfmt).

### `scripts/`

Shell scripts for system setup. ([README](./scripts/README.md))
