#!/usr/bin/env bash

# bash <(curl --location --silent https://jmgc.link/termux)

if [ ! -d /data/data/com.termux/files/usr/etc/termux/chosen_mirrors ]
then
    mkdir --mode 0700 /data/data/com.termux/files/usr/etc/termux/chosen_mirrors

    cp /data/data/com.termux/files/usr/etc/termux/mirrors/europe/grimler.se /data/data/com.termux/files/usr/etc/termux/chosen_mirrors/
fi

pkg --check-mirror update

pkg upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confnew" --yes

pkg install --yes \
    git \
    helm \
    htop \
    k9s \
    kubectl \
    mandoc \
    oh-my-posh \
    openssh \
    termux-services \
    tree \
    wget \
    zsh

chsh -s zsh

if [ ! -s ~/.ssh/authorized_keys ]
then
    cat << 'EOF' > ~/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQowLl5Bzn87ig+Gs7Ze5kWODRTdHiD+V8sOCwOx16Z
EOF

    chmod 0400 ~/.ssh/authorized_keys
fi

if [ ! -f ~/.ssh/config ]
then
    cat << 'EOF' > ~/.ssh/config
Host *
    User jcardoso

Host omv
    HostName 192.168.144.205

Host pi
    HostName 192.168.144.2
EOF

    chmod 0400 ~/.ssh/config
fi

if [ ! -f ~/.ssh/id_ed25519 ]
then
    touch ~/.ssh/id_ed25519

    echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQowLl5Bzn87ig+Gs7Ze5kWODRTdHiD+V8sOCwOx16Z' > ~/.ssh/id_ed25519.pub

    chmod 0400 ~/.ssh/id_*
fi

if [ ! -f ~/.termux/font.ttf ]
then
    curl --location --output ~/.termux/font.ttf https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/IosevkaTerm/IosevkaTermNerdFont-Regular.ttf
fi

cat << 'EOF' > ~/.termux/termux.properties
extra-keys = []
hide-soft-keyboard-on-startup = true
terminal-cursor-blink-rate = 750
EOF

cat << 'EOF' > ~/.zshrc
autoload -U compinit && compinit
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/asininemonkey/miscellaneous/refs/heads/main/linux/oh-my-posh.json)"
EOF

git config --global user.email "65740649+asininemonkey@users.noreply.github.com"
git config --global user.name "Jose Cardoso"

termux-reload-settings
