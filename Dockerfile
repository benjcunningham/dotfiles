FROM ubuntu:latest
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y install sudo tzdata
WORKDIR /root/dotfiles
ENV DOTFILES_LOCAL=1
COPY . .
RUN ./install.sh
