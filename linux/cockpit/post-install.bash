#!/usr/bin/env bash

ln --force --symbolic /etc/libvirt/qemu/networks/default.xml /etc/libvirt/qemu/networks/autostart/default.xml

sed --in-place 's/^#LLMNR.*/LLMNR=no/' /etc/systemd/resolved.conf

su jcardoso --command 'systemctl --user enable podman.socket'

cat << EOF > /etc/libvirt/qemu.conf
spice_listen = "msi-pro.fable-blues.ts.net"
vnc_listen = "msi-pro.fable-blues.ts.net"
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

systemctl enable tailscale-serve.service
