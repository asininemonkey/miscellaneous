#!/usr/bin/env bash

# bash <(curl --location --silent https://jmgc.link/termux)

if [ ! -d /data/data/com.termux/files/usr/etc/termux/chosen_mirrors ]
then
    mkdir --mode 0700 /data/data/com.termux/files/usr/etc/termux/chosen_mirrors

    cp /data/data/com.termux/files/usr/etc/termux/mirrors/europe/grimler.se /data/data/com.termux/files/usr/etc/termux/chosen_mirrors/
fi

pkg --check-mirror update

pkg upgrade --yes

pkg install --yes \
    git \
    htop \
    mandoc \
    oh-my-posh \
    openssh \
    termux-services \
    tree \
    wget \
    zsh

chsh -s zsh

if [ ! -f ~/.termux/font.ttf ]; then
    curl --location --output ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/IosevkaTerm/IosevkaTermNerdFont-Regular.ttf
fi

if [ ! -f ~/.ssh/authorized_keys ]; then
cat << 'EOF' > ~/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQowLl5Bzn87ig+Gs7Ze5kWODRTdHiD+V8sOCwOx16Z
EOF
fi

if [ ! -f ~/.ssh/config ]; then
cat << 'EOF' > ~/.ssh/config
Host *
    User jcardoso

Host intel-nuc
    HostName 192.168.144.200

Host openmediavault
    HostName 192.168.144.205

Host raspberry-pi-5-16gb-docker
    HostName 192.168.144.2
EOF
fi

cat << 'EOF' > ~/.termux/termux.properties
# https://github.com/termux/termux-tools/blob/master/termux.properties
extra-keys = []
hide-soft-keyboard-on-startup = true
terminal-cursor-blink-rate = 750
EOF

cat << 'EOF' > ~/.zshrc
autoload -U compinit && compinit
eval "$(oh-my-posh init zsh)"
EOF

touch ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub

chmod 0400 ~/.ssh/authorized_keys ~/.ssh/config ~/.ssh/id_*

termux-reload-settings
