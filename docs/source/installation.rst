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
