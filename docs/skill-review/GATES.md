# Gates: Skills Review

Scope: candidate-only review of the current installed library. Human decisions may remain open; agent coverage gaps may not be counted as completion.

- [x] G1: frozen inventory distinguishes identities, full-tree variants, mirrors, current plugins and excluded historical material
  EVIDENCE: Parent source inspection and independent materialization check plus 13 fixture tests passed on 2026-09-06; see VERIFICATION.md for the 482 accessible-variant denominator and 16 known gaps. Embedded builtin completeness remains unknown.
- [ ] G2: every in-scope variant has a complete candidate tree and a source-grounded review, including supporting instructions
  CHECK: PYTHONDONTWRITEBYTECODE=1 python3 review.py check
  EXPECT: "allSelectedContractsValid": true
  EVIDENCE: Six local full-tree reviews verified; 476 variants remain unreviewed. Candidate metadata is only the runnable portion; semantic evidence remains per-candidate and in evaluations/01-local.md.
- [ ] G3: questions, provenance, execution recommendations and pack proposals are centrally indexed
  EVIDENCE: Generated INDEX.json, INDEX.md, COVERAGE.md and QUESTIONS.md cover the frozen denominator, with eight questions for six reviewed variants. Remaining recommendations and pack integration are incomplete.
- [ ] G4: composition scenarios cover review scope, authority, delegation, tracker concurrency and provider limitations
  EVIDENCE: Local-batch static scenarios recorded in evaluations/01-local.md; cross-library integration remains incomplete.
- [ ] G5: baseline comparison proves live skill content and discovery links unchanged
  CHECK: PYTHONDONTWRITEBYTECODE=1 python3 inventory.py verify-live
  EXPECT: LIVE_BASELINE_OK
  EVIDENCE: Latest review.py verify-preservation exits 1 with Cursor .sync-manifest.json and Redis plugin-cache path drift; protected worktree preserved. Do not reset or refresh this baseline; see VERIFICATION.md.
- [ ] G6: both optional-pack proposals reflect reviewed constraints without deploying the engine
  EVIDENCE: pending
- [ ] G7: Linear records bounded batches and honest review readiness, with no approval or deployment claim
  EVIDENCE: HJ-729 confirmed Done with six-candidate evidence and explicit limitations; HJ-730 through HJ-732 remain queued. Library-wide tracking and readiness remain incomplete; see VERIFICATION.md for the resolution comment.

Runnable review checks will be added once their measuring implementation exists and has been inspected. Manual gates remain unmet until evidence is available.
