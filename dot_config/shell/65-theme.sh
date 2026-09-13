#!/usr/bin/env bash
# 65-theme.sh -- terminal-tool colors that can only come from the environment.
#
# Most themed tools read their own config file (bat, eza, lazygit, and delta
# through git config), so they need nothing here. fzf only reads
# FZF_DEFAULT_OPTS, so a machine that ships a palette in ~/.config/fzf/theme.sh
# gets it appended after 10-tools.sh has set the layout. Machines without that
# file (it is Vespasian-only today) are unaffected.

_fzf_theme="${XDG_CONFIG_HOME:-$HOME/.config}/fzf/theme.sh"
# shellcheck disable=SC1090  # machine-specific file, not present in CI.
[ -r "$_fzf_theme" ] && . "$_fzf_theme"
unset _fzf_theme
