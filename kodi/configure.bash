#!/usr/bin/env bash

set -x

KODI="${HOME}/.kodi"
SERVER="smb://192.168.144.200"

systemctl stop mediacenter.service

rm --force --recursive "${KODI}"

mkdir --parents "${KODI}/userdata"

cat << EOF > "${KODI}/userdata/guisettings.xml"
<settings version="2">
    <setting id="audiooutput.dtshdpassthrough">true</setting>
    <setting id="audiooutput.dtspassthrough">true</setting>
    <setting id="audiooutput.eac3passthrough">true</setting>
    <setting id="audiooutput.guisoundmode">0</setting>
    <setting id="audiooutput.passthrough">true</setting>
    <setting id="audiooutput.truehdpassthrough">true</setting>
    <setting id="bluray.playerregion">2</setting>
    <setting id="locale.country">UK (12h)</setting>
    <setting id="powermanagement.displaysoff">15</setting>
    <setting id="screensaver.time">1</setting>
    <setting id="videolibrary.updateonstartup">true</setting>
    <setting id="videoplayer.autoplaynextitem">false</setting>
</settings>
EOF

cat << EOF > "${KODI}/userdata/mediasources.xml"
<mediasources>
    <network>
        <location id="0">${SERVER}</location>
    </network>
</mediasources>
EOF

cat << EOF > "${KODI}/userdata/sources.xml"
<sources>
    <video>
        <default pathversion="1"></default>
        <source>
            <name>movies</name>
            <path pathversion="1">${SERVER}/media/movies/</path>
            <path pathversion="1">${SERVER}/rips/movies/</path>
            <allowsharing>false</allowsharing>
        </source>
        <source>
            <name>television</name>
            <path pathversion="1">${SERVER}/media/television/</path>
            <path pathversion="1">${SERVER}/rips/television/</path>
            <allowsharing>false</allowsharing>
        </source>
    </video>
</sources>
EOF

systemctl start mediacenter.service

sleep 10

sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (1,'${SERVER}/media/movies/','movies','metadata.themoviedb.org.python',NULL,2147483647,1,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (2,'${SERVER}/rips/movies/','movies','metadata.themoviedb.org.python',NULL,2147483647,1,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (3,'${SERVER}/media/television/','tvshows','metadata.tvshows.themoviedb.org.python',NULL,0,0,NULL,0,0,0,NULL,NULL);"
sqlite3 "${KODI}/userdata/Database/MyVideos121.db" "INSERT INTO 'path' VALUES (4,'${SERVER}/rips/television/','tvshows','metadata.tvshows.themoviedb.org.python',NULL,0,0,NULL,0,0,0,NULL,NULL);"

kodi-send --action "UpdateLibrary(video)"
