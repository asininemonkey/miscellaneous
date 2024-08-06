#!/usr/bin/env zsh

MODEL_NAME="$(system_profiler SPHardwareDataType | awk -F ': ' '/Model Name/ {print $2}')"

sudo scutil --set ComputerName "Jose Cardoso's ${MODEL_NAME}"
sudo scutil --set HostName "jose-cardoso-$(echo "${MODEL_NAME}" | awk '{print tolower($0)}' | sed 's/ /-/')"
sudo scutil --set LocalHostName "jose-cardoso-$(echo "${MODEL_NAME}" | awk '{print tolower($0)}' | sed 's/ /-/')"

/usr/libexec/PlistBuddy "${HOME}/Library/Preferences/com.apple.Terminal.plist" -c 'Set ":SecureKeyboardEntry" true'

if ! grep --silent 'pam_tid.so' /etc/pam.d/sudo
then
  sudo sed -e '/^# sudo/a\'$'\n''auth       sufficient     pam_tid.so' -i '' /etc/pam.d/sudo
fi
