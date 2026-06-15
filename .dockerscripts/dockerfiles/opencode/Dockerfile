FROM node:26.3.0-trixie-slim

RUN apt-get update && apt-get install -y curl git wget

# Install OpenCode and difit
ARG OPENCODE_VERSION
RUN npm install -g opencode-ai@${OPENCODE_VERSION} difit

# Install GitLab CLI (v1.101.0)
RUN wget https://gitlab.com/gitlab-org/cli/-/releases/v1.101.0/downloads/glab_1.101.0_linux_amd64.deb \
    && dpkg -i glab_1.101.0_linux_amd64.deb
