#!/bin/sh
# Reports Antigravity (agy) model/provider/effort to Herdr panes.
#
# The herdr-installed herdr-agent-state.sh is session-only (its header says to
# add custom hooks beside it rather than editing it), so the sidebar's
# $model/$provider/$effort tokens have no source for agy panes. This hook
# scans the PostTurn/PreInvocation payload for model-ish fields and reports
# what it finds; unknown payloads are logged once for diagnosability.
set -eu

[ "${HERDR_ENV:-}" = "1" ] || exit 0
[ -n "${HERDR_SOCKET_PATH:-}" ] || exit 0
[ -n "${HERDR_PANE_ID:-}" ] || exit 0
command -v herdr >/dev/null 2>&1 || exit 0
command -v python3 >/dev/null 2>&1 || exit 0

hook_input="$(cat 2>/dev/null || true)"
args="$(HOOK_INPUT="$hook_input" python3 - <<'PY'
import json, os

try:
    payload = json.loads(os.environ.get("HOOK_INPUT") or "{}")
except Exception:
    payload = {}
if not isinstance(payload, dict):
    payload = {}


def q(v):
    return "'" + str(v).replace("'", "'\\''") + "'"


def find_first(obj, keys):
    """Depth-first search for the first non-empty string under any key."""
    if isinstance(obj, dict):
        for k in keys:
            v = obj.get(k)
            if isinstance(v, str) and v:
                return v
        for v in obj.values():
            found = find_first(v, keys)
            if found:
                return found
    elif isinstance(obj, list):
        for v in obj:
            found = find_first(v, keys)
            if found:
                return found
    return ""


model = find_first(payload, ("model", "model_id", "modelId", "model_name", "modelName"))
provider = find_first(payload, ("provider", "provider_id", "providerId"))
effort = find_first(payload, ("effort", "effortLevel", "effort_level", "reasoning_effort"))
# This hook only ever runs in Antigravity panes, whose provider is Google.
if not provider:
    provider = "google"

# Antigravity encodes effort as a model-name suffix (gemini-3.8-flash-high).
if not effort:
    for suffix in ("high", "medium", "low"):
        if model.endswith("-" + suffix):
            effort = suffix
            break

if not model:
    dbg = os.path.expanduser("~/.local/state/herdr/agy-metadata-unknown.log")
    try:
        os.makedirs(os.path.dirname(dbg), exist_ok=True)
        with open(dbg, "a") as f:
            f.write(json.dumps(payload)[:2000] + "\n")
    except Exception:
        pass
    raise SystemExit(0)

args = ["--token", "model=%s" % model]
if provider:
    args += ["--token", "provider=%s" % provider]
if effort:
    args += ["--token", "effort=%s" % effort]
print(" ".join(q(a) for a in args))
PY
)" || args=""

[ -n "$args" ] || exit 0
# shellcheck disable=SC2086 # args is deliberately word-split
eval "herdr pane report-metadata \"\$HERDR_PANE_ID\" \
  --source custom:agy-metadata --agent agy --ttl-ms 86400000 $args" \
  >/dev/null 2>&1 || true
