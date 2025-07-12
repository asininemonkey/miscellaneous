#!/bin/bash

set -ex

# https://mrmacintosh.com/macos-sequoia-full-installer-database-download-directly-from-apple/
INSTALL_URL='https://swcdn.apple.com/content/downloads/51/28/082-44432-A_4NJSZXK8G5/v10fo5dlwd50fja3qbnhj7z9tp1dx41vq2/InstallAssistant.pkg' # macOS v15.5.0
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
