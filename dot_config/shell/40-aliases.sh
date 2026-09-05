#!/usr/bin/env bash
# 40-aliases.sh -- aliases and the small functions that behave like them.

# Listing. On Linux these override the equivalents from Omarchy's base rc with
# the same eza invocations, so both machines list identically.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Coding-agent launchers.
alias codex="codex --approve-for-me"
alias oc="opencode"
alias cursor="agent"

# `n` with no argument opens the current directory in nvim.
n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}
