#!/usr/bin/env bash

unalias apt
unalias apt-get

mkdir "${HOME}/.ssh"

chmod 0700 "${HOME}/.ssh"

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYDHpVs4nKaLG+tnLUGH+4Ivnq9ELPW0S3W/uJhxNd/' > "${HOME}/.ssh/authorized_keys"

chmod 0400 "${HOME}/.ssh/authorized_keys"
chmod 0500 "${HOME}/.ssh"

sudo systemctl enable --now docker

curl -fsSL 'https://pkgs.tailscale.com/stable/ubuntu/focal.tailscale-keyring.list' | sudo tee '/etc/apt/sources.list.d/tailscale.list' > /dev/null

curl -fsSL 'https://pkgs.tailscale.com/stable/ubuntu/focal.noarmor.gpg' | sudo tee '/usr/share/keyrings/tailscale-archive-keyring.gpg' > /dev/null

sudo apt-get update

sudo apt-get install ca-certificates
sudo apt-get install tailscale

sudo tailscale up
