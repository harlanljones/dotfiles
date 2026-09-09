# Impeccable (Gemini) Candidate Review

Disposition: retain as the Gemini-CLI provider build; candidate only, not approval or deployment. Proposed pack: provider-scoped frontend-design craft for Gemini CLI projects, not universal core. Invocation: explicit `/impeccable` with the SKILL.md Commands table (23 sub-commands plus `pin`, `hooks`, `doctor`); no-argument invocations get the context-aware menu from `reference/routing.md` and never auto-run. Execution: in-session agentic runs by default. `critique` mandates two isolated sub-agents (dual-agent header or `DEGRADED` banner); `live` needs a running dev server with HMR plus browser automation; `serve-question.mjs` blocks on a loopback decision page. Alternatives: bounded read-only delegation for audit/critique evidence gathering; worktrees do not isolate the loopback helper ports or the user's browser.

## Evidence and Changes

Read the complete frozen tree: `SKILL.md` (80 lines, v4.1.1), all 39 `reference/` playbooks (35 topical plus 4 `degraded/` fallbacks), `scripts/command-metadata.json` (23 commands), and all 107 scripts (102 `.mjs`, 5 `.js`). Provenance, exact hashes, mirrors, and tree id `impeccable:ea77c0b5c3987755bfbaf2f5464043ee49fa2005ca62343c9b65ba4f48c56553` are the `inventory.json` entry for this candidate path. The sole source mirror is the local installed tree `/home/harlan/.gemini/skills/impeccable` (upstream unknown, version 4.1.1 from frontmatter only).

No semantic rewrite was warranted: the provider build is coherent and its adaptations are deliberate. Changes are six inline review questions only, one line each, preserving every instruction byte around them:

- `SKILL.md`: `Q-impeccable-frontmatter` on the missing license/invocation frontmatter.
- `reference/hooks.md` + `scripts/hook-admin.mjs`: `Q-impeccable-hooks-gemini` on the absent Gemini hook target.
- `scripts/generate-image.mjs`: `Q-impeccable-image-cost` on OpenAI-credit spend disclosure.
- `scripts/context.mjs`: `Q-impeccable-update-check` on the default-on version phone-home.
- `scripts/live-server.mjs`: `Q-impeccable-vendored-screenshot` on the unversioned vendored bundle.
- `scripts/live-copy-edit-agent.mjs`: `Q-impeccable-copy-agent` on the codex/claude-only agent choice.

Retained expertise: mode-gated design authority (Persuade/Operate/Read/Experience), the new-work concept roll with challenger verdicts and comp-led/code-led contracts, the craft floor's mechanical checks and refusal list, dual-assessment critique with Nielsen scoring and personas, platform references (iOS slop test, Material 3 conformance), the live variant loop with carbonize cleanup and `accept-verify.mjs` postconditions, strict live event validation, loopback-only helper servers with token auth, and the detector's two-tier hook integration.

## Provider Differences (vs Claude-Coupled Sibling)

Diffed file-by-file against `library/harness-claude-skills/impeccable/6c5d5e55dd40`: identical path sets, 22 files differ. All reference diffs are mechanical `.claude/skills/impeccable` to `.gemini/skills/impeccable` path swaps and `CLAUDE.md` to `GEMINI.md` context-file swaps, except: (1) every `STOP and call the AskUserQuestion tool` became `Ask the user directly to clarify what you cannot infer` (`bolder`, `critique`, `distill`, `document`, `extract`, `init`, `overdrive`, `quieter`) — Gemini CLI exposes no native question tool, correctly adapted; (2) `craft-floor.md` gains two lines banning hover animation on images, absent from the Claude tree; (3) `new-work.md` omits the Claude tree's `measured rendition prior` paragraph; (4) `SKILL.md` frontmatter drops `user-invocable`, `argument-hint`, `license: Apache 2.0`, and `allowed-tools`; (5) `scripts/lib/provider.mjs` declares `gemini` with `/` prefix. `pin.mjs` and `hook-admin.mjs` still enumerate the other harnesses' directories, so cross-harness pin/repair keeps working from a Gemini checkout.

## Validation

Executed (safe, offline, no candidate workflow run against live services): mirror hash comparison 148/148 pass against `/home/harlan/.gemini/skills/impeccable`; `node --check` over all 107 scripts pass; `command-metadata.json` parses and names the 22 pinned commands plus `craft`; relative markdown-link walk over all 40 markdown files; pure-function fixture imports (`target-slug`, `event-validation`, `accept-verify`, `provider`) with 9 assertions pass, zero writes, zero network; scoped `review.py check --source harness-gemini-skills --skill impeccable` contract-valid. Static walkthroughs kept separate: critique dual-agent flow, live generate/accept/carbonize loop, hooks `on` on a Gemini-only project (repairs nothing), and copy-edit Apply with no codex/claude CLI present (returns null; degraded manual-edit path applies inline).

## Limitations

No live harness evaluation: no browser, dev server, image generation, or hook installation was run. No license file exists in-tree; only two SPDX headers (`Apache-2.0`, Paul Bakaus) in the detector facade files, so redistribution rights are unknown. Upstream version beyond frontmatter `4.1.1` is unverified, and the `GEMINI.md ## Design Context` writer that `critique.md` personas depend on is not specified anywhere in-tree. Maintenance ownership and merge/retirement against the six sibling impeccable variants remain human decisions.

## Questions

- `Q-impeccable-frontmatter` (SKILL.md): add license/invocation metadata once Gemini loader support is verified; until then the REVIEW record carries the license gap.
- `Q-impeccable-hooks-gemini` (hooks.md, hook-admin.mjs): document hookless operation (`MANUAL_DETECTOR_REQUIRED`) as the expected Gemini state.
- `Q-impeccable-image-cost` (generate-image.mjs): keep explicit pre-call cost disclosure; never persist the user's key.
- `Q-impeccable-update-check` (context.mjs): keep throttled silent-fail default; document the host opt-out.
- `Q-impeccable-vendored-screenshot` (live-server.mjs): pin upstream version and license before promotion.
- `Q-impeccable-copy-agent` (live-copy-edit-agent.mjs): confirm whether a Gemini CLI wake path is wanted or degraded-inline remains the contract.

## Promotion Boundary

Keep under its Gemini-harness owner; do not merge with the Claude/Opencode/Pi siblings — the AskUserQuestion adaptation, GEMINI.md references, and frontmatter shape are provider-specific. Promotion needs human answers to all six questions, a license determination, and a live-harness evaluation of critique, live, and hooks paths. No install, apply, commit, push, purchase, or credential access was performed or is authorized by this review.
