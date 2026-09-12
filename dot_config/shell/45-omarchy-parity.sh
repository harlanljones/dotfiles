#!/usr/bin/env bash
# 45-omarchy-parity.sh -- the portable half of Omarchy's base alias layer.
#
# On Linux, ~/.bashrc sources "$OMARCHY_PATH/default/bash/rc" before these
# modules, so bash there already has `cd`->`zd`, the git shortcuts and the fzf
# pickers. Nothing sources that rc on macOS, and nothing sources it for zsh on
# either machine, so outside Linux bash those aliases simply never existed.
# This module supplies the portable ones.
#
# The guard is `zd` itself rather than $OMARCHY_PATH: aliases and functions are
# not inherited by child shells but exported variables are, so a zsh started
# from Linux bash would see the variable, skip, and end up with no `cd`.
#
# Deliberately not ported from Omarchy's `aliases`:
#   open()   wraps xdg-open and would shadow macOS's native `open`.
#   sff()    uses GNU `find -printf`; BSD find has no such flag.
#   ff       Omarchy's kitty branch previews images via `kitty icat`. Only the
#            bat branch is reproduced, so this module never regresses kitty.
#   d h a ic ix icx  docker, herdr, omarchy-agent and tdl are not installed
#            here. Guard and add them alongside `r`/`t` when they are.
#
# `cx`, `n`, `ls`/`lsa`/`lt`/`lta` and `..` are owned by 40-aliases.sh, whose
# versions deliberately differ from Omarchy's. They are not repeated here.

if ! command -v zd >/dev/null 2>&1; then
  # zoxide-backed cd: an existing directory is a plain cd, anything else is a
  # frecency jump. Matches Omarchy's behaviour, including the jump's output.
  if command -v zoxide >/dev/null 2>&1; then
    zd() {
      if [ "$#" -eq 0 ]; then
        builtin cd ~ || return
      elif [ -d "$1" ]; then
        builtin cd "$1" || return
      else
        if ! z "$@"; then
          echo "Error: Directory not found"
          return 1
        fi
        printf '\xf3\xb1\x9e\xa9 '
        pwd
      fi
    }
    alias cd='zd'
  fi

  if command -v fzf >/dev/null 2>&1 && command -v bat >/dev/null 2>&1; then
    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
    # Single-quoted so $EDITOR and the picker both resolve at call time.
    alias eff='$EDITOR "$(ff)"'
  fi

  alias g='git'
  alias gcm='git commit -m'
  alias gcam='git commit -a -m'
  alias gcad='git commit -a --amend'

  command -v rails    >/dev/null 2>&1 && alias r='rails'
  command -v tmux     >/dev/null 2>&1 && alias t='tmux attach || tmux new -s Work'
  command -v opencode >/dev/null 2>&1 && alias c='opencode --auto'
  command -v mise     >/dev/null 2>&1 && alias mup='MISE_MINIMUM_RELEASE_AGE=0 mise up'
fi
