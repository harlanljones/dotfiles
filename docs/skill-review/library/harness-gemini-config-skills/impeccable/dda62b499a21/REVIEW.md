# Impeccable Candidate Review (harness-gemini-config-skills)

Disposition: retain with provider-limitation corrections. Proposed pack:
`frontend-design`, task-triggered and optional, not universal core. Invocation:
explicit `/impeccable <command>` or a clearly implied frontend-design request;
bare invocation presents the routing menu and never auto-runs a command.
Execution: in-session for design, critique, audit and refinement passes;
bounded delegation for parallel comp generation and the shipped
finish-reviewer/documenter/manual-edit-applier subagents where the harness
supports them; live mode only with a running dev server plus browser tooling.

## Full-Tree Evidence

Read all 148 baseline files: `SKILL.md` (84 lines), 39 `reference/*.md`
(including 4 `reference/degraded/*.md` hookless fallbacks), and 108
`scripts/**/*` (1 JSON manifest, 5 `.js`, 102 `.mjs`; 3.26 MB, 72,571 lines
total). Provenance, exact hashes and mirrors are the `inventory.json` entry
for this candidate path: single installed mirror at
`/home/harlan/.gemini/config/skills/impeccable`, upstream unknown, version
`4.1.1` from `SKILL.md` frontmatter only. No license file was discovered for
this variant; the frontmatter `license: Apache 2.0` line is a claim without
accompanying license text, so redistribution rights are not inferred from
local installation. All binary/vendored asset bytes are preserved unchanged:
`scripts/live-browser.js`, `scripts/modern-screenshot.umd.js` and
`scripts/detector/detect-antipatterns-browser.js` are untouched.

Pass 1, entrypoint and routing: `SKILL.md` Setup (context.mjs boot, one
playbook, craft-floor before edits), Modes (Persuade/Operate/Read/Experience),
26-row Commands table, routing (explicit command, no-argument menu, general
design fallback), Pin, Hooks, Doctor, never-repair-drift rule.

Pass 2, references: all Build (craft/shape/init/document/extract), Evaluate
(critique/audit/audit.native), Refine (polish/bolder/quieter/distill/harden/
onboard), Enhance (animate/colorize/typeset/layout/delight/overdrive), Fix
(clarify/adapt/adapt.native/optimize), Iterate (live/live-setup) and platform
(ios/android/routing/operate/craft/craft-floor/visualize/document/doctor/hooks)
playbooks, plus the 4 degraded fallbacks. Audit keeps deterministic detector
findings separate from visual judgment with a 0-4 five-dimension scorecard.

Pass 3, core/config scripts: `context.mjs` (boot, update check, hook-mode
resolution), `lib/provider.mjs`, `lib/impeccable-config.mjs`,
`lib/impeccable-paths.mjs`, `lib/staleness*.mjs`, `lib/*catalog*.mjs`,
`lib/design-parser.mjs`, `lib/template-extensions.mjs`, `lib/surface-briefs.mjs`,
`lib/target-*.mjs`, `lib/artifact-schema.mjs`, `lib/roll-selection.mjs`,
`lib/is-generated.mjs`, `lib/open-system-browser.mjs`, `doctor.mjs`,
`hook.mjs`, `hook-lib.mjs`, `hook-admin.mjs`, `hook-before-edit.mjs`,
`detect.mjs`, `detect-csp.mjs`, `embed-prompt.mjs`, `generate-image.mjs`,
`concept-seed.mjs`, `context-signals.mjs`, `critique-storage.mjs`,
`palette.mjs`, `pin.mjs`, `serve-question.mjs`, `surface-brief.mjs`,
`command-metadata.json` (23 command keys covering every Commands-table verb), `live-accept.mjs`.

Pass 4, detector subsystem (`scripts/detector/**`, 18 files): browser injected
bundle, CLI entry, design-system, antipattern registry/rules, regex/static-html/
visual engines, node file-system, profiler, shared color/constants/fonts/
inline-ignores/page/findings helpers.

Pass 5, live subsystem (`scripts/live*/**`, ~60 files): server (token-gated
loopback CORS, SSE/poll, annotation upload, manual-edit stash/commit/discard),
poll/resume/status/complete, inject/insert/wrap/target, browser DOM/session
scripts, framework adapters (astro/nextjs/nuxt/sveltekit/tanstack-start/
vite-generic/static-html), svelte AST/component injection, session-store,
source-lock/search, event-validation, vocabulary, ui-surfaces, instructions,
generation-preflight, manual-apply with transaction rollback, and
`live-copy-edit-agent.mjs` (Codex/Claude/chat/mock runners).

Preserved expertise: bounded verification ceiling (batched screenshot rounds,
at most one confirm round), brief-wins and refinement-vs-redesign rules,
evidence-based visual authority, visitor modes, native slop tests and size-
class-driven adaptivity, motion thesis with budgets and reduced-motion paths,
detector two-tier rule surfacing, token-gated live server, source-locked
accept with carbonize cleanup, and per-harness poll/hook policy.

## Provider Diff and Changes

This is the Antigravity provider build (`scripts/lib/provider.mjs:4`
`IMPECCABLE_PROVIDER_ID = "antigravity"`) stored under the Gemini config
tree, distinct from `harness-gemini-skills/impeccable/ea77c0b5c398` (`.gemini`
paths) and `shared/impeccable/2053dc80fb14` (`.agents` paths, `$` prefix):
fallbacks here are `.agent/skills/impeccable/scripts`, command prefix `/`,
and only this variant carries `allowed-tools` + `license: Apache 2.0`
frontmatter. `SKILL.md` gains three review annotations, nothing else changed:
the update-check opt-out, the Antigravity hook limitation, and the copy-edit
runner cost/bypass note.

Consequential findings, each with exact source:

- Hook gap: `reference/hooks.md:47` answers `hooks on` with "The design hook
  will fire after the next Edit/Write/MultiEdit on a UI file", but
  `scripts/hook-admin.mjs:73-141` installs manifests only for Claude
  (`.claude`), Codex (`.codex`, also via `.agents`), Cursor (`.cursor`) and
  Copilot (`.github`); `scripts/context.mjs:1224-1231` drift map adds grok but
  no antigravity entry, so `automaticHookMode` (`context.mjs:1262-1280`)
  resolves `HOOK_MANIFESTS_BY_PROVIDER["antigravity"] || []` to `none`. The
  loader degrades correctly (`reference/hooks.md:9`
  `MANUAL_DETECTOR_REQUIRED`), but the `hooks on` reply over-promises on this
  provider. `SKILL.md` now states the limitation inline.
- Network/cost authority: `scripts/context.mjs:70-81,1039,1056` piggybacks a
  daily version poll on boot (`FETCH_TIMEOUT_MS = 1200`, cache
  `~/.impeccable/update-check.json`), silent on failure, disabled only via
  `IMPECCABLE_NO_UPDATE_CHECK=1`. `SKILL.md` Setup now names the opt-out.
- External execution authority: `scripts/live-copy-edit-agent.mjs:566-596`
  shells `codex exec --dangerously-bypass-approvals-and-sandbox --ephemeral`
  and `claude --print --permission-mode bypassPermissions`, spending real
  model calls; `mock`/`chat` alternatives and per-provider diagnostics
  (`describeNoProviderError`) are retained. `SKILL.md` now names the mock dry
  run. Spawning finish-reviewer/documenter/manual-edit-applier subagents is
  the workflow default wherever the harness supports it (`reference/
  new-work.md:112,120`, `reference/live.md:303`); hookless harnesses use the
  `reference/degraded/*.md` in-thread passes with one-line disclosure.

## Validation and Questions

Static walkthroughs (no live harness, no network, no paid calls): bare
invocation routes to the menu; explicit command loads one playbook;
`hooks on` on Antigravity reports `none` + manual detector fallback;
`UPDATE_AVAILABLE` offers `npx impeccable update` and never blocks boot;
live Apply with no runner prints the per-provider fix list; carbonize accept
requires `live-complete.mjs` before the next poll. Executed safe checks:
`node --check` parse over all 107 `.mjs`/`.js` scripts, JSON parse of
`command-metadata.json`, and `review.py check --source
harness-gemini-config-skills --skill impeccable`.

`Q-impeccable-hooks-antigravity` in `SKILL.md` asks whether `hooks on` should
report the Antigravity no-manifest fallback instead of the fire-after-edit
promise. Recommend reporting the fallback, since no installer manifest exists
for this provider. `Q-impeccable-update-check` in `SKILL.md` asks whether the
opt-out daily version poll stays acceptable as boot behavior. Recommend
keeping it with the documented env opt-out, since it is throttled, silent on
failure, and never blocks context output. `Q-impeccable-copy-edit-runners` in
`SKILL.md` asks whether skill invocation alone should authorize
approval-bypassing CLI runners and real model spend. Recommend explicit user
confirmation before the first non-mock Apply per project, since bypass flags
and cost exceed ordinary edit authority.

## Maintenance and Limits

No live Antigravity/Gemini harness evaluation, no network calls, and no paid
model invocations were performed for this review. Upstream maintenance owner
is unknown (local installed tree); promotion needs a discovered license file,
cross-harness hook-matrix tests, and human decisions on all three questions.
The `portableLocal`/explicit-link distribution shape is integration work, not
repaired here. No candidate workflow was run against live services; no
install, apply, commit, push, or settings change was made.
