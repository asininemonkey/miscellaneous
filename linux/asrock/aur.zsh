#!/usr/bin/env zsh

curl --location --output /tmp/paru.tar.zst https://github.com/morganamilo/paru/releases/download/v2.0.4/paru-v2.0.4-x86_64.tar.zst

tar --directory /tmp --extract --file /tmp/paru.tar.zst --zstd paru

su jcardoso --command '/tmp/paru --noconfirm --sync 1password paru sublime-merge'
