#!/bin/bash -e

IGNORE_PATTERN=".git"

echo "Create dotfile links."

# For dotfiles
for dotfile in .??*; do
  [[ $dotfile == "$IGNORE_PATTERN" ]] && continue
  ln -snfv "$(pwd)/$dotfile" "$HOME/$dotfile"
done

# For normal files
TARGET_PATTERNS=("compose.yaml")
for file in "${TARGET_PATTERNS[@]}"; do ln -snfv "$(pwd)/$file" "$HOME/$file"; done

echo "Success"
