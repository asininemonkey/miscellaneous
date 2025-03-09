#!/usr/bin/env zsh

mkdir --parents /home/jcardoso/.config/fastfetch /home/jcardoso/.config/ghostty

cat << 'EOF' > /home/jcardoso/.config/fastfetch/config.jsonc
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "display": {
    "separator": " "
  },
  "logo": {
    "height": 20,
    "source": "/etc/nixos/logo.png",
    "type": "kitty-direct",
    "width": 46
  },
  "modules": [
    {
      "key": "╭─ 󰌢 ",
      "keyColor": "red",
      "type": "host"
    },
    {
      "key": "├─ 󰻠 ",
      "keyColor": "red",
      "type": "cpu"
    },
    {
      "key": "├─ 󰍛 ",
      "keyColor": "red",
      "type": "gpu"
    },
    {
      "key": "├─ 󰍹 ",
      "keyColor": "red",
      "type": "display"
    },
    {
      "key": "├─  ",
      "keyColor": "red",
      "type": "disk"
    },
    {
      "key": "╰─ 󰑭 ",
      "keyColor": "red",
      "type": "memory"
    },
    "break",
    {
      "key": "╭─  ",
      "keyColor": "green",
      "type": "shell"
    },
    {
      "key": "├─  ",
      "keyColor": "green",
      "type": "terminal"
    },
    {
      "key": "├─  ",
      "keyColor": "green",
      "type": "de"
    },
    {
      "key": "├─  ",
      "keyColor": "green",
      "type": "wm"
    },
    {
      "key": "├─ 󰧨 ",
      "keyColor": "green",
      "type": "lm"
    },
    {
      "key": "├─ 󰉼 ",
      "keyColor": "green",
      "type": "theme"
    },
    {
      "key": "╰─ 󰀻 ",
      "keyColor": "green",
      "type": "icons"
    },
    "break",
    {
      "format": "{1}@{2}",
      "key": "╭─  ",
      "keyColor": "blue",
      "type": "title"
    },
    {
      "key": "├─  ",
      "keyColor": "blue",
      "type": "os"
    },
    {
      "format": "{1} {2}",
      "key": "├─  ",
      "keyColor": "blue",
      "type": "kernel"
    },
    {
      "key": "├─ 󰅐 ",
      "keyColor": "blue",
      "type": "uptime"
    },
    {
      "compact": true,
      "key": "╰─ 󰩟 ",
      "keyColor": "blue",
      "type": "localip"
    },
    "break"
  ]
}
EOF

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

cat << 'EOF' > /home/jcardoso/.zshrc
for ALIASES in "${HOME}/.zsh_aliases_"*
do
    source "${ALIASES}"
done

for ENVS in "${HOME}/.zsh_envs_"*
do
    source "${ENVS}"
done

autoload run-help
unalias run-help

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

unsetopt EXTENDED_HISTORY

zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

typeset -U cdpath fpath manpath path

# Oh My Posh
eval "$(oh-my-posh init zsh --config https://raw.githubusercontent.com/asininemonkey/miscellaneous/refs/heads/main/oh-my-posh-theme.json)"

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d ${ZINIT_HOME} ] && mkdir --parents "$(dirname ${ZINIT_HOME})"
[ ! -d ${ZINIT_HOME}/.git ] && git clone 'https://github.com/zdharma-continuum/zinit.git' "${ZINIT_HOME}"

source "${ZINIT_HOME}/zinit.zsh"

## Oh My Zsh Libraries
zinit snippet OMZL::history.zsh

## Oh My Zsh Plugins
zinit snippet OMZP::git
zinit snippet OMZP::kubectl

# Fastfetch
fastfetch
EOF

cat << 'EOF' > /home/jcardoso/.zsh_aliases_common
alias 'grpo'='git remote prune origin'
alias 'help'='run-help'
EOF

cat << 'EOF' > /home/jcardoso/.zsh_envs_common
HISTSIZE="10000"
SAVEHIST="10000"

export AWS_PAGER=""
export AWS_SDK_LOAD_CONFIG="true"
export EXA_ICON_SPACING="2"
export SSH_AUTH_SOCK="${HOME}/.1password/agent.sock"
EOF
