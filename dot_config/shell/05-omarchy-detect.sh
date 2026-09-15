#!/usr/bin/env bash
# 05-omarchy-detect.sh -- resolve the Omarchy base layer and source its shell rc
# on machines that have it. Bash-only: the rc is a bash rc and zsh relies on its
# own integration, so this mirrors what ~/.bashrc used to do inline.
#
# Moved out of ~/.bashrc so the rc file is a pure loader (AGENTS.md §6). Runs
# early (before 15-base-bash.sh) so OMARCHY_BASE_LOADED is set when that module
# decides whether to supply the base layer itself.

if [ "$SHELL_KIND" = bash ]; then
  if [[ -f /etc/omarchy.conf ]]; then
    # shellcheck disable=SC1091  # system file, may not exist on all machines
    source /etc/omarchy.conf
    export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
  else
    export OMARCHY_PATH=/usr/share/omarchy
  fi
  # Guarded so Linux boxes without Omarchy (Vespasian, WSL) still get a working
  # shell; ~/.config/shell/15-base-bash.sh supplies the base layer there.
  if [[ -r "$OMARCHY_PATH/default/bash/rc" ]]; then
    # shellcheck disable=SC1091  # omarchy-managed file
    source "$OMARCHY_PATH/default/bash/rc"
    # shellcheck disable=SC2034  # consumed by 15-base-bash.sh in the same shell session.
    OMARCHY_BASE_LOADED=1
  fi
fi
