#!/bin/bash
# shellcheck enable=all

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
if [[ -x /usr/bin/lesspipe ]]; then SHELL=/bin/sh lesspipe &> /dev/null; fi

# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z ${debian_chroot:-} ]] && [[ -r /etc/debian_chroot ]]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "${TERM}" in
  xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h: \w\a\]${PS1}"
    ;;
  *) ;;
esac

# -----------------------------------------------------------------------------

# Set prompt color
export PS1="\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;33m\]\w\[\e[0m\]\$ "

# Export an environment variable 'SHELL' to run dircolors without errors
if [[ -n ${SHELL} ]]; then
  export SHELL
fi

# Import .colorrc to set color of strings when ls command executed
if [[ -x /usr/bin/dircolors ]] && [[ -r ~/.colorrc ]]; then
  colors="$(dircolors ~/.colorrc)"
  eval "${colors}"
fi

# Set background color of terminal (set RGB following '#' in hexadecimal form)
echo -e "\033]11;#000000\a"

# -----------------------------------------------------------------------------

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [[ -f ~/.aliases ]]; then
  . "${HOME}"/.aliases
fi

if ! [[ -f ~/.git-completion.bash ]]; then
  echo "Downloading git-completion.bash..."
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi

if [[ -f ~/.git-completion.bash ]]; then
  . "${HOME}"/.git-completion.bash
else
  echo "ERROR: git-completion.bash not found"
fi

# Create an empty .gitconfig file if it does not exist, such that `git config`
# commands do not write configurations to .config/git/config by default.
if ! [[ -f ~/.gitconfig ]]; then
  echo "Creating empty .gitconfig..."
  touch ~/.gitconfig
fi

export PATH=${PATH}:${HOME}/.local/bin:${HOME}/.local/bin/nvim:${HOME}/bin

# Set neovim as default editor for
# - git
# - pass
# and other commands.
if hash nvim &> /dev/null; then
  export EDITOR=nvim
  export VISUAL=nvim
elif hash vim &> /dev/null; then
  export EDITOR=vim
  export VISUAL=vim
elif hash vi &> /dev/null; then
  export EDITOR=vi
  export VISUAL=vi
else
  echo "ERROR: vi not found"
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# -----------------------------------------------------------------------------

# Define and export environment variables for Docker Compose to recognize the
# current user and group.
# NOTE: It seems that $UID is already defined but not exported by default.
GID=$(id -g)
export UID GID
export DOCKER_CONTEXT=rootless

# Use GPG Agent as SSH Agent.
# When an SSH client (ex. `ssh`, `scp`) needs to anthenticate to a remote
# server, it looks for the SSH_AUTH_SOCK environment variable to find the path
# to communicate with the SSH agent. Here we set the SSH_AUTH_SOCK to the
# socket file created by GPG Agent.
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export SSH_AUTH_SOCK
