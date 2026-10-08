#!/usr/bin/env bash

set -e

if [ -f "${TARGET_HOSTNAME}.iso" ]
then
    rm --force "${TARGET_HOSTNAME}.iso"
fi

docker run \
    --rm \
    --volume "${PWD}:/pwd" \
    --workdir /pwd \
    quay.io/coreos/coreos-installer:release \
        iso customize \
            --dest-device "${TARGET_DEVICE}" \
            --dest-ignition "${TARGET_HOSTNAME}.json" \
            --output "${TARGET_HOSTNAME}.iso" \
            "${COREOS_ISO_FILE}"
