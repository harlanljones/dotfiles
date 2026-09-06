# Review Plan

## Contract

The driver owns integration documents, the two existing optional-pack proposals and Linear state. Inventory work owns only inventory tooling and its outputs. Candidate reviewers will own disjoint variant directories assigned after the inventory freezes. No worker may modify a live skill or another worker's files. No worktree is needed for disjoint document trees; do not create Herdr topology merely for this review.

## Depth tree

| Leaf | Outcome | Dependencies | State |
| --- | --- | --- | --- |
| inventory | Reproducible accessible-current-library denominator, provenance and materialized candidate trees; 16 explicit gaps | none | VERIFIED |
| workflow | Local and engineering workflow candidate reviews | inventory | IN PROGRESS |
| provider | Provider/builtin/plugin candidate reviews | inventory | WAITING |
| specialist | Domain and platform candidate reviews | inventory | WAITING |
| integration | Cross-skill scenarios, questions, index, pack proposals and validation | all reviews | WAITING |

All manual coverage remains open until source-grounded evidence is returned and checked. Counts from preliminary planning are not the frozen denominator.

## First Review Wave

Frozen scope: 482 accessible full-tree variants. The first wave covers six local
variants and all 34 Matt Pocock variants, split across `batches/01-local.md`
through `batches/04-authoring.md`. These four batches are disjoint and cover 40
variants, not the entire library. Remaining variants stay explicitly unreviewed.
Review tooling is an independent leaf owning only `review.py` and `test_review.py`.
The driver owns all integration documents and generated indexes.

Cooperative ownership leases live in ignored `docs/skill-review/.unlazy/review/`,
with `docs/skill-review` as the checker root. No Herdr topology is needed for
disjoint document edits. The driver alone assigns and updates Linear tickets.

`VERIFICATION.md` records a changed Cursor sync manifest. This is not a candidate
review blocker, but broad live-baseline preservation remains unmet and must not
be reported as passed. Neither the live manifest nor the frozen baseline is reset.

## Resumed Driver Work

- Tooling: independently inspected; 34 review and 13 inventory fixture tests pass.
- HJ-729: all six local candidates verified for human-review readiness; the
  driver completed the work after the delegated worker failed for wallet balance.
  Linear state is confirmed Done with a resolution comment; eight policy questions
  remain open. Local and tooling ownership leases have been released.
- HJ-730, HJ-731, HJ-732: execution, planning and authoring batches remain queued;
  no successful review dispatch is assumed.
- The latest preservation check also detects a Redis plugin-cache path change.
  Protected worktree state passes; broad live preservation remains unmet.
