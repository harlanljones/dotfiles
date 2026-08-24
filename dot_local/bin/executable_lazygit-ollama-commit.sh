#!/usr/bin/env bash
#
# lazygit-ollama-commit.sh
#
# Generates a clean Conventional Commit message from staged git changes using
# ollama-commit-msg.sh, then opens it in $EDITOR (via `git commit --edit`)
# for review/tweaking before finalizing.
#
# Bound to <c-g> in ~/.config/lazygit/config.yml (output: terminal), so lazygit
# suspends while this runs and resumes once it exits.
#

set -eu

GEN="$(dirname "$(readlink -f "$0")")/ollama-commit-msg.sh"
if [[ ! -x "$GEN" ]]; then
  echo "Error: ollama-commit-msg.sh not found next to $0." >&2
  exit 1
fi

# --- Generate message & open editor ------------------------------------

TMP_MSG_FILE="$(mktemp /tmp/lazygit-ollama-commit.XXXXXX.txt)"
trap 'rm -f "$TMP_MSG_FILE"' EXIT

# Errors and progress from the generator go straight to the terminal.
"$GEN" >"$TMP_MSG_FILE"

# git commit with the generated message loaded into your editor for
# review/edit before it's finalized.
git commit --edit --file="$TMP_MSG_FILE"
