FROM node:26-alpine3.23

RUN apk add --no-cache \
    bash \
    curl \
    git

ARG HERMES_AGENT_VERSION
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash -s -- --branch "v${HERMES_AGENT_VERSION}"

ARG GITLAB_MCP_VERSION
RUN npm install -g @zereight/mcp-gitlab@${GITLAB_MCP_VERSION}
