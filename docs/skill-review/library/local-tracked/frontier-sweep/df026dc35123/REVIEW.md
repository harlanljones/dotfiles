# Frontier Sweep Candidate Review

Disposition: retain as explicit orchestration, substantially rewrite unsafe
coordination. Proposed pack: `engineering-orchestration`, optional rather than
core. Invocation remains explicit, retaining `disable-model-invocation: true`;
that metadata's enforcement is provider-dependent and must be tested.
Execution: one in-session dispatcher with bounded workers for independent
tickets, isolated worktrees for concurrent writes, sequential fallback. Herdr
is an authorized visibility/control option, not a prerequisite for every task.

## Full-Tree Evidence

Read all 188 baseline lines of `SKILL.md`, the entire one-file tree. Inventory
entry keyed by this directory records original tree hash, mirrors and provenance.
No license was discovered. Useful retained expertise: dependency-frontier
selection, ticket-scoped implementation, human review before commit, worktree
locations, a PR-description artifact and failure/interrupt reporting.

Source-specific corrections:

- Baseline lines 17 and 182 fall back to direct API access, contrary to the local
  tracker contract. Candidate uses the configured CLI and stops on setup gaps.
- Line 35's child claim rule says it eliminates races. It does not. A single
  dispatcher claims lowest-number eligible tickets, checks native relations,
  verifies ownership, and records cooperative rather than atomic coordination.
- Line 86 hardcodes `main`, a worktree path and `--focus`. Candidate resolves
  base/commit, respects dirty prerequisites, reads Herdr help, uses returned IDs
  and `--no-focus`, and asks for topology authority.
- Lines 129 and 168 equate artifact presence or no frontier with implementation
  completion. Candidate requires actual acceptance evidence, all working-tree
  changes in review, and separate blocked/in-progress/awaiting-review counts.
- Lines 184 and 188 can release partial work or mark unreviewed work done.
  Candidate preserves partial changes and keeps human-review work open.

## Validation

Static scenarios: two workers sharing `self` need one dispatcher; a completed
tracker prerequisite missing from the base blocks dispatch; an in-review ticket
does not unblock a dependent; untracked implementation must be reviewed; no
eligible ticket does not mean all work is complete; wallet failure stops new
dispatch without deleting partial work. Herdr mechanics were compared against
the local rubric and loaded coordination guidance, not executed.

Inline questions: `Q-frontier-sweep-dispatch` recommends centralized claims and
tracker updates; `Q-frontier-sweep-herdr` recommends separate topology authority
unless already requested. Neither proposal creates topology or accepted policy.

## Limits and Promotion

No real worker, worktree, tracker mutation, build or test was launched by this
candidate. These are static workflow checks, not measured throughput or race-free
execution. Concurrent external dispatchers remain a coordination risk. Keep the
tracked local owner and review changes against upstream/mirror updates before
promotion; the live original is untouched. No blanket five-worker or Herdr rule
is substituted for capacity planning.
