ARG DOCKER_BASE

# Preinstall

FROM ${DOCKER_BASE} AS preinstall

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install sudo

WORKDIR /root/dotfiles
COPY . .

# Test

FROM preinstall AS test

RUN apt-get install -y \
        file \
        shellcheck

# Install

FROM preinstall AS install
