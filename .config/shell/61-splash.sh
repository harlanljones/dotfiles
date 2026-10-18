#!/usr/bin/env bash
# 61-splash.sh -- the Diocletian fastfetch banner on every interactive shell.
# Runs after 60-prompt.sh, so it prints before Starship draws the first prompt.

[[ $- == *i* ]] || return 0
command -v fastfetch >/dev/null 2>&1 || return 0
fastfetch

# `clear` wipes the banner; redraw it afterwards. Only the typed command is
# wrapped (Ctrl+L still just clears), and arguments pass through.
clear() {
  command clear "$@" || return
  fastfetch
}
