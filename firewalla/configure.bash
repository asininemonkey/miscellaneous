#!/usr/bin/env bash

unalias apt
unalias apt-get

# sudo systemctl enable --now docker

curl -fsSL 'https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list' | sudo tee '/etc/apt/sources.list.d/tailscale.list' > /dev/null
curl -fsSL 'https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg' | sudo tee '/usr/share/keyrings/tailscale-archive-keyring.gpg' > /dev/null

sudo apt-get update

sudo apt-get install ca-certificates
sudo apt-get install tailscale

sudo tailscale up --ssh
