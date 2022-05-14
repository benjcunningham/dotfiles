# Preinstall

FROM ubuntu:20.04 AS preinstall

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install sudo tzdata

WORKDIR /root/dotfiles
COPY . .

# Test

FROM preinstall AS test

RUN apt-get install -y \
        file \
        shellcheck

# Install

FROM preinstall AS install
