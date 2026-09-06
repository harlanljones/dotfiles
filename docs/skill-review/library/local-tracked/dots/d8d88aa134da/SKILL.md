---
name: dots
description: Manage chezmoi-backed user dotfiles with the dots wrapper. Use for configuration edits, drift capture, apply previews, synchronization, and dotfile diagnostics on this machine; not ordinary application source files.
---

# Dots

Use `chezmoi` through `~/.local/bin/dots` to keep persistent configuration in its
source tree. Read the repository's instructions and target index first; templates,
encrypted files and machine-specific ignores can make a live file differ by design.

## Authority and Scope

Choose the operation the user requested: review, source edit, live edit, apply,
or publication. A source edit does not authorize applying it. Commit and push
require explicit authorization, even when this skill was invoked directly.
Work in-session; delegate independent inspection only when it helps. Concurrent
writers need disjoint files or worktrees, but worktrees do not isolate `$HOME`.

> Q-dots-apply: Should a request to edit a source file also authorize apply?
> Recommendation: no; source changes and live deployment remain separate unless
> the user explicitly requests both. This avoids triggering unrelated hooks.

## Review or Source Edit

1. Inspect git status and the relevant source/target diff before editing. Preserve
   unrelated work and distinguish pre-existing drift from this task.
2. Edit the owning source or template. Put shell settings in the shared shell
   modules, not the rc loaders; follow the repo's source-name conventions.
3. Preview with `dots diff`; use `dots diff --all` to include hook scripts.
   For template edits, run the repo's required `chezmoi apply --dry-run` and
   report any unrelated failure separately. Diff output can contain secrets;
   inspect it locally without copying sensitive values into reports.
4. Run relevant syntax/config checks. Report changed source paths, validation,
   and whether the live target is deliberately unapplied.

For read-only review, stop at findings; no absorb, sync or publication.

## Requested Live Edit

Prefer a source edit when it can express the desired persistent setting. If the
task requires a live edit, capture only the intended paths afterward with
`dots absorb <path>` (or `chezmoi re-add <path>` where appropriate), then inspect
the source diff. Existing templates require care: use the wrapper's supported
capture path rather than replacing a template with machine-specific contents.
Broad `dots absorb` can capture unrelated drift; review its scope first.

## Requested Apply or Publication

Before an authorized apply, preview the entire affected set and hooks, then use
`dots sync` and validate the live behavior. A successful apply is not proof of
application behavior. `run_onchange_*` hooks are content-change driven;
`run_after_*` runs after every apply, not merely after a script edit.

`dots push` captures drift and delegates to the commit/push wrapper. Inspect its
current help and implementation, git status, diff and recent log before using it.
It is not a scoped commit primitive: if it would include another person's work,
stop and resolve the publication scope rather than silently publishing it.
`dots update` pulls/rebases and applies; treat it as a live mutation too.

## Command Map

| Command | Purpose |
| --- | --- |
| `dots status` | Inspect managed drift |
| `dots diff [--all]` | Preview target changes, optionally hooks |
| `dots absorb <path>` | Capture intended live changes into source |
| `dots sync --dry-run` | Preview apply without deploying |
| `dots sync` | Apply authorized source changes and eligible hooks |
| `dots doctor` | Diagnose toolchains, keys and settings drift |
| `dots push` | Capture, commit and push only when explicitly authorized |

Keep new secrets age-encrypted (`encrypted_*.age`); never put plaintext secrets
in source, logs or commits. Candidate-only documentation work does not require
absorb or apply. Completion reports distinguish source edits, applied targets,
and published commits rather than treating synchronization as one indivisible step.
