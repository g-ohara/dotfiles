FROM alpine:3.23.0

# Install necessary packages
RUN apk add neovim docker-cli docker-cli-compose git nodejs

# Enable to access Docker scripts mounted from host
ENV PATH=${PATH}:/root/.dockerscripts
