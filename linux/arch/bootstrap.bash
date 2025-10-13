#!/usr/bin/env bash

set -ex

cat << EOF > /etc/greetd/config.toml
[default_session]
command = "cage -s -- regreet"
user = "greeter"

[terminal]
vt = 1
EOF

cat << EOF > /etc/ssh/ssh_known_hosts
github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
EOF

cat << EOF > /etc/vconsole.conf
FONT=default8x16
KEYMAP=uk
XKBLAYOUT=gb
XKBMODEL=pc105
XKBOPTIONS=terminate:ctrl_alt_bksp
EOF

# curl --location --silent https://github.com/Morganamilo/paru/releases/download/v2.1.0/paru-v2.1.0-$(uname --machine).tar.zst | tar --directory /tmp --extract --zstd paru
curl --location --silent https://github.com/Jguer/yay/releases/download/v12.5.2/yay_12.5.2_$(uname --machine).tar.gz | tar --directory /tmp --extract --gzip --no-anchored --strip-components 1 --wildcards yay

sed --in-place 's/ALL=(ALL)/ALL=(ALL) NOPASSWD:/' /etc/sudoers.d/00_jcardoso

sudo --user jcardoso /tmp/yay --noconfirm --sync paru-bin yay-bin

sudo --user jcardoso chezmoi init asininemonkey --apply

sed --in-place 's/NOPASSWD: //' /etc/sudoers.d/00_jcardoso

chown --recursive jcardoso:jcardoso /home/jcardoso

usermod --append --groups docker jcardoso
