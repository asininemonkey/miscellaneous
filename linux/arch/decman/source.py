# https://github.com/kiviktnm/decman/blob/main/example/source.py

import decman
import re
import subprocess

from decman import File

lscpu = subprocess.run(
    ["lscpu"],
    capture_output=True,
    check=True,
    text=True,
)

decman.aur_packages += ["decman"]

decman.enabled_systemd_units += [
    "docker.service",
    "sshd.service",
]

decman.files["/etc/vconsole.conf"] = File(
    owner="root", permissions=0o644, source_file="files/etc/vconsole.conf"
)

decman.ignored_packages += [
    "base",
    "base-devel",
    "efibootmgr",
    "grub",
    "linux",
    "linux-firmware",
    "networkmanager",
    "yay",
    "yay-debug",
    "zram-generator",
]

decman.packages += [
    "btop",
    "docker",
    "git",
    "openssh",
    "man-db",
    "paru",
    "wget",
]

if re.search("VMware", lscpu.stdout):
    decman.packages += [
        "open-vm-tools",
    ]
