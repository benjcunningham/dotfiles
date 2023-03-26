dotfiles
========

Hey, these are my dotfiles. You probably shouldn't use them, but you're very
welcome to try. Just be careful, since they might not do what you expect. And
this website? It's documentation for those dotfiles, and more generally how
I setup my machines. It's all a bit excessive, but maybe you'll find it as
useful as I do.

By the way, the source of this project is on `GitHub
<https://github.com/benjcunningham/dotfiles>`_.

Features
--------

I use these dotfiles on multiple machines, work and personal. Some things
aren't exactly the same across different systems, but there is a lot of
standardization. Here are the highlights:

.. list-table::
   :header-rows: 1

   * - Name
     - macOS 12
     - Ubuntu
     - Purpose
   * - android-file-transfer
     - ✔ :superscript:`P`
     -
     - Transfer files to and from Android devices.
   * - apt-transport-https
     -
     - ✔
     -
   * - argo
     - ✔
     -
     -
   * - audacity
     - ✔
     -
     - Record audio.
   * - balenaetcher
     - ✔ :superscript:`P`
     -
     - Flash SD cards and USB drives.
   * - bash
     - ✔
     -
     -
   * - bat
     - ✔
     -
     - View files with syntax highlighting (alternative to ``cat``).
   * - brave-browser
     - ✔
     -
     - Web browser.
   * - brew
     - ✔
     -
     - Package manager.
   * - build-essential
     -
     - ✔
     -
   * - ca-certificates
     -
     - ✔
     -
   * - colordiff
     - ✔
     -
     - Diff files with syntax highlighting (alternative to ``diff``).
   * - cookiecutter
     - ✔
     -
     - Create Python projects from templates.
   * - croc
     - ✔
     -
     - Securely transfer files between computers.
   * - curl
     - ✔
     - ✔
     -
   * - docker
     - ✔
     -
     - Container engine (installed as Docker Desktop on macOS).
   * - fd
     - ✔
     - ✔
     - Find files (alternative to ``find``).
   * - ffmpeg
     - ✔
     -
     - Convert audio and video.
   * - fx
     - ✔
     -
     - View JSON.
   * - fzf
     - ✔
     - ✔
     - Fuzzy find files (required for ``fzf.vim`` plugin).
   * - g++
     -
     - ✔
     -
   * - gcc
     -
     - ✔
     -
   * - gh
     - ✔
     -
     - Work with GitHub from command line.
   * - git
     - ✔
     - ✔
     - Version projects.
   * - git-lfs
     - ✔
     -
     - Version large files.
   * - gnupg
     -
     - ✔
     -
   * - gnupg-agent
     -
     - ✔
     -
   * - google-chrome
     - ✔ :superscript:`W`
     -
     - Web browser.
   * - helm
     - ✔
     -
     - Kubernetes package manager.
   * - htop
     - ✔
     -
     - Interactive process viewer (alternative to ``top``).
   * - iterm2
     - ✔
     -
     - Terminal emulator (alternative to Terminal).
   * - jq
     - ✔
     - ✔
     - JSON processor.
   * - less
     -
     - ✔
     -
   * - libffi-dev
     -
     - ✔
     - Pager.
   * - libssl-dev
     -
     - ✔
     -
   * - libssl1.1
     -
     - ✔
     -
   * - lulu
     - ✔ :superscript:`P`
     -
     - Firewall unknown outgoing connections.
   * - mactex
     - ✔ :superscript:`P`
     -
     - TeX distribution for processing LaTeX.
   * - make
     - ✔
     - ✔
     - Automate builds.
   * - microsoft-teams
     - ✔ :superscript:`W`
     -
     - Chat and video call.
   * - ncdu
     - ✔
     -
     - Perform disk utilities (alternative to ``du``).
   * - pandoc
     - ✔
     -
     - Convert between markup formats.
   * - private-internet-access
     - ✔ :superscript:`P`
     -
     - VPN client.
   * - pyenv
     - ✔
     - ✔
     - Manage multiple Python versions.
   * - pyenv-virtualenv
     - ✔
     -
     - Virtual environment plugin for ``pyenv``.
   * - python
     - ✔
     -
     -
   * - r
     - ✔
     -
     -
   * - ripgrep
     - ✔
     - ✔
     - Search tool (alternative to ``grep``).
   * - ruby
     - ✔
     -
     -
   * - shellcheck
     - ✔
     - ✔
     - Static analysis of shell scripts.
   * - slack
     - ✔ :superscript:`W`
     -
     -
   * - software-properties-common
     -
     - ✔
     -
   * - spotify
     - ✔
     -
     - Music streaming.
   * - sudo
     -
     - ✔
     -
   * - tmux
     - ✔
     - ✔
     - Terminal multiplexing.
   * - transmission
     - ✔ :superscript:`P`
     -
     - BitTorrent client.
   * - vim
     - ✔
     - ✔
     - Text editor.
   * - vlc
     - ✔
     -
     - Multimedia player.
   * - zlib1g-dev
     -
     - ✔
     -
   * - zlibc
     -
     - ✔
     -
   * - zoom
     - ✔
     -
     - Video call.
   * - zsh
     - ✔
     - ✔
     - Shell.

Next Steps
----------

Want to go deeper? Check out the sidenav for loads of extra information on how
to install software, link dotfiles, or even setup a new machine from scratch.
✌️

.. toctree::
   :caption: Getting Started
   :hidden:

   installation

.. toctree::
   :caption: Systems
   :hidden:

   systems/cross-platform
   systems/macos
   systems/ubuntu

.. toctree::
   :caption: Dev Resources
   :hidden:

   GitHub <https://github.com/benjcunningham/dotfiles>
   dev/contributing
