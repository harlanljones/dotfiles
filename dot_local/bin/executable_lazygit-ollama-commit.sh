#!/usr/bin/env bash
#
# lazygit-ollama-commit.sh
#
# Generates a clean Conventional Commit message from staged git changes
# using a local Ollama model, then opens it in $EDITOR (via `git commit --edit`)
# for review/tweaking before finalizing.
#

set -eu

# --- Configuration -----------------------------------------------------

MODEL="${OLLAMA_COMMIT_MODEL:-qwen2.5-coder:7b}"
OLLAMA_HOST="${OLLAMA_HOST:-http://localhost:11434}"
MAX_DIFF_CHARS="${OLLAMA_COMMIT_MAX_DIFF_CHARS:-20000}"
OLLAMA_NUM_CTX="${OLLAMA_COMMIT_NUM_CTX:-8192}"
OLLAMA_TIMEOUT="${OLLAMA_TIMEOUT:-30}"

# --- Sanity checks ----------------------------------------------------

if ! command -v git >/dev/null 2>&1; then
  echo "Error: git is not installed or not on PATH." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository." >&2
  exit 1
fi

if ! command -v curl >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  echo "Error: curl and jq are required for lazygit-ollama-commit." >&2
  exit 1
fi

# Check for staged changes
STAT="$(git diff --cached --stat)"
if [[ -z "$STAT" ]]; then
  echo "Error: no staged changes found. Stage something first (git add)." >&2
  exit 1
fi

# --- Ensure Ollama is reachable ---------------------------------------

ensure_ollama() {
  if curl -s --connect-timeout 2 "${OLLAMA_HOST}/api/tags" >/dev/null 2>&1; then
    return 0
  fi

  # Auto-start ollama if connecting to localhost and ollama binary exists
  if [[ "$OLLAMA_HOST" == *"localhost"* || "$OLLAMA_HOST" == *"127.0.0.1"* ]] && command -v ollama >/dev/null 2>&1; then
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

ensure_ollama

# --- Build diff & context ----------------------------------------------

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

DETAILED_DIFF="$(git diff --cached --no-color -- "${EXCLUDE_PATTERNS[@]}" 2>/dev/null || true)"

# Fall back to full diff if excluding generated files left diff empty (e.g. only lockfiles staged)
if [[ -z "$DETAILED_DIFF" ]]; then
  DETAILED_DIFF="$(git diff --cached --no-color)"
fi

# Clean line-boundary truncation if diff exceeds MAX_DIFF_CHARS
IS_TRUNCATED=false
if (( ${#DETAILED_DIFF} > MAX_DIFF_CHARS )); then
  IS_TRUNCATED=true
  DETAILED_DIFF="$(echo "$DETAILED_DIFF" | head -c "$MAX_DIFF_CHARS" | sed -e '$d')"
fi

# Assemble user prompt with high-level file stats and staged diff.
# Placing the task directive at the bottom (after diff delimiters) prevents
# the LLM from drifting into file summaries or code review descriptions.
if [[ "$IS_TRUNCATED" == "true" ]]; then
  PROMPT_CONTENT="<staged_files_summary>
${STAT}
</staged_files_summary>

<staged_diff>
${DETAILED_DIFF}
[Note: Diff was truncated to fit context limits]
</staged_diff>

Write a concise Conventional Commit message for the staged changes above.
Output ONLY the commit message text. Do NOT summarize or explain the files."
else
  PROMPT_CONTENT="<staged_diff>
${DETAILED_DIFF}
</staged_diff>

Write a concise Conventional Commit message for the staged changes above.
Output ONLY the commit message text. Do NOT summarize or explain the files."
fi

# --- System Prompt & Format Rules -------------------------------------

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

# --- Call Ollama Chat API with Few-Shot Example -----------------------

FEW_SHOT_DIFF='diff --git a/src/auth/jwt.ts b/src/auth/jwt.ts
--- a/src/auth/jwt.ts
+++ b/src/auth/jwt.ts
@@ -10,3 +10,5 @@
+if (!token) throw new UnauthorizedError("Token missing");'

PAYLOAD=$(jq -n \
  --arg model "$MODEL" \
  --arg system "$SYSTEM_PROMPT" \
  --arg fs_diff "$FEW_SHOT_DIFF" \
  --arg prompt "$PROMPT_CONTENT" \
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

HTTP_RESPONSE=$(curl -s --connect-timeout 5 --max-time "$OLLAMA_TIMEOUT" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  "${OLLAMA_HOST}/api/chat" || echo '{"error": "curl_failed"}')

# Check for API error
if echo "$HTTP_RESPONSE" | jq -e '.error' >/dev/null 2>&1; then
  ERR_MSG="$(echo "$HTTP_RESPONSE" | jq -r '.error')"
  echo "Error from Ollama ($MODEL): $ERR_MSG" >&2
  if [[ "$ERR_MSG" == *"not found"* ]]; then
    echo "Tip: Run 'ollama pull $MODEL' or set OLLAMA_COMMIT_MODEL." >&2
  fi
  exit 1
fi

RAW_OUTPUT="$(echo "$HTTP_RESPONSE" | jq -r '.message.content // empty')"

if [[ -z "$RAW_OUTPUT" ]]; then
  echo "Error: Ollama returned an empty message." >&2
  exit 1
fi

# --- Post-process & Sanitize Message -----------------------------------

# Clean up common LLM artifacts:
# 1. Strip <think>...</think> tags if reasoning model used
# 2. Strip code fences (```, ```git, ```markdown)
# 3. Strip common intro headers ("Here is...", "Commit message:", "Subject:", etc.)
# 4. Strip matched surrounding quotes on subject line
# 5. Extract starting from conventional commit line if preamble preceded it
# 6. Normalize trailing whitespace and remove initial blank lines

CLEAN_MSG="$(echo "$RAW_OUTPUT" | awk '
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
' | sed -e '1s/^\(["'\''`]\)\(.*\)\1$/\2/' | sed -e '/^[[:space:]]*$/{ $d; }' | sed '/./,$!d')"

if [[ -z "$CLEAN_MSG" ]]; then
  echo "Error: Sanitized commit message is empty. Raw output was:" >&2
  echo "$RAW_OUTPUT" >&2
  exit 1
fi

# --- Open Editor for Review -------------------------------------------

TMP_MSG_FILE="$(mktemp /tmp/lazygit-ollama-commit.XXXXXX.txt)"
trap 'rm -f "$TMP_MSG_FILE"' EXIT

printf '%s\n' "$CLEAN_MSG" > "$TMP_MSG_FILE"

# git commit with the generated message loaded into your editor for
# review/edit before it's finalized.
git commit --edit --file="$TMP_MSG_FILE"

