ARG GITHUB_MCP_SERVER_VERSION
ARG MCP_PROXY_VERSION

FROM ghcr.io/github/github-mcp-server:${GITHUB_MCP_SERVER_VERSION} AS github-mcp-server

FROM ghcr.io/sparfenyuk/mcp-proxy:${MCP_PROXY_VERSION}
RUN apk add --no-cache curl
COPY --from=github-mcp-server /server/github-mcp-server /usr/local/bin/github-mcp-server

ENV HOST=0.0.0.0 \
    PORT=3003

EXPOSE 3003

CMD ["--host", "0.0.0.0", "--port", "3003", "--transport", "streamablehttp", "--pass-environment", "github-mcp-server", "stdio"]
