#!/usr/bin/env bash
# 60-prompt.sh -- recolor the Starship prompt red after a failed command.
#
# Omarchy's base rc has already run `starship init bash`, so this only wraps
# the starship_precmd it left behind. Every foreground color in the prompt
# turns red when the previous command exited non-zero.

if declare -F starship_precmd >/dev/null 2>&1; then
  _starship_precmd_definition="$(declare -f starship_precmd)"
  eval "${_starship_precmd_definition/starship_precmd /starship_precmd_original }"
  unset _starship_precmd_definition

  starship_precmd() {
    starship_precmd_original
    local color_pattern rendered_style

    if (( ${STARSHIP_CMD_STATUS:-0} != 0 )); then
      color_pattern=$'\e''\[([0-9;]*)(30|32|33|34|35|36|37|90|92|93|94|95|96|97)m'

      while [[ $PS1 =~ $color_pattern ]]; do
        rendered_style=$'\e['"${BASH_REMATCH[1]}31m"
        PS1="${PS1/"${BASH_REMATCH[0]}"/"$rendered_style"}"
      done

      # Truecolor foregrounds (38;2;r;g;b) -> red, in one global sed pass so
      # the recolored red (255;102;92) can't re-match and loop.
      local tc_sed=$'s/\033\\[([0-9;]*)38;2;[0-9]+;[0-9]+;[0-9]+m/\033[\\138;2;255;102;92m/g'
      PS1=$(printf '%s' "$PS1" | sed -E "$tc_sed")
    fi
  }
fi
