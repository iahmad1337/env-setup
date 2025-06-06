#!/bin/sh

set -eux

if cat /proc/version | grep -i debian; then
    distro="debian"
elif cat /proc/version | grep -i ubuntu; then
    distro="ubuntu"
else
    echo "Unsupported distro: $(cat /proc/version)"
fi

exit

if docker ps; then
    echo "Docker already installed. Aborting"
    return 0
fi

# The steps are based on:
# - https://docs.docker.com/engine/install/ubuntu/
# - https://docs.docker.com/engine/install/linux-postinstall/

############
#  step 1  #
############

sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/$distro/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/$distro \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

############
#  step 2  #
############

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

############
#  step 3  #
############
sudo groupadd docker
sudo usermod -aG docker $USER


################################################################################
#                              Post-installation                               #
################################################################################

# Launch this command right after running this script; otherwise docker won't
# work. Or just restart your machine and changes from step 3 will apply
# automatically
newgrp docker

sudo docker run hello-world
