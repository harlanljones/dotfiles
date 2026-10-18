#!/usr/bin/env bash
# 65-theme.sh -- fzf colors from the current Omarchy theme. fzf only reads its
# colors from FZF_DEFAULT_OPTS, so the rendered file appends to what
# 10-tools.sh set.

_fzf_theme="$HOME/.local/state/omarchy/current/theme/fzf.sh"
# shellcheck disable=SC1090  # rendered at theme-set time
[ -r "$_fzf_theme" ] && . "$_fzf_theme"
unset _fzf_theme
