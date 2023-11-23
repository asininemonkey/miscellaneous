#!/usr/bin/env bash

ln --force --symbolic /etc/libvirt/qemu/networks/default.xml /etc/libvirt/qemu/networks/autostart/default.xml

sed --in-place 's/^#LLMNR.*/LLMNR=no/' /etc/systemd/resolved.conf

su jcardoso --command 'mkdir ~/.ssh'
su jcardoso --command 'chmod 0700 ~/.ssh'

su jcardoso --command 'echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKYDHpVs4nKaLG+tnLUGH+4Ivnq9ELPW0S3W/uJhxNd/" > ~/.ssh/authorized_keys'
su jcardoso --command 'chmod 0600 ~/.ssh/authorized_keys'

su jcardoso --command 'systemctl --user enable podman.socket'

cat << EOF > /etc/libvirt/qemu.conf
spice_listen = "msi-pro.fable-blues.ts.net"
vnc_listen = "msi-pro.fable-blues.ts.net"
EOF

cat << EOF > /etc/systemd/system/mnt-isos.mount
[Install]
  WantedBy=multi-user.target

[Mount]
  Type=cifs
  What=//192.168.144.200/iso-images
  Where=/mnt/isos

[Unit]
  After=network-online.service
  Requires=network-online.target
EOF

cat << EOF > /etc/systemd/system/tailscale-serve.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/tailscale serve https+insecure://127.0.0.1:9090
ExecStartPre=-/usr/bin/tailscale serve --https 443 off
ExecStopPost=-/usr/bin/tailscale serve --https 443 off
Restart=on-failure
RestartSec=5

[Unit]
After=network-pre.target NetworkManager.service systemd-resolved.service tailscaled.service
Description=Tailscale Serve
Wants=network-pre.target
EOF

systemctl enable mnt-isos.mount tailscale-serve.service
