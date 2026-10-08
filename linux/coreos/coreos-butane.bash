#!/usr/bin/env bash

set -e

docker run \
    --rm \
    --volume "${PWD}:/pwd" \
    --workdir /pwd \
    quay.io/coreos/butane:release \
        --output "${TARGET_HOSTNAME}.json" \
        --pretty \
        --strict \
        "${TARGET_HOSTNAME}.yaml"
