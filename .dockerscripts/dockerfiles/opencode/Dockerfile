FROM node:26.3.0-trixie-slim

RUN apt-get update && apt-get install -y curl git

# Install OpenCode and difit
ARG OPENCODE_VERSION
RUN npm install -g opencode-ai@${OPENCODE_VERSION} difit
