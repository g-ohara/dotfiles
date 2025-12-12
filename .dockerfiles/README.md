# .dockerfiles

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

### Install Rootless Docker

Refer [Docker official document](https://docs.docker.com/engine/security/rootless/).
