#!/bin/sh

set -eux

wget \
    https://go.dev/dl/go1.22.4.linux-amd64.tar.gz \
    -P ~/programs

tar -C ~/programs -xzf ~/programs/go1.22.4.linux-amd64.tar.gz

echo 'export PATH=$PATH:$HOME/programs/go/bin' >>~/.bashrc
