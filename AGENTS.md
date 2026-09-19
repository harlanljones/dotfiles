# AGENTS.md — Dotfiles Repo

Authoritative index for any development agent (or human) working in this chezmoi
dotfiles repo. When instructions here conflict with a task's ad-hoc request, prefer
this file and surface the conflict rather than silently overriding it.

---

## 1. What this is

A [chezmoi](https://www.chezmoi.io/) source tree that manages the user's shell,
editor, prompt, terminal, window manager, git config, and AI-agent harness config
across **three machines** (macOS `hadrian`, Linux/Omarchy `augustus`, Ubuntu-on-WSL2
`vespasian`). Sensitive values are stored as [age](https://github.com/FiloSottile/age)
encrypted files.

- **Source repo:** `~/.local/share/chezmoi` (this directory). Target home dir is `~`.
- **Apply:** `chezmoi apply` (or the `dots` CLI wrapper). Dry-run: `chezmoi apply --dry-run`.
- **Machine resolution:** `.chezmoi.toml.tmpl` → `[data] machine`, first match wins:
  hostname `omarchy` → `augustus`, `MacBookPro` → `hadrian`, `DESKTOP-UTOJEVB` →
  `vespasian`; then a WSL kernel → `vespasian`, any other Linux → `augustus`,
  darwin → `hadrian`, else `unknown`.
- **Vespasian is not Augustus-lite.** It has no `/usr/share/omarchy`, no desktop
  session and no systemd agent units. Gate Omarchy-only files on
  `eq .machine "augustus"` (or `osRelease.id == "omarchy"`), never on
  `eq .chezmoi.os "linux"`.

## 2. Source-name conventions

Every entry in the source tree maps to a home-directory target by a filename prefix:

| Prefix | Target | Example |
| --- | --- | --- |
| `dot_` | literal file in `~` | `dot_zshrc` → `~/.zshrc` |
| `dot_config/` | `~/.config/…` | `dot_config/starship.toml.tmpl` → `~/.config/starship.toml` |
| `dot_local/` | `~/.local/…` | `dot_local/bin/executable_dots` → `~/.local/bin/dots` |
| `private_dot_` | literal file in `~` with `0600` perms | `private_dot_ssh/config` → `~/.ssh/config` |
| `encrypted_…age` | age-encrypted at rest | `dot_config/opencode/encrypted_opencode.json.age` → `~/.config/opencode/opencode.json` |
| `executable_` | file becomes an executable | `executable_dots` → `~/.local/bin/dots` |
| `symlink_` | file becomes a symlink | `symlink_project-doc-planner` → a shared skill |

| `run_*.sh.tmpl` | executable apply script (not a dotfile) | see §3 |
| `*.tmpl` | Go-template rendered at apply time | `dot_config/git/config.tmpl` |

`.chezmoiignore.tmpl` controls what is *applied* (target-side), including per-OS and
per-machine gating. It does **not** control git tracking.

## 3. `run_*` script contract (apply hooks)

Chezmoi auto-runs scripts matching `run_*.sh` in the source root. Trigger semantics:

- `run_once_*` — executes once ever.
- `run_onchange_*` — executes only when the script file's contents change.
- `run_after_*` — executes after **every** apply.
- `*_before_*` — runs before normal dotfiles are applied; `*_after_*` runs after.

Number prefixes establish **intra-phase** order. There is no strict cross-type
ordering guarantee — treat each trigger class separately.

Script names follow `run_<trigger>_<phase>_<NN>-[<machine>|shared|omarchy]-<action>.sh.tmpl`:
the optional `<machine>` token (`augustus`/`hadrian`/`vespasian`) marks a
machine-scoped hook (mirrors the `vespasian-*` scripts), `omarchy-` marks an
Omarchy-feature hook (effectively Augustus-only), and `shared-`/`none` marks a
hook that runs on every machine (gated internally on `.machine`). Gaps in the
`<NN>` sequence (e.g. `11-19`, `33-39`) are intentional room for insertion.

| Order | Script | Trigger | Purpose |
| --- | --- | --- | --- |
| 00 | `run_once_before_00-verify-deps.sh.tmpl` | once | Fail early if `git`/`age` missing; warn on optional tools |
| 05 | `run_once_before_05-sync-hermes-skills.sh.tmpl` | once | Clone/fast-forward hermes-skills into `~/.hermes/skills` (no-op when remote unreachable/unauthenticated) |
| 09 | `run_onchange_before_09-install-agent-skills.sh.tmpl` | onchange | Install missing cross-harness agent skills (retries without incompatible providers, non-fatal on download error) |
| 10 | `run_onchange_after_10-install-omarchy-plugins.sh.tmpl` | onchange | Install/update Omarchy desktop plugins |
| 20 | `run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl` | onchange | Antigravity token/usage collector setup |
| 23 | `run_after_23-sync-agent-skills.sh.tmpl` | every apply | Reconcile shared `~/.agents/skills` into harnesses |
| 24 | `run_once_after_24-setup-omarchy-agents.sh.tmpl` | once (augustus) | Local state dirs + user systemd daemon |
| 25 | `run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl` | onchange | Validate/deploy `omarchy-agents` plugin builds |
| 26 | `run_onchange_after_26-setup-omarchy-cursor.sh.tmpl` | onchange | Cursor usage collector setup |
| 27 | `run_onchange_after_27-sync-claude-mcp.sh.tmpl` | onchange | Sync Claude Code MCP config |
| 28 | `run_onchange_after_28-sync-claude-settings.sh.tmpl` | onchange | Sync Claude Code permissions/hooks |
| 29 | `run_onchange_after_29-enable-omarchy-user-units.sh.tmpl` | onchange (augustus) | Enable Omarchy drift-capture and Cline-scrape user units |
| 30 | `run_onchange_after_30-hadrian-macos-defaults.sh.tmpl` | onchange (hadrian) | Declarative `defaults write` preferences |
| 31 | `run_onchange_after_31-augustus-mouse-dpi.sh.tmpl` | onchange (augustus) | Pin Logitech mice to 400 DPI |
| 32 | `run_onchange_after_32-setup-omarchy-agent-registrations.sh.tmpl` | onchange (augustus) | Register configured agents and collect initial Omarchy leaderboard usage |
| 33 | `run_onchange_after_33-augustus-machine-branding.sh.tmpl` | onchange (augustus) | Write Omarchy screensaver/about branding art from the machine identity |
| 34 | `run_after_34-augustus-backdrop-split.sh.tmpl` | after (augustus) | Re-split current theme background across monitors via Backdrop |
| 35 | `run_after_35-augustus-theme-modes-converge.sh.tmpl` | after (augustus) | Converge Theme modes light/dark slots from the dots theme registry via state-file merge (widget stays the actuator) |
| 40 | `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` | onchange (vespasian) | Write the Tokyo Night Windows Terminal fragment (scheme + Ubuntu profile update) |
| 41 | `run_onchange_after_41-vespasian-nerd-font.sh.tmpl` | onchange (vespasian) | Per-user install of the pinned JetBrainsMono Nerd Font on Windows |
| 42 | `run_onchange_after_42-vespasian-theme-state.sh.tmpl` | onchange (vespasian) | Rebuild bat's theme cache; set Claude Code theme to `dark-ansi`/`light-ansi` per the selected theme |
| 43 | `run_onchange_after_43-vespasian-1password-ssh-bridge.sh.tmpl` | onchange (vespasian) | Build/configure the WSL 1Password SSH bridge |
| 44 | `run_onchange_after_44-vespasian-windows-debloat.sh.tmpl` | onchange (vespasian) | Apply Windows developer-experience registry tweaks |
| 45 | `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` | onchange (vespasian) | Install/configure WezTerm, GlazeWM, Zebar, Flow Launcher, QuickLook, TranslucentTB, and AutoHotkey |
| 46 | `run_onchange_after_46-vespasian-wallpaper.sh.tmpl` | onchange (vespasian) | Set the Windows desktop wallpaper from the selected theme |
| 47 | `run_onchange_after_47-vespasian-wsl-boot.sh.tmpl` | onchange (vespasian) | Register WSL keepalive at Windows logon and reconcile portable user services |

## 4. Contents map

**Start here: [`INDEX.json`](INDEX.json).** It is the generated, authoritative
map of every tracked file — decoded home-directory target, chezmoi attributes
(`template`/`encrypted`/`private`/`executable`/`symlink`), category, subsystem,
and structured `run_*` hook semantics. Read it instead of inferring targets from
source-name prefixes; [`INDEX.md`](INDEX.md) is the same data for humans. Both
are generated by `docs/generate_index.py` and gated by CI — **never hand-edit
either file**; change the script (or its `CATEGORY_RULES`) and regenerate.

The table below is the orienting summary; the index is the detail.

| Path | What lives there |
| --- | --- |
| `dot_config/shell/` | **Shell configuration.** Modules shared by bash and zsh, sourced in numeric order by both rc loaders; see its own `README.md`. Add shell config here, never to `dot_bashrc`/`dot_zshrc` |
| `dot_config/` | All per-tool configs under `~/.config` (starship, ghostty, git, nvim, hypr, mise, opencode, omarchy, systemd/user, herdr, zoxide, btop, atuin, …) |
| `dot_local/bin/` | Custom scripts, usage collectors, scrapers, agent hooks (installed to `~/.local/bin`) |
| `dot_local/bin/cline-safety/` | `git` interceptor that refuses `commit`/`push` under Cline |
| `dot_local/bin/executable_statusline.tmpl` | Shared cross-harness CLI statusline renderer (Claude Code + Cursor) → `~/.local/bin/statusline` |
| `dot_local/bin/executable_chrome-profile` | **Chrome profile selector** → `~/.local/bin/chrome-profile`. Discovers profiles from Chrome's `Local State` JSON and launches Chrome in the chosen one (interactive `fzf` picker or fuzzy name/email filter). Cross-platform: Linux (`google-chrome-stable`), macOS (direct `.app` binary), WSL2 (Windows `chrome.exe` via `wslpath`). Shell aliases in `55-apps.sh`: `chrome` (picker), `chrome-work` (primeiq.ai), `chrome-personal` (Personal). Requires `jq`; `fzf` for interactive mode. Usage: `chrome-profile [filter] [URLs...]`, `chrome-profile --list` |
| `dot_agents/`, `dot_claude/`, `dot_cline/`, `dot_codex/`, `dot_gemini/`, `dot_grok/`, `private_dot_hermes/`, `dot_pi/` | Per-harness config, skills, rules, MCP, hooks |
| `private_dot_hermes/` | Default-profile Hermes config (`0700`, secrets-adjacent): `~/.hermes/config.yaml` (settings-only template), `~/.hermes/SOUL.md`; the skill library moved to the [hermes-skills](https://github.com/harlanljones/hermes-skills) repo, cloned/pulled into `~/.hermes/skills/` by `run_once_before_05-sync-hermes-skills` |
| `.chezmoidata/` | YAML data sources read by `.tmpl`s (`machines`, `agent_skills`, `omarchy_plugins`, `claude_mcp`, `claude_settings`, `codex_projects`, `themes`) |
| `.chezmoitemplates/themes/<name>/` | Verbatim upstream per-tool theme ports (Windows Terminal, lazygit, delta, fzf, eza, bat, Gemini) included by the themed templates; never applied. Select with `dots theme set <name>` (edits `machines.<machine>.theme.name`), never by editing rendered targets |
| `docs/` | Recovery guide, Vespasian boot & theming guides, reorganization proposal, and generator scripts (chezmoi-ignored, git-tracked) |
| `docs/agents/` | Cross-agent tracking guide (Skills Review retired 2026-09-16 — evidence recoverable from git history); never deploy or execute copied workflows as repo automation |
| `INDEX.json` / `INDEX.md` | **Generated** file index (see above); never hand-edit |
| `Documents/` | Non-config content (Cline workflow docs) |
| `.github/workflows/ci.yml` | CI: dry-run apply on Linux (Augustus + Vespasian) and macOS, gitleaks, shellcheck with chezmoi config, actionlint |
| `dot_config/opencode/encrypted_opencode.json.age` | Age-encrypted OpenCode auth & configuration |
| `dotfiles-showcase/` | **Submodule** — interactive web app; never apply, never edit here |
| `package.json` / `bun.lock` | Runtime CLI deps installed outside mise (see §5) |

Chezmoi ignores `dotfiles-showcase/`, `docs/`, `.github/`, `README.md`,
`AGENTS.md`, `INDEX.md`, `INDEX.json`, `package.json`, `bun.lock`, and
`to-questionnaire-*.md` for **apply** (see `.chezmoiignore.tmpl`). These are
repository/git material, not home-dir dotfiles.

## 5. Tool ownership (single source of truth)

Each CLI/runtime is owned by exactly one manager. Do not spread a tool across two.

| Manager | Manifest | Tools |
| --- | --- | --- |
| mise | `dot_config/mise/config.toml` | bun, chezmoi, claude, codex, copilot, gemini, gh, `github:can1357/oh-my-pi`, go, node, `npm:@xai-official/grok`, `npm:playwright`, opencode, pi, pnpm, python, ruby, terraform, tflint, uv |
| node/bun (npm) | root `package.json` + `bun.lock` | @magnitudedev/cli, @nanonets/graft, @schpet/linear-cli, cline, freebuff, supabase, wrangler |
| Homebrew (macOS) | `dot_Brewfile` | brews + casks (Ghostty, JetBrainsMono Nerd Font, …) |
| pacman / paru (Augustus) | `dot_config/pacman/pkglist.txt` + `aurlist.txt` | native + AUR packages |
| mise conf.d (Vespasian) | `dot_config/mise/conf.d/vespasian.toml` | atuin, bat, delta, direnv, eza, fd, fzf, lazygit, neovim, ripgrep, starship, zoxide (pacman/brew own these elsewhere) |
| apt (Vespasian) | `dot_config/apt/pkglist.txt` | age, build-essential, curl, erlang-nox, figlet, jq, postgresql, sqlite3, tailscale, unzip |
| standalone / scripts | `dot_local/bin/`, `~/.fly/bin` | flyctl (Fly.io CLI installer), chrome-profile (Chrome profile selector) |

## 6. Hard rules for agents

- **Before selecting, claiming, delegating or updating tracked work**, read
  [`docs/agents/issue-tracker.md`](docs/agents/issue-tracker.md). It defines the
  Skills Review Linear destination, agent capability tiers, human-only tasks,
  ownership protocol and blocker-discovery limits. Use it across harnesses;
  task labels alone are not dispatch authority.
- **Never apply or edit `dotfiles-showcase/`.** It's an independent git submodule with
  its own `AGENTS.md`/`ROADMAP.md`. Changes belong in the submodule repo.
- **Never commit secrets.** Do not add `.linear.toml`, `key.txt`, age keys, SSH
  private material, or harness `settings.local.json` contents. Use age encryption for
  new secrets (`encrypted_*.age`).
- **Keep repo-level `.gitignore` and `.chezmoiignore` in sync** with what is
  intentionally git-tracked vs applied.
- **Keep `.unlazy/` coordination local** via the shared ignore rules, not only
  `.git/info/exclude`. Regenerate the root index after publishing files.
- **Add new dotfiles with the correct prefix** (§2) and register them in
  `README.md` + this file if they add a tool or hook.
- **`dot_config/nvim/lazy-lock.json` was seeded from a snapshot, not from a
  live machine.** It came from the showcase's `fallback/lazy-lock.json`, a
  byte-identical FULL-COPY taken 2026-08-31. Before applying it to a second
  machine, run `chezmoi re-add ~/.config/nvim/lazy-lock.json` on the box whose
  plugin set is authoritative (Augustus), so an apply cannot roll plugins back
  to those pins. After that first re-add this is an ordinary managed file.
- **Never manage an agent harness's config as a whole file.** Codex, Gemini
  and Claude Code rewrite their own settings (model, effort, trust, counters).
  `~/.codex/config.toml` and `~/.gemini/settings.json` are `modify_` templates
  that merge a baseline from `.chezmoitemplates/` into the live file;
  `~/.claude/settings.json` is merged by `run_onchange_after_28` from
  `claudeSettings` (enforced) and `claudeSettingsDefaults` (seed-only). Put a
  key the tool changes interactively in the live-owned/defaults layer, never in
  the enforced baseline, or every `dots push` will commit the last choice.
- **Shell configuration goes in `dot_config/shell/`, not in the rc files.**
  `dot_bashrc` and `dot_zshrc` are loaders and must stay that way. Each module
  is a `*.sh` file with a shebang so CI shellchecks it, guards on the binary it
  configures, and branches on `SHELL_KIND` rather than being duplicated per
  shell. `60-prompt.sh` is deliberately divergent between the shells — see the
  comment in it before "simplifying" it.
- **After editing any `run_*` hook**, `git gc`/re-apply mentally: `run_onchange_*`
  will re-trigger if contents changed, which may re-run installs.
- **Hermes is managed separately from the other harnesses.** The *default*
  profile's config and `SOUL.md` are synced via `private_dot_hermes/`
  (`config.yaml.tmpl`, `dot_SOUL.md`); the default-profile skill library is
  its own git repo, `github.com/harlanljones/hermes-skills`, cloned or
  fast-forwarded into `~/.hermes/skills/` by
  `run_once_before_05-sync-hermes-skills` (repo URL/ref in
  `.chezmoidata/hermes_sync.yaml`). Still true and enforced:
  - Secrets live in `~/.hermes/.env`, never tracked.
  - The whole `~/.hermes/skills` tree is chezmoi-ignored — chezmoi neither
    manages nor deletes it. Runtime state (`.hub/` cache, `.curator_*`,
    `.usage.json*`, `.locks`, `.bundled_manifest`) is gitignored inside the
    skills repo and never synced.
  - All of `~/.hermes/profiles/` stay unmanaged — project-based profiles
    (verdict, flipforever) own their own skills/config via their repo `./dev`
    entrypoints.
  - The skills repo holds portable skill dirs plus `linked-skills.txt`
    (symlink names into the shared `~/.agents/skills` pool, owned by
    `agent_skills.yaml`); the sync hook recreates those symlinks per machine.
    Add a pooled skill in BOTH `agent_skills.yaml` (dotfiles) and
    `linked-skills.txt` (skills repo).
  - Skill *content* is edited in `~/.hermes/skills/` and synced by git
    (commit + push on the editing machine; other machines fast-forward on
    their next `chezmoi apply`). There is NO `chezmoi re-add` step for skills
    anymore — it does nothing. The sync hook only fast-forwards: it warns on
    divergence instead of resetting, so local edits are never destroyed.
  - `~/.hermes/agent-hooks/*` scripts are owned by the repo `./dev`
    entrypoints (verdict, flipforever), never by chezmoi.
  - Profiles, `state.db`, memories, sessions and caches stay unmanaged.
  - Hermes is excluded from the shared cross-harness skills pool
    (`agent_skills.yaml`, `run_onchange_before_09-install-agent-skills.sh`,
    `run_after_23-sync-agent-skills.sh`, `~/.agents/skills`) — it has its own
    library repo above; never add it to `agent_skills.yaml`.
- **`dots` CLI** is the human-friendly wrapper (`dots status/diff/update/push/doctor`).
  Prefer `dots push` to commit+push; it generates a Conventional Commit message via
  local Ollama and never commits agent work automatically.

## 7. Validation

- `chezmoi apply --dry-run` must succeed after any template edit.
- `INDEX.json` / `INDEX.md` are generated and CI-gated
  (`python3 docs/generate_index.py --check`). Regenerate with
  `python3 docs/generate_index.py` after adding, moving, or removing any tracked
  file. `python3 docs/generate_index.py --audit-showcase` additionally reports
  showcase `livePath` declarations that no longer match a managed target
  (requires the submodule to be checked out; not part of CI).
- The `## 📂 Repository Structure` tree in `README.md` is generated by
  `docs/generate_readme_tree.py` and gated by CI
  (`python3 docs/generate_readme_tree.py --check`). Regenerate it after adding or
  moving dotfiles (`python3 docs/generate_readme_tree.py`).
- CI (`.github/workflows/ci.yml`) validates templates on Linux (Augustus fallback and pinned Vespasian/WSL) and macOS, runs gitleaks secret scanning across full history, executes shellcheck over rendered managed scripts with generated chezmoi configuration, and verifies index/README trees.
- For changes to tools not self-verified here, run the relevant tool's own tests
  (e.g. the submodule's `bun test`).
