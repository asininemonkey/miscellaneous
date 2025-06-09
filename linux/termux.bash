#!/usr/bin/env bash

ln --force --symbolic /data/data/com.termux/files/usr/etc/termux/mirrors/europe /data/data/com.termux/files/usr/etc/termux/chosen_mirrors

pkg update

pkg upgrade --yes

pkg install --yes \
    oh-my-posh \
    openssh \
    tree \
    wget

touch ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

chmod 0400 ~/.ssh/id_*

cat << EOF > ~/.termux/termux.properties
# https://github.com/termux/termux-tools/blob/master/termux.properties
extra-keys = []
hide-soft-keyboard-on-startup = true
terminal-cursor-blink-rate = 750
EOF

termux-reload-settings
