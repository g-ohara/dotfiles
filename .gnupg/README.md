# GPG-Agent

## Trouble Shooting

* Command `ssh-add <key-file>` fails. -> Restart `ssh-agent`:
  ```
  systemctl --user restart ssh-agent
  ```

* When you get `Could not add identity xxx: agent refused operation`, run:
  ```
  eval `ssh-agent`
  ```
