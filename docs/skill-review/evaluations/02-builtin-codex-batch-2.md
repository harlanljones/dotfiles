# Builtin Codex Batch 2 Verification

Date: 2026-09-08. Scope: HJ-734 and exactly these two candidates:

- `library/builtin-codex/skill-creator/5be1693bd421`
- `library/builtin-codex/skill-installer/bd391a97dbae`

The reviewer authored and re-read the review artifacts; this is not an independent
second-model review. No candidate workflow touched a live skill, service, GitHub
repository, credential, install directory, or provider-managed file.

## Source and coverage evidence

The frozen inventory identifies exactly one variant for each exact
source/identity filter: nine baseline files for `skill-creator`, tree
`5be1693bd421e1fe66cacbc0a62d72c6c58ce2966b1e3c1d4d05fcd29b066020`, and
eight for `skill-installer`, tree
`bd391a97dbaef49c3d2126167e3924866ae62a3fa089629d9aa0e03909639bdb`.
Both are local installed Codex trees with unknown upstream versions and preserved
in-tree Apache-2.0 license text. The two license files are byte-identical at
SHA-256 `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`.

Every baseline file was read. Text/code was inspected with numbered source;
agent YAML and frontmatter were parsed; all Python ASTs were parsed; both SVGs
were read; both 100x100 RGBA PNGs were visually inspected; and both complete
202-line licenses were read. Candidate scripts were never invoked against live
inputs or services.

Codebase-memory project
`home-harlan-.local-share-ft-HJ-734-builtin-codex-batch-2` was ready at generation
`2026-09-08T16:26:06Z`. Graph search found 14 creator and 27 installer functions;
outbound traces confirmed initializer composition and the install main path. Exact
coverage checks reported no recorded issue for candidate text/code. Both SVG/PNG
pairs were excluded by the indexer's ignored-suffix policy and inspected directly.
`inventory.json` had a recorded parse-timeout and its exact candidate ranges were
read directly. The graph is best-effort evidence, not proof of completeness.

## Executed safe checks

All checks used `PYTHONDONTWRITEBYTECODE=1` where Python could otherwise emit
cache files.

- Exact pre-review `review.py status` filters selected one candidate apiece and
  reported no missing baseline files or layout errors; reviews were then absent.
- Python AST parsing covered six scripts. YAML parsing covered both agent metadata
  files and both extracted `SKILL.md` frontmatters.
- A temporary creator fixture confirmed that the frozen candidate validates,
  present-but-empty required metadata currently passes, and invalid generated UI
  metadata leaves a partial scaffold. Writes stayed under a system temporary
  directory.
- A temporary installer fixture mocked repository preparation and GitHub listing.
  URL parsing and directory-list sorting passed; relative-path and ZIP traversal
  were rejected; a two-path install with a missing second source returned failure
  after leaving the first copy. No network, Git, credentials, or live destination
  was used.
- Asset type inspection confirmed two three-line SVGs and two non-interlaced
  100x100 RGBA PNGs. Both metadata files point to the inspected assets.

The repository-wide `inventory.py check` is a documented pre-review oracle and
currently refuses an already-reviewed local candidate; it is not a scoped HJ-734
failure and was not used to refresh or weaken the frozen baseline.

## Static composition scenarios

| Scenario | Expected recommendation | Evidence |
| --- | --- | --- |
| Narrow update to an existing skill | Edit only requested files, preserve invocation/metadata fields, run proportional checks | creator `SKILL.md:147-215` |
| Metadata generation over policy/dependencies | Update intended fields in place; do not run the replacing generator | creator `SKILL.md:90-111` |
| Scaffold metadata generation fails | Leave no destination after proposed transactional fix | creator initializer `179-218`; safe fixture |
| Small ordinary skill change | Work in-session; no mandatory forward-test subagent | creator `SKILL.md:217-229` |
| User asks what curated skills exist | Read-only network list; no install authority | installer `SKILL.md:12-30` |
| Arbitrary private repository install | Surface source/ref/dest and trust limits; use existing credentials without logging | installer `SKILL.md:39-56` and scripts |
| Archive or repo path escapes source root | Reject before copy | installer `108-120,169-216`; safe fixture |
| Existing or system destination | Refuse overwrite and route system repair separately | installer `SKILL.md:47,57`; installer `219-223,337-338` |
| Second member of batch is invalid | Proposed preflight prevents any publish; current behavior leaves first copy | installer `329-345`; safe fixture |

These are source-grounded walkthroughs and isolated local fixtures, not live
harness evaluation or measured quality claims.

## Final handoff reverification

The continuation pass preserved the completed source inspection and reverified
the resulting contracts. At codebase-memory generation `2026-09-08T21:23:32Z`,
the candidate scopes contained 14 creator and 27 installer functions. Outbound
traces covered the initializer and installer entry paths. Exact path and scope
coverage reported no recorded issue for text/code and only the four already
disclosed ignored-suffix icon gaps; the prior inventory parse-timeout observation
was not present in this newer generation. This remains best-effort graph evidence.

Both exact `review.py check` commands selected one candidate, reported one valid
contract, zero missing reviews, zero invalid reviews, zero missing candidates and
zero layout errors, with `allSelectedContractsValid: true`. The repository review
fixtures passed: 13 inventory tests, 34 review-driver tests and 2 local-candidate
tests. Six Python scripts parsed as AST, both contracts parsed as JSON, both agent
metadata files parsed as YAML, the two license SHA-256 values matched, and asset
type checks reconfirmed both SVG/PNG pairs. Tracked and seven owned untracked
review/evaluation files passed whitespace checks.

Two shared/global checks remain intentionally unresolved rather than being
silently widened into this batch. `review.py verify-preservation` exited 1 against
the frozen historical oracle, reporting current live drift plus changed Git
head/index and protected paths outside HJ-734; it reported no live comparison
errors. The root `generate_index.py --check` and `generate_readme_tree.py --check`
also exited 1 because shared generated documents are stale. The issue assigns
shared integration reports to the integration writer and authorizes writes only
inside the two candidate directories plus this batch evaluation, so this pass did
not regenerate those shared files.

## Remaining boundaries

The reviews are ready for human inspection, not approved or deployed. Questions
about transactional scaffolding, system-skill ownership, and batch atomicity remain
human policy decisions. Upstream versions, provider update behavior, cross-harness
metadata support, next-turn discovery behavior, remote source integrity, and live
network/authentication paths were not evaluated. The parent dispatcher owns final
reverification and all Linear state; this worktree remains uncommitted.
