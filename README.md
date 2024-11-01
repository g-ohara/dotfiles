# dotfiles

Dotfiles for [g-ohara](https://github.com/g-ohara)'s personal environment.

## Getting Started

1. Clone this repository:
   ```sh
   git clone https://github.com/g-ohara/dotfiles.git
   ```
1. Create links in your home directory to dotfiles in this repository:
   ```sh
   cd dotfiles && ./install_links.sh
   ```
> [!WARNING]
> Before installing links,
  you should back up the original dotfiles in your home directory.

## Files and Directories

### `.aliases`

It sets aliases for CLI commands.

- Loaded by `.bashrc`

### `.bash_profile`

It sets environment variables.

- Loaded once at login
- Load `.bashrc`
- Hide mouse cursor
- Disable dash-to-dock
- Remove icons from desktop

### `.bashrc`

It sets configurations for bash shell.

- Loaded when shell starts or `.bash_profile` is loaded
- Set terminal color
- Load `.aliases`
- Export `UID` and `GID` for Docker Compose

### `.colorrc`

It sets color configurations for `dircolors`.

- Read by `dircolors`

### `.editorconfig`

It sets configurations for [shfmt](https://github.com/mvdan/sh#shfmt).

- Read by `shfmt`
- Configurations follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html).

### `.config/`

It contains some other configuration files. (See [.config/README](./.config))

### `scripts/`

It contains shell scripts for system setup. (See [scripts/README](./scripts))
