# Node.js 22.4.1 (https://hub.docker.com/_/node)
FROM node:22.4.1-alpine3.20

# ShellCheck (https://github.com/koalaman/shellcheck)
# shfmt (https://github.com/mvdan/sh)
RUN apk update && apk add shellcheck shfmt

# Bash Language Server (https://github.com/bash-lsp/bash-language-server)
RUN npm install -g bash-language-server
