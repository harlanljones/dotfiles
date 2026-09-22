#!/usr/bin/env bash
# dots-ui.sh — shared TUI helpers for setup.sh and `dots register`.
#
# Repo material: tracked in git, never applied (see .chezmoiignore.tmpl).
# Source it; do not execute it. setup.sh runs from a fresh clone before
# `chezmoi apply`, so callers locate this file relative to the repo, not $HOME.
#
# Uses `gum` when it is installed and both stdin and stdout are a TTY and
# NON_INTERACTIVE is not "true". Otherwise it falls back to tput colors and
# plain read prompts, so CI logs and -y runs stay clean.
#
# Contract for callers:
#   NON_INTERACTIVE   "true" accepts every default without prompting
#   UI_STEP_TOTAL     denominator for step() (default 7)
#   ask_choice / ask_input print the selection on stdout; prompts go to stderr.

NON_INTERACTIVE="${NON_INTERACTIVE:-false}"
UI_STEP_TOTAL="${UI_STEP_TOTAL:-7}"

if [[ -t 1 ]] && command -v tput >/dev/null 2>&1 && [[ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]]; then
  BOLD=$(tput bold); DIM=$(tput dim); RESET=$(tput sgr0)
  BLUE=$(tput setaf 4); GREEN=$(tput setaf 2); YELLOW=$(tput setaf 3); RED=$(tput setaf 1); CYAN=$(tput setaf 6)
else
  BOLD=""; DIM=""; RESET=""; BLUE=""; GREEN=""; YELLOW=""; RED=""; CYAN=""
fi

ui_gum() {
  [[ "$NON_INTERACTIVE" != "true" && -t 0 && -t 1 ]] && command -v gum >/dev/null 2>&1
}

ui_banner() {
  local title="$1" subtitle="${2:-}"
  if ui_gum; then
    printf '\n'
    gum style --border double --border-foreground 6 --foreground 6 --bold \
      --padding "0 2" --margin "0 1" "$title" ${subtitle:+"$subtitle"}
    printf '\n'
    return 0
  fi
  printf '\n%s%s======================================================%s\n' "$BOLD" "$CYAN" "$RESET"
  printf '%s%s   %s%s\n' "$BOLD" "$CYAN" "$title" "$RESET"
  printf '%s%s======================================================%s\n' "$BOLD" "$CYAN" "$RESET"
  [[ -n "$subtitle" ]] && printf '%s  %s%s\n' "$DIM" "$subtitle" "$RESET"
  printf '\n'
}

# ui_step <n> <title>
step() {
  if ui_gum; then
    printf '\n'
    gum style --foreground 4 --bold "[$1/$UI_STEP_TOTAL] $2"
  else
    printf '\n%s%s[%s/%s] %s%s\n' "$BOLD" "$BLUE" "$1" "$UI_STEP_TOTAL" "$2" "$RESET"
  fi
}
info()    { printf '  %sℹ%s %s\n' "$CYAN" "$RESET" "$1"; }
success() { printf '  %s✓%s %s\n' "$GREEN" "$RESET" "$1"; }
warn()    { printf '  %s⚠%s %s\n' "$YELLOW" "$RESET" "$1"; }
err()     { printf '  %s✖%s %s\n' "$RED" "$RESET" "$1" >&2; }

# ui_kv <label> <value> — aligned key/value row
ui_kv() { printf '  %-18s %s\n' "$1" "$2"; }

# confirm <prompt> [Y|N default] — returns 0 for yes
confirm() {
  local prompt="$1" default="${2:-Y}" reply=""
  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    [[ "$default" =~ ^[Yy] ]] && return 0 || return 1
  fi
  if ui_gum; then
    if [[ "$default" =~ ^[Yy] ]]; then
      gum confirm --default=true "$prompt"
    else
      gum confirm --default=false "$prompt"
    fi
    return
  fi
  if [[ "$default" =~ ^[Yy] ]]; then
    printf '  %s? %s [Y/n]: %s' "$YELLOW" "$prompt" "$RESET" >&2
  else
    printf '  %s? %s [y/N]: %s' "$YELLOW" "$prompt" "$RESET" >&2
  fi
  read -r reply || true
  reply="${reply:-$default}"
  [[ "$reply" =~ ^[Yy] ]]
}

# ask_choice <prompt> <default> <option>... — prints the chosen option.
# The default may be a full option or its first word (e.g. "augustus").
ask_choice() {
  local prompt="$1" default_val="$2" chosen=""
  shift 2
  local options=("$@") default_opt="" opt
  for opt in "${options[@]}"; do
    if [[ "$opt" == "$default_val" || "${opt%% *}" == "$default_val" ]]; then
      default_opt="$opt"; break
    fi
  done
  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    echo "${default_opt:-$default_val}"
    return 0
  fi
  if ui_gum; then
    chosen="$(gum choose --header "$prompt" ${default_opt:+--selected "$default_opt"} "${options[@]}")" || chosen=""
    echo "${chosen:-${default_opt:-$default_val}}"
    return 0
  fi
  printf '  %s? %s%s\n' "$YELLOW" "$prompt" "$RESET" >&2
  local i num marker
  for i in "${!options[@]}"; do
    num=$((i + 1)); marker=" "
    [[ "${options[$i]}" == "$default_opt" ]] && marker="*"
    printf '    %s%s %s) %s%s\n' "$DIM" "$marker" "$num" "${options[$i]}" "$RESET" >&2
  done
  printf '  Select [1-%s] (default: %s): ' "${#options[@]}" "${default_opt:-$default_val}" >&2
  read -r chosen || true
  if [[ -z "$chosen" ]]; then
    echo "${default_opt:-$default_val}"
  elif [[ "$chosen" =~ ^[0-9]+$ ]] && (( chosen >= 1 && chosen <= ${#options[@]} )); then
    echo "${options[$((chosen - 1))]}"
  else
    echo "$chosen"
  fi
}

# ask_input <prompt> [default] — prints the entered text ([default] if blank).
ask_input() {
  local prompt="$1" default_val="${2:-}" reply=""
  if [[ "$NON_INTERACTIVE" == "true" ]]; then
    echo "$default_val"; return 0
  fi
  if ui_gum; then
    reply="$(gum input --prompt "? $prompt " --placeholder "$default_val")" || reply=""
  else
    printf '  %s? %s%s%s: ' "$YELLOW" "$prompt" "${default_val:+ [$default_val]}" "$RESET" >&2
    read -r reply || true
  fi
  echo "${reply:-$default_val}"
}

# ask_secret <prompt> — prints entered text without echo.
ask_secret() {
  local prompt="$1" reply=""
  if ui_gum; then
    reply="$(gum input --password --prompt "? $prompt ")" || reply=""
  else
    printf '  %s? %s: %s' "$YELLOW" "$prompt" "$RESET" >&2
    stty -echo 2>/dev/null || true
    read -r reply || true
    stty echo 2>/dev/null || true
    printf '\n' >&2
  fi
  echo "$reply"
}

# ui_spin <title> <command...> — run a command behind a spinner when gum is
# usable; otherwise announce it and run it plainly. Returns its exit status.
ui_spin() {
  local title="$1"
  shift
  if ui_gum; then
    gum spin --spinner dot --title "$title" --show-error -- "$@"
  else
    info "$title"
    "$@"
  fi
}

# ui_summary <title> <label=value>... — closing panel
ui_summary() {
  local title="$1" pair
  shift
  if ui_gum; then
    local body=""
    for pair in "$@"; do body+="${pair%%=*}: ${pair#*=}"$'\n'; done
    printf '\n'
    gum style --border rounded --border-foreground 2 --foreground 2 --padding "0 2" --margin "0 1" \
      "$title" "" "${body%$'\n'}"
    return 0
  fi
  printf '\n%s%s======================================================%s\n' "$BOLD" "$GREEN" "$RESET"
  printf '%s%s   %s%s\n' "$BOLD" "$GREEN" "$title" "$RESET"
  printf '%s%s======================================================%s\n' "$BOLD" "$GREEN" "$RESET"
  for pair in "$@"; do ui_kv "${pair%%=*}:" "${pair#*=}"; done
}
