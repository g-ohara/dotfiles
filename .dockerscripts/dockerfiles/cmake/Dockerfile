FROM ubuntu:22.04

RUN apt update && apt install -y --no-install-recommends \
    ca-certificates \
    g++ \
    make \
    tar \
    wget \
    && rm -rf /var/lib/apt/lists/*

ARG CMAKE_VERSION=4.3.3
RUN mkdir -p /opt/cmake \
    && wget -qO- https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz \
    | tar -xz -C /opt/cmake --strip-components=1

ENV PATH=/opt/cmake/bin:$PATH
