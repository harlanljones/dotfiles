#!/usr/bin/env bash
# 20-integrations.sh -- shell hooks for the modern CLI tools.
#
# Each is guarded on the binary being present so a missing tool never breaks
# the shell, and each takes the shell name from SHELL_KIND rather than being
# written out twice.

# Initialize zsh completion before tools and navigation register completions.
if [ "$SHELL_KIND" = zsh ]; then
  autoload -Uz compinit
  compinit
fi

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init "$SHELL_KIND" --hook pwd)"
command -v atuin  >/dev/null 2>&1 && eval "$(atuin init "$SHELL_KIND")"
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook "$SHELL_KIND")"

# fzf is the one that cannot share a line: it prints bash init to stdout for
# `--bash`, but `--zsh` is meant to be sourced.
if command -v fzf >/dev/null 2>&1; then
  # shellcheck disable=SC1090  # fzf generates its zsh init at runtime; nothing to follow.
  case "$SHELL_KIND" in
    zsh) source <(fzf --zsh) ;;
    *) eval "$(fzf --bash)" ;;
  esac
fi

# mise stays zsh-only on purpose. The pre-split .bashrc never activated it --
# on Linux, Omarchy's base rc owns tool activation -- so activating it here for
# bash would be a behaviour change rather than a refactor.
if [ "$SHELL_KIND" = zsh ] && command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# 1Password CLI shell completion
if command -v op >/dev/null 2>&1; then
  eval "$(op completion "$SHELL_KIND")"
elif command -v op.exe >/dev/null 2>&1; then
  eval "$(op.exe completion "$SHELL_KIND")"
fi

# 1Password SSH Agent integration
if [ -n "${WSL_DISTRO_NAME:-}" ] || grep -qi microsoft /proc/version 2>/dev/null; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
  mkdir -p "$HOME/.1password"
  if [ -e "$SSH_AUTH_SOCK" ] && ! pgrep -x wsl-ssh-bridge >/dev/null 2>&1; then
    rm -f "$SSH_AUTH_SOCK"
  fi
  if ! pgrep -x wsl-ssh-bridge >/dev/null 2>&1 && command -v wsl-ssh-bridge >/dev/null 2>&1; then
    (wsl-ssh-bridge >/dev/null 2>&1 &)
  fi
elif [ "$(uname -s 2>/dev/null || echo '')" = "Darwin" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
elif [ -e "$HOME/.1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi

