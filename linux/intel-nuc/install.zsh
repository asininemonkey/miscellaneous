#!/usr/bin/env zsh

archinstall \
    --config 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/intel-nuc/config.json' \
    --creds 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/creds.json' \
    --silent \
    --skip-version-check
