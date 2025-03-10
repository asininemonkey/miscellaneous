#!/usr/bin/env zsh

curl --location --output /tmp/yay.tar.gz https://github.com/Jguer/yay/releases/download/v12.4.2/yay_12.4.2_x86_64.tar.gz

tar --directory /tmp --extract --file /tmp/yay.tar.gz --gzip --no-anchored --strip-components 1 yay

su jcardoso --command '/tmp/yay --noconfirm --refresh --sync 1password 1password-cli octopi oh-my-posh-bin sublime-merge yay-bin'
