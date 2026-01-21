FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y \
    firefox-esr \
    fonts-noto-cjk \
    dbus-x11 \
    fcitx5-frontend-gtk3 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
