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
|`.editorconfig`| Formatter configs for [shfmt](https://github.com/mvdan/sh#shfmt).|

#### Configs for Neovim

|File Path (`~/.config/nvim/***`)|Details|
|---|---|
|`init.lua`|Loads some files in `~/.config/nvim/lua/`|
|`lua/*`|Config files for Neovim, which is loaded by `init.lua`.|
|`after/syntax/*.vim`|Syntax files for built-in semantic highlight.|

### Dockerfiles

Dockerfiles for [my docker images](https://hub.docker.com/u/genjiohara) in `~/.dockerfiles/` directory.

|Image Name|Base Image|Installed Package(s)|Pull Count|
|:--|:--|:--|:-:|
|[genjiohara/bashls](https://hub.docker.com/repository/docker/genjiohara/gnuplot/general)|[ubuntu](https://hub.docker.com/_/ubuntu)|[gnuplot](https://gnuplot.sourceforge.net/)<br>gnuplot-x11|![pull count for gnuplot](https://img.shields.io/docker/pulls/genjiohara/gnuplot.svg)|
|[genjiohara/gnuplot](https://hub.docker.com/repository/docker/genjiohara/gnuplot/general)|[ubuntu](https://hub.docker.com/_/ubuntu)|[gnuplot](https://gnuplot.sourceforge.net/)<br>gnuplot-x11|![pull count for gnuplot](https://img.shields.io/docker/pulls/genjiohara/gnuplot.svg)|
|[genjiohara/graphviz](https://hub.docker.com/repository/docker/genjiohara/graphviz/general)|ubuntu|[graphviz](https://graphviz.org/)|![pull count for graphviz](https://img.shields.io/docker/pulls/genjiohara/graphviz.svg)|
|[genjiohara/haskell-language-server](https://hub.docker.com/repository/docker/genjiohara/haskell-language-server/general)|[haskell](https://hub.docker.com/_/haskell/):9.8.2-buster|[Haskell Language Server](https://github.com/haskell/haskell-language-server)|![pull count for haskell-language-server](https://img.shields.io/docker/pulls/genjiohara/haskell-language-server.svg)|
|[genjiohara/rye](https://hub.docker.com/repository/docker/genjiohara/rye/general)|ubuntu|[rye](https://rye-up.com/)|![pull count for rye](https://img.shields.io/docker/pulls/genjiohara/rye.svg)|
|[genjiohara/rye-cuda](https://hub.docker.com/repository/docker/genjiohara/rye-cuda/general)|[nvidia/cuda](https://hub.docker.com/r/nvidia/cuda/):12.4.1-runtime-ubuntu22.04|rye|![pull count for rye-cuda](https://img.shields.io/docker/pulls/genjiohara/rye-cuda.svg)|
|[genjiohara/texlab](https://hub.docker.com/repository/docker/genjiohara/texlab)|[mfisherman/texlive-full](https://hub.docker.com/r/mfisherman/texlive-full)|[TexLab](https://github.com/latex-lsp/texlab)|![pull count for rye](https://img.shields.io/docker/pulls/genjiohara/texlab.svg)|
