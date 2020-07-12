FROM ubuntu:16.04
RUN apt-get update && \
    apt-get -y install sudo
RUN useradd -m docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo
WORKDIR /dotfiles
COPY . .
RUN ./install.sh
