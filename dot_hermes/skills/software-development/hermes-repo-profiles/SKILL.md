---
name: hermes-repo-profiles
description: Use when setting up a repo-local Hermes profile via ./dev.
---

# Hermes Repo Profiles

Class of task: give a repo its own isolated Hermes profile with a `./dev` entrypoint, pruned skill set, project-skill symlinks, and per-profile shell hooks. Do not duplicate the `hermes-agent` skill's config reference — this is the repo-bootstrap workflow and its pitfalls.

## Procedure

1. **Mirror an existing profile repo, don't design from scratch.** Read the target repo's sibling (e.g. an existing profile repo's `./dev`, `.hermes.md`, `AGENTS.md`, `.gitignore`) and adapt: entrypoint script, disabled-skills list, project-skill symlink lists, hook scripts, project rules. Keep `./dev` idempotent (safe to re-run) and never touching the default profile: subcommands `setup` (bootstrap only), `doctor` (verify), anything else execs `hermes --profile <name> "$@"`.
2. **Profile + skill prune.** `hermes profile create <name> --clone --description ...`, then `hermes --profile <name> config set skills.disabled --force '<json array>'`. Keep the disabled list embedded in `./dev` so a fresh machine rebuilds the profile exactly; skip the set when `config get skills.disabled` already returns a non-empty list.
3. **Project skills.** Symlink categories into `./.hermes/skills/` (gitignored — they are per-machine), repair broken links by re-finding the skill dir, then `hermes --profile <name> skills trust .` from the repo root.
4. **Hooks.** Write per-profile hook scripts to `~/.hermes/agent-hooks/`, register them with `config set hooks.<event> --force '<json>'` (pre_tool_call guard fail_closed:true for mutating git ops; post_tool_call evidence/fmt; pre_llm_call context injection). Adapt the evidence hook's grep patterns to the repo's real verification commands.
5. **Project rules.** `AGENTS.md` = operating manual (invariants, conventions, non-goals, empty Commands block until commands are actually run and verified). `.hermes.md` = Hermes conduct + skill routing table WITH negative controls (near-neighbor asks that must NOT load a skill).
6. **Verify with `./dev doctor`** and commit.

## Pitfalls

- Never build the value for `config set` by shell-expanding a file region (`$(sed ... file)`) — multi-line captures get embedded into config.yaml as a garbage key and silently break the profile; pass a literal single-line JSON string and verify with `config get` immediately after.
- `hermes skills trust` without an explicit path fails with 'Not inside a git checkout' even when run inside one — always pass `.`; scripts that grep its output for the project-skill count will read 0 otherwise.
- `write_file`/`patch` do not set the executable bit — `chmod +x` every hook script before `doctor`, which should test executability, not existence.
- `config set` on custom top-level keys (e.g. `skills.disabled`) prints a notice about needing `--force`; confirm the value actually applied via `config get`, don't trust the notice.
- `hermes profile create <name> --clone` duplicates the full skills catalog into `profiles/<name>/skills/`. Project-skill symlinks in `./.hermes/skills/` MUST then point into the profile's own catalog (or dedupe to the same file) — a link to the default `~/.hermes/skills/...` leaves the same skill at two distinct paths, and bare `/skill-name` slash commands fail with "Failed to load stacked skills" because `skill_view` refuses the ambiguous name. Scan-time enumeration still lists the skill, so `doctor` passing does NOT rule this out — test `/<skill>` itself.
- `--clone` copies symlinked skills literally, so links like `unlazy -> ../../.agents/skills/unlazy` are broken inside the profile dir (relative to `profiles/<name>/skills/`). Fall back to the default catalog for such skills; `find -type d` misses them — test with `[ -e dir/SKILL.md ]`.
- Hook allowlist consent is per-profile: the first session prompts, or run `hermes --profile <name> --accept-hooks` once; note this in `doctor` output.
- Delete stale `profiles/<name>/backups/config/*` after repairing a corrupted config — startup scans backups too and keeps emitting the old warnings.
- Skills enabled in a profile are deliberate, not drift: record user-mandated exceptions (e.g. a design skill kept enabled for frontend repos) in both the disabled-list comment and `.hermes.md` routing so a rebuild doesn't drop them.
