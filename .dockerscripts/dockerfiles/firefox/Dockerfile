FROM debian:bookworm-slim

# Install Firefox ESR and Japanese language support
RUN apt-get update && apt-get install -y \
    firefox-esr \
    fonts-noto-cjk \
    dbus-x11 \
    fcitx5-frontend-gtk3 \
    locales \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Configure Japanese locale
RUN echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LC_ALL ja_JP.UTF-8
