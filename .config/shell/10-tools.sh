#!/usr/bin/env bash
# 10-tools.sh -- configuration that individual tools read from the environment.
# Omarchy already sets MANPAGER (bat) and BAT_THEME.

if [ -r "$HOME/.config/ripgrep/rc" ]; then
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --info=inline'

export PAGER=less

# zoxide reads its settings from the environment (it has no config file).
export _ZO_RESOLVE_SYMLINKS=1
export _ZO_EXCLUDE_DIRS="$HOME:*/.git:*/.git/*:*/node_modules:*/node_modules/*:*/.venv:*/.venv/*:*/target:*/target/*:/tmp:/tmp/*:/mnt:/mnt/*"
