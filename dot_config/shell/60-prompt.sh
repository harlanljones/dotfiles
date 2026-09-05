#!/usr/bin/env bash
# 60-prompt.sh -- Starship, and the recolor that turns the prompt red after a
# failed command.
#
# This is the one module that is deliberately NOT unified. The bash and zsh
# implementations differ in real semantics -- bash recolors every foreground
# color, zsh recolors cyan only -- and ROADMAP decision F1 in the showcase
# makes that divergence a feature it demonstrates via its shell toggle. Both
# implementations are kept here, verbatim, rather than reconciled.
#
# They also hook Starship differently: on Linux, Omarchy's base rc has already
# run `starship init bash`, so bash only wraps the precmd it left behind; zsh
# initializes Starship itself.
#
# The zsh branch is guarded on the binary, which the pre-split .zshrc was not:
# starship is installed by mise, so on a freshly bootstrapped machine the shell
# used to open with `command not found: starship` and no prompt wrapper. Every
# other tool in this directory is already guarded the same way; this was the
# one exception. Without starship, zsh keeps its default prompt.

if [ "$SHELL_KIND" = zsh ] && command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"

  # Match the Bash prompt behavior: keep successful prompts cyan and recolor
  # all Starship components red after a non-zero exit status.
  starship_status_prompt() {
    local rendered_prompt style_prefix old_style new_style
    local -a style_prefixes

    rendered_prompt="$(command starship prompt \
      --terminal-width="$COLUMNS" \
      --keymap="${KEYMAP:-}" \
      --status="${STARSHIP_CMD_STATUS:-}" \
      --pipestatus="${STARSHIP_PIPE_STATUS[*]:-}" \
      --cmd-duration="${STARSHIP_DURATION:-}" \
      --jobs="$STARSHIP_JOBS_COUNT")"

    if (( ${STARSHIP_CMD_STATUS:-0} != 0 )); then
      # Iterate as "${style_prefixes[@]}", never as a bare $style_prefixes.
      # zsh word-splits an unquoted array and drops empty elements, so the ""
      # prefix -- the unstyled `36m` and the unstyled truecolor sequence, which
      # are the most common ones -- was silently skipped. The pre-split .zshrc
      # had exactly that bug: after a failed command it recolored `1;36m` and
      # friends but left plain cyan cyan. shellcheck flagged it as SC2128 and
      # the first draft of this file waved it away as a zsh idiom.
      style_prefixes=("" "1;" "2;" "3;" "1;2;" "1;3;" "2;3;" "1;2;3;")

      for style_prefix in "${style_prefixes[@]}"; do
        old_style=$'%{\e['"${style_prefix}"$'36m%}'
        new_style=$'%{\e['"${style_prefix}"$'31m%}'
        rendered_prompt="${rendered_prompt//$old_style/$new_style}"
      done

      # TC-01 (HJ-431): truecolor cyan 38;2;46;222;250 -> red 38;2;255;102;92.
      # Mirror the 8-color loop; cyan-only (zsh semantics). The RGB is the
      # starship default palette cyan (#2EDEFA); if a custom hex palette is
      # adopted, update these literals to match the active palette.
      local tc_cyan="46;222;250"
      local tc_red="255;102;92"
      for style_prefix in "${style_prefixes[@]}"; do
        old_style=$'%{\e['"${style_prefix}"$'38;2;'"${tc_cyan}"$'m%}'
        new_style=$'%{\e['"${style_prefix}"$'38;2;'"${tc_red}"$'m%}'
        rendered_prompt="${rendered_prompt//$old_style/$new_style}"
      done
    fi

    print -rn -- "$rendered_prompt"
  }

  # shellcheck disable=SC2034  # PROMPT is zsh's prompt variable.
  PROMPT='$(starship_status_prompt)'

elif declare -F starship_precmd >/dev/null 2>&1; then
  # Recolor Starship's cyan prompt after failed commands. Starship exposes the
  # previous exit status to its character module, but not as a global style.
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

      # TC-01 (HJ-431): truecolor foreground 38;2;r;g;b -> palette red
      # (bash semantics: all-foreground -> red). Use a single global sed pass so
      # the recolored red (255;102;92) cannot re-match and loop. The RGB is the
      # starship default palette cyan (#2EDEFA); if a custom hex palette is
      # adopted, update the replacement to match the active palette.
      local tc_sed=$'s/\033\\[([0-9;]*)38;2;[0-9]+;[0-9]+;[0-9]+m/\033[\\138;2;255;102;92m/g'
      PS1=$(printf '%s' "$PS1" | sed -E "$tc_sed")
    fi
  }
fi
