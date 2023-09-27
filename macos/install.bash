#!/bin/bash

set -ex

SOURCE_FOLDER='/Volumes/Installer'
TARGET_FOLDER='/Volumes/Macintosh HD' # Post Installation Location: '/System/Volumes/Data/Previous Content'

if [ -f "${SOURCE_FOLDER}/InstallAssistant.pkg" ]
then
  cp -v "${SOURCE_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant.pkg"
else
  curl --location --output "${TARGET_FOLDER}/InstallAssistant.pkg" 'https://swcdn.apple.com/content/downloads/28/01/042-55926-A_7GZJNO2M4I/asqcyheggme9rflzb3z3pr6vbp0gxyk2eh/InstallAssistant.pkg' # macOS v13.6.0
fi

pkgutil --check-signature "${TARGET_FOLDER}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/InstallAssistant"

mv "${TARGET_FOLDER}/InstallAssistant/Payload/Applications" "${TARGET_FOLDER}/"

mkdir "${TARGET_FOLDER}/Applications/Install macOS Ventura.app/Contents/SharedSupport"

mv "${TARGET_FOLDER}/InstallAssistant.pkg" "${TARGET_FOLDER}/Applications/Install macOS Ventura.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET_FOLDER}/InstallAssistant"

"${TARGET_FOLDER}/Applications/Install macOS Ventura.app/Contents/MacOS/InstallAssistant_springboard"
