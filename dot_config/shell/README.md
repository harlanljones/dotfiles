# `~/.config/shell`

Personal shell configuration, split into modules shared by bash and zsh.

`~/.bashrc` and `~/.zshrc` are loaders and nothing else: each sources every
`*.sh` in this directory in numeric order. Add configuration here, not there.

## Why it is split

Before the split, `.bashrc` (169 lines) and `.zshrc` (111 lines) held 29
byte-identical lines between them, `~/.local/bin` was prepended to `PATH` four
times in a login shell because three installers had each appended their own
copy, and neither file was linted — CI's shellcheck loop matches `*.sh`,
`*.sh.tmpl` and `dot_local/bin/*.tmpl`, and requires a shebang, so the two most
complex shell files in the repo had no static analysis at all. Every module
here is shellchecked.

## Load order

| Module | Holds |
| --- | --- |
| `00-env.sh` | Shell detection (`SHELL_KIND`), `_path_prepend`, `PATH`, `EDITOR`/`VISUAL` |
| `10-tools.sh` | Environment read by tools: ripgrep, fzf, pager, `MANPAGER` |
| `15-base-bash.sh` | Bash base layer (history, completion, mise, `starship init bash`) when Omarchy's rc is absent — Vespasian/WSL |
| `20-integrations.sh` | zoxide / fzf / atuin / direnv hooks, mise (zsh) |
| `30-navigation.sh` | `zj` / `zp` jumping and their key bindings |
| `40-aliases.sh` | Listing and traversal aliases, agent launchers, `n` |
| `50-agents.sh` | `cline` safety wrapper |
| `55-apps.sh` | `ft` (FreeToken desktop), WebKit workaround |
| `60-prompt.sh` | Starship init and the failure recolor |
| `65-theme.sh` | Terminal palette export for fzf (`~/.config/fzf/theme.sh` on Vespasian) |
| `70-cloud.sh` | flyctl, Google Cloud SDK |
| `75-tool-paths.sh` | Machine-specific PATH corrections |
| `80-local.sh` | Loads `~/.config/shell/local.sh` (unmanaged) — see below |

`00-env.sh` runs first so later modules can rely on `SHELL_KIND` and
`_path_prepend`. Renumber rather than reorder if something needs to move.

## Conventions

- **Guard on the binary.** `command -v foo >/dev/null 2>&1 && …` — a missing
  tool must never break the shell.
- **Branch on `SHELL_KIND`, don't duplicate the file.** Splitting into `bash/`
  and `zsh/` trees would recreate the duplication this replaced.
- **Every module is `*.sh` with a shebang** so CI shellchecks it. They are
  sourced, never executed; the shebang is a lint hint.
- **`60-prompt.sh` is deliberately divergent.** Bash recolors every foreground
  color, zsh recolors cyan only. That difference is real and the showcase
  demonstrates it (ROADMAP decision F1) — do not "unify" the two branches.
- **Iterate arrays as `"${arr[@]}"`.** zsh drops empty elements from an
  unquoted array expansion, which silently broke the recolor's unstyled case.

## `80-local.sh` — the sanctioned local-override layer

`80-local.sh` is managed; the file it sources is not. It loads
`~/.config/shell/local.sh` when that file exists, and chezmoi never touches
`local.sh`: chezmoi only creates, updates or removes files that have an entry
in the source tree, so anything you put in `local.sh` survives every
`chezmoi apply` untouched (pattern: thoughtbot's `dotfiles-local`, holman's
`gitconfig.local.symlink`).

Put machine-local aliases, functions and exports there instead of editing
`~/.bashrc` or `~/.zshrc` — those are managed, so an edit there is lost on the
next `chezmoi apply`, and a short loader makes the stray append obvious in
`chezmoi diff`. The git config has the mirror-image escape hatch:
`~/.gitconfig.local`, included from `dot_config/git/config.tmpl` and likewise
unmanaged.

Local files are also the right home for anything an installer appends to an
rc file: move the block into `~/.config/shell/local.sh` and delete the append.
