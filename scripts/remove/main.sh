#!/bin/bash
# shellcheck enable=all

# Uninstall redundant packages listed in packages.txt,
# ignoring empty lines and comments starting with '#'.
while read -r package; do
  if [[ "${package}" != "" ]] && [[ "${package:0:1}" != "#" ]]; then
    sudo apt purge --autoremove "${package}"
  fi
done < packages.txt
