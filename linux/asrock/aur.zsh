#!/usr/bin/env zsh

#curl --location --output /tmp/paru.tar.zst https://github.com/morganamilo/paru/releases/download/v2.0.4/paru-v2.0.4-x86_64.tar.zst

curl --location --output /tmp/yay.tar.gz https://github.com/Jguer/yay/releases/download/v12.4.2/yay_12.4.2_x86_64.tar.gz

#tar --directory /tmp --extract --file /tmp/paru.tar.zst --zstd paru

tar --directory /tmp --extract --file /tmp/yay.tar.gz --gzip --no-anchored --strip-components 1 yay

#su jcardoso --command '/tmp/paru --noconfirm --refresh --sync 1password 1password-cli paru'

su jcardoso --command '/tmp/yay --noconfirm --refresh --sync yay'
