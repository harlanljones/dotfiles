# Dots Candidate Review

Disposition: retain with authority corrections. Proposed pack: `dotfiles`,
enabled on chezmoi-managed machines rather than universal core. Invocation:
task-triggered for dotfile work; application source is outside its trigger.
Execution: in-session by default. Bounded read-only delegation can help with
independent config inspection; worktrees cannot isolate shared live targets.

## Evidence and Changes

Read the complete baseline `SKILL.md` (87 lines), the only retained file.
Provenance, exact hashes and mirrors are the `inventory.json` entry for this
candidate path. No license file was discovered for this variant; ownership and
redistribution rights are not inferred from local installation.

The old live workflow steps 4-5 and source workflow steps 3-5 treated apply and
publication as routine completion. The candidate separates review, source edit,
live capture, apply and publication. It retains age handling, targeted capture,
template awareness, wrapper commands and relevant dry-run validation. The old
hook rule incorrectly grouped onchange and every-apply triggers; these now have
distinct semantics. Removing the mandatory pre-git absorb rule permits harmless
git inspection before any mutation.

Read-only supporting evidence outside this candidate: repository `AGENTS.md`;
`dot_local/bin/executable_dots:294-423`; and all 53 lines of `executable_dots-push`.
The latter runs `chezmoi re-add` and `git add -A`, so even authorized publication
requires checking whether unrelated work would be included. No wrapper changed.

## Validation and Questions

Static walkthroughs: read-only review ends at findings; candidate documentation
does not apply; source template edit reaches dry-run, not deployment; a requested
live edit captures intended paths; publication in a dirty tree pauses over
unrelated work. These are document-level checks, not live executions.

`Q-dots-apply` beside the authority rule asks whether source edits should imply
apply. Recommend separate authority because hooks and unrelated drift may run.
The rewrite is a proposed policy, not user approval of that choice.

## Promotion Boundary

Keep this local customization under its tracked owner; propagate to mirrors only
after human approval and distribution tests. The narrower trigger and per-machine
pack recommendation have not been evaluated in a live harness. No apply, capture,
commit, push, or diagnostic command with live effects was run for this review.
