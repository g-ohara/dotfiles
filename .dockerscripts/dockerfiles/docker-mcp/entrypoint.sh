#!/bin/sh
# shellcheck enable=all

rm -f /var/run/docker.pid

dockerd >/var/log/dockerd.log 2>&1 &

READY=0
for _ in $(seq 1 30); do
  if docker info >/dev/null 2>&1; then
    READY=1
    break
  fi
  sleep 1
done

if [ "${READY}" -ne 1 ]; then
  echo "Error: dockerd did not become ready in time" >&2
  cat /var/log/dockerd.log >&2
  exit 1
fi

exec python3 /app/server.py
