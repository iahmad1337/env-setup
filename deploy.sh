#!/bin/sh

set -eu

# This script is responsible for deploying a minimal development enrironment on
# remote machines. I only want this to work on ubuntu.

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
mkdir -p ~/.vim
cp min-vimrc ~/.vimrc
echo "SELECTED_EDITOR=vim" >~/.selected_editor

################################################################################
#                       Download the necessary software                        #
################################################################################

progs="tmux vim g++ gcc python3 make mc htop ncdu"

for prog in $progs; do
    # sudo apt install -y "$prog" || echo "Failed to install $prog"
    echo "Installed $prog"
done

echo "Deploment finished."
echo "Current state of the filesystem:"
df -h
