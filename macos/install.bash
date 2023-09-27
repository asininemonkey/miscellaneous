#!/bin/bash

set -ex

TARGET='/Volumes/Macintosh HD' # Post Installation Location: '/System/Volumes/Data/Previous Content'

if curl --connect-timeout 5 --fail --head --location --output '/dev/null' --silent 'http://192.168.144.200/macos/InstallAssistant-13.6.0.pkg'
then
  curl --location --output "${TARGET}/InstallAssistant.pkg" 'http://192.168.144.200/macos/InstallAssistant-13.6.0.pkg'
else
  curl --location --output "${TARGET}/InstallAssistant.pkg" 'https://swcdn.apple.com/content/downloads/28/01/042-55926-A_7GZJNO2M4I/asqcyheggme9rflzb3z3pr6vbp0gxyk2eh/InstallAssistant.pkg' # macOS v13.6.0
fi

pkgutil --check-signature "${TARGET}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET}/InstallAssistant.pkg" "${TARGET}/InstallAssistant"

mv "${TARGET}/InstallAssistant/Payload/Applications" "${TARGET}/"

mkdir "${TARGET}/Applications/Install macOS Ventura.app/Contents/SharedSupport"

mv "${TARGET}/InstallAssistant.pkg" "${TARGET}/Applications/Install macOS Ventura.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET}/InstallAssistant"

"${TARGET}/Applications/Install macOS Ventura.app/Contents/MacOS/InstallAssistant_springboard"
