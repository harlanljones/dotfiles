# Review Rubric

## Evidence and scope

- Review each distinct full instruction-bearing tree, not only unique `SKILL.md` text. Record all mirrors, hashes, provenance, known version or unknown version, license files and provider constraints.
- Read supporting references, scripts, templates and agent metadata. Preserve assets and licenses. State external dependencies and unavailable provider payloads explicitly.
- Use exact source paths and sections for consequential findings. Graph tools are unavailable in this session; graph project, generation and index coverage are unknown. Source inspection is the evidence fallback.
- Distinguish static scenario walkthroughs from executed tests and live harness evaluation. Never turn a prompt-style preference into a measured performance claim.

## Candidate quality

- A description names the task and its distinct trigger branches, not every synonym or generic promise. Preserve explicit-invocation boundaries; provider support for metadata must be verified before promotion.
- Keep task-specific expertise, hazards and command gotchas. Remove generic coaching and rigid sequencing only where they do not encode a real dependency.
- Put branch-specific reference material behind useful pointers. A shorter entrypoint is not an improvement if it hides required safety or tool instructions.
- Match discovery and tests to the task's risk. Reviews prioritize actionable correctness, safety and regressions; heuristics are optional unless a requirement makes them binding.
- State write authority and completion precisely. Planning, review and research do not grant edit, publish, commit, deploy, credential-access or purchase authority.
- Preserve user agency. Ask inline review questions for unresolved policy choices, not for facts the agent can inspect.

## Workflow composition

- Review scope explicitly includes the requested endpoints and any staged, unstaged or untracked implementation. Triple-dot comparisons mean merge-base review, not exact endpoint review.
- Delegation is task-dependent. Prefer in-session execution for small, interactive or read-only work; bounded in-session delegation for independent reading; isolated worktrees for concurrent overlapping writes. Herdr adds visibility, not isolation by itself.
- Herdr control requires `HERDR_ENV=1` and explicit authorization for the topology. Use current CLI help, returned IDs and `--no-focus`; a completed pane state is not test evidence.
- Use the repository's configured Linear destination; in this project select the lowest-number eligible open ticket, assign `--assignee self` before work, and verify relations and ownership. Assignment has no atomic compare-and-swap guarantee; use one dispatcher for shared claims.
- Keep decisions, implementation, human review and deployment as different states. Do not close review work as human-approved.

## Per-candidate review contract

Each `REVIEW.md` records disposition, proposed task pack and invocation, per-skill execution recommendation with alternatives, source-specific changes and retained expertise, reviewed supporting paths, validation and limitations, indexed questions, provider/upstream-update implications, and a promotion boundary. Provenance and hashes may point to the inventory entry instead of being copied.

Each reviewer also writes `review.json` with `status`, `disposition`, `pack`, `invocation`, `execution`, `reviewedFiles`, `changes`, `questions`, `validation`, and `limitations`. Questions are objects with `id`, `question`, `recommendation`, `rationale`, and `files`. Paths are relative to the candidate. `status` is `reviewed` only after the full tree is inspected.
