#!/usr/bin/env bash

SERVER="smb://192.168.144.200"

cat << EOF > "${HOME}/.kodi/userdata/sources.xml"
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
