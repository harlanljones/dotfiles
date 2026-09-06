# Issue Tracker

Read this before selecting, claiming, delegating or updating Skills Review work.
This is the cross-harness entry point; no prior chat or installed skill is required.
The destination below applies to Skills Review, not unrelated dotfiles work or the
independent showcase submodule.

## Destination

- CLI: `linear` on PATH (`@schpet/linear-cli`, verified version 2.5.0).
- Workspace: `harlanljones`; team: `HJ` (Harlan Jones).
- Project: [Skills Review](https://linear.app/harlanljones/project/skills-review-c64b191a871a).
- Project UUID: `599d37c9-7044-48a8-8720-407bf496b75e`.
- [Routing policy](https://linear.app/harlanljones/document/skills-review-agent-routing-policy-78b9312c25ff), document ID `0b166cc4-76d2-4ffe-923d-7a7ffbcf849f`.
- [Issue/dependency map](https://linear.app/harlanljones/document/skills-review-agent-routing-and-dependency-map-612fad0757da), document ID `101d5c3b-1391-43f6-bf2a-43993f37e933`.

Linear holds current task state, decisions and ownership. The map is an initial
scope snapshot, not live readiness. Candidate evidence lives in
[`../skill-review/`](../skill-review/README.md). Read its README, RUBRIC and
VERIFICATION plus the complete assigned issue before touching candidates.

## Access

Run `linear --version` and `linear --help`; inspect subcommand help when needed.
Use the managed credentials on this machine without displaying them. In Bash,
with shell tracing disabled, define this session-only wrapper:

```bash
linear_skills() {
  local key
  key="$(sed -n 's/^LINEAR_API_KEY[[:space:]]*=[[:space:]]*"\(.*\)"$/\1/p' "$HOME/.linear.toml")" || return
  [ -n "$key" ] && [[ "$key" != *$'\n'* ]] || return 1
  LINEAR_API_KEY="$key" command linear "$@"
}
```

This parses the managed single-line format, not arbitrary TOML. It reloads on
each call and fails before invoking the CLI on missing/empty/duplicate matches.
On another machine, obtain operator-provided access through the installed CLI's
supported authentication flow. If CLI or credentials are unavailable, report the
blocker and continue only explicitly assigned local work. Never copy credentials
into tickets, files, prompts or logs, or substitute a different tracker/raw API.

Fetch the policy and frontier without downloading attachments:

```bash
linear_skills document view 0b166cc4-76d2-4ffe-923d-7a7ffbcf849f --json --no-download
linear_skills issue query --team HJ --project 599d37c9-7044-48a8-8720-407bf496b75e --label ready-for-agent --unassigned --all-states --json --limit 0
linear_skills issue view HJ-730 --json --no-download
linear_skills issue relation list HJ-730
```

`HJ-730` is an example, not a permanently selected task. Exclude completed and
canceled results and inspect current native prerequisites before selection.

## Routing

| Labels | Contract |
| --- | --- |
| `work:agent` / `work:human` | Execution role; human decisions stay human-owned |
| `ready-for-agent` / `ready-for-human` | Cached readiness hint, checked against current state and blockers |
| `agent-tier:1-routine` | Mechanical task with fully specified outcome and objective checks |
| `agent-tier:2-standard` | Bounded source-grounded engineering review and validation |
| `agent-tier:3-expert` | Expert reasoning for authority/security, orchestration, provider ambiguity or synthesis |
| `agent-mode:checkpointed` | Resumable file-level coverage; independent of capability tier |

Every agent task requires exactly one minimum tier. Use an operator-calibrated
model configuration meeting that tier plus domain/tool requirements; higher tiers
may substitute. Model identity, price and self-confidence are not calibration.
With no approved capability mapping, ask the dispatcher to route the task instead
of inventing a mapping or silently downgrading. Human tasks receive no agent tier.

## Claim and Handoff

1. Resume assigned work first. Otherwise select the lowest-number eligible issue
   in this project that the available qualified worker can execute.
2. Read its body, comments and native relations. CLI 2.5.0 truncates nested query
   relations at 100 and relation-list incoming results at 50. HJ-853 has 115 planned
   prerequisites. Both-endpoint checks can prove known edges, not absence of hidden
   blockers. Fail closed on incomplete blocker discovery; request paginated CLI
   support or human reconciliation rather than assuming readiness.
3. One dispatcher controls shared tracker writes. Re-read ownership, assign
   `--assignee self`, and record worker/session ID, model configuration, tier,
   exact write scope and verification owner in a claim comment. Assignment is
   cooperative, not atomic; multiple agents can share `self`.
4. Remove `ready-for-agent` and set In Progress when execution starts. A delegated
   worker returns evidence to the dispatcher rather than independently claiming
   other issues or changing shared status. Reserve disjoint file ownership;
   shared working directories and Herdr panes are not isolation.
5. Keep checkpointed tasks In Progress through all retained-file passes. Preserve
   partial work and record exact completed paths, remaining work and failed checks
   at handoff. Escalate ambiguity or repeated failures rather than lowering quality.
6. Before resolution, re-read the issue and verify every acceptance criterion.
   Record commands/results and limitations, then use the appropriate state.
   Review-readiness completion is not human approval or deployment. Disclose when
   authoring and verification were performed by the same agent.
7. Recompute affected dependents' readiness after completion, reopening or new
   blockers. Canceled prerequisites need reconciliation, not automatic satisfaction.
   Preserve unrelated labels; use `--add-label` / `--remove-label`, not replacement.

For Markdown comments/descriptions use CLI `--body-file` / `--description-file`
with a temporary file and re-read before replacing shared descriptions. A missing
comment or failed command is not a successful claim, publication or transition.

## Boundaries and Portability

Skills Review is candidate-only. Its tickets do not authorize live skill changes,
installs, apply, commits, pushes, purchases or Herdr topology. Preserve the frozen
inventory and report failed preservation gates; never reset or refresh them away.
Repository guidance added for tracker discoverability is separate authorized work,
not evidence that the original broad preservation check passes.

Agents in this shared workspace can read the current candidate trees. A fresh clone
or remote worker must first verify those trees and frozen inventory are available;
the initial publication `ffff1e3` was withdrawn from remote `main` for CI repair.
Use the replacement publication once available, or request an authorized artifact
handoff if missing. Do not push the withdrawn commit back onto `main`.
The ignored `.unlazy/` leases and ledgers are machine-local, not clone artifacts;
use committed verification records and establish fresh coordination. Do not rebuild missing candidates from
newer live skills or treat Linear descriptions alone as reviewed source evidence.

The frozen inventory records absolute paths and pre-publication Git state. Its
preservation commands are historical, machine-local oracles, not portable CI
checks. Publication legitimately changes HEAD/index but does not waive recorded
live drift. Contract checks on edited candidates still require hash-matching
original bytes from recorded source mirrors; report unavailable originals on a
fresh clone rather than weakening validation. Fixture tests are portable.

This document enables manual or orchestrated use. It installs no orchestrator,
model mapping, credentials, auto-assignment or automatic readiness maintenance.
