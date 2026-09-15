#!/usr/bin/env bash
#
# ollama-commit-msg.sh
#
# Generates a clean Conventional Commit message from the currently staged git
# changes and prints it to stdout. Does not commit.
#
# Tries GitHub Copilot CLI first (same backend as the LazyVim copilot
# integration): far more reliable on larger diffs and immune to the local
# model's failure modes below. Falls back to a local Ollama model when
# `copilot` isn't installed/authenticated or the call fails, so this still
# works fully offline. Set COMMIT_MSG_NO_COPILOT=1 to skip straight to Ollama.
#
# Consumers:
#   - lazygit-ollama-commit.sh  (loads it into $EDITOR via `git commit --edit`)
#   - nvim <leader>P            (pre-fills the commit message prompt)
#   - dots-push                 (chezmoi dotfiles repo commits)
#
# Exits non-zero with a message on stderr if a message can't be generated.
#

set -eu

# --- Configuration -----------------------------------------------------

MODEL="${OLLAMA_COMMIT_MODEL:-qwen2.5-coder:7b}"
OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}"
OLLAMA_MAX_DIFF_CHARS="${OLLAMA_COMMIT_MAX_DIFF_CHARS:-20000}"
OLLAMA_NUM_CTX="${OLLAMA_COMMIT_NUM_CTX:-8192}"
OLLAMA_TIMEOUT="${OLLAMA_TIMEOUT:-30}"

# Set OLLAMA_COMMIT_NO_SERVE=1 to fail fast instead of starting `ollama serve`.
OLLAMA_COMMIT_NO_SERVE="${OLLAMA_COMMIT_NO_SERVE:-0}"

COMMIT_MSG_NO_COPILOT="${COMMIT_MSG_NO_COPILOT:-0}"
# Copilot's context window comfortably fits much larger diffs than the local
# 7B model, which is the whole point of trying it first on big commits.
COPILOT_MAX_DIFF_CHARS="${COPILOT_COMMIT_MAX_DIFF_CHARS:-100000}"
COPILOT_TIMEOUT="${COPILOT_COMMIT_TIMEOUT:-25}"

# --- Sanity checks ----------------------------------------------------

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git is not installed or not on PATH." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository." >&2
  exit 1
fi

# Check for staged changes
STAT="$(git diff --cached --stat)"
if [[ -z "$STAT" ]]; then
  echo "Error: no staged changes found. Stage something first (git add)." >&2
  exit 1
fi

# --- Shared diff assembly ------------------------------------------------

# Filter noisy/generated files from the detailed diff to save token budget
EXCLUDE_PATTERNS=(
  ":(exclude)*package-lock.json"
  ":(exclude)*pnpm-lock.yaml"
  ":(exclude)*yarn.lock"
  ":(exclude)*Cargo.lock"
  ":(exclude)*go.sum"
  ":(exclude)*composer.lock"
  ":(exclude)*.min.js"
  ":(exclude)*.min.css"
  ":(exclude)*.map"
  ":(exclude)*.svg"
)

FULL_DIFF="$(git diff --cached --no-color -- "${EXCLUDE_PATTERNS[@]}" 2>/dev/null || true)"

# Fall back to full diff if excluding generated files left diff empty (e.g. only lockfiles staged)
if [[ -z "$FULL_DIFF" ]]; then
  FULL_DIFF="$(git diff --cached --no-color)"
fi

# build_prompt DIFF MAX_CHARS: truncates DIFF to MAX_CHARS on a clean line
# boundary and prints the assembled user-prompt content on stdout.
build_prompt() {
  local diff="$1" max_chars="$2" truncated=false
  if ((${#diff} > max_chars)); then
    truncated=true
    diff="$(printf '%s' "$diff" | head -c "$max_chars" | sed -e '$d')"
  fi
  if [[ "$truncated" == "true" ]]; then
    printf '<staged_files_summary>\n%s\n</staged_files_summary>\n\n<staged_diff>\n%s\n[Note: Diff was truncated to fit context limits]\n</staged_diff>\n\nWrite a concise Conventional Commit message for the staged changes above.\nOutput ONLY the commit message text. Do NOT summarize or explain the files.' \
      "$STAT" "$diff"
  else
    printf '<staged_diff>\n%s\n</staged_diff>\n\nWrite a concise Conventional Commit message for the staged changes above.\nOutput ONLY the commit message text. Do NOT summarize or explain the files.' \
      "$diff"
  fi
}

# --- Sanitize a raw model response into a clean commit message ---------
#
# Clean up common LLM artifacts:
# 1. Strip <think>...</think> tags if reasoning model used
# 2. Strip code fences (```, ```git, ```markdown)
# 3. Strip common intro headers ("Here is...", "Commit message:", "Subject:", etc.)
# 4. Strip matched surrounding quotes on subject line
# 5. Extract starting from conventional commit line if preamble preceded it
# 6. Normalize trailing whitespace and remove initial blank lines
sanitize_message() {
  awk '
    BEGIN { in_think = 0; }
    /<think>/ { in_think = 1; next }
    /<\/think>/ { in_think = 0; next }
    in_think { next }
    /^```/ { next }
    {
      line = $0
      gsub(/^[\*#_` \t]+|[\*#_` \t]+$/, "", line)
      line_lower = tolower(line)
      if (line_lower ~ /^(here is|here'\''s|suggested commit|commit message|commit|subject|title)(:.*)?$/) {
        next
      }
      print
    }
  ' | awk '
    BEGIN {
      found_cc = 0;
      total_lines = 0;
    }
    {
      lines[NR] = $0;
      total_lines = NR;
      if (!found_cc && $0 ~ /^(feat|fix|refactor|perf|style|test|docs|chore|build|ci|revert)(\([^)]+\))?!?: /) {
        first_cc_line = NR;
        found_cc = 1;
      }
    }
    END {
      if (found_cc) {
        for (i = first_cc_line; i <= total_lines; i++) {
          print lines[i];
        }
      } else {
        for (i = 1; i <= total_lines; i++) {
          print lines[i];
        }
      }
    }
  ' | sed -e '1s/^\(["'\''`]\)\(.*\)\1$/\2/' | sed -e '/^[[:space:]]*$/{ $d; }' | sed '/./,$!d'
}

SYSTEM_PROMPT='You are an expert software developer specializing in generating Git commit messages adhering strictly to the Conventional Commits specification.

Format:
<type>(<optional-scope>): <imperative summary in lowercase under 72 chars>

- <optional bullet point explaining key change>
- <optional bullet point explaining context/rationale>

Rules:
1. Output ONLY the raw commit message text.
2. NEVER output file summaries, introductions, markdown code blocks (```), conversational text, or explanations.
3. NEVER describe or list the modified files.
4. The first line MUST start with a valid conventional commit type: feat, fix, refactor, perf, style, test, docs, chore, build, or ci.
5. Write in imperative mood ("add", "fix", "update", "remove", NOT "added", "fixes", "updating").
6. If changes are small or straightforward, return ONLY the subject line.'

# looks_like_commit_message: reject anything whose first line isn't actually
# a conventional-commit subject. The local 7B model can go fully incoherent
# on large/syntax-heavy diffs even after sanitize_message (repeats fragments
# of the few-shot example, garbled tokens); better to fall through to the
# dated fallback in dots-push/nvim than to commit that.
looks_like_commit_message() {
  local first_line
  first_line="$(printf '%s' "$1" | head -n1)"
  [[ "$first_line" =~ ^(feat|fix|refactor|perf|style|test|docs|chore|build|ci|revert)(\([^\)]+\))?!?:\ .+ ]]
}

# --- Engine: GitHub Copilot CLI (preferred) -----------------------------

try_copilot() {
  [[ "$COMMIT_MSG_NO_COPILOT" != "1" ]] || return 1
  command -v copilot >/dev/null 2>&1 || return 1
  command -v timeout >/dev/null 2>&1 || return 1

  local prompt
  prompt="$(build_prompt "$FULL_DIFF" "$COPILOT_MAX_DIFF_CHARS")"

  local raw
  # --available-tools '' : text generation only, no file/shell/tool access —
  # this is a read-only summarization task, not an agentic one.
  raw="$(timeout "$COPILOT_TIMEOUT" copilot \
    -p "${SYSTEM_PROMPT}

${prompt}" \
    --available-tools '' -s --no-color 2>/dev/null || true)"

  [[ -n "$raw" ]] || return 1
  local clean
  clean="$(printf '%s' "$raw" | sanitize_message)"
  looks_like_commit_message "$clean" || return 1
  printf '%s' "$clean"
}

# --- Engine: local Ollama model (offline fallback) ----------------------

ensure_ollama() {
  if curl -s --connect-timeout 2 "${OLLAMA_HOST}/api/tags" >/dev/null 2>&1; then
    return 0
  fi

  # Auto-start ollama if connecting to localhost and ollama binary exists
  if [[ "$OLLAMA_COMMIT_NO_SERVE" != "1" ]] &&
    [[ "$OLLAMA_HOST" == *"localhost"* || "$OLLAMA_HOST" == *"127.0.0.1"* ]] &&
    command -v ollama >/dev/null 2>&1; then
    echo "Ollama server not detected. Starting background service..." >&2
    nohup ollama serve >/dev/null 2>&1 &
    for _ in {1..15}; do
      if curl -s --connect-timeout 1 "${OLLAMA_HOST}/api/tags" >/dev/null 2>&1; then
        return 0
      fi
      sleep 0.5
    done
  fi

  echo "Error: Could not reach Ollama server at ${OLLAMA_HOST}." >&2
  echo "Tip: Run 'ollama serve' in another terminal." >&2
  return 1
}

try_ollama() {
  command -v curl >/dev/null 2>&1 || { echo "Error: curl is required for ollama-commit-msg." >&2; return 1; }
  command -v jq >/dev/null 2>&1 || { echo "Error: jq is required for ollama-commit-msg." >&2; return 1; }
  ensure_ollama || return 1

  # Backticks in the diff (routine in shell scripts/markdown, i.e. most of a
  # dotfiles repo) reliably derail qwen2.5-coder:7b into echoing/garbling a
  # markdown code fence instead of a commit message (reproduced directly
  # against /api/chat: a diff containing `foo` style spans made it return
  # a bare "``" or mangled text). Swap them for single quotes before the diff
  # ever reaches the prompt; only affects what the model sees, not the diff itself.
  local diff_for_ollama="${FULL_DIFF//\`/\'}"
  local prompt
  prompt="$(build_prompt "$diff_for_ollama" "$OLLAMA_MAX_DIFF_CHARS")"

  local few_shot_diff='diff --git a/src/auth/jwt.ts b/src/auth/jwt.ts
--- a/src/auth/jwt.ts
+++ b/src/auth/jwt.ts
@@ -10,3 +10,5 @@
+if (!token) throw new UnauthorizedError("Token missing");'

  local payload
  payload=$(jq -n \
    --arg model "$MODEL" \
    --arg system "$SYSTEM_PROMPT" \
    --arg fs_diff "$few_shot_diff" \
    --arg prompt "$prompt" \
    --argjson num_ctx "$OLLAMA_NUM_CTX" \
    '{
      model: $model,
      messages: [
        {role: "system", content: $system},
        {role: "user", content: ("<staged_diff>\n" + $fs_diff + "\n</staged_diff>\n\nWrite a concise Conventional Commit message for the staged changes above. Output ONLY the commit message text. Do NOT summarize or explain the files.")},
        {role: "assistant", content: "fix(auth): throw error when token is missing"},
        {role: "user", content: $prompt}
      ],
      stream: false,
      options: {
        temperature: 0.1,
        top_p: 0.9,
        num_predict: 256,
        num_ctx: $num_ctx
      }
    }')

  local http_response
  http_response=$(curl -s --connect-timeout 5 --max-time "$OLLAMA_TIMEOUT" \
    -H "Content-Type: application/json" \
    -d "$payload" \
    "${OLLAMA_HOST}/api/chat" || echo '{"error": "curl_failed"}')

  if echo "$http_response" | jq -e '.error' >/dev/null 2>&1; then
    local err_msg
    err_msg="$(echo "$http_response" | jq -r '.error')"
    echo "Error from Ollama ($MODEL): $err_msg" >&2
    if [[ "$err_msg" == *"not found"* ]]; then
      echo "Tip: Run 'ollama pull $MODEL' or set OLLAMA_COMMIT_MODEL." >&2
    fi
    return 1
  fi

  local raw
  raw="$(echo "$http_response" | jq -r '.message.content // empty')"
  [[ -n "$raw" ]] || { echo "Error: Ollama returned an empty message." >&2; return 1; }

  local clean
  clean="$(printf '%s' "$raw" | sanitize_message)"
  if ! looks_like_commit_message "$clean"; then
    echo "Error: Ollama output didn't look like a commit message; discarding. Raw output was:" >&2
    echo "$raw" >&2
    return 1
  fi
  printf '%s' "$clean"
}

# --- Run: Copilot first, Ollama fallback --------------------------------

CLEAN_MSG="$(try_copilot || true)"

if [[ -z "$CLEAN_MSG" ]]; then
  CLEAN_MSG="$(try_ollama || true)"
fi

if [[ -z "$CLEAN_MSG" ]]; then
  echo "Error: no commit message engine produced output (tried Copilot CLI and Ollama)." >&2
  exit 1
fi

printf '%s\n' "$CLEAN_MSG"
