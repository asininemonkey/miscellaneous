#!/usr/bin/env zsh

partprobe --summary

archinstall \
    --config 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/asrock/config.json' \
    --creds 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/creds.json' \
    --silent \
    --skip-version-check
