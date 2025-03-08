#!/usr/bin/env zsh

mkdir --parents /etc/sddm.conf.d

cat << 'EOF' > /etc/sddm.conf.d/theme.conf
[Theme]
Current=breeze
EOF

cat << 'EOF' > /etc/sddm.conf.d/wayland.conf
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell

[Wayland]
CompositorCommand=kwin_wayland --drm --locale1 --no-global-shortcuts --no-lockscreen
EOF

cat << 'EOF' > /home/jcardoso/.config/kwinoutputconfig.json
[
    {
        "data": [
            {
                "allowSdrSoftwareBrightness": false,
                "autoRotation": "InTabletMode",
                "brightness": 1,
                "colorPowerTradeoff": "PreferEfficiency",
                "colorProfileSource": "sRGB",
                "connectorName": "DP-1",
                "edidHash": "6b85735fd37b4c0b998eb5e9ed61e9de",
                "edidIdentifier": "DEL 41444 809782867 16 2022 0",
                "highDynamicRange": true,
                "iccProfilePath": "",
                "mode": {
                    "height": 1440,
                    "refreshRate": 174963,
                    "width": 3440
                },
                "overscan": 0,
                "rgbRange": "Automatic",
                "scale": 1.25,
                "sdrBrightness": 250,
                "sdrGamutWideness": 0,
                "transform": "Normal",
                "vrrPolicy": "Automatic",
                "wideColorGamut": true
            }
        ],
        "name": "outputs"
    },
    {
        "data": [
            {
                "lidClosed": false,
                "outputs": [
                    {
                        "enabled": true,
                        "outputIndex": 0,
                        "position": {
                            "x": 0,
                            "y": 0
                        },
                        "priority": 0
                    }
                ]
            }
        ],
        "name": "setups"
    }
]
EOF
