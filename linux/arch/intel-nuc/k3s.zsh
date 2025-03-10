#!/usr/bin/env zsh

mkdir /etc/systemd/system/k3s.service.d

cat << 'EOF' > /etc/systemd/system/k3s.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/k3s server --disable traefik --disable-helm-controller --tls-san 192.168.144.200
EOF

systemctl enable k3s
