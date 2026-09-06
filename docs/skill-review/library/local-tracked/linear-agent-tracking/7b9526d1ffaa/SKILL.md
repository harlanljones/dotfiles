---
name: linear-agent-tracking
description: Coordinate agent-owned work in Linear using @schpet/linear-cli. Use when creating or working a Wayfinder map, publishing Matt Pocock-style tickets, claiming ready work, recording progress or resolution, or configuring Linear as a repo's issue tracker.
---

## Load synced Linear credentials

For an authorized tracker workflow on this machine, load the chezmoi-managed
single-line credential without printing it. This is a loader for the managed
format, not a general TOML parser. Keep shell tracing disabled.

```bash
load_linear_toml() {
  local file="${1:-$HOME/.linear.toml}"
  local key
  key="$(sed -n 's/^LINEAR_API_KEY[[:space:]]*=[[:space:]]*"\(.*\)"$/\1/p' "$file")" || return
  [ -n "$key" ] && [[ "$key" != *$'\n'* ]] || return 1
  export LINEAR_API_KEY="$key"
}

load_linear_toml
```

Check the loader's exit status before invoking the CLI; on failure stop the
tracker workflow without falling back to a stale environment credential. Use
this loader for every Linear workflow in this skill. The snippet requires bash.

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
2. Resolve the configured wrapper or `linear` on `PATH`. A machine-specific fallback is usable only when its location is verified. Do not replace the configured tracker with GitHub issues, local markdown, or direct API calls when the command is unavailable.
3. Run `<linear-command> --version` and `<linear-command> --help` once per session. This installation is expected to be `@schpet/linear-cli`; command help is authoritative because the package can change.
4. If no tracker document exists, use the explicitly requested destination for this task; ask for missing scope. Creating persistent tracker configuration is separate setup work. When requested, use `setup-matt-pocock-skills` and [the Linear tracker template](references/issue-tracker-linear.md).

For exact CLI operations, read [Linear CLI operations](references/linear-cli.md). Read it before performing a mutation or a frontier query.

## Task lifecycle

### Discover

Fetch the requested map or project and query a bounded candidate set as JSON. A ticket is on the frontier only when it is:

- open;
- in the requested project/scope, and a child of the named map when one exists;
- unassigned; and
- not blocked by any open issue.

Do not equate list order or `ready-for-agent` with unblocked. Inspect native relations for each candidate. Refer to issues by linked title in human-facing text; identifiers are transport details.

### Claim

Select the lowest-number eligible open ticket under this environment's policy.
Immediately before claiming, re-read its state, assignee and relations. Assign
`--assignee self` as the first write, then re-read before starting. If assigned to
someone else, leave it untouched. On resume, inspect your existing assigned work
before selecting more work.

Assignment is a cooperative claim, not an atomic lock: this CLI has no
compare-and-swap, and several agents may share `self`. Use one dispatcher for
concurrent workers plus exclusive write scopes; a read-after-write cannot prove
another dispatcher did not race. Pause on unresolved ownership.

> Q-linear-agent-tracking-dispatch: Make a single dispatcher the default for
> shared-account claims? Recommendation: yes, with worker identity and file scope
> recorded; an assignee alone cannot establish exclusive ownership.

Do not use `issue start` merely to claim work: it also changes git state and workflow state. Use explicit assignment unless the user asked for the branch transition.

### Work and report

Keep substantive context in Linear rather than duplicating it in agent messages. Comments should state durable facts, decisions, verification evidence, or a context pointer. Do not emit routine play-by-play comments.

Never expose tokens. Prefer `--description-file` and `--body-file` for Markdown; create temporary files outside the repo and remove only those exact files after the command succeeds.

### Resolve

Re-read the ticket before transition. Record delivered evidence and unmet criteria,
then use the state appropriate to the originating workflow. Implementation awaiting
human review stays open/in review, not completed. A candidate-review ticket can be
completed when its stated deliverable is review readiness, without calling the
candidates approved. For resolved Wayfinder decisions, append only a one-line gist
and link to the map's `Decisions so far`; the full answer remains on the child.
For implementation graphs, update the parent only when its workflow requires it.

After resolution, recompute the frontier from current Linear state. Never claim a second Wayfinder decision ticket in the same session; follow Wayfinder's research-ticket exception exactly.

## Write boundaries

Tracker reads are safe discovery. Creating, assigning, editing, commenting on, relating, or closing issues mutates shared external state. Perform those writes when the user requested tracking/publishing/working a tracked map or ticket; otherwise show the intended changes and obtain authorization. Confirm destructive operations such as deletion separately.

If authentication or configuration is missing, report the exact failing command and continue any work that does not require Linear. Do not improvise another tracker.

Keep tracker mutations in-session with the dispatcher. Delegate independent
read-only issue/source inspection when useful; neither Herdr nor a worktree
isolates shared tracker state.
