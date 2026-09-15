#!/usr/bin/env bash
# 55-apps.sh -- launchers for local desktop applications.

# WebKit on this hardware falls over with the DMABUF renderer enabled.
[ "$(uname -s)" = "Linux" ] && export WEBKIT_DISABLE_DMABUF_RENDERER=1

# FreeToken desktop panel -- always launch it detached from this terminal.
#
# The panel is built panic=abort and its log relay writes with eprintln!.
# Rust's std io panics when a write to stderr fails, so one failed log line
# aborts the whole process. Inheriting the terminal's pty makes that a live
# hazard: once the terminal goes away the pty master is closed, the next log
# line gets EIO, and the panel dies. That is exactly how PID 45430 died on
# 2026-08-30, 25s after an overnight suspend, while relaying CUDA OOM errors
# from its backend supervisor.
#
# `setsid --fork` gives it its own session with no controlling terminal, and
# the redirects mean stderr is a regular file rather than a pty -- so no
# terminal lifecycle can reach it. The output is kept rather than discarded
# (it relays the backend's errors, which are what made that crash legible)
# with one generation of rotation so the log cannot grow without bound.
#
# Linux-only: `setsid` is not present on macOS by default, and the panel is
# not installed there.
if [ "$(uname -s)" = "Linux" ]; then
  ft() {
    local log_dir="${XDG_STATE_HOME:-$HOME/.local/state}/freetoken"
    local log="$log_dir/desktop.log"

    mkdir -p "$log_dir" || return 1
    [ -f "$log" ] && mv -f "$log" "$log.1"

    setsid --fork freetoken-desktop "$@" </dev/null >"$log" 2>&1 || return 1
    printf 'freetoken-desktop detached (log: %s)\n' "$log"
  }
fi
