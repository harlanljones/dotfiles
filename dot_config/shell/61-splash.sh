#!/usr/bin/env bash
# 61-splash.sh - Machine-identity splash on EVERY interactive shell (phase 7.12).
#
# Harlan's call: the banner shows whenever a terminal is opened — no
# once-per-window/per-boot gating (the marker machinery was removed after it
# misfired repeatedly; Ghostty exposes no window identity and herdr-spawned
# shells detach from the window process, so per-window keying was unreliable).
#
# Still skips: non-interactive shells. Runs after 60-prompt.sh so the banner
# prints during rc sourcing, before starship draws the first prompt.
#
# Cost: dots-identity is timeout-guarded internally (<1s worst case, ~0.3s
# typical including the project-context probe).

[[ $- == *i* ]] || return 0
command -v dots-identity >/dev/null 2>&1 || return 0
dots-identity 2>/dev/null

# `clear` wipes the banner; redraw it afterwards. Only the typed command is
# wrapped (Ctrl+L still just clears), and args pass through (e.g. `clear -x`).
clear() {
  command clear "$@" || return
  dots-identity 2>/dev/null
  return 0
}
return 0
