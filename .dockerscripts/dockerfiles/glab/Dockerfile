FROM ubuntu:24.04
RUN apt-get update && apt-get install -y wget git
RUN wget https://gitlab.com/gitlab-org/cli/-/releases/v1.95.0/downloads/glab_1.95.0_linux_amd64.deb && \
    dpkg -i glab_1.95.0_linux_amd64.deb
