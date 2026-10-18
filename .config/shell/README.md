# `~/.config/shell`

Personal bash configuration, split into modules. `~/.bashrc` stays the stock
Omarchy file (it loads Omarchy's base rc: history, completion, mise, starship,
zoxide, fzf, the default aliases) and ends with a loader that sources every
`*.sh` here in numeric order. Add configuration here, not to `~/.bashrc`.

| Module | Holds |
| --- | --- |
| `00-env.sh` | `EDITOR`/`VISUAL` |
| `10-tools.sh` | Environment read by tools: ripgrep config, fzf commands and layout, pager, zoxide |
| `20-integrations.sh` | atuin and direnv hooks, 1Password CLI completion and SSH agent socket |
| `30-navigation.sh` | `zj` / `zp` zoxide pickers on Alt-X / Alt-Z |
| `40-aliases.sh` | Listing, git, yadm, mise and agent aliases; `opr` |
| `60-prompt.sh` | Starship prompt turns red after a failed command |
| `61-splash.sh` | fastfetch banner on every interactive shell; `clear` redraws it |
| `65-theme.sh` | fzf colors from the current Omarchy theme |
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

## Theme sync

`~/.config/omarchy/themed/*.tpl` are rendered from the active theme's
`colors.toml` into `~/.local/state/omarchy/current/theme/` on every
`omarchy theme set`; a theme that ships its own copy of a file wins.

| Rendered file | Used by |
| --- | --- |
| `starship.toml` | `STARSHIP_CONFIG` (10-tools.sh) |
| `bat.tmTheme` | `~/.config/bat/themes/omarchy.tmTheme` link, `BAT_THEME=omarchy` |
| `delta.gitconfig` | `[include]` in `~/.config/git/config` |
| `eza-theme.yml` | `~/.config/eza/theme.yml` link |
| `fzf.sh` | 65-theme.sh |
| `lazygit.yml` | `LG_CONFIG_FILE` (10-tools.sh, environment.d) |
| `fastfetch.jsonc` | `~/.config/fastfetch/config.jsonc` link |
| `gemini-theme.json` | `ui.theme` path in `~/.gemini/settings.json` |

The theme-set hook `~/.config/omarchy/hooks/theme-set.d/theme-art` copies the
theme's `branding/{about,screensaver}.txt` into `~/.config/omarchy/branding/`
(or renders the machine name with figlet when the theme has none) and rebuilds
bat's theme cache.
