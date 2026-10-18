#!/usr/bin/env bash
# 80-local.sh -- source the untracked ~/.config/shell/local.sh last, so
# machine-local or private settings override everything above without
# touching tracked files.

# shellcheck disable=SC1090  # the file is user-supplied
_local_shell_conf="${XDG_CONFIG_HOME:-$HOME/.config}/shell/local.sh"
[ -r "$_local_shell_conf" ] && source "$_local_shell_conf"
unset _local_shell_conf
