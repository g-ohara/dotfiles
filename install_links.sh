#!/bin/bash -e

IGNORE_PATTERN=".git"

echo "Create dotfile links."

for dotfile in .??*; do
  [[ $dotfile == "$IGNORE_PATTERN" ]] && continue
  ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
done

echo "Success"
