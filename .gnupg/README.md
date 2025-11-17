# GPG-Agent

## Trouble Shooting

* Command `ssh-add <key-file>` fails. -> Restart `ssh-agent`:
  ```
  systemctl --user restart ssh-agent
  ```

