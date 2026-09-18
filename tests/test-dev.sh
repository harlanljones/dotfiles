#!/bin/bash
# Tests that differentiate ./dev (the Hermes entrypoint script in this repo)
# from /dev and ~/dev (the devices' development directories).
#
#   ./dev  is this repo's launcher: it pins the dotfiles profile, cds to the
#          repo root no matter the caller's cwd, and execs hermes.
#   ~/dev  is NOT the repo, NOT a profile, and ./dev must never target it.
#
# Checks: static (profile binding, no device-dev paths, no repo dev/ dir) and
# behavioral (a PATH shim captures what ./dev actually invoked and from where).
#
# Usage: tests/test-dev.sh [path-to-repo-root]
# Exit:  number of failures. TTY-safe (never launches a real hermes session).

set -u
fails=0
say() { printf '%s\n' "$1"; }
assert() { # assert <name> <command...> — must exit 0
  local name=$1
  shift
  if "$@"; then say "PASS $name"; else say "FAIL $name"; fails=$((fails+1)); fi
}

repo="${1:-}"
if [[ -z $repo ]]; then
  repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
repo="$(cd "$repo" && pwd)"
dev_script="$repo/dev"

say "repo: $repo"

# ── static: the script exists and is the Hermes entrypoint ──────────────────
assert "dev-script-exists" test -f "$dev_script"
assert "profile-pinned" grep -q 'PROFILE="dotfiles"' "$dev_script"

# ── static: no reference to the devices' dev directories ────────────────────
# /dev/null, /dev/stdout, /dev/stderr, /dev/tty, /dev/fd are legit; ~/dev,
# "$HOME/dev", /dev/<repo> as targets are not. The repo must not contain a
# dev/ directory either, so a stray `cd dev` can never silently land anywhere.
if [[ -d $repo/dev ]]; then
  say "FAIL repo-has-dev-dir (rename it: ./dev is the launcher)"; fails=$((fails+1))
else
  say "PASS no-repo-dev-dir"
fi
bad_refs=""
while IFS= read -r line; do
  # match /dev/<something> but whitelist the standard device files
  if grep -qE '/dev/(null|stdout|stderr|tty|fd)' <<<"$line"; then
    continue
  fi
  if grep -qE '/dev/[a-zA-Z]' <<<"$line"; then
    bad_refs+="$line"$'\n'
  fi
done < <(grep -n '/dev/' "$dev_script" 2>/dev/null)
assert "no-device-dev-paths" test -z "$bad_refs"
[[ -n $bad_refs ]] && printf '%s' "$bad_refs"

# shellcheck disable=SC2016  # the $(grep …) must expand inside bash -c
assert "no-home-dev-references" bash -c 'test "$(grep -cE "([\\$]HOME|~/)dev" "$0/dev")" -eq 0' "$repo"

# ── static: no shadowing launcher in the devices' dev dir ───────────────────
# A ~/dev/dev script (any script named dev) shadows ./dev when a shell is
# already in ~/dev — exactly the confusion these tests exist to prevent.
if [[ -e $HOME/dev/dev ]]; then
  say "FAIL rogue-home-dev-dev ($HOME/dev/dev exists and shadows ./dev — remove or rename it)"; fails=$((fails+1))
else
  say "PASS no-rogue-home-dev-dev"
fi

# ── behavioral: shim hermes, run ./dev, capture argv and cwd ────────────────
sandbox="$(mktemp -d)"
shim_dir="$sandbox/bin"
mkdir -p "$shim_dir"
shim_log="$sandbox/hermes-calls.log"
cat > "$shim_dir/hermes" <<EOF
#!/bin/bash
printf '%s\n' "\$PWD|\$*" >> "$shim_log"
exit 0
EOF
chmod +x "$shim_dir/hermes"

# Run ./dev from a foreign cwd (a devices-like dev dir if one exists, else
# the sandbox) to prove the launcher re-anchors to the repo root.
caller_cwd="$HOME/dev"
[[ -d $caller_cwd ]] || caller_cwd="$sandbox"

(cd "$caller_cwd" && PATH="$shim_dir:$PATH" HOME="$sandbox" "$dev_script" doctor >/dev/null 2>&1)
assert "shim-saw-hermes" test -s "$shim_log"
assert "behavioral-profile" grep -q -- "--profile dotfiles" "$shim_log"
# Every hermes invocation must have been re-anchored to the repo root.
grep -v "^$repo|" "$shim_log" > "$sandbox/nonrepo.log"
assert "behavioral-repo-cwd" test ! -s "$sandbox/nonrepo.log"

# ── behavioral: the launcher never writes into the devices' dev dirs ────────
before="$(find "$caller_cwd" -maxdepth 1 2>/dev/null | sort | md5sum)"
(cd "$caller_cwd" && PATH="$shim_dir:$PATH" HOME="$sandbox" "$dev_script" doctor >/dev/null 2>&1)
after="$(find "$caller_cwd" -maxdepth 1 2>/dev/null | sort | md5sum)"
assert "caller-dir-untouched" test "$before" = "$after"

rm -rf "$sandbox"
say "FAILURES=$fails"
exit $fails
