#!/bin/sh

set -eux

./install-docker.sh

if docker-compose -h; then
    echo "docker-compose already installed. Aborting"
    return 0
fi

# The steps are based on:
# - https://docs.docker.com/compose/install/standalone/

INSTALLATION_PATH=$HOME/.local/bin/docker-compose

curl -SL \
    https://github.com/docker/compose/releases/download/v2.29.6/docker-compose-linux-x86_64 \
    -o "$INSTALLATION_PATH"

chmod +x "$INSTALLATION_PATH"
