# Skills Review

Status: in progress; candidates only, not approved or deployed.

For ticket selection, model-tier routing, claims and handoffs, read
[the shared tracker entry point](../agents/issue-tracker.md). Current state and
blocking relations live in Linear; local progress notes are evidence snapshots.

This review covers the current shared/local library, provider variants and builtins, and currently installed plugin skills. Historical versions, fixtures and examples are inventoried but excluded as independent rewrite targets. Supporting examples belonging to a current skill remain part of its candidate tree.

Live skills, discovery links, activation settings, provider-owned originals and the pack engine are outside the write scope. Candidate files under `docs/` are excluded from chezmoi apply. No commit, push, install or apply is authorized by this review.

Start with [INDEX.md](INDEX.md), [QUESTIONS.md](QUESTIONS.md) and
[COVERAGE.md](COVERAGE.md) for the current candidate library. The first six local
reviews and eight policy questions are ready for human review; 476 variants remain
unreviewed. [RUBRIC.md](RUBRIC.md), [GATES.md](GATES.md) and [PLAN.md](PLAN.md)
define the contract and outstanding work. An unchanged supporting file means
retained content, not permission to skip reading it.

Questions use stable `Q-<skill>-<topic>` identifiers beside the affected candidate instruction. Central decisions will distinguish recommendations from accepted policy. Installation is not usage evidence; proposed core membership must be justified by workflow, not upstream collection size.

Completion is readiness for human review, not approval. Provider promotion, upstream maintenance, invocation metadata and final core membership remain explicit human decisions where evidence cannot settle them.

## Publication and Validation

The initial publication `ffff1e3` was withdrawn from remote `main` for CI repair;
the files are retained locally for a replacement publication. Earlier notes
about untracked files describe the original verification session. The
frozen inventory retains that session's absolute source paths and Git baseline;
do not refresh it to make post-publication preservation checks pass. See
[the tracker guide](../agents/issue-tracker.md#boundaries-and-portability) for
clone limitations and source-mirror requirements.

CI runs only the review tooling fixtures, not copied workflows in `library/`.
With Python 3, PyYAML, Git and Bash installed, run from the repository root:

```bash
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/test_inventory.py -v
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/test_review.py -v
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/evaluations/test_local.py -v
```

Fixtures use the system temporary directory (`TMPDIR` may override it). Full
`review.py check` is not a CI completion gate while candidates remain unreviewed
and source-mirror portability is unresolved. Keep `.unlazy/` state local; committed
evidence is the handoff source, not local leases or approvals.
