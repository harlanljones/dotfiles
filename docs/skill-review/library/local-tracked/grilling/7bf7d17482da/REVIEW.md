# Grilling Candidate Review

Disposition: retain the decision-tree interview, clarify bounded rounds and
completion. Proposed pack: `planning-interviews`, optional. Invocation:
task-triggered only when the user requests stress-testing or grilling. This
preserves natural-language access without treating every question as an interview.
Execution: in-session with the user; bounded read-only fact lookup may be delegated.
Neither a worktree nor Herdr is warranted for the interview itself.

## Source and Retained Expertise

Read the full 28-line baseline `SKILL.md` and all three lines of
`agents/openai.yaml`. Retain the display name and short description unchanged.
The inventory entry for this path records provenance and mirrors; no license
was discovered. Preserve design-tree dependencies, frontier recomputation,
recommendations accompanying questions, facts versus user decisions, and waiting
for answers before downstream questions.

Baseline line 8 asks the entire frontier regardless of size; candidate permits
bounded groups but keeps the remainder visible. Line 26 requires a subagent even
for cheap facts and says all facts are accessible; candidate favors direct lookup,
optional bounded delegation and explicit access limits. Line 28 treats an empty
frontier as exhaustive completion even if prerequisites are blocked; candidate
distinguishes resolution, deferral, blockage and the user's decision to pause.
Shared understanding no longer implies implementation authority.

## Validation and Decision

Static walkthroughs: a dependent question waits; a large independent frontier
can be split without losing branches; inaccessible facts stay unknown; a paused
interview reports open choices; confirmed understanding does not deploy a plan.
`Q-grilling-round-size` asks whether to preserve whole-frontier rounds; recommend
whole-frontier for manageable sets, visible bounded groups for large sets.

This is not a merge with `grill-me` or `grill-with-docs`: compare their full trees
before any retirement proposal. Local ownership and user agency justify retaining
this variant pending that comparison. Metadata discovery and interview quality
have not been evaluated in live providers. Candidate only, no files written by
the interview workflow and no promotion to shared mirrors.
