FROM rust:1.78-buster AS builder
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install --git https://github.com/latex-lsp/texlab --locked \
    --target=x86_64-unknown-linux-musl

FROM mfisherman/texlive-full
COPY --from=builder /usr/local/cargo/bin/texlab /usr/local/bin/texlab
