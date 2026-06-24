#!/usr/bin/env bash

echo -n mem > /sys/power/state

hdparm --user-master u --security-set-pass NULL "${1}"

hdparm --user-master u --security-erase-enhanced NULL "${1}"
