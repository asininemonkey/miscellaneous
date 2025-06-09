#!/usr/bin/env bash

#bash <(curl --location --silent https://jmgc.link/termux)

mkdir --mode 0700 /data/data/com.termux/files/usr/etc/termux/chosen_mirrors

cp /data/data/com.termux/files/usr/etc/termux/mirrors/europe/grimler.se /data/data/com.termux/files/usr/etc/termux/chosen_mirrors/

pkg --check-mirror update

pkg upgrade --yes

pkg install --yes \
    oh-my-posh \
    openssh \
    termux-services \
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

sv-enable ssh-agent sshd
