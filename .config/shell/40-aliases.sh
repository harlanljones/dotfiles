#!/usr/bin/env bash
# 40-aliases.sh -- aliases and the small functions that behave like them.
# Omarchy's base rc already defines ls/lsa/lt/lta (eza), .., n, g, gcm, cx
# (Claude) and cy (Codex); these only add to them.

if command -v eza >/dev/null 2>&1; then
  alias ll='ls -a'
  alias la='ls -a'
  alias l='ls'
fi

# Coding agents.
alias codex='codex --approve-for-me'
alias cy='codex'  # Omarchy's cy already adds --approve-for-me; avoid doubling it
alias cr='codex -m gpt-reserve'
alias oc='opencode'

# Git and dotfiles.
alias gs='git status -sb'
alias gd='git diff --stat --patch'
alias gl='git log --oneline --decorate --graph -20'
alias gp='git pull --rebase'
alias ys='yadm status'
alias yd='yadm diff'
alias lg='lazygit'

# mise.
alias mi='mise install'
alias mr='mise run'

# Run a command with secrets from 1Password injected into its environment,
# without writing them to disk. Uses the first env file found.
opr() {
  if ! command -v op >/dev/null 2>&1; then
    echo "error: 1Password CLI not found in PATH" >&2
    return 1
  fi

  if [ -f .env.op ]; then
    op run --env-file=.env.op -- "$@"
  elif [ -f .env.template ]; then
    op run --env-file=.env.template -- "$@"
  elif [ -f .env ]; then
    op run --env-file=.env -- "$@"
  else
    op run -- "$@"
  fi
}
