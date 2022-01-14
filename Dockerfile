FROM ubuntu:20.04

ENV HOME /root
WORKDIR $HOME

RUN apt-get update \
        && apt-get install sudo

ENV CI true
COPY . ./dotfiles
RUN dotfiles/install/ubuntu-20.04/minimal.sh
