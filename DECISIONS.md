# Decisions

## ADR: TUI for setup wizard and new-machine registration (2026-09-21)

### Context
`setup.sh` (521 lines) is an interactive onboarding wizard with tput-based
colors and `step`/`info`/`success`/`warn`/`err`/`confirm` helpers. There is no
flow for registering a new machine: that requires hand-editing
`.chezmoidata/machines.yaml` and the hostname mapping in `.chezmoi.toml.tmpl`.
`gum` and `fzf` are available on augustus; `dots theme` already uses `fzf`.
`setup.sh` runs from a fresh clone, before `chezmoi apply`, so it cannot depend
on applied files.

### Settled decisions
| Area | Decision |
| --- | --- |
| Scope | `setup.sh` polish + new `dots register` command. `install.sh` (POSIX, pre-gum) and hook 32 are out of scope. |
| Toolkit | `gum` when present and stdout is a TTY; fall back to the existing tput helpers. |
| Shared lib | One repo-relative, chezmoi-ignored library (e.g. `lib/dots-ui.sh`) exposing the existing helper names plus gum-backed `choose`, `input`, `spin`, `confirm`. `setup.sh` sources it via `$(dirname "$0")`; `dots` sources it via `chezmoi source-path`. |
| `dots register` | (1) prompt name/OS/theme and add `machines.<name>` to `machines.yaml`, preserving comments (reuse `theme_write_machine_name` approach); (2) add hostname mapping to `.chezmoi.toml.tmpl`; (3) age key retrieval via 1Password (reuse setup.sh step); (4) offer `dots push`. |
| Non-interactive | `-y`, CI, or no TTY: plain output, defaults accepted, no gum/spinners. Current `-y` semantics preserved. |

### Alternatives & trade-offs
- tput-only helpers: no dependency, but no pickers/spinners. Rejected as the primary path, kept as the fallback.
- fzf pickers: consistent with `dots theme`, but poor for text input and confirmation.
- Applying the lib to `~/.local/lib` with an inline copy in `setup.sh`: duplicates code. Rejected.

### Implications
- Add the lib path to `.chezmoiignore.tmpl` and `.gitignore` as tracked-but-not-applied; regenerate `INDEX.*` and the README tree.
- Register `dots register` in AGENTS.md/README and `dots --help`.
- Shellcheck in CI must cover the new lib. Editing `.chezmoi.toml.tmpl` must pass `chezmoi apply --dry-run` on all three CI targets.
- Registering a machine is an outward-facing edit (commit/push): always confirm before `dots push`.
