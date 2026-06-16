FROM rust:1.95.0-alpine3.22 AS tree-sitter-cli

# Install cargo-binstall
RUN apk add curl \
    && curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | sh

# Install tree-sitter-cli
RUN apk add clang-dev \
    && RUSTFLAGS="-C target-feature=-crt-static" cargo binstall -y tree-sitter-cli
