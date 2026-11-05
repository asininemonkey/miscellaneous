#!/usr/bin/env bash

sed --in-place 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on module_blacklist=i915 quiet xe.force_probe=0x46a8 xe.max_vfs=7"/' /etc/default/grub

sed 's/https:\/\/enterprise/http:\/\/download/; s/^Components:.*/Components: no-subscription/' /etc/apt/sources.list.d/ceph.sources > /etc/apt/sources.list.d/ceph-no-subscription.sources
sed 's/https:\/\/enterprise/http:\/\/download/; s/^Components:.*/Components: pve-no-subscription/' /etc/apt/sources.list.d/pve-enterprise.sources > /etc/apt/sources.list.d/pve-no-subscription.sources

echo 'Enabled: false' >> /etc/apt/sources.list.d/ceph.sources
echo 'Enabled: false' >> /etc/apt/sources.list.d/pve-enterprise.sources

apt update

apt --assume-yes full-upgrade

apt --assume-yes install driverctl i2c-tools intel-gpu-tools lm-sensors sysfsutils

echo 'devices/pci0000:00/0000:00:02.0/sriov_numvfs = 7' > /etc/sysfs.d/sriov_numvfs.conf

cat << 'EOT' > /etc/systemd/system/i2c-devices-ddr5.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/bin/bash -c '/usr/bin/echo spd5118 0x50 > /sys/bus/i2c/devices/$(i2cdetect -l | grep I801 | awk \'{print $1}\')/new_device'
ExecStart=/usr/bin/bash -c '/usr/bin/echo spd5118 0x52 > /sys/bus/i2c/devices/$(i2cdetect -l | grep I801 | awk \'{print $1}\')/new_device'
RemainAfterExit=yes
Type=oneshot

[Unit]
Description=i2c-devices-ddr5
EOT

cat << 'EOT' > /etc/systemd/system/override-vf-bindings.service
[Install]
WantedBy=multi-user.target

[Service]
ExecStart=/usr/sbin/modprobe vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.1 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.2 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.3 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.4 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.5 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.6 vfio-pci
ExecStart=/usr/sbin/driverctl set-override 0000:00:02.7 vfio-pci
RemainAfterExit=yes
Type=oneshot

[Unit]
Description=override-vf-bindings
EOT

systemctl enable i2c-devices-ddr5.service
systemctl enable override-vf-bindings.service
