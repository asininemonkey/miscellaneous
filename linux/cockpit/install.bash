#!/usr/bin/env bash

nvme format --force --ses 1 /dev/nvme0n1

archinstall \
    --config 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/cockpit/user_configuration.json' \
    --creds 'https://raw.githubusercontent.com/asininemonkey/miscellaneous/main/linux/cockpit/user_credentials.json' \
    --silent
