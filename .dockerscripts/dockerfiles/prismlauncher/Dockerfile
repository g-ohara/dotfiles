FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# 必要なツールをインストール
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    grep \
    ca-certificates \
    openjdk-21-jre \
    libgl1-mesa-dri \
    libglx-mesa0 \
    mesa-vulkan-drivers \
    intel-media-va-driver-non-free \
    libx11-6 \
    libxext6 \
    libqt6core6t64 \
    libqt6gui6t64 \
    libqt6widgets6t64 \
    libqt6network6t64 \
    libqt6svg6 \
    libquazip1-qt6-1 \
    && apt-get clean

# GitHubから最新版の.debファイルを自動取得してインストール
RUN wget https://prism-launcher-for-debian.github.io/repo/prismlauncher.gpg -O /usr/share/keyrings/prismlauncher-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/prismlauncher-archive-keyring.gpg] https://prism-launcher-for-debian.github.io/repo $(. /etc/os-release; echo "${UBUNTU_CODENAME:-${DEBIAN_CODENAME:-${VERSION_CODENAME}}}") main" | tee /etc/apt/sources.list.d/prismlauncher.list \
  && apt-get update \
  && apt-get install -y prismlauncher

ENV LANG C.UTF-8
