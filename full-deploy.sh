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
#                         Perform basic setup actions                          #
################################################################################

./deploy.sh

################################################################################
#                       Download the necessary software                        #
################################################################################

install_progs() {
    read -p "Are you sure you want to install $1? (y/n)" choice
    case "$choice" in
        y|Y )  {
            echo "Installing $1..."
            sudo apt install -y $2
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
    fzf \
    bat \
    fd-find \
    duf \
    hyperfine \
    zoxide \
    entr \
"

# bat is invoked via `batcat`

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
            https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage \
            -P ~/programs
        ln -s ~/programs/nvim.appimage ~/.local/bin/nvim
        mkdir -p ~/.config && cp -r ./nvim ~/.config
        echo "SELECTED_EDITOR=nvim" >~/.selected_editor

        pip3 install pynvim 'python-lsp-server[all]'
        sudo apt install libfuse2  # to launch appimage
        chmod u+x "~/.local/bin/nvim"
    };;
esac

# clang: https://releases.llvm.org/download.html
read -p "Custom clang installation? (y/n) " choice

case "$choice" in
    y|Y )  {
    dest="llvm-clang-17"
    arch_name="clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04.tar.xz"
    arch_basename="clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04"
	wget \
		https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/$arch_name \
		-P ~/programs
    mkdir -p ~/programs/"$dest"
    tar -xf ~/programs/"$arch_name" -C ~/programs/"$dest"
	for i in ~/programs/"$dest"/"$arch_basename"/bin/clang*; do
		ln -s "$i" ~/.local/bin/"$(basename $i)"
	done
    };;
esac

################################################################################
#                            cmake-language-server                             #
################################################################################

read -p "Install LSP for cmake? (y/n) " choice

case "$choice" in
    y|Y )  {
        pip3 install cmake-language-server
    };;
esac

################################################################################
#                                    Vcpkg                                     #
################################################################################

read -p "Install vcpkg? (y/n) " choice

case "$choice" in
    y|Y )  {
    cd "$HOME"
    git clone https://github.com/Microsoft/vcpkg.git
    cd vcpkg
    sudo apt install zip pkg-config
    ./bootstrap-vcpkg.sh -disableMetrics
    ./vcpkg install abseil fmt gtest benchmark range-v3 re2 nlohmann-json spdlog argparse
    cd
    };;
esac

################################################################################
#                                     fzf                                      #
################################################################################

# How to find this path: https://github.com/junegunn/fzf/issues/1866#issuecomment-585176100
# Or just save the output of `fzf --bash`
echo '. "/usr/share/doc/fzf/examples/key-bindings.bash"'>>~/.bashrc
# ctrl+r for fuzzy history
# ctrl+t for fuzzy substitution

################################################################################
#                                    zoxide                                    #
################################################################################

echo 'eval "$(zoxide init bash)"' >>~/.bashrc

################################################################################
#                                   The end.                                   #
################################################################################

echo "Deployment finished."
echo "Current state of the filesystem:"
df -h
