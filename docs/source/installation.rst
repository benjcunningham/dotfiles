Installation
============

The most convenient way to install everything on a new machine is with:

.. code-block:: bash

    # Ubuntu prerequesite
    #
    # Note: Some machines require installing sudo first
    #       (i.e., apt-get update && apt-get install sudo)

    sudo apt-get update \
        && sudo apt-get install curl

    # Both Ubuntu and macOS

    curl -fsSL \
        https://raw.githubusercontent.com/benjcunningham/dotfiles/master/install.sh \
        -o dotfiles.sh \
        && bash dotfiles.sh

.. warning::

    Make sure to verify the contents of the script you downloaded matches the contents of ``install.sh`` located at https://github.com/benjcunningham/dotfiles before executing. These are my personal install scripts and dotfiles, and therefore they likely are not appropriate to add to your machine until you understand what they do.

Dotfiles
--------

If you want to install only the dotfiles:

.. code-block:: bash

    make dotfiles
