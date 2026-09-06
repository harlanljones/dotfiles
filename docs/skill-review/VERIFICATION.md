# Verification Record

## Inventory Reverification, 2026-09-06

The parent inspected all 677 lines of `inventory.py`, all 188 lines of
`test_inventory.py`, the complete inventory notes, and all 16 recorded gaps.
Graph tools are unavailable; project, generation and coverage remain unknown.

Commands ran from the repository root in bash with Python 3 and installed PyYAML:

| Check | Result |
| --- | --- |
| `PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py check` | Exit 0, `MATERIALIZATION_OK`: all 482 candidates matched the frozen trees before review |
| `PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/test_inventory.py -v` | Exit 0, all 13 fixture tests passed |
| `PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py verify-worktree` | Exit 0, `WORKTREE_BASELINE_OK`, before parent integration edits |
| `PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py verify-live` | Exit 1, one changed baseline path: `/home/harlan/.cursor/skills-cursor/.sync-manifest.json` |

The current Cursor sync manifest contains skill names and sync/inventory
timestamps. The snapshot stores its old hash, not its original contents, so a
timestamp-only change cannot be proved. All other observed baseline paths passed
the same comparison. Neither the manifest nor the frozen snapshot was changed by
this review. Retain the failed broad live gate; do not silently waive the drift.
Candidate review can continue against the frozen trees without changing this file.

## Scope Limits

- Eight broken/non-skill discovery links are existing observations, not repair work.
- Two Snowflake metadata copies are invalid JSON; installed-manifest evidence
  still establishes selection. This does not validate the invalid metadata.
- Six current CLI installations have unknown embedded builtin completeness.
  Accessible filesystem trees are included; inaccessible builtin payloads remain
  uncovered. No exhaustive claim about every provider builtin is justified.
- License discovery is bounded and 319 variants have no discovered license file.
  Local review copies are not a redistribution permission or promotion approval.
- The denominator is 482 frozen accessible full-tree variants, not 482 completed
  reviews. All were baseline-only at the start of parent verification.

The original `check` command is a pre-review baseline oracle and will fail after
intentional candidate edits. Review completion needs a separate oracle. Likewise,
the original `verify-worktree` includes parent-owned documents; its later failure
must be reconciled against the explicitly authorized document paths, never by
refreshing the frozen baseline.

## Review Tooling Reverification, 2026-09-06

The driver read all 430 lines of `review.py` and all 441 lines of
`test_review.py`, plus the inventory helpers they call. Bash commands below ran
from `docs/skill-review` with `PYTHONDONTWRITEBYTECODE=1`:

| Check | Result |
| --- | --- |
| `python3 test_review.py -v` | Exit 0, 34 tests, `OK`; fixture-only writes in `/tmp/opencode` |
| `python3 test_inventory.py -v` | Exit 0, 13 tests, `OK` |
| `python3 review.py status` | 482 selected, zero valid contracts, 482 missing reviews, no missing candidates or layout errors before candidate edits |
| `python3 review.py verify-preservation` | Exit 1; worktree preserved, live baseline not preserved; no comparison errors |

The live comparison now reports two paths: the previously recorded Cursor sync
manifest and `/home/harlan/.cursor/plugins/cache/cursor-public/redis-development`.
This records observed drift, not its cause. Neither path was changed or waived
by the review. The frozen snapshot remains unchanged. Candidate checks verify
metadata, retained files and asset bytes, not semantic quality or live behavior.

The earlier local worker failed on insufficient provider wallet balance before
producing edits. All six local trees were independently confirmed baseline-only;
the driver resumes their review directly. No review worker is assumed active.

## HJ-729 Closure Verification, 2026-09-06

The resumed driver checked the ticket's acceptance criteria and existing evidence.
The ticket remains scoped to the six local candidates, not library integration or
deployment. Source discovery uses the existing bounded filesystem evidence;
graph project, generation and index coverage remain unavailable.

- The approved `leaf-local:G1` command ran through the checker in `/bin/sh`,
  working directory `docs/skill-review`: exit 0 and the expected
  `"allSelectedContractsValid": true` matched. Both local gates are met;
  G2 is the documented static composition review, not a live evaluation.
- Direct bash reruns of `evaluations/test_local.py -v`, `test_review.py -v`
  and `test_inventory.py -v`, all with `PYTHONDONTWRITEBYTECODE=1`, exited 0:
  2, 34 and 13 tests passed respectively. Synthetic credentials only.
- `review.py status` remeasured 6 valid contracts, 476 missing reviews,
  0 invalid reviews, 0 missing candidates and 16 inventory gaps; no layout errors.
- `review.py verify-preservation` again exited 1: protected worktree preserved,
  with exactly the two previously recorded live drift paths and no comparison
  errors. The global live-preservation gate remains unmet, not abandoned.
- Repository `git diff --check` and both generated-document `--check` commands
  exited 0. The diff check excludes untracked candidate content.

All eight local questions remain open. The driver authored and separately
verified the work; no independent second-model review is claimed. No candidate
or live configuration edits were needed during this closure verification.

Linear HJ-729 was re-read, the resolution evidence posted, and state `Done`
confirmed. Resolution comment:
https://linear.app/harlanljones/issue/HJ-729/review-local-workflow-skill-candidates#comment-cd97a64d
Local and tooling ownership leases were released after verification. The local
ledger has 2 met, 0 unmet and 0 abandoned gates; tooling also has 2 met gates.
Library-wide completion and live-preservation gates remain unmet.

## Publication Convention Review, 2026-09-06

Remote `main` was confirmed at `ffff1e30cd26e2d0855a2e5d3c026c366f30ab96`.
The commit published the review tree plus previously separate preference changes:
4,323 changed files. Review scope here was repository integration and the changed
managed configuration, not semantic review of all copied skills.

The root generated index was stale at 225 entries; regeneration now includes
4,541 tracked entries. CI's recursive shell scan linted copied candidate scripts
and failed on a wizard template's unused variable. The lint selector now uses
tracked paths and excludes repository review copies and the submodule. CI adds
only the explicitly named review fixture suites; their temporary directories no
longer depend on an OpenCode-specific path. Shared Git/chezmoi ignores now cover
local coordination and tooling state while keeping review evidence tracked.

Preservation results above describe the original session. Publication changes
HEAD/index and tracked status, so the historical Git oracle no longer passes.
Do not reset the immutable baseline or portray this as newly proven live drift.

Remaining findings outside the convention fixes:

- GitHub run `34060927958` reports 111 secret-scan findings with pinned gitleaks
  8.21.2. A redacted local scan of the pushed commit with the installed, unversioned
  build reports 4,128 findings (4,031 Sourcegraph-rule, 90 generic-key and 7 curl
  header matches). Rule versions differ; these counts are not interchangeable.
  Findings include inventory/provenance data and copied examples, but individual
  credential validity has not been established. No allowlist or scan exclusion was
  added; secret CI remains unresolved pending triage.
- `dot_local/bin/executable_omarchy-agent.tmpl:34` unconditionally switches to
  HOME, losing project context for inline prompts from a repository. The upstream
  prompt launcher forwards prompt/inline flags without preserving the original
  directory. Left unchanged as a separate functional behavior decision.
- `review.py:159-173` requires original bytes at snapshot-machine source paths;
  reviewed candidates can fail contract validation on another machine. A bounded
  in-memory missing-mirror check reproduced this for all six local candidates.
  Portable hash-verified original-byte evidence is still needed; fail-closed
  binary protection is retained.
- `review.py:316-320` and `inventory.py:527-529` inspect the frozen repository
  path and pre-publication Git state. They are session-local historical oracles,
  not current-checkout or fresh-clone checks. Documentation now states this limit.

No candidate library contents, live settings, encrypted configuration or frozen
inventory were changed by this convention review. No commit, push or apply was
performed. Separate read-only reviewers checked tooling portability and the
managed preference diff; MCP graph access remained unavailable.

## Publication Repair

The user withdrew `ffff1e3` from remote `main`, restoring `74622d9`, and requested
repair before republishing. The candidate library and immutable inventory remain
byte-identical to the withdrawn commit; the frozen baseline was not refreshed.

Gitleaks 8.21.2 reproduced all 111 findings. Every finding was matched to source:
98 occurrences are 14 skill identifiers whose suffix equals the inventory's
recorded tree SHA-256. The remaining 13 are documentation placeholders: seven
literal API-token prompts, four short Cloudflare anti-pattern keys, one ellipsis
anti-pattern key and one short Grafana localhost example. None is an actual
credential. `.gitleaks.toml` extends the default rules and restricts each
exception to both the exact known value and its evidence paths. Directory-mode
scanning additionally truncates one verified hash at a chunk boundary; only that
exact 44-character prefix in the inventory is excepted. No whole-file, directory,
commit or general hash exemption was added. The existing historical compromised
credential in `.gitleaksignore` remains a separate rotation requirement.

Three scanner regression tests cover accepted examples, new credentials in the
same files, changed values, other paths and an extra credential beside an allowed
identifier. Synthetic values are assembled at runtime, never real credentials.
These tests run in the secret-scan CI job using its pinned binary.

The 49 review fixtures pass with `TMPDIR` unset. The managed-script CI loop passes
ShellCheck 0.10.0, and actionlint passes with ShellCheck available. Root generated
documents now cover 4,543 entries. `chezmoi apply --dry-run --force` passes locally;
`--force` only resolves noninteractive conflict prompts during this dry run. No
actual apply, installation into managed paths, commit or push was performed.

Final repair checks: the pinned scanner reports no unaccepted findings across
104 commits (including the withdrawn publication) and across an isolated copy of
all proposed regular files. Both generated-document checks and `git diff --check`
pass for the repair delta against `ffff1e3`. These are local Linux results;
hosted Linux/macOS CI awaits publication.

Local `main` was moved to `74622d9` with a soft reset, retaining every working
file, and the replacement was staged. The exact staged diff passes gitleaks
8.21.2 with no unaccepted findings. Local and remote-tracking `main` have zero
commits of divergence; the withdrawn commit is no longer on local `main`.
The complete staged whitespace check reports pre-existing whitespace in copied
candidate sources and generated `QUESTIONS.md`. Those preserved artifacts were
not reformatted to silence it; the repair delta passes its whitespace check.

The launcher working-directory behavior, unavailable source-mirror portability,
historical preservation-oracle limits and incomplete semantic review described
above remain separate known limitations, not repaired by making CI pass.
