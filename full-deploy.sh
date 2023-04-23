#!/bin/sh

set -eux

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
mkdir -p ~/programs
mkdir -p ~/.local/bin
cp min-tmux-conf ~/.tmux.conf

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
    read -p "Are you sure you want to install $1? (y/n)" choice
    case "$choice" in
        y|Y )  {
            echo "Installing $1..."
            sudo apt install $2
            echo "Done installing $1"
        };;
        * ) {
            echo "Skipping $1"
        };;
    esac
}

progs="\
    make \
    python3 \
    python3-pip\
"

# DON'T ADD 'clang++' AND OTHER '+' CONTAINING NAMES HERE, IT BREAKS REALLY BAD
# AND I SPENT A LOT OF TIME SEARCHING FOR A WORKAROUND - NOTHING WORKED
dev_progs="\
    build-essential \
    bear \
    shellcheck \
    flake8 \
"

utility_progs="\
    mc \
    tmux \
    htop \
    ncdu \
"

# Install programs essential for development
sudo apt install -q -y $progs

install_progs "development programs" "$dev_progs"
install_progs "utility programs" "$utility_progs"

################################################################################
#                                    Neovim                                    #
################################################################################
read -p "Install neovim? (y/n) " choice

case "$choice" in
    y|Y )  {
        wget \
            https://github.com/neovim/neovim/releases/download/stable/nvim.appimage \
            -P ~/programs
        ln -s ~/programs/nvim.appimage ~/.local/bin/nvim
        mkdir -p ~/.config && cp -r ./nvim ~/.config
        echo "SELECTED_EDITOR=nvim" >~/.selected_editor
    };;
esac

# clang: https://releases.llvm.org/download.html
read -p "Custom clang installation? (y/n) " choice

case "$choice" in
    y|Y )  {
	dest="llvm-clang-15"
	wget \
		https://github.com/llvm/llvm-project/releases/download/llvmorg-15.0.6/clang+llvm-15.0.6-x86_64-linux-gnu-ubuntu-18.04.tar.xz \
		-P ~/programs/"$dest"
	for i in ~/programs/"$dest"/clang*; do
		ln -s "$i" ~/.local/bin/"$(basename $i)"
	done
    };;
esac

################################################################################
#                                   The end.                                   #
################################################################################

echo "Deployment finished."
echo "Current state of the filesystem:"
df -h
