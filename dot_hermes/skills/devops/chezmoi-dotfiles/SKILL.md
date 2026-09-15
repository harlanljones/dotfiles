---
name: chezmoi-dotfiles
description: Use for chezmoi repo work — pulls, conflicts, templates.
---

# Chezmoi dotfiles work

Procedure for safely integrating upstream changes and editing a chezmoi source tree. Repo AGENTS.md (if present) is authoritative for repo-specific rules — this skill carries the workflow and generic pitfalls only.

## Safe pull of upstream changes

1. `git fetch origin`, then read `git log --oneline main..origin/main` and `git diff --stat main origin/main` to understand the incoming batch BEFORE touching the working tree.
2. Cross-check incoming touched files against local dirty files (`git diff --name-only main origin/main` intersected with `git status --short`). This predicts every conflict before it happens — do the merge in a sandbox only if the overlap is real.
3. Sandbox with a worktree: `git stash push -u -m <msg>` then `git worktree add -b integration/pull-<topic> ../<name>-merge origin/main`, then `git stash pop` inside it. Conflicts surface there, never in the live checkout.
4. Resolve, validate (below), commit, then fast-forward the live checkout: `git merge --ff-only integration/...`. Clean up: `git stash drop`, `git worktree remove`, `git branch -D`.

## Conflict resolution rules

- Generated files (index/README trees): never hand-merge. Take one side wholesale, then regenerate with the repo's generator after the merge. If the local work added no new tracked files, the upstream regeneration already covers it — take upstream.
- Rename/rename: inspect what each side renamed the file INTO before choosing. One side is often a redesign (e.g. config moved to `.chezmoitemplates/` plus an include/merge file) that supersedes the other's in-place edit; take the redesign and verify nothing stash-only was lost that is still repo-owned.
- Distinguish repo drift from runtime drift. Config files that applications rewrite themselves (hooks trust hashes, model picks, auto-appended project trusts) are runtime state; edits to them do NOT need re-applying on top of a redesign that stopped tracking them. Losing that content in a merge is correct, not data loss.

## Validation gates

- Run `chezmoi apply --dry-run --force` (from the source repo). A bare `--dry-run` prompts "file has changed since chezmoi last wrote it" for any target file the app itself rewrote at runtime, and fails with a TTY error in a non-interactive shell — `--force` bypasses that prompt so you get a true pass/fail. That prompt is a pre-existing state condition, not a merge defect; distinguish before debugging.
- Shellcheck each touched shell module; run the repo's own generator `--check` gates if it has them.
- After editing any `run_onchange_*` hook, its next apply re-runs (installs may execute).

## Editing rules

- New files must use the correct source-name prefix (`dot_`, `private_dot_`, `executable_`, `encrypted_…age`, `*.tmpl`); secrets only via `encrypted_*.age`.
- rc files are pure loaders — shell config goes in the shell module directory, never `dot_bashrc`/`dot_zshrc`.
- When keeping a local fix that overlaps a refactor's new file, check the refactor didn't relocate that concern elsewhere (e.g. tool completions moved to a dedicated module) before assuming the original location is still right.