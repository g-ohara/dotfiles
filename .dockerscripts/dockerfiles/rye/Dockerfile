FROM ubuntu

# Configure path for Rye installation
ENV RYE_HOME=/home/ubuntu/.rye/
ENV PATH=${RYE_HOME}/shims:${PATH}

# Install dependencies
RUN apt update && apt install -y curl git

# Install Rye as a non-root user
USER ubuntu
RUN curl -sSf https://rye.astral.sh/get | \
    RYE_VERSION="0.43.0" RYE_INSTALL_OPTION="--yes" bash
