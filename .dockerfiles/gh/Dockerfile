FROM alpine:3.22.2 AS builder
RUN wget https://github.com/cli/cli/releases/download/v2.82.1/gh_2.82.1_linux_amd64.tar.gz \
    && tar -xvf gh_2.82.1_linux_amd64.tar.gz

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=builder /gh_2.82.1_linux_amd64/bin/gh /usr/local/bin/gh

