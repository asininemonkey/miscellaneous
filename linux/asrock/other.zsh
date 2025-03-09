#!/usr/bin/env zsh

cat << 'EOF' > /home/jcardoso/.config/ghostty/config
# https://ghostty.org/docs/config/reference
app-notifications = no-clipboard-copy
background-opacity = 0.85
bold-is-bright = true
clipboard-paste-protection = true
copy-on-select = clipboard
cursor-style = block
cursor-style-blink = true
font-family = Iosevka Nerd Font
font-size = 14
keybind = ctrl+shift+k=clear_screen
theme = Builtin Tango Dark
window-height = 35
window-width = 155
EOF

cat << 'EOF' > /home/jcardoso/.local/share/user-places.xbel
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xbel>
<xbel>
 <bookmark href="davs://files.josecardoso.net/">
  <title>files.josecardoso.net</title>
  <info>
   <metadata owner="http://freedesktop.org">
    <bookmark:icon name="folder-yellow-network"/>
   </metadata>
  </info>
 </bookmark>
</xbel>
EOF

cat << 'EOF' > /home/jcardoso/.zshrc
eval "$(oh-my-posh init zsh)"
EOF
