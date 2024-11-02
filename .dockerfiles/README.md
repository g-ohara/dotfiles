# .dockerfiles

Dockerfiles for [my docker images](https://hub.docker.com/u/genjiohara).

I **hate** polluting my local environment by installing lots of applications.
But I am Neovimmer and desire to create my best development environment using 
language servers.
My current best practice is to create Docker containers
and install my application inside it.
Neovim runs in my local environment and accesses the language server
in the container via [LSP (Language Server Protocol)](https://langserver.org/).

## Getting Started

### Prerequisites

All you need to install is [Docker](https://www.docker.com/).
Carefully use [`docker.sh`](/scripts/docker.sh).

### Usage

Docker images have been pushed on
[my Docker Hub](https://hub.docker.com/u/genjiohara)
and aliases for CLI commands are in [`.local/bin`](/.local/bin).
So you do not have to build images and can simply run commands
as if they are installed in your local environment.
When you open C/C++ or Python code by Neovim, images are pulled automatically
then you will see some features such as diagnostics and completion.

## Details

|Image Name|Base Image|Installed Package(s)|Pull Count|
|:--|:--|:--|:-:|
|[genjiohara/bashls](https://hub.docker.com/repository/docker/genjiohara/bashls/general)|[node:22.4.1-alpine3.20](https://hub.docker.com/layers/library/node/22.4.1-alpine3.20/images/sha256-c590de4d628763538c9b4dfadc8460e15dd3bdac2c8cd1f3a69dd24f8e7ee551?context=explore)|[ShellCheck](https://github.com/koalaman/shellcheck)<br>[shfmt](https://github.com/mvdan/sh)<br>[Bash Language Server](https://github.com/bash-lsp/bash-language-server)|![pull count for bashls](https://img.shields.io/docker/pulls/genjiohara/bashls.svg)|
|[genjiohara/cabal](https://hub.docker.com/repository/docker/genjiohara/cabal/general)|[haskell:9.8.2-buster](https://hub.docker.com/layers/library/haskell/9.8.2-buster/images/sha256-02070136c1f558441ed8f549eef3f027be6da31890bae8c1f0cfcfe9dbf2a7fb?context=explore)||![pull count for cabal](https://img.shields.io/docker/pulls/genjiohara/cabal.svg)|
|[genjiohara/gnuplot](https://hub.docker.com/repository/docker/genjiohara/gnuplot/general)|[ubuntu](https://hub.docker.com/_/ubuntu)|[gnuplot](https://gnuplot.sourceforge.net/)<br>gnuplot-x11|![pull count for gnuplot](https://img.shields.io/docker/pulls/genjiohara/gnuplot.svg)|
|[genjiohara/graphviz](https://hub.docker.com/repository/docker/genjiohara/graphviz/general)|ubuntu|[graphviz](https://graphviz.org/)|![pull count for graphviz](https://img.shields.io/docker/pulls/genjiohara/graphviz.svg)|
|[genjiohara/haskell-language-server](https://hub.docker.com/repository/docker/genjiohara/haskell-language-server/general)|[genjiohara/cabal:9.8.2-buster](https://hub.docker.com/layers/genjiohara/cabal/9.8.2-buster/images/sha256-2c2236ddd9a196eac7a0a5f2eacc98c3dce2d82872d1fb8aad9531aabc05365d?context=explore)|[Haskell Language Server](https://github.com/haskell/haskell-language-server)|![pull count for haskell-language-server](https://img.shields.io/docker/pulls/genjiohara/haskell-language-server.svg)|
|[genjiohara/node-tsserver](https://hub.docker.com/repository/docker/genjiohara/node-tsserver/general)|[node:22.6.0-slim](https://hub.docker.com/layers/library/node/22.6.0-slim/images/sha256-15d360867366f3229c99bd190fa83dd4fa7ba4e32eb39b4c41e46034f8c25094?context=explore)|[TypeScript Language Server](https://github.com/typescript-language-server/typescript-language-server)|![pull count for node-tsserver](https://img.shields.io/docker/pulls/genjiohara/node-tsserver.svg)|
|[genjiohara/rye](https://hub.docker.com/repository/docker/genjiohara/rye/general)|ubuntu|[rye](https://rye-up.com/)|![pull count for rye](https://img.shields.io/docker/pulls/genjiohara/rye.svg)|
|[genjiohara/rye-cuda](https://hub.docker.com/repository/docker/genjiohara/rye-cuda/general)|[nvidia/cuda:12.4.1-runtime-ubuntu22.04](https://hub.docker.com/layers/nvidia/cuda/12.4.1-runtime-ubuntu22.04/images/sha256-9ff288e475bad991c9b745a82597d9055541ba1533968820a7e7c7e00072bdac?context=explore)|rye|![pull count for rye-cuda](https://img.shields.io/docker/pulls/genjiohara/rye-cuda.svg)|
|[genjiohara/texlab](https://hub.docker.com/repository/docker/genjiohara/texlab)|[mfisherman/texlive-full](https://hub.docker.com/r/mfisherman/texlive-full)|[TexLab](https://github.com/latex-lsp/texlab)|![pull count for rye](https://img.shields.io/docker/pulls/genjiohara/texlab.svg)|
