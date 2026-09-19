#!/bin/sh
# Reports Grok's native context-window percentage and model metadata to Herdr.
# Grok invokes statusline commands with a JSON payload on stdin.
set -eu

command -v python3 >/dev/null 2>&1 || exit 0
command -v herdr >/dev/null 2>&1 || exit 0

hook_input="$(cat 2>/dev/null || true)"
metadata="$(HOOK_INPUT="$hook_input" python3 - <<'PY'
import json
import os

try:
    payload = json.loads(os.environ.get("HOOK_INPUT") or "{}")
except Exception:
    payload = {}
if not isinstance(payload, dict):
    payload = {}


def q(value):
    return "'" + str(value).replace("'", "'\\''") + "'"


model = payload.get("model") or {}
if isinstance(model, dict):
    model = model.get("display_name") or model.get("id") or ""
provider = payload.get("provider") or "xai"
effort = payload.get("effort") or {}
if isinstance(effort, dict):
    effort = effort.get("level") or ""
context = payload.get("context_window") or {}
pct = context.get("used_percentage") if isinstance(context, dict) else None

args = []
if model:
    args += ["--token", "model=%s" % model]
if provider:
    args += ["--token", "provider=%s" % provider]
if effort:
    args += ["--token", "effort=%s" % effort]
if isinstance(pct, (int, float)):
    args += ["--token", "usage_pct=%d" % min(max(int(pct), 0), 100)]
model_text = model if isinstance(model, str) else ""
print("\t".join((model_text, " ".join(q(value) for value in args))))
PY
)" || args=""

model="${metadata%%	*}"
args="${metadata#*	}"
[ -n "$args" ] || exit 0

pane_id="${HERDR_PANE_ID:-}"
if [ -z "$pane_id" ]; then
  pane_list="$(herdr pane list 2>/dev/null || true)"
  pane_id="$(PANE_LIST="$pane_list" PANE_CWD="${PWD:-}" PANE_MODEL="$model" python3 - <<'PY'
import json
import os

try:
    payload = json.loads(os.environ.get("PANE_LIST") or "{}")
except Exception:
    payload = {}

cwd = os.environ.get("PANE_CWD") or ""
model = os.environ.get("PANE_MODEL") or ""
if isinstance(payload, dict) and isinstance(payload.get("result"), dict):
    payload = payload["result"]
panes = payload.get("panes") if isinstance(payload, dict) else []
if not isinstance(panes, list):
    panes = []

def is_command_code(pane):
    agent = pane.get("agent")
    display_agent = pane.get("display_agent") or ""
    return agent == "cmd" or display_agent == "cmd" or display_agent.startswith("cmd ")

candidates = [pane for pane in panes if isinstance(pane, dict) and is_command_code(pane)]
if cwd:
    cwd_matches = [pane for pane in candidates if pane.get("cwd") == cwd]
    if cwd_matches:
        candidates = cwd_matches
if model:
    model_matches = [
        pane for pane in candidates
        if isinstance(pane.get("tokens"), dict)
        and pane["tokens"].get("model") == model
    ]
    if model_matches:
        candidates = model_matches
if len(candidates) == 1:
    print(candidates[0].get("pane_id") or "")
PY
)"
fi

[ -n "$pane_id" ] || exit 0
# shellcheck disable=SC2086 # args is deliberately word-split
eval "herdr pane report-metadata \"\$pane_id\" \
  --source custom:grok-metadata --ttl-ms 86400000 $args" \
  >/dev/null 2>&1 || true
