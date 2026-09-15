---
name: hermes-repo-devsetup
description: Use when a repo needs its own Hermes profile and dev script.
---

# Hermes Repo Dev Setup

Class of task: provisioning a repository with a repo-local Hermes dev
environment mirroring an established exemplar (this user's `~/dev/verdict`
is the reference implementation — read its `./dev`, `.hermes.md`,
`AGENTS.md`, profile config, and hook scripts FIRST, then mirror).
The `hermes-agent` skill is the general reference; this skill carries the
repro procedure and its gotchas.

## Procedure

1. **Read the exemplar before writing anything.** `~/dev/verdict/dev`
   (entrypoint), `~/.hermes/profiles/verdict/config.yaml` (hooks block),
   `~/.hermes/agent-hooks/*` (hook scripts), `.gitignore` (skills symlink
   exclusion). Mirror structure; adapt content to the new repo's language
   and invariants (e.g. cargo-fmt hook becomes prettier/eslint for web).
2. **Create the profile:** `hermes profile create <name> --clone --description "..."`.
3. **Prune skills:** `hermes --profile <name> config set skills.disabled --force '<literal JSON array>'`.
   Keep the full array in the `./dev` script's `build_disabled_list()` so a
   fresh machine can rebuild exactly.
4. **Hook scripts** in `~/.hermes/agent-hooks/<name>-*.sh`, chmod +x:
   git-guard (pre_tool_call on terminal|execute_code, `fail_closed: true`,
   blocks mutating git), formatter (post_tool_call on write_file|patch,
   guarded so it no-ops until the toolchain exists), evidence recorder
   (post_tool_call on terminal), git-status + evidence injectors
   (pre_llm_call). Read the JSON payload from stdin with jq; always print
   `{}` on no-op. Register via `hermes --profile <name> config set
   hooks.<event> --force '<JSON array>'`.
5. **Project skills:** symlink into `<repo>/.hermes/skills/` (gitignored,
   per-machine), repairing broken links by searching `~/.hermes/skills`.
6. **Trust:** `hermes --profile <name> skills trust .` — see pitfall below.
7. **Rules files:** `AGENTS.md` = operating manual (commands, layout,
   invariants — commands only once verified by running them);
   `.hermes.md` = Hermes-specific conduct layered on AGENTS.md: session
   behavior, skill routing table WITH negative controls, hooks doc.
8. **`./dev` entrypoint** (executable): default → ensure profile/prune/
   skills/trust then `exec hermes --profile <name> "$@"`; `setup` =
   bootstrap only; `doctor` = verify profile, unbroken skill links, trust
   count, hooks configured AND scripts executable, toolchain presence.
9. **Verify:** run `./dev doctor` (must exit 0), `hermes --profile <name>
   skills list` (confirm enabled/disabled counts), then git-commit.

## Pitfalls

- Pass `config set` values as a single literal quoted argument — never
  interpolate them through `$(...)` shell expansion of a file extract;
  multiline expansion corrupts the profile config.yaml (script text lands
  inside a key value) and silently drops the setting.
- `skills trust` does not resolve the enclosing checkout from cwd — always
  pass the explicit path argument (`skills trust .`), otherwise it reports
  'Not inside a git checkout' and doctor's project-skill count reads 0.
- The first session start will prompt for per-profile hook allowlist
  consent; state this, or run `hermes --profile <name> --accept-hooks`.
- Doctor must check hook scripts are EXECUTABLE, not just present — a
  chmod miss surfaces only as silent hook non-execution.
- `hermes config set` on a custom key prints a bridging notice — the write
  still applies; verify with `config get` rather than re-running with
  --force blindly. If config looks polluted, fix by overwriting the single
  affected key with a clean literal, never by hand-editing config.yaml.
- After any config repair, delete the stale auto-backup under
  `~/.hermes/profiles/<name>/backups/` — its presence re-triggers stale
  warnings on every command.
