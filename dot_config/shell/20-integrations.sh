#!/usr/bin/env bash
# 20-integrations.sh -- shell hooks for the modern CLI tools.
#
# Each is guarded on the binary being present so a missing tool never breaks
# the shell, and each takes the shell name from SHELL_KIND rather than being
# written out twice.

# Completion system. Nothing else initializes it, and it has to happen here:
# 30-navigation.sh calls `compdef _zoxide zj`, which is a hard error unless
# compinit has already run. It went unnoticed on Augustus because the login
# shell there is bash and Omarchy's base rc owns compinit; Hadrian runs zsh, so
# the module ordering is what makes the binding work.
#
# globdots makes completion offer dotfiles without typing the leading dot --
# most of the point of completion when the files you edit are dotfiles.
if [ "$SHELL_KIND" = zsh ]; then
  _zsh_compdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
  mkdir -p "${_zsh_compdump%/*}"
  autoload -Uz compinit
  compinit -d "$_zsh_compdump"
  unset _zsh_compdump
  _comp_options+=(globdots)
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
