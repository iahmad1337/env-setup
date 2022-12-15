#!/bin/sh

set -eu

# This script is responsible for deploying a full-blown development enrironment
# on remote machines. I only want this to work on ubuntu.


echo "Starting deployment..."
echo "Initial state of filesystem:"
df -h

if [ ! -e "ROOT_MARKER" ]; then
    echo "This script must be run from the directory in which it was installed"
    exit 1
fi

################################################################################
#                        Creating common dirs and files                        #
################################################################################
mkdir -p ~/personal
mkdir -p ~/.local/bin
cp min-tmux-conf ~/.tmux.conf
echo "SELECTED_EDITOR=nvim" >~/.selected_editor

################################################################################
#                                  Nvim setup                                  #
################################################################################
mkdir -p ~/.config && cp -r ./nvim ~/.config

################################################################################
#                                   .bashrc                                    #
################################################################################
{
    echo
    echo "# Nicer prompt with git branch"
    echo "# These lines were automatically appended by the script"
    cat bash-prompt
} >>~/.bashrc

################################################################################
#                       Download the necessary software                        #
################################################################################

install_progs() {
    print -p "Are you sure you want to install $1? (y/n)" choice
    case "$choice" in
        y|Y )  {
            echo "Installing $1..."
            sudo apt install --show-progress "$2"
            echo "Done installing $1"
        };;
        * ) {
            echo "Skipping $1"
        };;
    esac
}

progs="\
    neovim \
    make \
    python3 \
    python3-pip \
"

cxx_progs="\
    gcc \
    clang \
    clang++ \
    clangd \
    clang-tidy \
    clang-format \
    bear \
"

utility_progs="\
    mc \
    tmux \
    htop \
    ncdu \
"

# Install programs essential for development
sudo apt install -q -y "$progs"

install_progs "c++ development programs" "$cxx_progs"
install_progs "utility programs" "$utility_progs"

echo "Deployment finished."
echo "Current state of the filesystem:"
df -h
