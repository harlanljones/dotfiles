#!/usr/bin/env bash
# 70-cloud.sh -- cloud provider CLIs installed outside mise.

# Fly.io CLI.
if [ -d "$HOME/.fly" ]; then
  export FLYCTL_INSTALL="$HOME/.fly"
  _path_prepend "$FLYCTL_INSTALL/bin"
  export PATH
fi

# Google Cloud SDK. The vendored completion script is bash-specific, so it is
# only sourced under bash; the PATH entry applies to any shell.
if [ -f "$HOME/dev/harlan-web/google-cloud-sdk/path.bash.inc" ]; then
  # shellcheck disable=SC1091  # gcloud SDK files, machine-local
  . "$HOME/dev/harlan-web/google-cloud-sdk/path.bash.inc"
fi
if [ "$SHELL_KIND" = bash ] && [ -f "$HOME/dev/harlan-web/google-cloud-sdk/completion.bash.inc" ]; then
  # shellcheck disable=SC1091  # gcloud SDK files, machine-local
  . "$HOME/dev/harlan-web/google-cloud-sdk/completion.bash.inc"
fi

# gcloud configuration switching.
#
#   ggcp      activate the personal configuration
#   wgcp      activate the work configuration (concerto-labs)
#   gcp [cfg] activate <cfg>; with no argument, pick interactively from the
#             configurations on disk (current one marked). Repos carry no
#             automatic project selection, so the interactive picker is the
#             default flow.
_gcp_activate() {
  command -v gcloud >/dev/null 2>&1 || { echo "gcp: gcloud not on PATH" >&2; return 1; }
  gcloud config configurations activate "$1"
}

ggcp() { _gcp_activate personal; }
wgcp() { _gcp_activate concerto-labs; }

gcp() {
  local cur pick c
  if [ "$#" -gt 0 ]; then
    _gcp_activate "$1"
    return
  fi
  cur=$(cat "$HOME/.config/gcloud/active_config" 2>/dev/null || true)
  local _gcp_cfgs=()
  for _gcp_f in "$HOME/.config/gcloud/configurations"/config_*; do
    [ -e "$_gcp_f" ] || continue
    c=${_gcp_f##*/config_}
    [ "$c" = "$cur" ] && c="$c *(current)"
    _gcp_cfgs+=("$c")
  done
  unset _gcp_f
  [ "${#_gcp_cfgs[@]}" -gt 0 ] || { echo "gcp: no gcloud configurations found" >&2; return 1; }

  if command -v fzf >/dev/null 2>&1; then
    pick=$(printf '%s\n' "${_gcp_cfgs[@]}" | fzf --prompt='gcp config> ') || return 0
  else
    printf 'current: %s\n' "${cur:-none}"
    select pick in "${_gcp_cfgs[@]}"; do
      [ -n "$pick" ] && break
    done
    [ -n "$pick" ] || return 0
  fi
  _gcp_activate "${pick%% *}"
}
