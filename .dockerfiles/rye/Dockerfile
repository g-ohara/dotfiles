FROM ubuntu
ENV PATH=/root/.rye/shims:${PATH}
RUN apt update && apt install -y curl git && \
    curl -sSf https://rye.astral.sh/get | RYE_INSTALL_OPTION="--yes" bash
