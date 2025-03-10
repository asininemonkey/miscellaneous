#!/usr/bin/env zsh

setfont ter-v24n

partprobe --summary

archinstall \
    --config 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/arch/intel-nuc/config.json' \
    --creds 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/arch/creds.json' \
    --silent \
    --skip-version-check
