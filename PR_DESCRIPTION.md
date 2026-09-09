# Frontier Sweep Skills Review Bundle

## Summary

Consolidate six completed source-grounded Skills Review batches into one
reviewable branch and one eventual pull request:

- HJ-733 — four builtin Codex candidates: imagegen, openai-docs,
  plugin-creator, and review-agent.
- HJ-734 — builtin Codex skill-creator and skill-installer.
- HJ-735 — harness-claude-skills codebase-memory.
- HJ-736 — harness-claude-skills impeccable, 148-file bounded review.
- HJ-737 — harness-claude-skills mixture-of-agents, 93-file review including
  binary asset checks.

The branch contains additive review, evidence, question, and machine-readable
contract artifacts only. No candidate skill source is being promoted or
deployed.

## HJ-736 preservation blocker

The HJ-736 source worktree contains five pre-existing modifications to frozen
candidate files. They are intentionally excluded from this branch:

- `SKILL.md`
- `reference/live.md`
- `reference/new-work.md`
- `scripts/concept-seed.mjs`
- `scripts/context.mjs`

The exact paths, hashes, and 41-insertion/8-deletion mismatch are recorded in
`docs/skill-review/evaluations/HJ-736-impeccable.md`. The additive review
artifacts document this as a preservation failure; no reset or restoration was
performed.

## Boundaries

- No candidate workflow was installed, applied, or executed against live
  services.
- No Linear mutation, credential publication, commit, or push was performed by
  the workers.
- Candidate approval, source restoration, and deployment remain human
  decisions.
- Review authoring and verification were performed by the same workers; no
  independent second-model review is claimed.

## Validation

- Per-variant `docs/skill-review/review.py check` results are recorded in the
  batch evaluation files.
- Graph coverage, direct-source fallbacks, fixture tests, JSON validation,
  syntax checks, asset checks, and preservation limitations are recorded beside
  each review.
- Repository generated indexes are regenerated on this integration branch.

## Follow-up before opening the PR

1. Run the aggregate review-contract, fixture, generated-index, whitespace, and
   preservation checks.
2. Review the combined diff and confirm the five HJ-736 candidate-source edits
   are absent.
3. Commit this single branch and open one PR for human review.
