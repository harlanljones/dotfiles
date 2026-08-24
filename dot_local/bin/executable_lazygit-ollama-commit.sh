#!/usr/bin/env bash
#
# lazygit-ollama-commit.sh
#
# Generates a clean Conventional Commit message from staged git changes using
# ollama-commit-msg.sh, then opens it in $EDITOR (via `git commit --edit`)
# for review/tweaking before finalizing.
#

set -eu

GEN="$(dirname "$(readlink -f "$0")")/ollama-commit-msg.sh"
if [[ ! -x "$GEN" ]]; then
  echo "Error: ollama-commit-msg.sh not found next to $0." >&2
  exit 1
fi

# Exit the lazygit instance that launched this script. Lazygit runs terminal
# custom commands through a shell, so it may be more than one parent away.
# When run directly from a terminal, this is intentionally a no-op.
exit_parent_lazygit() {
  local pid="$PPID"
  local parent_pid
  local process_name

  while [[ "$pid" =~ ^[0-9]+$ ]] && ((pid > 1)); do
    process_name="$(ps -o comm= -p "$pid" 2>/dev/null || true)"
    process_name="${process_name//[[:space:]]/}"

    if [[ "$process_name" == "lazygit" ]]; then
      # Deferred and detached on purpose. Killing lazygit while it is still
      # waiting on this script makes it tear down the subprocess and render
      # the result as "exit status 128" before shutting down. Exiting 0 first
      # lets lazygit record the command as successful; setsid keeps the timer
      # out of lazygit's process group so its cleanup can't take it with it.
      setsid bash -c "sleep 0.3; kill -TERM $pid" >/dev/null 2>&1 &
      return
    fi

    parent_pid="$(ps -o ppid= -p "$pid" 2>/dev/null || true)"
    parent_pid="${parent_pid//[[:space:]]/}"
    if [[ ! "$parent_pid" =~ ^[0-9]+$ ]] || [[ "$parent_pid" == "$pid" ]]; then
      return
    fi
    pid="$parent_pid"
  done
}

# --- Generate message & open editor ------------------------------------

TMP_MSG_FILE="$(mktemp /tmp/lazygit-ollama-commit.XXXXXX.txt)"
trap 'rm -f "$TMP_MSG_FILE"' EXIT

# Errors and progress from the generator go straight to the terminal.
"$GEN" >"$TMP_MSG_FILE"

# git commit with the generated message loaded into your editor for
# review/edit before it's finalized.
if git commit --edit --file="$TMP_MSG_FILE"; then
  # Leave the successful commit output on screen and return to the invoking
  # terminal instead of showing lazygit's "press enter to return" prompt.
  exit_parent_lazygit
else
  commit_status=$?
  exit "$commit_status"
fi
