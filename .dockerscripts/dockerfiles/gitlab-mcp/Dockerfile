FROM node:26-alpine3.23

RUN apk add --no-cache \
    bash \
    curl \
    git

ARG GITLAB_MCP_VERSION
RUN npm install -g @zereight/mcp-gitlab@${GITLAB_MCP_VERSION}

ENV HOST=0.0.0.0 \
    PORT=3002 \
    STREAMABLE_HTTP=true

EXPOSE 3002

CMD ["zereight-mcp-gitlab"]