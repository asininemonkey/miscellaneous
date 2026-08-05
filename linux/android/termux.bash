#!/usr/bin/env bash

curl --location --output /data/data/com.termux/files/home/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IosevkaTerm/IosevkaTermNerdFont-Regular.ttf

termux-reload-settings

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
    git \
    termux-services

rm /data/data/com.termux/files/usr/var/service/ssh-agent/down

termux-reload-settings
