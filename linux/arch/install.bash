#!/usr/bin/env bash

LSPCI_OUTPUT=$(lspci)

curl \
  --location \
  --output /tmp/user_configuration.json \
  --silent \
  https://raw.githubusercontent.com/asininemonkey/miscellaneous/refs/heads/main/linux/arch/user_configuration.json

if grep --quiet 'NVIDIA' <<< ${LSPCI_OUTPUT}
then
  DISK=$(realpath /dev/disk/by-id/nvme-eui.6479a74c90201298)

  sed --in-place "s/xxx_disk_size_xxx/256/" /tmp/user_configuration.json
  sed --in-place 's/xxx_drivers_xxx/nvidia-open/' /tmp/user_configuration.json
  sed --in-place 's/xxx_hostname_xxx/asrock-x570-linux/' /tmp/user_configuration.json

  nvme format --force --ses 1 ${DISK}
fi

if grep --quiet 'VMware PCI' <<< ${LSPCI_OUTPUT}
then
  DISK=/dev/nvme0n1

  sed --in-place "s/xxx_disk_size_xxx/62/" /tmp/user_configuration.json
  sed --in-place 's/xxx_drivers_xxx/open-vm-tools/' /tmp/user_configuration.json
  sed --in-place 's/xxx_hostname_xxx/arch-linux-vm/' /tmp/user_configuration.json
fi

sed --in-place "s/xxx_disk_device_xxx/${DISK//\//\\\/}/" /tmp/user_configuration.json

partprobe --summary ${DISK}

archinstall \
  --config /tmp/user_configuration.json \
  --creds-url https://raw.githubusercontent.com/asininemonkey/miscellaneous/refs/heads/main/linux/arch/user_credentials.json \
  --silent
