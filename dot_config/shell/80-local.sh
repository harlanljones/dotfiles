#!/usr/bin/env bash
# 80-local.sh -- sanctioned local-override loader (thoughtbot's dotfiles-local /
# holman's gitconfig.local pattern, adapted for this repo).
#
# Sources ~/.config/shell/local.sh when it exists. That file is deliberately
# NOT managed by chezmoi: it has no entry in the source tree, so `chezmoi apply`
# never creates, overwrites or deletes it -- chezmoi only touches files it
# manages. Put machine-local or personal shell configuration there instead of
# editing ~/.bashrc or ~/.zshrc, which are managed and clobbered on the next
# apply.
#
# 80 is the next free number after 75-tool-paths.sh, so local.sh is sourced
# last among the managed modules and its overrides win over everything the
# repo ships. Works under both shells; no SHELL_KIND guard is needed -- a
# plain source behaves identically in bash and zsh.

# shellcheck disable=SC1090  # the whole point: the file is user-supplied
_local_shell_conf="${XDG_CONFIG_HOME:-$HOME/.config}/shell/local.sh"
[ -r "$_local_shell_conf" ] && source "$_local_shell_conf"
unset _local_shell_conf
