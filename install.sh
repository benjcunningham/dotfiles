#!/bin/bash

set -eo pipefail

# benjcunningham/dotfiles -- Ben Cunningham's Dotfiles
#
# DESCRIPTION
#
#   This script is meant for quick, easy install via:
#
#       $ curl -fsSLO https://github.com/benjcunningham/dotfiles/install.sh
#       $ bash install.sh
#
# NOTE
#
#   You should make sure to verify the contents of the script you download
#   matches the contents of the file at
#   https://github.com/benjcunningham/dotfiles/install.sh before executing it.
#
# LEARN MORE
#
#   See https://github.com/benjcunningham/dotfiles for more information.

usage() {
    # Show program help and usage
    #
    # USAGE
    #
    #   usage
    #
    # DESCRIPTION
    #
    #   Shows program help and basic usage for a local copy of this script.
    #   However, you should see the top-level DESCRIPTION for this script to
    #   learn about how to conveniently download this installer from GitHub on
    #   a new machine.

    cat <<-EOF
	NAME

	  benjcunningham/dotfiles -- Ben Cunningham's Dotfiles

	USAGE

	  bash install.sh [OPTIONS]

	OPTIONS

	  -h  Display this help message
	  -l  Source local version of dotfiles repository
	  -m  Minimal installation
	  -p  Install software for personal use
	  -w  Install software for work use

	NOTES

	  See https://github.com/benjcunningham/dotfiles to learn more about
	  this script and the software and dotfiles it installs.
	EOF

    exit 1

}

if [[ -t 1 ]]; then
    tty_escape() { printf "\033[%sm" "$1"; }
else
    tty_escape() { :; }
fi

tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_green="$(tty_mkbold 32)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

note() {
    # Print a note to the console.
    #
    # USAGE
    #
    #   note <text>
    #
    # DESCRIPTION
    #
    #   Prints the text argument as a bold, green line to the console.
    #
    # ARGS
    #
    #   <text>  Text to print.

    printf "${tty_green}==>${tty_bold} %s${tty_reset}\n" "${1}"

}

warn() {
    # Print a warning to the console.
    #
    # USAGE
    #
    #   warn <text>
    #
    # DESCRIPTION
    #
    #   Prints the text argument preceeded by a red "Warning:".
    #
    # ARGS
    #
    #   <text>  Text to print.

    printf "${tty_red}Warning${tty_reset}: %s\n" "$1"

}

is_darwin() {
    # Determine if the host is macOS.
    #
    # USAGE
    #
    #   is_darwin
    #
    # DESCRIPTION
    #
    #   Determines if the host running this script is macOS, using `uname -s`.

    case "$(uname -s)" in
        *darwin*) true;;
        *Darwin**) true;;
        *) false;;
    esac

}

clone_dotfiles() {
    # Clone dotfiles repository from GitHub.
    #
    # USAGE
    #
    #   clone_dotfiles <dotfiles_dir> <dotfiles_branch>
    #
    # DESCRIPTION
    #
    #   Clones the branch specified by <dotfiles_branch> of the
    #   benjcunningham/dotfiles repository from GitHub into the directory
    #   specified by <dotfiles_dir>. However, if <dotfiles_branch> is set to
    #   "local", the repository is assumed to already exist at the location and
    #   will not be cloned.
    #
    # ARGS
    #
    #   <dotfiles_dir>        Dotfiles repository directory.
    #   <dotfiles_branch>     Git revision of repository to use.

    local dotfiles_dir
    local dotfiles_branch

    dotfiles_dir="${1}"
    dotfiles_branch="${2}"

    if [ "${dotfiles_branch}" == "local" ]; then

        note "Using local dotfiles from ${dotfiles_dir}."
        echo "Assuming the files you want to use exist at the location."

    elif [ ! -d "${dotfiles_dir}" ]; then

        note "Downloading benjcunningham/dotfiles to ${dotfiles_dir}."
        echo "Will do a checkout of ref ${dotfiles_branch}"

        git clone https://github.com/benjcunningham/dotfiles "${dotfiles_dir}"
        cd "${dotfiles_dir}"
        git checkout "${dotfiles_branch}"

    else

        warn "Directory ${dotfiles_dir} already exists."
        echo "Assuming it is an existing clone of this project."
        echo "If this is not correct, you may want to move that directory."

    fi

}

macos_preinstall() {
    # Install minimal required macOS software.
    #
    # USAGE
    #
    #   macos_preinstall
    #
    # DESCRIPTION
    #
    #   Installs the minimal software to continue with the macOS installation
    #   of this script. All preinstalls generally require a package manager,
    #   Curl, Git, and Make.

    local homebrew_url

    note "Running macOS pre-installation."

    homebrew_url="https://raw.githubusercontent.com/Homebrew/install/master/install.sh"

    if [ ! -f "$(command -v brew)" ]; then
        echo | bash -c "$(curl -fsSL ${homebrew_url})"
    else
        warn "Homebrew installation already found."
    fi

    brew upgrade
    brew install curl git make

}

ubuntu_preinstall() {
    # Install minimal required Ubuntu software.
    #
    # USAGE
    #
    #   ubuntu_preinstall
    #
    # DESCRIPTION
    #
    #   Installs the minimal software to continue with the Ubuntu installation
    #   of this script. All preinstalls generally require a package manager,
    #   Curl, Git, and Make.

    note "Running Ubuntu pre-installation."

    if ! type "add-apt-repository" > /dev/null; then
        sudo apt-get update
        sudo apt-get install -y software-properties-common
    fi

    sudo add-apt-repository -y ppa:git-core/ppa
    sudo apt-get update
    sudo apt-get install -y \
        curl \
        git \
        gnupg \
        make

}

macos_install() {
    # Install macOS software.
    #
    # USAGE
    #
    #   macos_install <dotfiles_dir> <brewfile_personal> <brewfile_work>
    #
    # DESCRIPTION
    #
    #   Uses Brewfiles to install macOS software via Homebrew. The default
    #   Brewfile lists software that should be installed on all machines. If
    #   <brewfile_personal> is non-zero-length, Brewfile.personal will install
    #   software for a pesonal machine. If <brewfile_work> is non-zero-length,
    #   Brewfile.work will install software for a work machine.
    #
    # ARGS
    #
    #   <dotfiles_dir>          Dtofiles repository directory.
    #   <brewfile_personal>     Non-zero-length value if Brewfile.personal
    #                           should be installed.
    #   <brewfile_work>         Non-zero-length value if Brewfile.work should
    #                           be installed.

    local dotfiles_dir
    local brewfile_personal
    local brewfile_work

    dotfiles_dir="${1}"
    brewfile_personal="${2}"
    brewfile_work="${3}"

    if [ -f "/usr/local/bin/2to3" ]; then
        rm "/usr/local/bin/2to3"
    fi

    cd "${dotfiles_dir}"

    brew update
    brew upgrade

    note "Installing shared Brewfile"
    brew bundle --file homebrew/Brewfile

    if [ -n "${brewfile_personal}" ]; then
        note "Installing personal Brewfile"
        brew bundle --file homebrew/Brewfile.personal
    else
        warn "Skipping install of personal Brewfile"
    fi

    if [ -n "${brewfile_work}" ]; then
        note "Installing work Brewfile"
        brew bundle --file homebrew/Brewfile.work
    else
        warn "Skipping install of work Brewfile"
    fi

}

ubuntu_install() {
    # Install Ubuntu software.
    #
    # USAGE
    #
    #   ubuntu_install
    #
    # DESCRIPTION
    #
    #   Uses a hardcoded list of Ubuntu software to install via APT.

    note "Installing Ubuntu (APT) software."

    sudo apt-get update
    sudo apt-get install -y \
        sudo \
        apt-transport-https \
        build-essential \
        ca-certificates \
        g++ \
        gcc \
        gnupg-agent \
        less \
        software-properties-common \
        shellcheck \
        tmux \
        vim \
        zsh

    sudo apt-get upgrade -y
    sudo apt-get autoremove -y

}

dotbot_install() {
    # Install dotbot and link dotfiles
    #
    # USAGE
    #
    #   dotbot_install <dotfiles_dir>
    #
    # DESCRIPTION
    #
    #   Syncs the dotbot Git submodule and uses it to apply dotbot.conf.yaml
    #   (i.e., link all dotfiles).
    #
    # GLOBALS
    #
    #   DOTFILES_FRONTEND   Frontend being used for running this dotfiles
    #                       script. This roughly corresponds to the same
    #                       concept as DEBIAN_FRONTEND, but is more generalized
    #                       to the operating systems supported by this script.
    #
    # ARGS
    #
    #   <dotfiles_dir>  Dotfiles repository directory.

    local dotfiles_dir

    dotfiles_dir="${1}"

    note "Linking dotfiles with Dotbot..."

    cd "${dotfiles_dir}"
    git -C dotbot submodule sync --quiet --recursive
    git submodule update --init --recursive dotbot

    "${dotfiles_dir}/dotbot/bin/dotbot" -d "${dotfiles_dir}" -c dotbot.conf.yaml

    if [ "${DOTFILES_FRONTEND}" != "noninteractive" ]; then
        git_config
    fi

}

dracula_install() {
    # Install Dracula themes.
    #
    # USAGE
    #
    #   dracula_install <dotfiles_dir>
    #
    # DESCRIPTION
    #
    #   Clones the Dracula themes for iTerm2 (if on macOS) and Zsh, and links
    #   them to the respective programs.
    #
    # GLOBALS
    #
    #   HOME    Home directory.
    #
    # ARGS
    #
    #   <dotfiles_dir>  Dotfiles repository directory.

    local dotfiles_dir
    local dracula_dir
    local omz_dir
    local iterm_dir

    note "Installing Dracula themes..."

    dotfiles_dir="${1}"
    dracula_dir="${HOME}/.oh-my-zsh/custom/themes/dracula"
    omz_dir="${HOME}/.oh-my-zsh/themes"
    iterm_dir="${HOME}/.iterm/dracula"

    if is_darwin; then

        echo "Adding to iTerm2"

        if [ ! -d "${iterm_dir}" ]; then
            git clone https://github.com/dracula/iterm.git "${iterm_dir}"
        else
            warn "${iterm_dir} already exists. Skipping download."
        fi

        defaults write com.googlecode.iterm2.plist \
            PrefsCustomFolder -string "${dotfiles_dir}/iterm2"
        defaults write com.googlecode.iterm2.plist \
            LoadPrefsFromCustomFolder -bool true

    fi

    echo "Adding to Zsh"

    if [ ! -d "${dracula_dir}" ]; then
        git clone https://github.com/dracula/zsh.git "${dracula_dir}"
    fi

    if [ ! -d "${omz_dir}" ]; then
        mkdir -p "${omz_dir}"
    fi

    ln -fs "${dracula_dir}/dracula.zsh-theme" "${omz_dir}/dracula.zsh-theme"

}

ohmyzsh_install() {
    # Install Oh My Zsh.
    #
    # USAGE
    #
    #   ohmyzsh_install
    #
    # DESCRIPTION
    #
    #   Installs Oh My Zsh.
    #
    # GLOBALS
    #
    #   ZSH     A path, typically only set by Oh My Zsh, points to the Oh My
    #           Zsh repository and installer.

    local install_url

    note "Installing Oh My Zsh..."

    if [ -z "${ZSH}" ]; then

        install_url="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
        sh -c "$(curl -fsSL ${install_url})" "" --unattended

    else

        warn "Directory ${ZSH} already exists."
        cat <<-EOF
		Oh My Zsh installer would have exited with an error. If you really need to
		reinstall you can:
		- Unset the ZSH variable.
		- Move or delete the directory.
		EOF

    fi

}

tpm_install() {
    # Install TPM for Tmux
    #
    # USAGE
    #
    #   tpm_install
    #
    # DESCRIPTION
    #
    #   Installs TPM (the Tmux Plugin Manager), then starts Tmux and sources
    #   ~/.tmux.conf so all plugins are installed and made availabe.
    #
    # GLOBALS
    #
    #   HOME    Home directory.

    local tpm_dir

    note "Installing TPM..."

    tpm_dir="${HOME}/.tmux/plugins/tpm"

    if [ ! -d "${tpm_dir}" ]; then
        git clone https://github.com/tmux-plugins/tpm "${tpm_dir}"
    fi

    tmux start \; source-file "${HOME}/.tmux.conf"

}

vundle_install() {
    # Install Vundle for Vim.
    #
    # USAGE
    #
    #   vundle_install
    #
    # DESCRIPTION
    #
    #   Installs Vundle, the plugin manager for Vim, then runs `PluginInstall`
    #   on the existing ~/.vimrc so all plugins are installed and made
    #   available.
    #
    # GLOBALS
    #
    #   HOME    Home directory.

    local vundle_dir

    note "Installing Vundle..."

    vundle_dir="${HOME}/.vim/bundle/Vundle.vim"

    if [ ! -d "${vundle_dir}" ]; then
        git clone https://github.com/VundleVim/Vundle.vim.git "${vundle_dir}"
    fi

    echo | vim +'PluginInstall' +qa > /dev/null

}

git_config() {
    # Interactively populate ~/.gitconfig.local
    #
    # USAGE
    #
    #   git_config
    #
    # DESCRIPTION
    #
    #   Prompts an interactive user to provide their `user.name` and
    #   `user.email` to Git, and saves the resulting configuration in
    #   ~/.gitconfig.local. This is a useful pattern so that users can avoid
    #   saving this information in their Git-versioned ~/.gitconfig.

    note "Enter your Git credentials to populate ~/.gitconfig.local"

    echo -n 'user.name: '
    read -r user_name
    git config --file ~/.gitconfig.local user.name "${user_name}"

    echo -n 'user.email: '
    read -r user_email
    git config --file ~/.gitconfig.local user.email "${user_email}"

}

set_globals() {
    # Set globals from options
    #
    # USAGE
    #
    #   set_globals [OPTIONS]
    #
    # GLOBALS
    #
    #   DOTFILES_LOCAL      Set to "1" if the -l flag is provided.
    #   DOTFILES_PERSONAL   Set to "1" if the -p flag is provided.
    #   DOTFILES_WORK       Set to "1" if the -w flag is provided.
    #
    # OPTIONS
    #
    #   -h  Show usage and help for program.
    #   -l  Specify that the dotfiles repository is already available on the
    #       local host.
    #   -p  Specify that Brewfile.personal should be installed.
    #   -w  Specify that Brewfile.work should be installed.

    while getopts ":hlpw" flag; do
        case "${flag}" in
            h )
                usage
                ;;
            l )
                export DOTFILES_LOCAL=1
                ;;
            p )
                export DOTFILES_PERSONAL=1
                ;;
            w )
                export DOTFILES_WORK=1
                ;;
            * )
                usage
                ;;
        esac
    done

}

main() {
    # Install dotfiles and software.
    #
    # USAGE
    #
    #   main [OPTIONS]
    #
    # DESCRIPTION
    #
    #   Clones the contents of benjcunningham/dotfiles, then uses the
    #   specifications there (and in this script) to install software on the
    #   host machine and link all relevant dotfiles.
    #
    # GLOBALS
    #
    #   DOTFILES_BRANCH
    #   DOTFILES_LOCAL      Set to "1" if the -l flag is provided.
    #   DOTFILES_PERSONAL   Set to "1" if the -p flag is provided.
    #   DOTFILES_WORK       Set to "1" if the -w flag is provided.
    #   HOME                Home directory.
    #
    # OPTIONS
    #
    #   -h  Show usage and help for program.
    #   -l  Specify that the dotfiles repository is already available on the
    #       local host.
    #   -p  Specify that Brewfile.personal should be installed.
    #   -w  Specify that Brewfile.work should be installed.

    local start_time
    local dotfiles_dir

    set_globals "$@"

    note "Installing benjcunningham/dotfiles..."
    start_time=$(date +%s)

    if is_darwin; then
        macos_preinstall
    else
        ubuntu_preinstall
    fi

    if [ -n "${DOTFILES_LOCAL}" ]; then
        dotfiles_branch="local"
    else
        dotfiles_branch="${DOTFILES_BRANCH:-master}"
    fi

    dotfiles_dir="${HOME}/dotfiles"
    clone_dotfiles "${dotfiles_dir}" "${dotfiles_branch}"
    cd "${dotfiles_dir}"

    if is_darwin; then
        macos_install "${dotfiles_dir}" "${brewfile_personal}" "${brewfile_work}"
    else
        ubuntu_install
    fi

    ohmyzsh_install
    dotbot_install "${dotfiles_dir}"
    tpm_install
    vundle_install
    dracula_install "${dotfiles_dir}"

    note "Installation successful! ($(($(date +%s)-start_time))s)"
    cat <<-EOF
	Next steps:
	Find more documentation here: ${tty_underline}https://benjcunningham.org/dotfiles${tty_reset}.
	EOF

}

main "$@"
