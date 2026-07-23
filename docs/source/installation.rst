Installation
============

.. warning::

    Make sure to verify the contents of the script you download matches the
    contents of ``install.sh`` at https://github.com/benjcunningham/dotfiles
    before executing. These are personal install scripts and dotfiles; they
    likely are not appropriate for your machine until you understand what they
    do.

The installer behaves differently depending on the platform and flags you
pass:

- **macOS** — full desktop install by default (Homebrew, GUI apps, themes, etc.)
- **Linux (Ubuntu desktop)** — headless/server by default; pass ``-f`` to get the full desktop install
- **Linux (Raspberry Pi / server)** — headless/server by default; no PPAs or Ubuntu-specific tooling

macOS
-----

.. code-block:: bash

    curl -fsSL \
        https://raw.githubusercontent.com/benjcunningham/dotfiles/master/install.sh \
        -o dotfiles.sh \
        && bash dotfiles.sh

To also install personal or work software bundles:

.. code-block:: bash

    bash dotfiles.sh -p   # personal
    bash dotfiles.sh -w   # work
    bash dotfiles.sh -pw  # both

Ubuntu (desktop)
----------------

First, ensure ``curl`` and ``sudo`` are available:

.. code-block:: bash

    apt-get update && apt-get install -y curl sudo

Then run the installer with ``-f`` to opt into the full desktop install (PPAs,
``software-properties-common``, etc.):

.. code-block:: bash

    curl -fsSL \
        https://raw.githubusercontent.com/benjcunningham/dotfiles/master/install.sh \
        -o dotfiles.sh \
        && bash dotfiles.sh -f

Raspberry Pi / Server (headless)
---------------------------------

Server mode is the default on any Linux host. No PPAs or Ubuntu-specific
tooling are used, so this works on Raspberry Pi OS, Debian, and Ubuntu Server
alike.

First, ensure ``curl`` and ``sudo`` are available:

.. code-block:: bash

    apt-get update && apt-get install -y curl sudo

Then run the installer — no extra flags needed:

.. code-block:: bash

    curl -fsSL \
        https://raw.githubusercontent.com/benjcunningham/dotfiles/master/install.sh \
        -o dotfiles.sh \
        && bash dotfiles.sh

Dotfiles Only
-------------

To link dotfiles without installing any software:

.. code-block:: bash

    make dotfiles

Manual Steps
------------

A couple of things aren't automated by the installer and need to be done by
hand.

**Tmux plugins.** The installer clones TPM and sources ``.tmux.conf``, but it
doesn't fetch and install the plugins themselves. Start Tmux, then press the
prefix key followed by ``I`` (capital i) — by default that's ``Ctrl+b`` then
``Shift+I`` — to install them.

**Shell history.** ``.zsh_history`` and ``.bash_history`` aren't tracked by
these dotfiles. If you want to carry history over to a new machine, copy the
files directly — `croc <https://github.com/schollz/croc>`_ or a similar
peer-to-peer transfer tool works well.

**Brave profile.** Brave's ``Default`` profile (bookmarks, extensions,
saved passwords, etc.) also isn't tracked by these dotfiles. To carry it
over to a new machine (macOS paths shown below), quit Brave, tar up the
profile on the old machine, and send it with ``croc``:

.. code-block:: bash

    # Old machine
    cd "$HOME/Library/Application Support/BraveSoftware/Brave-Browser"
    tar -czf brave-default.tar.gz Default
    croc send brave-default.tar.gz

On the new machine, install Brave and quit it first, then receive and
unpack the archive into place:

.. code-block:: bash

    # New machine
    croc <code-phrase-from-sender>
    tar -xzf brave-default.tar.gz \
        -C "$HOME/Library/Application Support/BraveSoftware/Brave-Browser"
