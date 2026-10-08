#!/usr/bin/env bash

set -e

TARGET_DEVICE="/dev/nvme0n1"
TARGET_HOSTNAME="dreamquest"

source coreos-butane.bash
source coreos-iso-download.bash
source coreos-iso-customize.bash
