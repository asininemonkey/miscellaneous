#!/usr/bin/env zsh

cat << 'EOF' > /etc/networkd-dispatcher/routable.d/tailscale
#!/usr/bin/env sh
ethtool --features eno1 rx-gro-list off rx-udp-gro-forwarding on
EOF

cat << 'EOF' > /etc/sysctl.d/tailscale
net.ipv4.ip_forward = 1
net.ipv4.tcp_congestion_control = bbr
net.ipv6.conf.all.forwarding = 1
EOF

chmod 0755 /etc/networkd-dispatcher/routable.d/tailscale

systemctl enable networkd-dispatcher
