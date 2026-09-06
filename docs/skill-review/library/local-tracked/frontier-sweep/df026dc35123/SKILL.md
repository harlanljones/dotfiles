---
name: frontier-sweep
description: Implement a bounded frontier of Linear tickets with coordinated agents, leaving verified changes for human review. Invoke explicitly for a frontier sweep; no commits, pushes, or PR publication.
disable-model-invocation: true
---

# Frontier Sweep

Use one dispatcher to select and claim tickets, give each worker a bounded
implementation, and independently verify its return. This skill ends at human
review, not merge or deployment. Explicit invocation does not override repository
permissions or authorize additional paid capacity.

## Establish the Frontier

Read the repository tracker description and `linear-agent-tracking` for current
CLI, credential and relation mechanics. Use the configured team/project and the
named parent if one exists. Do not invent a parent or query unrelated work.
If tracker access is unavailable, report the blocker; do not substitute direct
API calls or another tracker.

Eligible tickets are open, unassigned, in the requested scope, and have no open
blocking relation. Inspect each issue and its native relations; a label or list
order is not evidence of eligibility. Select the lowest-number eligible ticket
first under this environment's policy.

The dispatcher re-reads, assigns `--assignee self` as its first write, then
re-reads ownership and relations before dispatch. Assignment is cooperative,
not an atomic compare-and-swap lock. A shared user identity cannot distinguish
two agents. Use one known dispatcher and exclusive file ownership; if ownership
is uncertain, pause that ticket rather than claiming a race was prevented.

> Q-frontier-sweep-dispatch: Keep one dispatcher responsible for all claims and
> tracker updates? Recommendation: yes; child self-assignment is not a lock, and
> centralized result tracking makes partial failures recoverable.

## Choose Execution

Use bounded parallel workers for independent tickets when capacity is available;
work sequentially in-session for a single ticket or unavailable delegation.
Confirm a concurrency limit based on quota and machine capacity rather than
spawning the entire frontier. Do not retry a paid-provider failure indefinitely.

Concurrent implementation normally needs one worktree per ticket. Resolve the
integration base from repository policy and requested scope; record its commit,
and check whether prerequisite changes are actually present there. A ticket's
tracker state is not proof its code exists in a new worktree. Uncommitted parent
changes are not included in a worktree created from HEAD.

For Herdr, require `HERDR_ENV=1` and authorization for the proposed topology.
Read `herdr --skill` and current subcommand help, use returned workspace/pane IDs
and `--no-focus`. Never hardcode `main`, guess IDs, or steal focus. Panes provide
visibility; worktrees isolate repository writes, not home directories or services.
Without topology authorization, use a suitable existing isolated workspace or
propose sequential execution. Never reset another worker's files.

> Q-frontier-sweep-herdr: Should explicitly requesting a sweep also authorize new
> Herdr worktrees? Recommendation: confirm topology separately unless the request
> already specifies it; keep sequential execution available.

## Worker Contract

Provide the claimed ticket, repository root, integration base, exact write scope,
acceptance criteria, relevant instructions and source evidence, dependencies,
validation commands, and output path. For graph evidence, include project,
generation, queries and coverage limits. If graph tools are unavailable or gaps
affect the task, use bounded source reads and disclose that limitation; do not
require a whole-repository reindex before every ticket.

The worker reads linked context, implements the requested slice, and runs checks
proportional to the acceptance criteria and risk. Material scope/security choices
go back to the dispatcher; low-risk implementation details remain the worker's
responsibility. Workers do not claim or close tickets themselves.

Return the worktree path, changed files (including untracked files), implementation
summary, actual commands and results, unmet acceptance criteria, and blockers.
Write `PR_DESCRIPTION.md` only if that path is free or owned by this task; otherwise
use an agreed artifact path. Its testing section separates executed results from
suggested tests. A written description alone is not successful implementation.
Never stage, commit, push, create a PR, merge, or deploy in this workflow.

## Verify and Continue

The dispatcher reviews the exact delivered state, including staged, unstaged
and untracked work, and reruns material acceptance checks. Use exact endpoint
diffs for endpoint review; a triple-dot diff intentionally reviews a merge-base
range and will omit uncommitted edits unless those are inspected separately.

Record evidence and worktree location in Linear and use the team's review state
if available. If there is no review state, leave the ticket open with a review
comment, not completed. Human-review work does not unblock dependents here.
On failure, preserve partial changes and describe the failed criteria; agree a
handoff before releasing the claim. Never make partial work silently reclaimable.

Requery after verified returns. Dispatch only newly eligible tickets whose code
dependencies are available at the chosen base. Stop when the requested bound is
reached, no eligible work remains, capacity is blocked, or the user interrupts.
On interruption, stop new dispatch and report each running worker; use available
safe pause/cancel controls when requested without deleting its changes.

Report ticket, worktree, observed tracker state, acceptance evidence and remaining
work. Distinguish no eligible tickets from all tickets implemented: unassigned,
blocked, in-progress, failed and awaiting-review work may still remain.
