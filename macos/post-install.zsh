#!/usr/bin/env zsh

MODEL_NAME="$(system_profiler SPHardwareDataType | awk -F ': ' '/Model Name/ {print $2}')"

sudo scutil --set ComputerName "Jose Cardoso's ${MODEL_NAME}"
sudo scutil --set HostName "jose-cardoso-$(echo "${MODEL_NAME}" | awk '{print tolower($0)}' | sed 's/ /-/')"
sudo scutil --set LocalHostName "jose-cardoso-$(echo "${MODEL_NAME}" | awk '{print tolower($0)}' | sed 's/ /-/')"

/usr/libexec/PlistBuddy "${HOME}/Library/Preferences/com.apple.Terminal.plist" -c 'Set ":SecureKeyboardEntry" true'

sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local

sudo sed 's/#auth/auth/' -i '' /etc/pam.d/sudo_local
