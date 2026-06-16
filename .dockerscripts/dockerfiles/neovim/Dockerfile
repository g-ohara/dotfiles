# syntax = edrevo/dockerfile-plus
INCLUDE+ ../tree-sitter-cli/Dockerfile

FROM alpine:3.23.0

RUN apk add \
    build-base \
    cmake \
    coreutils \
    curl \
    gettext-tiny-dev \
    git \
    linux-headers \
    ninja
RUN git clone --branch stable --depth 1  https://github.com/neovim/neovim /root/neovim
WORKDIR /root/neovim
RUN make CMAKE_BUILD_TYPE=RelWithDebInfo
RUN make CMAKE_INSTALL_PREFIX=/usr/local install

# Install necessary packages
COPY --from=tree-sitter-cli /usr/local/cargo/bin/tree-sitter /usr/local/bin/tree-sitter
RUN apk add \
    docker-cli \
    docker-cli-compose \
    nodejs \
    ripgrep

# Enable to access Docker scripts mounted from host
ENV PATH=${PATH}:/root/.dockerscripts
