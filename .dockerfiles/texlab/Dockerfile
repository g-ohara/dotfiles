FROM rust:1.85 AS builder
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo install --git https://github.com/latex-lsp/texlab --locked \
    --target=x86_64-unknown-linux-musl

FROM texlive/texlive:latest-full-doc
RUN chown -R texlive:texlive /usr/local/texlive/  # 1000:1000
USER texlive
COPY --from=builder /usr/local/cargo/bin/texlab /usr/local/bin/texlab
