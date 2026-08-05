#!/usr/bin/env bash

mkdir --parents /data/data/com.termux/files/usr/etc/termux

cat << EOF > /data/data/com.termux/files/usr/etc/termux/chosen_mirrors
WEIGHT=10
MAIN="https://packages-cf.termux.dev/apt/termux-main"
ROOT="https://packages-cf.termux.dev/apt/termux-root"
X11="https://packages-cf.termux.dev/apt/termux-x11"
EOF

pkg update

pkg upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --yes

pkg install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --yes \
    chezmoi \
    git

termux-reload-settings
