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
#                             Other setup scripts                              #
################################################################################

./configure-git.sh

################################################################################
#                        Creating common dirs and files                        #
################################################################################
mkdir -p ~/personal
mkdir -p ~/.local/bin
mkdir -p ~/.vim
mkdir -p ~/.config/mc
cp min-vimrc ~/.vimrc
cp min-tmux-conf ~/.tmux.conf
cp mc_ini ~/.config/mc/ini
echo "SELECTED_EDITOR=vim" >~/.selected_editor

################################################################################
#                                   .bashrc                                    #
################################################################################

sed -i 's/HISTSIZE=[0-9]*/HISTSIZE=/' ~/.bashrc
sed -i 's/HISTFILESIZE=[0-9]*/HISTFILESIZE=/' ~/.bashrc
cat eternal-history.sh >>~/.bashrc

{
    echo
    echo "# Nicer prompt with git branch"
    echo "# These lines were automatically appended by the script"
    cat bash-prompt
} >>~/.bashrc

################################################################################
#                       Download the necessary software                        #
################################################################################

progs="tmux vim g++ gcc python3 make mc htop ncdu"

for prog in $progs; do
    sudo apt install -q -y "$prog"
done

echo "Minimal deployment finished."
echo "Current state of the filesystem:"
df -h
