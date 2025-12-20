#!/bin/bash
# shellcheck enable=all

docker --version >/dev/null 2>&1
RETVAL=$?

if [[ "${RETVAL}" -ne 0 ]]; then
  echo "Error: Docker is not installed or not running in rootless mode." >&2
  echo ""
  echo "If you cannot install Rootless Docker, run following command to install ${1} locally:"
  echo ""
  echo "  ${2}"
  echo ""
  exit 1
fi
