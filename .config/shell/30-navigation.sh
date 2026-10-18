#!/usr/bin/env bash
# 30-navigation.sh -- zoxide pickers.
#
# `z` / `zi` come from Omarchy's `zoxide init`.
# `zj`: scored interactive jump (shows the frecency score).
# `zp`: paths-only interactive jump.

zj() {
  if command -v zoxide >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
    local line
    line=$(zoxide query -ls -- "$@" | fzf --height=40% --layout=reverse \
           --border --info=inline --prompt='z❯ ' --nth=2.. --accept-nth=2..)
    [ -n "$line" ] && cd "$line" || return
  else
    z "$@"
  fi
}

# shellcheck disable=SC2120  # called with a query by hand, and bare from the key binding.
zp() {
  if command -v zoxide >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
    local line
    line=$(zoxide query -l -- "$@" | fzf --height=40% --layout=reverse \
           --border --info=inline --prompt='z❯ ')
    [ -n "$line" ] && cd "$line" || return
  else
    z "$@"
  fi
}

# Alt-Z: paths-only jump. Alt-X: scored jump.
bind -x '"\ez": zp'
bind -x '"\ex": zj'
complete -F _zoxide zj 2>/dev/null || true
