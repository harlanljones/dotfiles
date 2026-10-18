# Dotfiles (yadm)

Managed with [yadm](https://yadm.io): a git repo whose work tree is `$HOME`.
Tracked files are real files in place, so when Omarchy edits one, the change
shows up in `yadm diff`.

This lives on the **`yadm` branch** of `harlanljones/dotfiles`. `main` is still
the old chezmoi setup (frozen at tag `chezmoi-final`), so always clone with
`-b yadm`.

## New machine
```bash
omarchy pkg add yadm git-lfs
yadm clone -b yadm git@github.com:harlanljones/dotfiles.git   # bootstrap runs after clone
DRY_RUN=1 yadm bootstrap   # preview; then `yadm bootstrap` to re-run for real
```
Clone keeps existing local files that conflict with tracked ones; review them
with `yadm status` / `yadm diff` before taking the repo's version with
`yadm checkout -- <path>`.

## Daily use
- `yadm status` / `yadm diff`: see what changed in tracked files.
- `yadm add <file>` and `yadm commit`: track a new file or record a change.
- `yadm enter lazygit`: interactive staging.
- `yadm push`: the pre-push hook scans outgoing commits with gitleaks and
  uploads LFS objects.

## Rules
- **This repo is public.** The tracked git hooks in `git-hooks/` run gitleaks on
  every commit and push, and refuse if gitleaks is missing. Still review
  `yadm show --stat` before pushing anything that could be personal.
- **Omarchy changes files under you.** `omarchy update` runs migrations that
  edit `~/.config` files in place; `omarchy refresh` overwrites them (with a
  `.bak` copy); `omarchy reinstall` overwrites with no backup. Run
  `yadm status` after any of these. The post-update hook
  (`~/.config/omarchy/hooks/post-update.d/90-yadm-drift.hook`) sends a
  notification after updates, but it runs before the AUR and mise steps and
  not at all for `omarchy refresh`.
- **No alternates for files Omarchy edits.** A copied alternate would overwrite
  migration edits; a symlinked one gets replaced by `sed -i`. Track those files
  directly.
- **Secrets and private details never go in the repo.** Put the value in a
  1Password item in the **Agents** vault, add a template under `secrets/` with
  `{{ op://Agents/<item>/<field> }}` references, and add a line to
  `secrets.list`; bootstrap renders it with `op inject`. Only the Agents vault
  is used; bootstrap skips templates that reference any other vault. Rendered
  today: the git identity (`~/.config/git/identity`, included from
  `~/.config/git/config`) and the WirePlumber audio defaults, which name
  specific hardware.
- **Commits use the GitHub noreply address.** bootstrap sets `user.email` for
  this repo only; other repos keep the identity from `~/.config/git/identity`.
- **Installs belong somewhere reproducible**: `packages.txt` for packages,
  `~/.config/mise/config.toml` for dev tools, `SETUP.md` for anything manual.

## Omarchy shell plugins
- `omarchy-plugins.txt` lists the third-party plugins; bootstrap clones any
  that are missing. `~/.config/omarchy/shell.json` (tracked) decides which are
  enabled and where they sit on the bar. The clones themselves are not tracked.
- Local patches live in `~/.local/share/omarchy-patches/` and are applied with
  `omarchy-plugin-patches apply`. Before `omarchy plugin update`, run
  `omarchy-plugin-patches revert`, then `apply` again afterward.
  If a plugin misbehaves after its files change (patching, updating), run
  `omarchy restart shell`: many hot reloads in a row can leave it stuck.
- Enabling many plugins makes the shell slow to answer IPC; if an `omarchy
  plugin` command says the shell is not responding, retry with
  `OMARCHY_SHELL_IPC_TIMEOUT=30s`.
- `backdrop-split` spreads the theme background across the monitors (Backdrop
  plugin); hooks run it on theme change and at boot. `backdrop-split -i` opens
  a tile picker.

## Per-host differences (when a second machine arrives)
Only one machine uses this repo today. When another host joins:
- Prefer dispatch inside the file when the tool supports it. For Hyprland:
  keep `~/.config/hypr/monitors.lua` close to stock, end it with a loader that
  reads `/etc/hostname` and requires `hypr.hosts.<host>`, and move this
  machine's layout into `~/.config/hypr/hosts/<hostname>.lua`. `omarchy refresh`
  would overwrite the loader too, so re-check after refreshes.
- Use yadm alternates (`file##hostname.<host>`, `##class.<class>`) only for
  whole files that Omarchy doesn't touch. Set a class with
  `yadm config local.class <class>`.

## Files here
| File | Purpose |
|---|---|
| `bootstrap` | Idempotent setup: hooks, excludes, LFS, packages, mise, secrets |
| `git-hooks/` | gitleaks and Git LFS hooks (enabled via `core.hooksPath`) |
| `exclude.list` | Paths that must never be committed |
| `secrets.list`, `secrets/` | 1Password templates rendered by bootstrap |
| `seeds.list`, `seeds/`, `merge-json` | JSON preferences merged into app-owned files (Grok Bot, Cursor CLI) |
| `packages.txt` | Packages added on top of Omarchy |
| `omarchy-plugins.txt` | Third-party Omarchy shell plugins |
| `SETUP.md` | Manual steps |
| `PORTING.md` | Checklist for porting from the old chezmoi repo |
| `notes/` | Local-only session notes (excluded from the repo) |
