#!/usr/bin/env bash

# if [ ! -d /data/data/com.termux/files/usr/etc/termux ]
# then
#     mkdir --mode 0700 --parents /data/data/com.termux/files/usr/etc/termux
# fi

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

termux-reload-settings
