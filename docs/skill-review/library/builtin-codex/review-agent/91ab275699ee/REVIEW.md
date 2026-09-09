# Review: builtin-codex `review-agent` (`91ab275699ee`)

## Disposition

**Retain with a diff-coverage correction; candidate only.** This is a focused, read-only review-agent prompt with sensible comparison-ref rules, severity filtering, source citations, and no authority expansion. It should not be promoted unchanged because its “complete diff” procedure can omit untracked implementation files.

Recommended pack: **code-review agent pack**. Invocation should remain explicit/delegated only (`agents/openai.yaml` sets implicit invocation false). Execution belongs in a dedicated read-only review agent with the requested comparison target and local repository context; further delegation is unnecessary for the narrow workflow.

## Source-grounded findings

### Required correction: untracked files are outside the prescribed diff

The skill requires inspection of the “complete diff” (`SKILL.md:15`) but prescribes `git diff` or `git diff <merge-base-sha>` (`SKILL.md:20-26`). Those commands cover tracked changes and do not include untracked files. A new untracked implementation file can therefore escape review even when it is part of the user's requested change.

Add an explicit untracked-file inventory (`git status --short` or equivalent), inspect relevant untracked files directly, and cite their source lines. Keep generated, dependency, and unrelated files scoped out deliberately rather than assuming absence from `git diff` means irrelevance.

### Strengths and boundaries

- Comparison logic distinguishes uncommitted changes, a base branch, a commit, and user-specified targets.
- The base-branch route uses a merge base, avoiding review of unrelated upstream history.
- Findings must be actionable, introduced by the reviewed change, severity-qualified, and cited to exact source ranges.
- The prompt explicitly produces review findings only. It does not claim authority to fix, commit, publish, or mutate external state.
- No scripts, network operations, assets, or executable workflows are included.
- No license file was retained or discovered. Distribution permission remains unknown.

## Rubric assessment

- **Trigger precision:** Strong and narrow; explicit invocation metadata is appropriate.
- **Correctness and coherence:** Clear except for the mismatch between “complete” and tracked-only diff commands.
- **Authority and safety:** Strong read-only boundary and no hidden side effects.
- **Progressive disclosure:** Appropriately compact for a single-purpose agent.
- **Operational quality:** Good comparison-ref and finding-quality rules; untracked coverage needs an explicit step.
- **Security/privacy:** Local source inspection only; custom user instructions must remain subordinate to higher-level safety and scope.
- **Maintenance:** Minimal surface area, but no discovered license.

## Recommended revision

1. Enumerate and inspect relevant untracked files in all review modes.
2. Clarify how to cite untracked files when they have no ordinary diff hunk.
3. State that unreadable or unavailable comparison refs are limitations to report, not reasons to guess.
4. Resolve licensing before promotion or redistribution.

## Validation and limitations

Both retained files were read in full. The comparison algorithms and output contract were walked through statically. The agent was not invoked, no candidate workflow was executed, and no repository changes were reviewed with it. Runtime finding quality therefore remains unmeasured.
