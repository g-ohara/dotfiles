# GPG-Agent

## Transfer Secret Keys

### Source

#### Export Primary Key (with all subkeys)

1. List your keys and get ID of the primary key you want to export:
   
   ```sh
   gpg --list-secret-keys
   ```
 
1. Export it as an ASCII file:

   ```sh
   gpg --armor --export-secret-keys {primary key ID} > private.key
   ```
   
> [!NOTE]
> In the example below, ID of the primary key is `ABCDEF..789ABC`. 
> ```
> $ gpg --list-secret-keys
> /home/user/.gnupg/pubring.kbx
> ------------------------------
> sec   ed25519 yyyy-mm-dd [SC] [expires: yyyy-mm-dd]
>       ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ABC
> uid                 [ultimate] Your Name <your-adress@email.com>
> ssb   cv25519 yyyy-mm-dd [E] [expires: yyyy-mm-dd]
> ssb   ed25519 yyyy-mm-dd [A] [expires: yyyy-mm-dd]
> ```

#### Export Only Subkey

1. List your keys and get ID of the subkey you want to export:
   
   ```sh
   gpg --list-secret-keys --with-subkey-fingerprints
   ```
   
1. Export it as an ASCII file:

   ```sh
   gpg --armor --export-secret-subkeys {key ID} > private.key
   ```

### Destination

1. Transfer the ASCII file to your destination in secure way.

1. Import it as a secret key:
   ```
   gpg --import private.key
   ```

## Trouble Shooting

* Command `ssh-add <key-file>` fails. -> Restart `ssh-agent`:
  ```
  systemctl --user restart ssh-agent
  ```

* When you get `Could not add identity xxx: agent refused operation`, run:
  ```
  eval `ssh-agent`
  ```
