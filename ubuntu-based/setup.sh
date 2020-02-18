#!/bin/bash

# Update all packages
sudo apt-get update && \
sudo apt-get upgrade -y && \
sudo apt-get dist-upgrade -y && \
sudo apt autoremove -y

# Install applications to install Docker & Add snap support
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common snapd

# Add the docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Install docker
sudo apt-get update && \
sudo apt-get install docker-ce && \
sudo systemctl enable docker

# Add ability to run docker without sudo
sudo usermod -aG docker ${USER} && \
su - ${USER}

# Install PHPStorm & Spotify through snaps
sudo snap install phpstorm && \
sudo snap install spotify

# Add update command to .bashrc
echo "alias update='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt autoremove -y'" >> ~/.bashrc
