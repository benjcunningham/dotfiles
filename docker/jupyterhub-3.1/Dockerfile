# Preinstall

FROM jupyter/minimal-notebook:hub-3.0.0 AS preinstall

ARG DEBIAN_FRONTEND=noninteractive

USER $NB_USER

WORKDIR /home/jovyan/dotfiles
COPY --chown=$NB_USER:$NB_USER . .

# Install

FROM preinstall AS install

ARG DEBIAN_FRONTEND=noninteractive
ARG DOTFILES_FRONTEND=noninteractive
ARG DOTFILES_LOCAL=1

RUN bash install.sh -c
