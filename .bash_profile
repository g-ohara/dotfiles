#!/bin/bash
# shellcheck enable=all

# execute .bashrc if it exists and can be read
if test -r ~/.bashrc; then
  . "${HOME}"/.bashrc
fi
