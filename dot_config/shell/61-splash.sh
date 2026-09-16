#!/usr/bin/env bash
# 61-splash.sh - First-shell-per-window identity splash (phase 7.12 task 3).
#
# Consumes ~/.local/bin/dots-identity (output contract frozen there) and shows
# the machine-identity banner once per interactive terminal window per boot.
# Runs AFTER 60-prompt.sh so the banner prints during rc sourcing, before
# starship draws the first prompt.
#
# Detection matrix — only terminals that expose a window-level identity get
# the splash; everything else stays quiet (dots-identity remains on-demand):
#
# | Terminal  | Env key                  | Window key                  | Behavior                |
# | --------- | ------------------------ | --------------------------- | ----------------------- |
# | WezTerm   | WEZTERM_PANE (p:W:T:P)   | W (window part of the pane) | once per window / boot  |
# | Ghostty   | GHOSTTY_RESOURCES_DIR    | none exposed (no pane env)  | once per app / boot     |
# | kitty     | KITTY_WINDOW_ID          | the window id               | once per window / boot  |
# | iTerm2    | ITERM_SESSION_ID (wN:U)  | wN (window part)            | once per window / boot  |
# | SSH       | SSH_CONNECTION           | -                           | no splash               |
# | unknown / plain tty / VTE | -       | -                           | no splash (quiet default) |
#
# Markers live in $XDG_STATE_HOME/dots/splash/ keyed on
# <terminal>-<window>-<boot id>, so they clear automatically on reboot and
# never accumulate. The marker is only written AFTER dots-identity renders
# successfully, so a transient failure retries on the next shell.
#
# Speed: non-interactive shells skip entirely; dots-identity internally
# timeout-guards its own slow paths (<1s worst case), nothing else blocks.

_dots_splash() {
  # Interactive shells only.
  case $- in
    *i*) ;;
    *) return 0 ;;
  esac

  # SSH sessions never get the banner.
  if [[ -n "${SSH_CONNECTION:-}" ]]; then
    return 0
  fi

  # Terminal detection -> "<terminal>:<window key>"; window key may be empty
  # (Ghostty) which degrades to once-per-app-per-boot. No match = no splash.
  local term_id=''
  if [[ -n "${WEZTERM_PANE:-}" ]]; then
    # WEZTERM_PANE is "p:<window>:<tab>:<pane>"; strip to the window part.
    # Plain-numeric values (older builds) are pane ids: unique enough.
    local pane=${WEZTERM_PANE#p:}
    term_id="wezterm-${pane%%:*}"
  elif [[ -n "${GHOSTTY_RESOURCES_DIR:-}" ]]; then
    term_id='ghostty'
  elif [[ -n "${KITTY_WINDOW_ID:-}" ]]; then
    term_id="kitty-${KITTY_WINDOW_ID}"
  elif [[ -n "${ITERM_SESSION_ID:-}" ]]; then
    # ITERM_SESSION_ID is "<window#><tab#><pane#>:<uuid>"; window part first.
    local session=${ITERM_SESSION_ID%%:*}
    term_id="iterm2-${session%%t*}"
  else
    return 0
  fi

  # Per-boot stamp: Linux boot_id, macOS boottime, else epoch (per-session).
  local boot
  if [[ -r /proc/sys/kernel/random/boot_id ]]; then
    IFS='-' read -r boot _ < /proc/sys/kernel/random/boot_id
  elif command -v sysctl >/dev/null 2>&1; then
    boot=$(sysctl -n kern.boottime 2>/dev/null | sed -n 's/.* sec = \([0-9]*\).*/\1/p')
  fi
  boot=${boot:-$(date +%s)}

  # Sanitize into a flat marker filename.
  local key
  key=$(printf '%s-%s' "$term_id" "$boot" | tr -c '[:alnum:]._-' '-')

  local marker_dir="${XDG_STATE_HOME:-$HOME/.local/state}/dots/splash"
  local marker="$marker_dir/$key"
  [[ -e "$marker" ]] && return 0

  # Guard on the binary; render; only then write the marker.
  if ! command -v dots-identity >/dev/null 2>&1; then
    return 0
  fi
  mkdir -p "$marker_dir"
  if dots-identity 2>/dev/null; then
    : >"$marker"
  fi
  return 0
}

_dots_splash
unset -f _dots_splash
