# Frontier Sweep — HJ-738 through HJ-742: five source-grounded skill-candidate reviews

Single-PR branch consolidating five Skills Review tickets, each independently
implemented in its own Herdr worktree and dispatcher-verified before
consolidation. All changes are byte-identical to the verified per-ticket
worktrees. No commits, pushes, installs, applies, or live-service runs were
performed by any worker; Linear mutations below were made only by the
single dispatcher.

## Tickets

| Ticket | Candidate | Disposition |
|--------|-----------|-------------|
| HJ-738 | `harness-config-opencode-skills/impeccable/82d09480e480` (148 files, v4.1.1) | retain, optional `frontend-craft` pack, never core; 5 questions |
| HJ-739 | `harness-gemini-config-skills/impeccable/dda62b499a21` (148 files, v4.1.1) | retain with corrections; 3 questions |
| HJ-740 | `harness-gemini-skills/impeccable/ea77c0b5c398` (148 files, v4.1.1) | retain as Gemini-CLI provider build; 6 questions |
| HJ-741 | `harness-pi-agent-skills/impeccable/fa8118279b98` (148 files) | retain, optional-frontend-craft, explicit invocation; 6 questions |
| HJ-742 | `pack-agent-reach/agent-reach/6cfca4cc59cc` (9 files) | retain with authority corrections, optional `internet-research-acquisition` pack; 2 questions |

Completion is review readiness, not approval, promotion, or deployment.

## Changes (per ticket)

- **HJ-738** — 7 additive one-line review-pointer lines (Q-ID tokens, no
  semantics changed) across `SKILL.md`, `reference/{hooks,live,visualize}.md`,
  `scripts/{generate-image,hook-lib,live-server}.mjs`; new `REVIEW.md`,
  `review.json` (148 reviewedFiles, 5 questions), `evaluations/HJ-738.md`.
  Key boundaries: image-generation cost, live-loop authority, hook consent,
  license, pack placement.
- **HJ-739** — 3 minimal provider-limitation annotations in `SKILL.md`
  (Antigravity has no hook manifest so `hooks on` over-promises; throttled
  opt-out version poll; live Apply may wake Codex/Claude CLIs with real
  spend); new `REVIEW.md`, `review.json`, `evaluations/HJ-739.md`.
- **HJ-740** — 7 one-line question insertions across `SKILL.md`,
  `reference/hooks.md`, `scripts/{context,generate-image,hook-admin,
  live-copy-edit-agent,live-server}.mjs`; new `REVIEW.md`, `review.json`
  (148/148 reviewedFiles, 6 questions), `evaluations/HJ-740.md`. Frozen
  source-mirror hashes 148/148 match.
- **HJ-741** — 5 comment-only question IDs across `SKILL.md`,
  `reference/{live,hooks}.md`, `scripts/{concept-seed,generate-image}.mjs`;
  new `REVIEW.md`, `review.json` (148 reviewedFiles, 6 questions),
  `evaluations/HJ-741.md`. Notable: Apache-2.0 claim with no LICENSE
  in-tree; live-mode localhost/CSP/source-write authority.
- **HJ-742** — narrowed invocation/authority boundaries in both entrypoints
  (`SKILL.md`, `SKILL_en.md`) and 5 references (login, credential and
  browser-session use, installs, system config, GitHub writes all require
  explicit user authorization); new `REVIEW.md`, `review.json`,
  `evaluations/HJ-742.md`.

Plus regenerated `INDEX.json` / `INDEX.md` (new review artifacts change the
tracked-file index; generated, never hand-edited).

## Testing

Per-ticket scoped checks, each rerun by the dispatcher in the ticket
worktree before consolidation (exit 0 throughout):

- `review.py check --source <src> --skill <skill>` — 1/1 contract-valid,
  0 errors, for all five tickets.
- `test_review.py` — 34 passed; `test_inventory.py` — 13 passed;
  `evaluations/test_local.py` — 2 passed.
- `git diff --check` — clean in every worktree.
- HJ-740: `node --check` 107/107 scripts; markdown links 87/87.
- HJ-741: `node --check` 103 pass; fake-mode image-gen smoke → valid PNG,
  $0.00, no API call. (Command count corrected 22→23 during validation.)
- HJ-738: `node --check` on edited `.mjs`; fake-mode image-gen smoke →
  valid PNG, byte-identical rerun.
- Post-consolidation, the same checks were rerun on this branch
  (see Notes).

No candidate workflow was executed against live services; static
walkthroughs are recorded separately from executed tests in each
`evaluations/HJ-*.md`.

## Notes

- HJ-742 was implemented first (Codex `gpt-5.6-luna/high`); HJ-738–741 were
  implemented by opencode `muse-spark-1.3-contributor-free` workers after the
  Codex account hit its 5h usage limit (prior partial progress recovered via
  `/export` transcripts, no passes redone).
- All five Linear tickets are In Review with dispatcher handoff comments;
  the same dispatcher authored and verified — no independent second-model
  review is claimed.
- Known separate gate: broad `review.py verify-preservation` still reports
  pre-existing worktree/live drift (Cursor sync-manifest et al.); no ticket
  waives it.
- Human decisions required: the 22 inline stable question IDs across the
  five candidates (pack/core placement, authority/consent boundaries,
  licensing, provider behavior).
