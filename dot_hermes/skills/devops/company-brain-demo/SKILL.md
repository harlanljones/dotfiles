---
name: company-brain-demo
description: Use when working on the brain repo's demo stack or recipes.
---

# company-brain demo stack

Workflow and pitfalls for the brain repo's demo pipeline (docker-compose GBrain + Postgres at localhost:3131, real Slack + Drive feeds, persona-scoped OAuth clients) in ~/dev/brain. AGENTS.md in the repo is authoritative for boundaries (read-only sources, fail-closed, data safety) — this skill carries the procedure and the traps, not the governance.

## Procedure: prepare / re-apply the v2 demo

1. **Secret store first.** The v2 path reads the gitignored store `cloud/local/.secrets/`, NOT `.env`. `bun run cloud/local/scripts/secrets.ts init` then `set` SLACK_BOT_TOKEN (must start `xoxb-`), GOOGLE_SERVICE_ACCOUNT (stored as a PATH to the key JSON, validated for client_email/private_key/token_uri), and the LLM key. Store layout: one file per secret under `cloud/local/.secrets/` (lowercase name, 0600). `serve-ui.sh` preflights the store and fails closed; `.env` is only the v1 legacy path (`serve-ui.sh --v1`) — keys added to .env are inert.
   - Pitfall: `secrets.ts get NAME` uses top-level await — capturing it in `$(...)` yields `[object Promise]`. Use `secrets.ts check NAME` to validate; to fix a bad value, overwrite the store file directly (`printf '%s' <value> > .secrets/<name> && chmod 600`).
2. **Apply the recipe.** `bun run scripts/apply-recipe.ts demo-v2.recipe.yaml` — pulls real Slack + Drive feeds into `gbrain-corpus/`, rewrites the whole stack (`down -v`), git-inits each bucket, syncs, registers one GBrain source per bucket and one OAuth client per persona, writes `.sandbox-credentials.json`, and runs the smoke suite. Re-run it after ANY corpus/recipe change — it is designed to be idempotent from a clean slate.
   - Fail-closed gate: every persona accessClass is checked against what the feeds actually produced; a class naming a channel/folder the real feeds did not produce fails the apply loudly. Recipe grammar is `slack:<channel>` (no `#`) and `drive:<drive>/<folder>` — drive matches on the LAST path segment only. The corpus is ground truth — derive source names from `gbrain-corpus/` paths, never from the recipe's own contentManifest prose.
   - Bucket grant rule: a persona gets a bucket only when EVERY source inside it is in their accessClasses — a mixed bucket is denied whole. Two channels with identical member sets land in one bucket, so a persona scoped to one necessarily holds both — reflect that in the persona narrative instead of fighting the granularity.
3. **Verify and launch.** Smoke suite must pass before serving (probes = 2 per persona; a persona granted every source in the corpus skips its denied probe with an explicit notice — that is a pass, not a failure). Restart `./serve-ui.sh` after EVERY apply and after any demo-ui HTML edit — the server snapshots tokens and page HTML at startup, so a running instance serves 401s and stale pages across an apply; it re-runs the per-persona smoke suite (fail-fast) before binding :8787. `launch-demo.sh` additionally opens the Chrome/herdr layout.
   - Concurrency: only one apply/serve-ui at a time. apply-recipe runs `down -v` and rewrites `.sandbox-credentials.json` — a second concurrent pipeline (another session, another recipe) wipes the stack and overwrites the credential set out from under the running UI. If identities/tokens look like an older apply, a concurrent runner rewrote the file; coordinate instead of re-applying on top.

## Pitfalls

- Corpus bucket repos must set `commit.gpgsign false`: the host's global git signing (1Password agent) makes `git commit` fail with 'failed to write commit object' when the agent is unreachable, leaving zero commits and the bucket invisible to sync — apply-recipe now does this and treats commit exit codes >1 as fatal (only exit 1 is 'nothing to commit').
- GBrain's walker reads sources through git objects, so every corpus bucket directory must be a git repo with committed files — untracked files are invisible to sync, and an empty commit is not enough. The corpus is regenerated fresh each apply, so the git init/commit must happen inside the apply flow, on the host (the /corpus mount is read-only in the container).
- Host git hooks (Conventional-Commit commit-msg) reject corpus commits and leave nothing committed while the script misreads it as 'no changes'. Always `git commit --no-verify` for throwaway corpus repos — check for the hook failure before assuming a commit failed for content reasons.
- Semantic retrieval (post-embedding) returns top-k matches for nearly any query, so a denied probe fails with 'returned N sources' unless the query's vocabulary is distinctive to the denied sources. Build denied probes from words verified absent in the persona's allowed buckets; broad queries ('what is discussed in #x') always retrieve something from allowed buckets. Re-verify probe vocabulary against the live corpus after ANY connector/recipe change — pruning a connector can move a doc's vocabulary into an allowed bucket (or delete the only denied bucket, which turns the probe into a skip), invalidating previously passing probes.
- Never leave apply-recipe runs in the background unaccounted for: a stale apply finishing late re-registers the OLD recipe's clients and rewrites .sandbox-credentials.json, silently reverting a newer migration. Poll to completion and reconcile the credentials file before verifying anything else.
- serve-ui.ts caches the demo-ui HTML at startup — restart ./serve-ui.sh after editing demo-ui/*.html or the served pages stay stale.
- When the recipe's personas/sources change, sweep the demo-ui pages for retired narrative copy (grep for the old persona identities, channel names, and example queries in PRESETS/DEMO_SCRIPT/explainer text) — stale synthetic-era strings survive silently in presenter copy long after the data behind them is gone.
- The LLM's honest refusal enumerates its allowed pages ('the retrieved pages discuss…'), which trips naive keyword-leak scorers. The scorer in scripts/smoke.ts must be phrase-level (keywords must co-occur in one denied line), stem query words, and ground out vocabulary that also occurs in allowed buckets. When tuning probes fails repeatedly, suspect the scorer, not the access control. Read the smoke scorer before reshaping probes: evaluateDenied requires zero sources AND no leakage for denied probes; granted probes require a non-empty cited answer.

## LLM provider wiring

- GBrain reads provider keys from its own Postgres config, NOT env vars, and `down -v` wipes that config — entrypoint.sh must re-assert `models.default`, `models.tier.deep`, and the provider key on every container start. The gateway reads the key from its own config, NOT the env var; docker-compose.yml must pass the env var through for the entrypoint to assert it.
- Model ids are `provider:model`; OpenRouter uses the nested form `openrouter:<vendor>/<model>` (e.g. `openrouter:anthropic/claude-haiku-4.5`). GBrain supports OpenRouter, DeepSeek, and Anthropic natively; Voyage is the embedding provider and is wired separately via GBRAIN_EMBEDDING_MODEL + VOYAGE_API_KEY in docker-compose.
- Keep the demo on Haiku-class or cheaper; provider swap is one config-set line, so do not fork code over it. See `references/model-choice.md` for the scored model decision matrix and swap checklist.

## Google Drive / service-account auth

- The Drive collector acts as the SA itself (no domain-wide delegation): it only sees files explicitly shared with the SA's email. `check-google-credentials.ts <key.json>` validates shape fast.
- Verify drive access by minting a JWT from the key (RS256, header + claims, drive.readonly scope) — the same flow as google-auth.ts. Remember the JWT header; omitting it returns `invalid_request`.
- gcloud ADC impersonation of the SA (`--impersonate-service-account`) requires `iam.serviceAccounts.getAccessToken` — usually absent; the key-file path is the reliable route.
- The SA auth path lists `/drive/v3/files` only — it never enumerates shared drives (no `includeItemsFromAllDrives`). If the demo is supposed to cover shared drives, confirm with the operator that the drives are shared with the SA email AND expect collector changes; files shared directly appear under container `shared-with-bot` when the parent folder is unresolvable.

## Command-gate notes

- Inline `bun -e` scripts (Drive JWT checks) trip the security gate and need user approval; keep each probe a single self-contained call and expect to wait for approval. The gbrain container health check is `curl -sf http://localhost:3131/health`.
