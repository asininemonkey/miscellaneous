#!/usr/bin/env bash

SSH_PUBLIC_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYDHpVs4nKaLG+tnLUGH+4Ivnq9ELPW0S3W/uJhxNd/'

if ! grep --silent "${SSH_PUBLIC_KEY}" /etc/pve/priv/authorized_keys
then
    echo "${SSH_PUBLIC_KEY}" >> /etc/pve/priv/authorized_keys
fi

ln --force --symbolic /dev/null ~/.bash_history

rm /etc/apt/sources.list.d/ceph.list
rm /etc/apt/sources.list.d/pve-enterprise.list

echo 'deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription' > /etc/apt/sources.list.d/ceph-no-subscription.list
echo 'deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription' > /etc/apt/sources.list.d/pve-no-subscription.list

curl --fail --location --output /etc/apt/sources.list.d/tailscale.list --show-error --silent 'https://pkgs.tailscale.com/stable/debian/bookworm.tailscale-keyring.list'
curl --fail --location --output /usr/share/keyrings/tailscale-archive-keyring.gpg --show-error --silent 'https://pkgs.tailscale.com/stable/debian/bookworm.noarmor.gpg'

apt-get update

apt-get --assume-yes upgrade
apt-get --assume-yes install btop jq tailscale

sed --in-place='.bak' --null-data --regexp-extended "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js

systemctl restart pveproxy.service

tailscale up

cat << EOF > /etc/systemd/system/tailscale-serve.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/tailscale serve https+insecure://127.0.0.1:8006
ExecStartPre=-/usr/bin/tailscale serve --https 443 off
ExecStopPost=-/usr/bin/tailscale serve --https 443 off
Restart=on-failure
RestartSec=5

[Unit]
After=network-pre.target NetworkManager.service systemd-resolved.service tailscaled.service
Description=Tailscale Serve
Wants=network-pre.target
EOF

systemctl daemon-reload

systemctl enable --now tailscale-serve.service
