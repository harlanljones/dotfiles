# Linear Agent Tracking Candidate Review

Disposition: retain shared tracker mechanics with coordination corrections.
Proposed pack: `engineering-tracking`, enabled alongside workflows that need it,
not universal core. Invocation: task-triggered by tracker work or a composing
workflow. Execution: one in-session tracker driver; independent read-only evidence
may be delegated. Worktrees and Herdr do not isolate Linear state.

## Full-Tree Read

Read `SKILL.md` (78 baseline lines), `references/linear-cli.md` (99),
`references/issue-tracker-linear.md` (51), and `agents/openai.yaml` (4).
Agent display metadata is retained unchanged. Inventory entry for this candidate
records original hashes and mirrors. No license was discovered.

Preserved expertise: managed credentials without token output, configured CLI
ownership, Wayfinder decisions versus implementation slices, native blocking
relations, CLI 2.5.0's missing parent filter, Markdown body files, incremental
labels, merge-before-update for shared bodies, and partial-write recovery.

## Corrections

Baseline claim paragraph calls assignment a concurrency lock. Candidate and both
references now distinguish cooperative claims from compare-and-swap and require
single-dispatcher coordination for shared identities. Lowest-number eligible
selection follows this environment's policy. Scope permits project work without
inventing a parent; existing self-assigned work can resume. Missing persistent
tracker docs no longer force unsolicited setup when the task destination is known.

The Bash loader now detects missing/duplicate matching credentials and makes its
managed-format limitation explicit. Its consumer must stop on loader failure,
not use stale ambient credentials. Hardcoded fallback binary ownership is removed.
Completion follows the originating acceptance criteria; implementation awaiting
human review remains open, while a review-readiness task may finish without
calling its candidates approved. References include explicit project/template
selection and a partial-work handoff before unassigning.

## Validation and Question

Static scenarios cover two agents sharing `self`, a newly claimed blocker,
project-only work, a missing tracker document with explicit destination, failed
credential loading, partial multi-issue writes and review-readiness versus human
approval. Current CLI version/help and HJ-729 view/relations were observed by the
driver; no speculative CLI output is treated as fact. The loader is evaluated
separately with synthetic fixtures, never by printing real credentials.

`Q-linear-agent-tracking-dispatch` recommends one dispatcher with worker scope
recorded. This reduces cooperative races but cannot guarantee exclusion against
uncoordinated clients. No distributed-lock implementation is proposed here.

## Promotion

Local tracked ownership remains authoritative for this candidate. Update the
entrypoint and both templates together after approval to avoid reintroducing the
old claim guarantee during repository setup. Provider metadata was read, not
live-tested. No tracker config was created and no real implementation ticket was
closed by this candidate workflow. Actual review-project tracking is driver work,
separate from this candidate's static validation.
