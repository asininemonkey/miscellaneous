#!/usr/bin/env bash

pkg update

pkg upgrade --yes

pkg install --yes \
    oh-my-posh \
    openssh \
    tree \
    wget

mkdir --mode 0700 ~/.ssh ~/.termux

touch ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

chmod 0400 ~/.ssh/id_*

cat << EOF > ~/.termux/termux.properties
# https://github.com/termux/termux-tools/blob/master/termux.properties
extra-keys = []
hide-soft-keyboard-on-startup = true
terminal-cursor-blink-rate = 750
EOF

termux-reload-settings
