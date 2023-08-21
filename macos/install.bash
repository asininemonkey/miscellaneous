#!/bin/bash

set -ex

TARGET='/Volumes/Macintosh HD' # Post Installation Location: '/System/Volumes/Data/Previous Content'

if curl --connect-timeout 5 --fail --head --location --output '/dev/null' --silent 'http://192.168.144.200/macos/InstallAssistant-13.5.1.pkg'
then
  curl --location --output "${TARGET}/InstallAssistant.pkg" 'http://192.168.144.200/macos/InstallAssistant-13.5.1.pkg'
else
  curl --location --output "${TARGET}/InstallAssistant.pkg" 'https://swcdn.apple.com/content/downloads/25/45/042-25643-A_KS23W0LI3U/f93qd41yyv7b4a4jmubqoiq89ldcpl6bbp/InstallAssistant.pkg' # macOS v13.5.1
fi

pkgutil --check-signature "${TARGET}/InstallAssistant.pkg"

pkgutil --expand-full "${TARGET}/InstallAssistant.pkg" "${TARGET}/InstallAssistant"

mv "${TARGET}/InstallAssistant/Payload/Applications" "${TARGET}/"

mkdir "${TARGET}/Applications/Install macOS Ventura.app/Contents/SharedSupport"

mv "${TARGET}/InstallAssistant.pkg" "${TARGET}/Applications/Install macOS Ventura.app/Contents/SharedSupport/SharedSupport.dmg"

rm -fr "${TARGET}/InstallAssistant"

"${TARGET}/Applications/Install macOS Ventura.app/Contents/MacOS/InstallAssistant_springboard"
