# https://github.com/kiviktnm/decman/blob/main/example/source.py

import decman
import re
import subprocess

from decman import Directory, File

lscpu = subprocess.run(
    ["lscpu"],
    capture_output=True,
    check=True,
    text=True,
)

decman.aur_packages += [
    "decman",
    "paru-bin",
    "yay-bin",
]

decman.directories["/home/jcardoso/.config"] = Directory(
    owner="jcardoso", source_directory="files/home/.config"
)

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
    "yay-debug",
    "zram-generator",
]

# Miscellaneous
decman.packages += [
    "btop",
    "docker",
    "ghostty",
    "git",
    "man-db",
    "openssh",
    "wget",
]

# Niri
decman.packages += [
    "niri",
    "xwayland-satellite",
]

# Virtual Machine (VMware)
if re.search("VMware", lscpu.stdout):
    decman.enabled_systemd_units += [
        "vmtoolsd.service",
    ]

    decman.packages += [
        "open-vm-tools",
    ]
