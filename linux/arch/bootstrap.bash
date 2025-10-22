#!/usr/bin/env bash

set -ex

cat << EOF > /etc/vconsole.conf
FONT=default8x16
KEYMAP=uk
XKBLAYOUT=gb
XKBMODEL=pc105
XKBOPTIONS=terminate:ctrl_alt_bksp
EOF

sed --in-place 's/ALL=(ALL)/ALL=(ALL) NOPASSWD:/' /etc/sudoers.d/00_jcardoso

sudo --user jcardoso chezmoi init asininemonkey --apply

sed --in-place 's/NOPASSWD: //' /etc/sudoers.d/00_jcardoso
