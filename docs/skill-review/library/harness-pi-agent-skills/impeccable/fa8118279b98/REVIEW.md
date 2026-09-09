# Review: harness-pi-agent-skills / impeccable (fa8118279b98)

Variant: `impeccable:fa8118279b9820b79d790c2786dd7132ebf0dda416ee1c9122af57ef24215ed4`
Tree: `library/harness-pi-agent-skills/impeccable/fa8118279b98` — 148 files
(1 SKILL.md + 40 reference/*.md + 1 scripts/command-metadata.json + 101
scripts/*.mjs + 5 scripts/*.js), 20 directories, no symlinks, no empty files.
Provenance: local installed tree `/home/harlan/.pi/agent/skills/impeccable`;
upstream version unknown; inventory license status:
"no license file found within bounded source ancestry; permission unknown".
SKILL.md hash `a0e577e0…ca5c` matches the frozen inventory; all 148 live-mirror
hashes re-verified matching before editing. This record is readiness for human
review, not approval, promotion, or deployment.

## Disposition

**retain** — keep as a pi-harness frontend-design skill with the limits below.
No behavioral rewrite was warranted: the entrypoint scoping, per-command
references, degraded (no-subagent) paths, and cost/network disclosures are
already explicit. The only candidate edits are six inline review-question IDs
in five files (HTML/JS comments, no behavior change); everything else is
preserved byte-for-byte, including the vendored
`scripts/modern-screenshot.umd.js` bundle.

## Pack and invocation

- Proposed pack: **optional-frontend-craft** (opt-in design skill, not core).
  Core membership is a human decision; see Q-impeccable-pack.
- Invocation: **explicit only**. `/impeccable <command>` (23 commands in
  SKILL.md Commands table + `scripts/command-metadata.json`; `teach` aliases
  `init`; `craft` is a deprecated no-op alias; `pin.mjs` mints standalone
  `/<command>` shortcuts on request). Bare `/impeccable` reads
  `reference/routing.md` and presents a context-aware menu — it never
  auto-runs a command. `allowed-tools` is pi-scoped
  (`Bash(npx impeccable *)`, `Bash(node .pi/skills/impeccable/scripts/*)`).

## Execution recommendation

- Recommended: **in-session execution** for design work (the skill is a
  prompt + local-script workflow; generation, critique, and fix batches run in
  the requesting thread).
- Alternatives: **bounded in-session delegation** for independent read-only
  passes (detector runs, audit evidence gathering); **isolated worktree** when
  two design threads would write overlapping targets. Live mode already
  constrains its own fan-out (one asset-producer agent per decision-comp card,
  max four in flight; finish review never inherits the build transcript).
- Not granted by this review: install/apply/commit/push, credential access,
  purchases, or running the skill against live services.

## Source-specific changes

1. `SKILL.md` — appended two HTML-comment question IDs
   (Q-impeccable-license, Q-impeccable-pack). No wording changed.
2. `reference/live.md` — appended Q-impeccable-live-authority comment.
3. `reference/hooks.md` — appended Q-impeccable-hooks comment.
4. `scripts/generate-image.mjs` — appended `// Q-impeccable-image-cost`
   comment.
5. `scripts/concept-seed.mjs` — appended `// Q-impeccable-telemetry`
   comment.
6. `REVIEW.md`, `review.json` — new review artifacts (this file + contract).

## Retained expertise (why no rewrite)

- Entry routing with native split: web `adapt.md`/`audit.md` vs
  `adapt.native.md`/`audit.native.md`, plus `ios.md`/`android.md` platform
  references with slop tests, capture commands (`xcrun simctl`, `adb`), and
  touch-type/safe-area rules. Collapsing these would lose the
  web-vs-native guardrails.
- `craft-floor.md` quality floor with absolute bans (e.g. kickers/eyebrows)
  vs defaults the brief can earn back; `operate.md` Operate/Read depth;
  `new-work.md` concept-roll contract with seed key, comp-led/code-led
  build paths, and direction-contract comment; `live.md` poll-loop machine
  with per-harness (Claude Code/Cursor/Codex/other) policy and carbonize
  cleanup gate; `hooks.md` triage ladder with narrowest-ignore preference;
  `doctor.md` auto/mention/route severity discipline; `init.md` PRODUCT.md
  schema with inference-labeling and unattended-probe rule.
- Detector engine (`scripts/detector/…`, `detect.mjs`, `detect-antipatterns.mjs`
  + browser bundle) with two-tier hook surfacing and inline-ignore markers;
  `live/` framework adapters (auto-detected, dev-only); degraded/* inline
  fallbacks for harnesses without subagents, each requiring a one-line
  substitution disclosure.
- Cost/network honesty already in-tree: `generate-image.mjs` states
  gpt-image-2 spend (~$0.05–0.25/image) before first call and ships an
  offline `IMPECCABLE_IMAGE_GEN_FAKE=1` fixture path; `concept-seed.mjs`
  documents the roll API + single choice ping with DO_NOT_TRACK /
  IMPECCABLE_NO_TELEMETRY opt-out; `context.mjs` update check honors
  IMPECCABLE_NO_UPDATE_CHECK and config `updateCheck`; `@babel/parser` is a
  soft optional require (warns `syntax_parser_unavailable`).

## Reviewed supporting paths

All 148 baseline regular files (see `reviewedFiles` in review.json):
SKILL.md; all 40 files under `reference/` (incl. `degraded/` ×4);
`scripts/command-metadata.json`; all 101 `scripts/**/*.mjs`; all 5
`scripts/**/*.js` (incl. vendored `modern-screenshot.umd.js`, preserved
unread-beyond-header — bytes unchanged, hash-covered by the contract).
20 baseline directories covered via the file tree (directory entries are not
listable in `reviewedFiles`, which covers regular files per review.py).
Full-tree read passes: entrypoint + all references (headers + full reads of
SKILL.md, hooks, doctor, craft-floor, operate, new-work, live, live-setup,
routing, ios, init; headers/structure for the rest), metadata JSON, and
script-level sweeps (imports, env vars, network sinks, fs writes, license
headers). Live-mirror hashes for all 148 files matched the frozen inventory
before editing.

## Validation (static walkthroughs separate from executed tests)

Static (no candidate workflow run against live services):
- Bounded full-tree enumeration: 148 files / 20 dirs, no symlinks/empties.
- Frontmatter parse of SKILL.md (name impeccable, version 4.1.1,
  `license: Apache 2.0` claim vs no LICENSE file — see question).
- `command-metadata.json` parses; 23 commands align with the SKILL.md table.
- Import/env/network sweeps: node builtins only at runtime; `svelte`/`react`
  imports are generated template strings for user projects; `@babel/parser`
  optional; network sinks limited to api.openai.com (keyed),
  impeccable.style/api (roll/ping/version, all opt-out-able), localhost:8400
  helper, and user dev-server URLs.
- `node --check` syntax sweep: 103 pass, 0 fail; 4 browser bundles excluded
  (modern-screenshot.umd.js, live-browser.js, live-browser-dom.js,
  detect-antipatterns-browser.js — shipped to browsers, not node).
- Live-mode authority walkthrough (live.md + live-setup.md + live-server.mjs):
  binds localhost helper, injects page script, offers dev-only CSP patch with
  verbatim consent prompt, writes user source on accept — recorded as
  Q-impeccable-live-authority, not executed.

Executed (safe fixtures only, offline):
- `IMPECCABLE_IMAGE_GEN_FAKE=1 node scripts/generate-image.mjs --prompt …`
  to a $TMPDIR path: exit 0, valid PNG bytes, `$0.00, no API call`, no key,
  no network. See evaluations/HJ-741.md for the exact command/result.
- `review.py check --source harness-pi-agent-skills --skill impeccable`:
  exit 0, `allSelectedContractsValid: true` (contract validation only — not
  proof of semantic reading, live behavior, approval, or deployability).

## Limitations

- No live harness evaluation: no browser, dev server, simulator, or model
  run; live-mode, detector accuracy, and image quality are unevaluated.
- No upstream: version unknown, no changelog; `npx impeccable` external CLI
  and `tests/` fixtures referenced by live.md (`tests/live-e2e/agent.mjs`,
  `tests/framework-fixtures/*`) are absent from the candidate and unverified.
- License: SKILL.md claims Apache 2.0 but no license text ships in-tree;
  not a redistribution permission (Q-impeccable-license).
- `modern-screenshot.umd.js` (vendored, ~29 KB) preserved by hash, not
  audited line-by-line.
- Graph tools unavailable; evidence is source inspection with exact paths.
- Author and verifier are the same agent; no independent second-model
  review is claimed.

## Indexed questions

- Q-impeccable-license (SKILL.md) — confirm license text before any
  redistribution/promotion. Recommendation: obtain the Apache 2.0 text or
  correct the frontmatter claim.
- Q-impeccable-pack (SKILL.md) — core vs optional-frontend-craft.
  Recommendation: ship as optional; core needs workflow-evidence, not
  collection size.
- Q-impeccable-live-authority (reference/live.md) — localhost server +
  page injection + CSP edits + source writes. Recommendation: keep
  per-project consent and dev-only guards; do not broaden silently.
- Q-impeccable-hooks (reference/hooks.md) — auto-run detector, Cursor
  write-blocking. Recommendation: keep opt-in per project with consent
  record; never enable as a side effect.
- Q-impeccable-image-cost (scripts/generate-image.mjs) — OpenAI spend.
  Recommendation: keep pre-first-call cost statement and fake fixture.
- Q-impeccable-telemetry (scripts/concept-seed.mjs) — roll API + choice
  ping. Recommendation: keep opt-outs and offline degraded path; no new
  sinks without review.

## Provider / upstream-update implications

- Pi build (`scripts/lib/provider.mjs`: `IMPECCABLE_PROVIDER_ID = "pi"`,
  `/impeccable` prefix). Hooks.md also documents Claude Code / Codex /
  Cursor / Copilot manifests — on pi the skill itself notes no design hook
  runs (new-work §7: hookless web build runs `detect.mjs` once instead).
  Promotion on another harness needs that harness's hook wiring re-verified.
- Upstream unknown: `context.mjs` `UPDATE_AVAILABLE` + `npx impeccable
  update` rewrites skill files in place — updates arrive outside this
  review; each update needs re-review (hashes will move).
- External dependencies: node runtime only (builtins) + optional
  `@babel/parser` from the user project + `npx impeccable` CLI for
  hook/detect-admin flows + user-held OPENAI_API_KEY for the image
  fallback + https://impeccable.style reachability for roll/version/ping
  (all with offline/degraded paths).

## Promotion boundary

Ready for human review. Not approved, not core, not a redistribution
permission. Human decisions required: license confirmation,
optional-vs-core pack, live/hook authority posture, telemetry default,
image-cost consent. Do not install, apply, commit, push, or run against
live services on the strength of this review.
