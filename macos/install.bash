#!/bin/bash

set -ex

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
    'https://swcdn.apple.com/content/downloads/00/11/052-69919-A_USBF3SRH1R/doynj295laqw3fo9i3fmhlljb0prsmzw0y/InstallAssistant.pkg' # macOS v14.6.0 - https://mrmacintosh.com/macos-sonoma-full-installer-database-download-directly-from-apple/

  curl \
    --location \
    --output "${TARGET_FOLDER}/InstallAssistant.pkg.integrityDataV1" \
    'https://swcdn.apple.com/content/downloads/00/11/052-69919-A_USBF3SRH1R/doynj295laqw3fo9i3fmhlljb0prsmzw0y/InstallAssistant.pkg.integrityDataV1'
fi

pkgutil --check-signature "${TARGET_FOLDER}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant"

mv "${TARGET_FOLDER}/InstallAssistant/Payload/Applications" "${TARGET_FOLDER}/"

mkdir "${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/SharedSupport"

mv "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET_FOLDER}/InstallAssistant"

"${TARGET_FOLDER}/Applications/Install macOS Sonoma.app/Contents/MacOS/InstallAssistant_springboard"
