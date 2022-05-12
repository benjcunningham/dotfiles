Cross-Platform
==============

Most of my tools are available everywhere. With some exceptions, the dotfiles I use for these tools are the same cross-platform as well. The only difference in setup tends to be how some software is installed on macOS versus Ubuntu. Here's what gets added to my machines, regardless of the system:

Bash
----

I've moved away from using Bash as my default shell (largely because `Apple is beginning to deprecate Bash <https://scriptingosx.com/2019/06/moving-to-zsh/>`_ due to the GPL v3 license on newer versions). Still, it's around and I frequently use it, so I track the staple configs:

.. code-block:: bash

    $HOME/
        .bash_aliases
        .bashrc

Dracula
-------

I use `Dracula <https://draculatheme.com/>`_ themes almost everywhere I can. See the system-specific pages for additional use cases, but all of my machines use the Dracula themes for:

- Tmux
- Vim

Docker
------

A Docker Engine gets installed on all systems, but per `Docker's official installation guide <https://docs.docker.com/engine/install/>`_, the details are a bit different on each OS. I don't use any dotfiles with either version.

EditorConfig
------------

My global `EditorConfig <https://editorconfig.org/>`_ file is located at:

.. code-block:: bash

    $HOME/
        .editorconfig

Vim is the only tool where I use an EditorConfig plugin to apply the styles to my code in real-time. See the later section on Vim for more information about this.

You should also understand that this "global" file is at the root of my home directory, and therefore applies only to paths under that root.

Git
---

I track the usual suspects at:

.. code-block:: bash

    $HOME/
        .gitconfig
        .gitignore

.. note::

    My ``.gitconfig`` only lists personal profile details, so has to be manually edited on my work machine. `Git's conditional includes <https://git-scm.com/docs/git-config#_conditional_includes>`_ don't seem like the right answer for me currently, but might just be the best alternative.

Jupyter
-------

I absolutely hate notebooks, but I do track a Jupyter config with some minimal customizations at:

.. code-block:: bash

    $HOME/
        .jupyter/
            jupyter_notebook_config.py

Tmux
----

My Tmux config is fairly minimal. It uses `TPM for plugin management <https://github.com/tmux-plugins/tpm>`_. Panes are split using ``|`` and ``-``, and mouse control is turned on. The status bar is set by the Dracula theme I have installed. Everything is stored in:

.. code-block:: bash

    $HOME/
        .tmux.conf

Vim
---

I'm solidly on Team Vim. I try to stay away from them, but I `manage plugins with Vundle <https://github.com/VundleVim/Vundle.vim>`_; Dracula is installed for theming, and there is an EditorConfig plugin for code style compliance.

Outside of the exceptions defined in the global EditorConfig, ``expandtab`` is on by default with 4 spaces. In visual mode, ``<Tab>`` / ``<Backspace>`` indent and unindent, respectively. In both normal and visual mode, ``j`` and ``k`` can move between soft-wrapped rows.

The config is linked to:

.. code-block:: bash

    $HOME/
        .vimrc

Zsh
---
