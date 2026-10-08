#!/usr/bin/env bash

set -e

COREOS_BUILDS="$(curl --location --silent 'https://builds.coreos.fedoraproject.org/streams/stable.json')"

COREOS_ISO_LOCATION="$(echo ${COREOS_BUILDS} | jq --raw-output '.architectures.x86_64.artifacts.metal.formats.iso.disk.location')"
COREOS_ISO_SHA256="$(echo ${COREOS_BUILDS} | jq --raw-output '.architectures.x86_64.artifacts.metal.formats.iso.disk.sha256')"

COREOS_ISO_FILE="${COREOS_ISO_LOCATION##*/}"

curl --location --output "${COREOS_ISO_FILE}" --remove-on-error --skip-existing "${COREOS_ISO_LOCATION}"

echo "${COREOS_ISO_SHA256} *${COREOS_ISO_FILE}" | sha256sum --check
