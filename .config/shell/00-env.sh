#!/usr/bin/env bash
# 00-env.sh -- editor. Runs first; Omarchy's envs already put ~/.local/bin on
# PATH and mise activation handles tool paths.

export EDITOR=nvim
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"
