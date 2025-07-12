#!/bin/bash

set -ex

# https://mrmacintosh.com/macos-sequoia-full-installer-database-download-directly-from-apple/
INSTALL_URL='https://swcdn.apple.com/content/downloads/39/51/072-70706-A_Q2E9RWYCSD/oddej58reimcphudve8mgtxmcjjp0t3cve/InstallAssistant.pkg' # macOS v15.3.1
RELEASE_NAME='Sequoia'

SOURCE_FOLDER='/Volumes/Installer'
TARGET_FOLDER='/Volumes/Macintosh HD' # Post Installation Location: '/System/Volumes/Data/Previous Content'

if [ -f "${SOURCE_FOLDER}/InstallAssistant.pkg" ]
then
  echo "Using Local Installer Package..."

  cp -v "${SOURCE_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant.pkg"
else
  echo "Using Remote Installer Package..."

  curl \
    --continue-at - \
    --location \
    --output "${TARGET_FOLDER}/InstallAssistant.pkg" \
    "${INSTALL_URL}"

  curl \
    --continue-at - \
    --location \
    --output "${TARGET_FOLDER}/InstallAssistant.pkg.integrityDataV1" \
    "${INSTALL_URL}.integrityDataV1"
fi

pkgutil --check-signature "${TARGET_FOLDER}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant"

mv "${TARGET_FOLDER}/InstallAssistant/Payload/Applications" "${TARGET_FOLDER}/"

mkdir "${TARGET_FOLDER}/Applications/Install macOS ${RELEASE_NAME}.app/Contents/SharedSupport"

mv "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/Applications/Install macOS ${RELEASE_NAME}.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET_FOLDER}/InstallAssistant"

"${TARGET_FOLDER}/Applications/Install macOS ${RELEASE_NAME}.app/Contents/MacOS/InstallAssistant_springboard"
