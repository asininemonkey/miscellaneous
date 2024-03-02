#!/usr/bin/env bash

mkdir /home/pi/.firewalla/run/docker/firewalla-purple

cat << EOF > /home/pi/.firewalla/run/docker/firewalla-purple/docker-compose.yaml
version: "3"

services:
  uptime-kuma:
    container_name: update-kuma
    image: louislam/uptime-kuma
    restart: unless-stopped
    networks:
      firewalla-purple:
        ipv4_address: 172.16.8.10
    ports:
      - 3001:3001/tcp

networks:
  firewalla-purple:
    driver: bridge
    ipam:
      config:
        - subnet: 172.16.8.0/24
EOF

sudo systemctl enable --now docker-compose@firewalla-purple

# LAN Access
sudo ip route add 172.16.8.0/24 dev br-$(sudo docker network ls | awk '$2 == "firewalla-purple_firewalla-purple" {print $1}') table lan_routable

# WAN Access
# sudo ip route add 172.16.8.0/24 dev br-$(sudo docker network ls | awk '$2 == "firewalla-purple_firewalla-purple" {print $1}') table wan_routable
