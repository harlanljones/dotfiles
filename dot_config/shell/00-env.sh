#!/usr/bin/env bash
# 00-env.sh -- shell-agnostic environment: shell detection, PATH, editor.
#
# Sourced by both ~/.bashrc and ~/.zshrc through the loader at the bottom of
# each. Runs first, so every later module can rely on SHELL_KIND being set and
# on _path_prepend existing.

# Which shell is sourcing us. Detected here rather than set by the rc files so
# that a module still behaves correctly when sourced directly for testing.
# shellcheck disable=SC2034  # read by every later module in this directory.
if [ -n "${ZSH_VERSION:-}" ]; then
  SHELL_KIND="zsh"
elif [ -n "${BASH_VERSION:-}" ]; then
  SHELL_KIND="bash"
else
  SHELL_KIND="sh"
fi

# Prepend to PATH only when the entry is not already present.
#
# The pre-split rc files prepended ~/.local/bin three separate times in
# .bashrc and a fourth in .bash_profile: once deliberately, then again by the
# Antigravity installer and the Codex installer, each appending its own copy.
# A login shell carried four duplicates of the same directory.
_path_prepend() {
  case ":${PATH}:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac
}

_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/.cache/.bun/bin"
export PATH

# Both shells now agree on the editor. This is the one deliberate behaviour
# change in the split: the pre-split .zshrc set it and .bashrc did not, leaving
# it to Omarchy's base rc on Linux.
export EDITOR=nvim
export VISUAL="$EDITOR"
