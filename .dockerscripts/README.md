# .dockerscripts

I **hate** polluting my local environment by installing lots of applications.
But I am Neovimmer and desire to create my best development environment using 
language servers.

The simplest solution would be to create a single container and install Neovim
and all language servers in it.
But the container would be very heavy and obviously not portable.
My current best practice is to create Docker containers for Neovim and each
language server.
The Neovim container accesses the host's Docker daemon and runs the language
server containers required to build a development environment for a given file.

## Getting Started

### Install Rootless Docker [^1]

1. Install binary files into `~/.local/bin`:
   ```sh
   curl -fsSL https://get.docker.com/rootless | DOCKER_BIN=~/.local/bin sh
   ```
1. Restart Docker service:
   ```sh
   systemctl --user restart docker
   ```

### Install Docker Compose [^2]

1. Confirm the latest version of Docker Compose at [Releases · docker/compose](https://github.com/docker/compose/releases).

1. Confirm the architecture of your system:
   ```sh
   uname -m
   ```

1. To download and install the Docker Compose CLI plugin, run:
   ```sh
   DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
   mkdir -p $DOCKER_CONFIG/cli-plugins
   curl -SL https://github.com/docker/compose/releases/download/{latest-version}/docker-compose-linux-{architecture} -o $DOCKER_CONFIG/cli-plugins/docker-compose
   ```
1. Apply executable permissions to the binary:
   ```sh
   chmod +x ~/.docker/cli-plugins/docker-compose
   ```
1. Test the installation:
   ```sh
   docker compose version
   ```

[^1]: [Rootless mode | Docker Docs](https://docs.docker.com/engine/security/rootless/)
[^2]: [Plugin | Docker Docs](https://docs.docker.com/compose/install/linux/#install-the-plugin-manually)

