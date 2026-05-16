# Preinstall

FROM debian:bookworm AS preinstall

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get -y install sudo tzdata

WORKDIR /root/dotfiles
COPY . .

# Install
#
# Runs the headless / server install, which is the default on any Linux host
# (no -f flag). This mirrors how the installer would be used on a Raspberry Pi
# running Debian Bookworm.

FROM preinstall AS install

ARG DEBIAN_FRONTEND=noninteractive
ARG DOTFILES_FRONTEND=noninteractive
ARG DOTFILES_LOCAL=1

RUN bash install.sh

ENTRYPOINT ["/bin/zsh"]
