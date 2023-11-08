#!/usr/bin/env bash

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYDHpVs4nKaLG+tnLUGH+4Ivnq9ELPW0S3W/uJhxNd/' > /etc/pve/priv/authorized_keys

ln --force --symbolic /dev/null ~/.bash_history

rm /etc/apt/sources.list.d/ceph.list
rm /etc/apt/sources.list.d/pve-enterprise.list

echo 'deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription' > /etc/apt/sources.list.d/ceph-no-subscription.list
echo 'deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription' > /etc/apt/sources.list.d/pve-no-subscription.list

echo 'deb [signed-by=/usr/share/keyrings/tailscale-archive-keyring.gpg] https://pkgs.tailscale.com/stable/debian bookworm main' > /etc/apt/sources.list.d/tailscale.list

apt update
apt upgrade

sed --in-place='.bak' --null-data --regexp-extended "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

systemctl restart pveproxy.service
