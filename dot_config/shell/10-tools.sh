#!/usr/bin/env bash
# 10-tools.sh -- configuration that individual tools read from the environment.
#
# Pure exports, identical for every shell. This block was duplicated verbatim
# between .bashrc and .zshrc before the split.

export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height=40% --layout=reverse --border --info=inline'

export PAGER=less
command -v bat >/dev/null 2>&1 && export MANPAGER="sh -c 'col -bx | bat -l man -p'"
