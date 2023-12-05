#!/usr/bin/env bash

KODI="${HOME}/.kodi"
SERVER="smb://192.168.144.200"

systemctl stop mediacenter.service

rm --force --recursive "${KODI}"

mkdir --parents "${KODI}/userdata"

cat << EOF > "${KODI}/userdata/guisettings.xml"
<settings version="2">
    <setting id="audiooutput.guisoundmode">0</setting>
    <setting id="locale.country">UK (12h)</setting>
    <setting id="powermanagement.displaysoff">15</setting>
    <setting id="screensaver.time">1</setting>
</settings>
EOF

cat << EOF > "${KODI}/userdata/sources.xml"
<sources>
    <files>
        <default pathversion="1"></default>
    </files>
    <games>
        <default pathversion="1"></default>
    </games>
    <music>
        <default pathversion="1"></default>
    </music>
    <pictures>
        <default pathversion="1"></default>
    </pictures>
    <programs>
        <default pathversion="1"></default>
    </programs>
    <video>
        <default pathversion="1"></default>
        <source>
            <name>media - movies</name>
            <path pathversion="1">${SERVER}/media/movies/</path>
            <allowsharing>false</allowsharing>
        </source>
        <source>
            <name>media - television</name>
            <path pathversion="1">${SERVER}/media/television/</path>
            <allowsharing>false</allowsharing>
        </source>
        <source>
            <name>rips - movies</name>
            <path pathversion="1">${SERVER}/rips/movies/</path>
            <allowsharing>false</allowsharing>
        </source>
        <source>
            <name>rips - television</name>
            <path pathversion="1">${SERVER}/rips/television/</path>
            <allowsharing>false</allowsharing>
        </source>
    </video>
</sources>
EOF

systemctl start mediacenter.service
