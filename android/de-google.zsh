#!/usr/bin/env zsh

FILE='app-arm64-v8a-release.apk'
REPO='imranr98/obtainium'

if [[ ! -f "${FILE}" ]]
then
    RELEASE="$(curl --location --silent "https://api.github.com/repos/${REPO}/releases" | jq -r 'map(select(.prerelease)) | first | .tag_name')"

    curl --location --remote-name "https://github.com/${REPO}/releases/download/${RELEASE}/${FILE}"

    echo -n "$(curl --location --silent "https://github.com/${REPO}/releases/download/${RELEASE}/${FILE}.sha1") ${FILE}" | sha1sum --check

    adb install "${FILE}"

    adb push 'obtainium-export.json' '/sdcard/Download/'
fi

# adb shell pm list packages | sort
for PACKAGE in \
    com.android.chrome \
    com.android.egg \
    com.android.stk \
    com.android.vending \
    com.google.ambient.streaming \
    com.google.android.apps.docs \
    com.google.android.apps.healthdata \
    com.google.android.apps.maps \
    com.google.android.apps.messaging \
    com.google.android.apps.nbu.files \
    com.google.android.apps.photos \
    com.google.android.apps.restore \
    com.google.android.apps.safetyhub \
    com.google.android.apps.tachyon \
    com.google.android.apps.turbo \
    com.google.android.apps.youtube.music \
    com.google.android.as.oss \
    com.google.android.calculator \
    com.google.android.calendar \
    com.google.android.contacts \
    com.google.android.deskclock \
    com.google.android.dialer \
    com.google.android.health.connect.backuprestore \
    com.google.android.healthconnect.controller \
    com.google.android.gm \
    com.google.android.googlequicksearchbox \
    com.google.android.ims \
    com.google.android.inputmethod.latin \
    com.google.android.keep \
    com.google.android.marvin.talkback \
    com.google.android.partnersetup \
    com.google.android.tts \
    com.google.android.videos \
    com.google.android.youtube \
    com.google.ar.core
do
    echo "Uninstalling ${PACKAGE} ..."
    adb shell pm uninstall --user 0 "${PACKAGE}"
    adb shell pm clear --user 0 "${PACKAGE}"
done
