#!/usr/bin/env bash

set -x

KODI="${HOME}/.kodi"
MOUNT="/mnt/openmediavault"
SERVER="192.168.144.205"

systemctl stop mediacenter.service

sudo apt-get install --yes autofs

echo '/- /etc/auto.nfs --timeout 5 browse' | sudo tee /etc/auto.master.d/nfs.autofs

cat << EOF | sudo tee /etc/auto.nfs
${MOUNT}/media/movies     ${SERVER}:/data/media/movies
${MOUNT}/media/television ${SERVER}:/data/media/television
${MOUNT}/rips/movies      ${SERVER}:/data/rips/movies
${MOUNT}/rips/television  ${SERVER}:/data/rips/television
EOF

rm --force --recursive "${KODI}"

mkdir --parents "${KODI}/userdata"

cat << EOF > "${KODI}/userdata/guisettings.xml"
<settings version="2">
    <setting id="audiooutput.dtshdpassthrough">false</setting> <!-- Unsupported on LG CX OLED -->
    <setting id="audiooutput.dtspassthrough">false</setting> <!-- Unsupported on LG CX OLED -->
    <setting id="audiooutput.eac3passthrough">true</setting>
    <setting id="audiooutput.guisoundmode">0</setting>
    <setting id="audiooutput.passthrough">true</setting>
    <setting id="audiooutput.truehdpassthrough">false</setting> <!-- Unsupported on LG CX OLED -->
    <setting id="bluray.playerregion">2</setting>
    <setting id="locale.country">UK (12h)</setting>
    <setting id="powermanagement.displaysoff">15</setting>
    <setting id="screensaver.time">1</setting>
    <setting id="videolibrary.updateonstartup">true</setting>
    <setting id="videoplayer.autoplaynextitem">false</setting>
</settings>
EOF

cat << EOF > "${KODI}/userdata/sources.xml"
<sources>
    <video>
        <default pathversion="1"></default>
        <source>
            <name>movies</name>
            <path pathversion="1">${MOUNT}/media/movies/</path>
            <path pathversion="1">${MOUNT}/rips/movies/</path>
            <allowsharing>false</allowsharing>
        </source>
        <source>
            <name>television</name>
            <path pathversion="1">${MOUNT}/media/television/</path>
            <path pathversion="1">${MOUNT}/rips/television/</path>
            <allowsharing>false</allowsharing>
        </source>
    </video>
</sources>
EOF

systemctl start mediacenter.service

sleep 10

sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (1,'${MOUNT}/media/movies/','movies','metadata.themoviedb.org.python',NULL,2147483647,1,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (2,'${MOUNT}/rips/movies/','movies','metadata.themoviedb.org.python',NULL,2147483647,1,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (3,'${MOUNT}/media/television/','tvshows','metadata.tvshows.themoviedb.org.python',NULL,0,0,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (4,'${MOUNT}/rips/television/','tvshows','metadata.tvshows.themoviedb.org.python',NULL,0,0,NULL,0,0,0,NULL,NULL);"

kodi-send --action "UpdateLibrary(video)"
