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
# review/edit before it's finalized. Saving with <leader>P in nvim hands
# control back here rather than committing itself, so the push below is the
# one that runs. The marker lets nvim recognize this session even though the
# buffer is a /tmp file, not COMMIT_EDITMSG; any non-approved exit aborts.
export NVIM_GIT_EDITOR_SESSION=1
git commit --edit --file="$TMP_MSG_FILE"

# --- Push --------------------------------------------------------------

# Set LAZYGIT_OLLAMA_NO_PUSH=1 to commit only.
if [[ "${LAZYGIT_OLLAMA_NO_PUSH:-0}" == "1" ]]; then
  exit 0
fi

# Note: `$?` inside `if ! git push` would be the negation's status (0), not
# git's, so capture it with `||` instead.
push_status=0
git push || push_status=$?

if ((push_status != 0)); then
  if ! git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' >/dev/null 2>&1; then
    echo "Tip: no upstream for this branch. Run: git push -u origin HEAD" >&2
  fi
  exit "$push_status"
fi
