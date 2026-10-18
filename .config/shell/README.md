# `~/.config/shell`

Personal bash configuration, split into modules. `~/.bashrc` stays the stock
Omarchy file (it loads Omarchy's base rc: history, completion, mise, starship,
zoxide, fzf, the default aliases) and ends with a loader that sources every
`*.sh` here in numeric order. Add configuration here, not to `~/.bashrc`.

| Module | Holds |
| --- | --- |
| `00-env.sh` | `EDITOR`/`VISUAL` |
| `10-tools.sh` | Environment read by tools: ripgrep config, fzf commands and layout, pager |
| `20-integrations.sh` | atuin and direnv hooks, 1Password CLI completion and SSH agent socket |
| `30-navigation.sh` | `zj` / `zp` zoxide pickers on Alt-X / Alt-Z |
| `40-aliases.sh` | Listing, git, yadm, mise and agent aliases; `opr` |
| `60-prompt.sh` | Starship prompt turns red after a failed command |
| `70-cloud.sh` | gcloud configuration switching |
| `80-local.sh` | Sources the untracked `local.sh` last |

## Conventions

- **Guard on the binary.** `command -v foo >/dev/null 2>&1 && …`: a missing
  tool must never break the shell.
- **Don't repeat Omarchy.** Its base rc already sets up zoxide (`cd` → `zd`),
  fzf key bindings, starship, mise, `ls`/`lt` (eza), `..`, `n`, `g`, `cx`
  (Claude) and `cy` (Codex). Only add what differs.
- **Every module is `*.sh` with a shebang** so shellcheck can lint it. They are
  sourced, never executed.

## `local.sh`

Untracked and sourced last, for anything machine-specific or private. If an
installer appends to `~/.bashrc`, move the block here so `~/.bashrc` stays
close to stock and `yadm diff` shows the stray append.
