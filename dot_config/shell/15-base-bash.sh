#!/usr/bin/env bash
# 15-base-bash.sh -- the bash base layer for Linux boxes without Omarchy.
#
# On Augustus, ~/.bashrc sources Omarchy's default/bash/rc before these modules
# and sets OMARCHY_BASE_LOADED. That rc owns history settings, completion, mise
# activation and `starship init bash`. Vespasian (Ubuntu under WSL) has no such
# rc, so this module supplies the parts later modules rely on -- in particular
# 60-prompt.sh's bash branch only wraps the precmd that `starship init bash`
# leaves behind, so without this the prompt would never be initialized.
#
# Not exported on purpose: every interactive bash re-runs ~/.bashrc, so a child
# shell decides for itself rather than inheriting the parent's answer.

if [ "$SHELL_KIND" = bash ] && [ -z "${OMARCHY_BASE_LOADED:-}" ]; then
  HISTCONTROL=ignoreboth
  HISTSIZE=32768
  HISTFILESIZE="$HISTSIZE"
  shopt -s histappend checkwinsize

  if ! shopt -oq posix && [ -r /usr/share/bash-completion/bash_completion ]; then
    # shellcheck disable=SC1091  # system file, not present in CI.
    . /usr/share/bash-completion/bash_completion
  fi

  # mise first: starship and the 20-integrations tools are mise-installed here.
  # if/fi (not `cmd && eval`) so a missing binary does not fail `source`.
  if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
  fi
  if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
  fi
fi
