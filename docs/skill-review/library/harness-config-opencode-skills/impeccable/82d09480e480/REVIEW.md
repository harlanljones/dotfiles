# Impeccable Candidate Review (HJ-738)

Disposition: retain as provider-managed frontend-craft skill with explicit
cost, live-loop, and hook consent boundaries. Proposed pack:
`frontend-craft` (optional, proposed — not core). Invocation: explicit
`/impeccable [command] [target]` or a clearly implied design sub-command from
the Commands table in `SKILL.md`; bare `/impeccable` never auto-runs and
presents the context-aware menu from `reference/routing.md`. Execution:
in-session design work for build/refine/fix branches; bounded live-browser
iteration only against the user's running dev server; subagent delegation only
where the reference names it (decision-comp fan-out, asset production, finish
review), with the degraded inline fallbacks otherwise. Alternatives: read-only
critique/audit without edits; code-led build skipping `reference/visualize.md`
by design; manual `npx impeccable detect` instead of the auto hook.

## Full-Tree Evidence

Variant `impeccable:82d09480e480d48c0f66f218081b507a20e5143998d407ff1ddd71c94185a661`,
source `harness-config-opencode-skills`, single local mirror
`/home/harlan/.config/opencode/skills/impeccable` (upstream unknown).
Read all 148 baseline files: `SKILL.md` (86 lines, version 4.1.1,
`user-invocable: true`), 39 reference files (5,238 lines: 35 playbooks plus
`reference/degraded/` fallbacks for harnesses without subagents), 107 scripts
plus `scripts/command-metadata.json` (25 command descriptors). Inventory
records no license file; `SKILL.md:7` declares `license: Apache 2.0` with no
accompanying bytes. No `package.json`: zero npm dependencies — scripts import
only `node:` builtins except one lazy-optional `require('@babel/parser')`
with a `syntax_parser_unavailable` warning fallback
(`scripts/live-copy-edit-agent.mjs:191`) and one `react` import that lives
inside a generated-component template string, not the skill's own dependency
closure (`scripts/live/tanstack-adapter.mjs:177`).

Preserved expertise: brief-wins direction discipline and
refinement-preserves versus redesign-replaces (`SKILL.md:26-30`); visitor modes
Persuade/Operate/Read/Experience; the new-work direction contract
(concept roll, seven-candidate spread, three-comp approval gate with recorded
approval, pixel-sampled inventory, medium gate); the craft floor's verify
checks and category-default refusals; platform-native slop tests with
Material 3 / iOS conventions and device-capture verification; the two-tier
detector (per-edit immediate tier plus Stop-event deep pass) with evidence-bar
triage; doctor's tool/schema/truth drift separation with `auto` as the only
unattended fix; live mode's token-gated loopback server (`127.0.0.1`,
`scripts/live-server.mjs:112,1658`) and localhost-only URL guard.

Source-specific changes (additive only, no instruction rewrite): review-pointer
comments carrying stable question IDs in `SKILL.md`,
`scripts/generate-image.mjs`, `reference/visualize.md`, `reference/live.md`,
`scripts/live-server.mjs`, `reference/hooks.md`, `scripts/hook-lib.mjs`.
Retained: all 25 command branches, routing, craft floor bans, detector rules,
live adapters, degraded fallbacks, and the `npx impeccable` CLI surface.

Reviewed supporting paths: all 148 baseline files (full list in
`review.json` `reviewedFiles`); entrypoint, all 39 references, all 108
script paths, and the command metadata were enumerated in bounded passes with
per-file byte/line/effect evidence (checkpoint: prior worker completed intake
plus the 39-file reference pass; this worker completed the 108-script effect
checkpoint — reads/writes/deletes/subprocess/network/env/server/browser/auth
flags — plus direct reads of the entrypoint, metadata, cost/network/server
scripts, and small references).

## Validation and Questions

Executed (safe, offline, no live services, no spend): `node --check` on the
three edited `.mjs` files (exit 0); `generate-image.mjs` fake-mode smoke in
`/tmp/opencode/hj738` (`IMPECCABLE_IMAGE_GEN_FAKE=1`, 64x64 PNG, valid magic,
`SYNTHETIC` marker, `$0.00`, byte-identical rerun); scoped
`review.py check --source harness-config-opencode-skills --skill impeccable`
(contract-valid); `test_review.py` fixtures (34 passed). Static walkthroughs,
separate from executed tests: no-arg routing returns a menu without running;
comp-led build blocks on code until recorded approval; `config_missing` routes
to `live-setup.md`; hook triage (fix / narrowest ignore with evidence / ask
once); finish-reviewer four-word disposition vocabulary; documenter never
canonizes floor bans into `DESIGN.md`. No live harness comparison, no paid
model or image calls, no dev-server launch.

`Q-impeccable-cost` recommends explicit per-session consent before the
`gpt-image-2` fallback spends the user's OpenAI credit. `Q-impeccable-live`
recommends keeping the live server loopback-bound with project writes scoped
to the user's repo. `Q-impeccable-hook` recommends per-project opt-in for
post-edit auto-runs. `Q-impeccable-license` recommends confirming the
Apache-2.0 declaration and upstream maintenance owner. `Q-impeccable-pack`
recommends provider-managed distribution with optional-pack membership only.
All five remain human decisions; review readiness does not choose them.

## Maintenance and Limits

No live skill, discovery link, activation setting, or provider original was
changed. External dependencies: Node.js runtime; optional `OPENAI_API_KEY`
(cost-bearing, `scripts/generate-image.mjs:206`); optional
`@babel/parser` (graceful fallback); the `impeccable.style/api` roll catalog
(`scripts/concept-seed.mjs:117`, 4s shared deadline, degrades to
assignment-only seed; full catalog does not ship); the external
`npx impeccable` CLI distribution. Possible merge/retirement: none proposed —
the 25 branches share one entrypoint and the `craft` alias is already
deprecated in-tree. Promotion boundary: ready for human review only; core
membership, provider promotion, invocation-metadata support, and the five
open questions stay human-owned. Do not run this skill against live services
as review validation; fixture and fake-mode evidence only.
