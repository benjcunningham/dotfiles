Raspberry Pi
============

What comes with the Raspberry Pi (headless/server) installer?

The server install is the default on any Linux host. It uses only standard APT
packages — no Launchpad PPAs or Ubuntu-specific tooling — so it works on
Raspberry Pi OS, Debian, and Ubuntu Server without modification.

Packages
--------

The following packages are installed via APT:

- ``build-essential``, ``g++``, ``gcc`` — C/C++ build tools
- ``ca-certificates``, ``curl``, ``gnupg``, ``gnupg-agent`` — networking and cryptography essentials
- ``fd-find``, ``fzf``, ``ripgrep`` — modern file and search tools
- ``jq`` — JSON processor
- ``less`` — pager
- ``libffi-dev``, ``libssl-dev``, ``zlib1g-dev`` — common build dependencies (e.g., for compiling Python via pyenv)
- ``make`` — build automation
- ``shellcheck`` — shell script linter
- ``tmux`` — terminal multiplexer
- ``vim`` — text editor
- ``zsh`` — shell

.. note::

    ``software-properties-common`` is **not** installed in server mode because
    it is only needed for managing PPAs, which are Ubuntu-specific and
    unsupported on Raspberry Pi OS / Debian.

Pyenv
-----

`pyenv <https://github.com/pyenv/pyenv>`_ is installed via the official
installer script so that multiple Python versions can be managed without
affecting the system Python.

Dotfiles
--------

The same dotfiles are linked on all platforms via dotbot:

.. code-block:: bash

    $HOME/
        .editorconfig
        .gitconfig
        .gitignore
        .tmux.conf
        .vimrc
        .zshrc

Clipboard
---------

On a headless Linux system (no ``$DISPLAY``), the tmux ``y`` copy binding
stores selections in the tmux buffer rather than piping to ``xclip``, which
requires an X11 display. When a display is available, ``xclip`` is used as
normal.
