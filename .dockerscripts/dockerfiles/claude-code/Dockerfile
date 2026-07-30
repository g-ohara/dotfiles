FROM node:26.5.0-alpine3.24

RUN apk add --no-cache bash git

ARG CLAUDE_CODE_VERSION
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}
