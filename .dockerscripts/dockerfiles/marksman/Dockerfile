FROM alpine:3.23.4

RUN apk add curl icu-libs
ARG MARKSMAN_VERSION
RUN curl -fLO https://github.com/artempyanykh/marksman/releases/download/${MARKSMAN_VERSION}/marksman-linux-musl-x64
RUN mv marksman-linux-musl-x64 usr/local/bin/marksman && chmod +x /usr/local/bin/marksman
