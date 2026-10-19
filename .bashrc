# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# Personal configuration lives in ~/.config/shell/*.sh (see its README).
for _shell_module in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/*.sh; do
  [ -r "$_shell_module" ] && source "$_shell_module"
done
unset _shell_module

# Added by codebase-memory-mcp install
export PATH="/home/harlan/.local/bin:$PATH"
