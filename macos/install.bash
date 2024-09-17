#!/bin/bash

set -ex

# https://mrmacintosh.com/macos-sequoia-full-installer-database-download-directly-from-apple/
INSTALL_URL='https://swcdn.apple.com/content/downloads/11/43/062-78429-A_DAI7Y9IP98/qxbabjzemiel7guag7q09xxe0631iie45p/InstallAssistant.pkg' # macOS v15.0.0

SOURCE_FOLDER='/Volumes/Installer'
TARGET_FOLDER='/Volumes/Macintosh HD' # Post Installation Location: '/System/Volumes/Data/Previous Content'

if [ -f "${SOURCE_FOLDER}/InstallAssistant.pkg" ]
then
  echo "Using Local Installer Package..."

  cp -v "${SOURCE_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant.pkg"
else
  echo "Using Remote Installer Package..."

  curl \
    --location \
    --output "${TARGET_FOLDER}/InstallAssistant.pkg" \
    "${INSTALL_URL}"

  curl \
    --location \
    --output "${TARGET_FOLDER}/InstallAssistant.pkg.integrityDataV1" \
    "${INSTALL_URL}.integrityDataV1"
fi

pkgutil --check-signature "${TARGET_FOLDER}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant"

mv "${TARGET_FOLDER}/InstallAssistant/Payload/Applications" "${TARGET_FOLDER}/"

mkdir "${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/SharedSupport"

mv "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET_FOLDER}/InstallAssistant"

"${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/MacOS/InstallAssistant_springboard"
