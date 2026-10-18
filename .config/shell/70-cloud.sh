#!/usr/bin/env bash
# 70-cloud.sh -- gcloud configuration switching (gcloud comes from mise).
#
#   ggcp      activate the personal configuration
#   wgcp      activate the work configuration (concerto-labs)
#   gcp [cfg] activate <cfg>; with no argument, pick from the configurations
#             on disk (current one marked)

_gcp_activate() {
  command -v gcloud >/dev/null 2>&1 || { echo "gcp: gcloud not on PATH" >&2; return 1; }
  gcloud config configurations activate "$1"
}

ggcp() { _gcp_activate personal; }
wgcp() { _gcp_activate concerto-labs; }

gcp() {
  local cur pick c f
  if [ "$#" -gt 0 ]; then
    _gcp_activate "$1"
    return
  fi
  cur=$(cat "$HOME/.config/gcloud/active_config" 2>/dev/null || true)
  local cfgs=()
  for f in "$HOME/.config/gcloud/configurations"/config_*; do
    [ -e "$f" ] || continue
    c=${f##*/config_}
    [ "$c" = "$cur" ] && c="$c *(current)"
    cfgs+=("$c")
  done
  [ "${#cfgs[@]}" -gt 0 ] || { echo "gcp: no gcloud configurations found" >&2; return 1; }

  if command -v fzf >/dev/null 2>&1; then
    pick=$(printf '%s\n' "${cfgs[@]}" | fzf --prompt='gcp config> ') || return 0
  else
    printf 'current: %s\n' "${cur:-none}"
    select pick in "${cfgs[@]}"; do
      [ -n "$pick" ] && break
    done
    [ -n "$pick" ] || return 0
  fi
  _gcp_activate "${pick%% *}"
}
