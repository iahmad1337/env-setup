#!/bin/sh

set -eux

git config --global alias.st status
git config --global alias.cam "commit -am"
git config --global alias.cfg "config --list"
git config --global alias.co checkout
git config --global alias.cob "checkout -b"
git config --global alias.fixup "commit -a --fixup=HEAD"
