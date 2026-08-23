---
name: linear-agent-tracking
description: Coordinate agent-owned work in Linear using @schpet/linear-cli. Use when creating or working a Wayfinder map, publishing Matt Pocock-style tickets, claiming ready work, recording progress or resolution, or configuring Linear as a repo's issue tracker.
---

# Linear Agent Tracking

Use Linear as the shared, durable task graph for agents. This skill supplies the tracker mechanics; preserve the workflow semantics of the skill that produced the work.

## Route the work

- A large effort whose route still contains unresolved decisions: invoke `wayfinder`. A Wayfinder ticket resolves one decision; it is not an implementation slice.
- An approved spec, plan, or conversation ready to decompose: invoke `to-tickets`. Its tickets are independently verifiable vertical implementation slices.
- An existing spec and ticket graph ready to build: invoke `implement-spec`. Work only the unblocked frontier and keep Linear synchronized as tickets move.
- Ordinary task tracking without one of those workflows: use the lifecycle below directly.

Do not silently convert Wayfinder decision tickets into implementation tickets. Once the route is clear, hand the result to `to-tickets`; once that task graph exists, `implement-spec` may consume it.

## Establish the tracker

1. Read `docs/agents/issue-tracker.md` in the repository when present. It is authoritative for the workspace, team, project, wrapper command, labels, and local conventions.
2. Resolve the CLI in this order: the command named by that tracker doc, `linear` on `PATH`, then `/home/harlan/.cache/.bun/bin/linear`. Do not replace the configured tracker with GitHub issues, local markdown, or direct API calls when the command is unavailable.
3. Run `<linear-command> --version` and `<linear-command> --help` once per session. This installation is expected to be `@schpet/linear-cli`; command help is authoritative because the package can change.
4. If the repo has not configured Linear for the Matt Pocock skills, invoke `setup-matt-pocock-skills` and use [the Linear tracker template](references/issue-tracker-linear.md) as the tracker description.

For exact CLI operations, read [Linear CLI operations](references/linear-cli.md). Read it before performing a mutation or a frontier query.

## Task lifecycle

### Discover

Fetch the parent/map at low resolution and query candidate children as JSON. A ticket is on the frontier only when it is:

- open;
- a child of the named parent/map;
- unassigned; and
- not blocked by any open issue.

Do not equate list order or `ready-for-agent` with unblocked. Inspect native relations for each candidate. Refer to issues by linked title in human-facing text; identifiers are transport details.

### Claim

Assignment is the concurrency lock. Immediately before claiming, re-read the issue and its relations. If it remains open, unassigned, and unblocked, assign it to `self` as the first write. If another agent won the race, leave it untouched and choose another frontier ticket.

Do not use `issue start` merely to claim work: it also changes git state and workflow state. Use explicit assignment unless the user asked for the branch transition.

### Work and report

Keep substantive context in Linear rather than duplicating it in agent messages. Comments should state durable facts, decisions, verification evidence, or a context pointer. Do not emit routine play-by-play comments.

Never expose tokens. Prefer `--description-file` and `--body-file` for Markdown; create temporary files outside the repo and remove only those exact files after the command succeeds.

### Resolve

Re-read the ticket before closing. Record the resolution as a comment, then move it to the team's completed state. For Wayfinder, also append only a one-line gist and link to the map's `Decisions so far`; the full answer remains on the child ticket. For implementation graphs, update the parent only when its workflow explicitly requires it.

After resolution, recompute the frontier from current Linear state. Never claim a second Wayfinder decision ticket in the same session; follow Wayfinder's research-ticket exception exactly.

## Write boundaries

Tracker reads are safe discovery. Creating, assigning, editing, commenting on, relating, or closing issues mutates shared external state. Perform those writes when the user requested tracking/publishing/working a tracked map or ticket; otherwise show the intended changes and obtain authorization. Confirm destructive operations such as deletion separately.

If authentication or configuration is missing, report the exact failing command and continue any work that does not require Linear. Do not improvise another tracker.
