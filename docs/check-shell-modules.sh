#!/usr/bin/env bash
# check-shell-modules.sh -- dual-shell syntax + sourcing checks for the shell
# modules under dot_config/shell/*.sh. Called by the CI lint job; runnable
# locally from the repo root.
#
# Checks per module, for SHELL_KIND=bash and SHELL_KIND=zsh:
#   1. bash -n / zsh -n           (source-level syntax, both shells)
#   2. source in a clean subshell (must exit 0 without side effects: every
#      module guards on the binary it configures per AGENTS.md, so sourcing
#      on a machine without the tool is a no-op)
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v zsh >/dev/null 2>&1; then
  echo "error: zsh is required (CI installs it; locally: pacman -S zsh)" >&2
  exit 1
fi

status=0
modules=$(find dot_config/shell -maxdepth 1 -name '*.sh' -print | sort)
if [ -z "$modules" ]; then
  echo "::error::no shell modules found under dot_config/shell" >&2
  exit 1
fi

# Modules known to perform side effects on source and therefore excluded from
# the sourcing smoke test (still syntax-checked). Empty today; kept so the
# exclusion list has a documented, single place to live.
source_skip_re='^$'

for f in $modules; do
  for kind in bash zsh; do
    # 1. syntax check with the shell's own parser
    # shellcheck disable=SC2086
    if ! "$kind" -n "$f"; then
      echo "FAIL: $kind -n $f"
      status=1
      continue
    fi

    # 2. sourcing smoke test in a clean subshell; nothing should execute.
    # zsh: compinit is not loaded in -c mode, so modules calling compdef
    # (e.g. 30-navigation.sh) would fail with `command not found: compdef`.
    # Stub it the way a real interactive zsh would provide it.
    if [ "$kind" = zsh ]; then
      zsh_pre='compdef() { :; }; '
    else
      zsh_pre=''
    fi
    if printf '%s' "$f" | grep -qE "$source_skip_re"; then
      echo "skip (source): $kind $f"
      continue
    fi
    if ! SHELL_KIND="$kind" "$kind" -c "${zsh_pre}source '$PWD/$f'" >/dev/null 2>&1; then
      echo "FAIL: source ($kind, SHELL_KIND=$kind) $f"
      status=1
      continue
    fi
    echo "ok: $kind $f"
  done
done

exit "$status"
