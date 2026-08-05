ARG DOCKER_VERSION

FROM docker:${DOCKER_VERSION}

RUN apk add --no-cache --upgrade expat python3 py3-pip curl

WORKDIR /app

COPY docker-mcp/requirements.txt .
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

COPY docker-mcp/server.py .
COPY docker-mcp/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV HOST=0.0.0.0 \
    PORT=3004

EXPOSE 3004

ENTRYPOINT ["/entrypoint.sh"]
