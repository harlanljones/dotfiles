#!/usr/bin/env bash
# 40-aliases.sh -- aliases and the small functions that behave like them.

# Listing. On Linux these override the equivalents from Omarchy's base rc with
# the same eza invocations, so both machines list identically.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
  alias ll='ls -a'
  alias la='ls -a'
  alias l='ls'
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Coding-agent launchers.
alias codex="codex --approve-for-me"
alias cx="codex"
alias cr="codex -m gpt-reserve"
alias oc="opencode"
command -v agent >/dev/null 2>&1 && alias cursor="agent"

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

# 1Password CLI (WSL desktop integration)
command -v op.exe >/dev/null 2>&1 && alias op="op.exe"

# In-memory secret injection: runs commands with secrets from 1Password without disk files
opr() {
  local op_bin
  if command -v op.exe >/dev/null 2>&1; then
    op_bin="op.exe"
  elif command -v op >/dev/null 2>&1; then
    op_bin="op"
  else
    echo "error: 1Password CLI not found in PATH" >&2
    return 1
  fi

  if [ -f .env.op ]; then
    "$op_bin" run --env-file=.env.op -- "$@"
  elif [ -f .env.template ]; then
    "$op_bin" run --env-file=.env.template -- "$@"
  elif [ -f .env ]; then
    "$op_bin" run --env-file=.env -- "$@"
  else
    "$op_bin" run -- "$@"
  fi
}

# Aliases managed by the Omarchy Alias Manager plugin (leoom.aliases)
# shellcheck disable=SC1091  # omarchy-managed file
[ -r "$HOME/.config/omarchy/aliases" ] && source "$HOME/.config/omarchy/aliases"

# `n` with no argument opens the current directory in nvim.
n() {
  if [ "$#" -eq 0 ]; then
    nvim .
  else
    nvim "$@"
  fi
}
