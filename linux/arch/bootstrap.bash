#!/usr/bin/env bash

set -ex

sed --in-place 's/ALL=(ALL)/ALL=(ALL) NOPASSWD:/' /etc/sudoers.d/00_jcardoso

# sudo --user jcardoso chezmoi init asininemonkey --apply

sed --in-place 's/NOPASSWD: //' /etc/sudoers.d/00_jcardoso
