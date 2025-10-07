# g-ohara's Dotfiles

This repository contains the personal dotfiles for [g-ohara](https://github.com/g-ohara). These files are used to configure the shell, editor, and other tools to create a consistent development environment.

## Getting Started

To use these dotfiles, follow these steps:

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/g-ohara/dotfiles.git
    ```

2.  **Install the dotfiles:**
    ```sh
    cd dotfiles && ./install_links.sh
    ```

    > [!WARNING]
    > This script will create symbolic links in your home directory to the files in this repository. It's highly recommended to back up your existing dotfiles before running this script.

## Files and Directories

This repository is organized into the following files and directories:

### Root Directory

-   **.aliases**: Defines command-line aliases to shorten frequently used commands. It is loaded by `.bashrc`.
-   **.bash_profile**: Sets environment variables and performs initial setup when you log in. It loads `.bashrc`, hides the mouse cursor, disables the dash-to-dock extension, and removes icons from the desktop.
-   **.bashrc**: Configures the bash shell for interactive use. It is loaded when a new shell starts or from `.bash_profile`. It sets terminal colors, loads `.aliases`, and exports `UID` and `GID` for Docker Compose.
-   **.colorrc**: Configures colors for the `dircolors` command, which is used to colorize file listings.
-   **.editorconfig**: Contains configuration for [shfmt](https.com/mvdan/sh#shfmt) to ensure consistent shell script formatting. The settings follow the [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html).
-   **install_links.sh**: A script that creates symbolic links from your home directory to the dotfiles in this repository.

### `.config/`

This directory contains various configuration files for applications. For more details, see the [.config/README.md](./.config/README.md) file.

### `scripts/`

This directory contains shell scripts for system setup and other tasks. For more details, see the [scripts/README.md](./scripts/README.md) file.

## License

This project is licensed under the terms of the MIT License. See the [LICENSE](LICENSE) file for details.