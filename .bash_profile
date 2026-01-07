#!/bin/bash
# shellcheck enable=all

# Create an empty .gitconfig file if it does not exist, such that `git config`
# commands do not write configurations to .config/git/config by default.
if ! [[ -f ~/.gitconfig ]]; then
  touch ~/.gitconfig
fi

# Enable git autocompletion
if ! [[ -f ~/.git-completion.bash ]]; then
  echo "Downloading git-completion.bash..."
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
fi
if [[ -f ~/.git-completion.bash ]]; then
  . "${HOME}"/.git-completion.bash
else
  echo "ERROR: git-completion.bash not found"
fi

export PATH=${PATH}:${HOME}/.local/bin:${HOME}/.dockerscripts

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

# Use Fcitx as input method.
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# Use GPG Agent as SSH Agent.
# When an SSH client (ex. `ssh`, `scp`) needs to anthenticate to a remote
# server, it looks for the SSH_AUTH_SOCK environment variable to find the path
# to communicate with the SSH agent. Here we set the SSH_AUTH_SOCK to the
# socket file created by GPG Agent.
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export SSH_AUTH_SOCK

# Execute `~/.bashrc` if it exists and can be read
if test -r ~/.bashrc; then
  . ~/.bashrc
fi
