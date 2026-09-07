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
alias cx="codex"
alias cr="codex -m gpt-reserve"
alias oc="opencode"
alias cursor="agent"

# Git and dotfile workflows.
alias gs='git status -sb'
alias gd='git diff --stat --patch'
alias gl='git log --oneline --decorate --graph -20'
alias gp='git pull --rebase'
alias ds='dots status'
alias dd='dots diff'
alias du='dots update'

# mise workflows.
alias mi='mise install'
alias mr='mise run'

alias lg="lazygit"

# Aliases managed by the Omarchy Alias Manager plugin (leoom.aliases)
[ -r "$HOME/.config/omarchy/aliases" ] && source "$HOME/.config/omarchy/aliases"

# `n` with no argument opens the current directory in nvim.
n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}
