#!/usr/bin/env bash
# 30-navigation.sh -- zoxide-aware directory jumping.
#
# `z` / `zi` come from `zoxide init` in 20-integrations.sh.
# `zj`: scored interactive jump (shows the frecency score from db.zo).
# `zp`: paths-only interactive jump (the `zi` feel from a key).
#
# The two functions were byte-identical in .bashrc and .zshrc before the split;
# only the key bindings genuinely differ, because zsh binds through zle.

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

# shellcheck disable=SC2120  # called with a query by hand, and bare from zp-widget.
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

# Alt-Z: paths-only jump.  Alt-X: scored jump.  (`cd` stays the builtin.)
if [ "$SHELL_KIND" = zsh ]; then
  zj-widget() {
    local d
    d=$(zoxide query -ls | fzf --height=40% --layout=reverse \
        --border --info=inline --prompt='z❯ ' --nth=2.. --accept-nth=2..)
    [ -n "$d" ] && cd "$d" && zle reset-prompt
  }
  zp-widget() { zle -I; zp; zle reset-prompt; }
  zle -N zj-widget
  zle -N zp-widget
  bindkey '\ez' zp-widget
  bindkey '\ex' zj-widget
  compdef _zoxide zj
else
  bind -x '"\ez": zp'
  bind -x '"\ex": zj'
  complete -F _zoxide zj
fi
