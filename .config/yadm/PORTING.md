# Porting checklist: chezmoi → yadm

Every file the old chezmoi repo managed, with chezmoi's source names translated
to their target paths. **Nothing here has been copied.** Prune this list: delete
the lines you don't want and keep the ones you do. Then port each kept item as
its own commit, reading the source at the frozen tag:

```bash
git -C <clone> show chezmoi-final:<source path>
```

Actions are only suggestions:
- **port**: a plain file. Copy it, review it, `yadm add`.
- **rewrite**: needs a yadm mechanism instead of a chezmoi feature, as noted.
  Templates become `##template.esh` (needs the `esh` package) or a plain file,
  since only one host uses this repo. `modify_`/`create_`/`run_*` become
  idempotent bootstrap steps. Encrypted files become `secrets.list` entries.
- **drop**: other OS, other hardware, or tied to chezmoi.
- **skip**: deliberately not ported for now (revisit later).

Rules while porting:
- Files that Omarchy also edits get tracked directly, never as alternates.
- Symlinks stay symlinks.
- Look for hardcoded `/home/harlan` paths, the old machine name `augustus`, and
  installer leftovers (for example the old `.bashrc` had `. ~/.cargo/env` and
  Ubuntu `OPENSSL_*` paths).
- The old repo's `INDEX.json` describes most files and is worth checking.
<!-- generated from harlanljones/dotfiles @ ff7687d (tag chezmoi-final); names only -->

## Shell

- [x] **drop** `~/.bash_profile` <sub>`dot_bash_profile`</sub> — stock is fine; no cargo here (2026-10-18)
- [x] **done** `~/.bashrc` <sub>`dot_bashrc`</sub> — stock Omarchy .bashrc plus a module loader; installer leftovers dropped (2026-10-18)
- [x] **done** `~/.config/environment.d/10-defaults.conf` <sub>`dot_config/environment.d/10-defaults.conf`</sub> — ported (2026-10-18)
- [x] **drop** `~/.config/environment.d/10-machine.conf` (template → esh `##template.esh` or plain file) <sub>`dot_config/environment.d/10-machine.conf.tmpl`</sub> — only dots-identity read it (2026-10-18)
- [x] **done** `~/.config/shell/00-env.sh` <sub>`dot_config/shell/00-env.sh`</sub> — EDITOR/VISUAL=nvim; PATH handled by Omarchy and mise (2026-10-18)
- [x] **drop** `~/.config/shell/05-omarchy-detect.sh` <sub>`dot_config/shell/05-omarchy-detect.sh`</sub> — stock .bashrc loads Omarchy's rc (2026-10-18)
- [x] **done** `~/.config/shell/10-tools.sh` <sub>`dot_config/shell/10-tools.sh`</sub> — ported; MANPAGER left to Omarchy (2026-10-18)
- [x] **drop** `~/.config/shell/15-base-bash.sh` <sub>`dot_config/shell/15-base-bash.sh`</sub> — non-Omarchy hosts only (2026-10-18)
- [x] **done** `~/.config/shell/20-integrations.sh` <sub>`dot_config/shell/20-integrations.sh`</sub> — atuin, direnv, op completion, 1Password agent; zoxide/fzf left to Omarchy (2026-10-18)
- [x] **done** `~/.config/shell/30-navigation.sh` <sub>`dot_config/shell/30-navigation.sh`</sub> — bash only (2026-10-18)
- [x] **done** `~/.config/shell/40-aliases.sh` <sub>`dot_config/shell/40-aliases.sh`</sub> — dots aliases became ys/yd; Omarchy's cx (Claude) and cy (Codex) kept (2026-10-18)
- [x] **drop** `~/.config/shell/45-omarchy-portable-aliases.sh` <sub>`dot_config/shell/45-omarchy-portable-aliases.sh`</sub> — zsh/macOS only (2026-10-18)
- [ ] **port** `~/.config/shell/50-agents.sh` <sub>`dot_config/shell/50-agents.sh`</sub>
- [x] **drop** `~/.config/shell/55-apps.sh` <sub>`dot_config/shell/55-apps.sh`</sub> — WebKit fix not wanted; ft and chrome-profile not installed (2026-10-18)
- [x] **done** `~/.config/shell/60-prompt.sh` <sub>`dot_config/shell/60-prompt.sh`</sub> — bash branch only (2026-10-18)
- [x] **done** `~/.config/shell/61-splash.sh` <sub>`dot_config/shell/61-splash.sh`</sub> — fastfetch banner instead of dots-identity (2026-10-18)
- [x] **drop** `~/.config/shell/65-theme.sh` <sub>`dot_config/shell/65-theme.sh`</sub> — Vespasian only (2026-10-18)
- [x] **done** `~/.config/shell/70-cloud.sh` <sub>`dot_config/shell/70-cloud.sh`</sub> — gcp switchers; SDK and flyctl paths dropped (2026-10-18)
- [x] **drop** `~/.config/shell/75-tool-paths.sh` <sub>`dot_config/shell/75-tool-paths.sh`</sub> — opencode and grok live in ~/.local/bin (2026-10-18)
- [x] **done** `~/.config/shell/80-local.sh` <sub>`dot_config/shell/80-local.sh`</sub> — ported; local.sh excluded (2026-10-18)
- [x] **done** `~/.config/shell/README.md` <sub>`dot_config/shell/README.md`</sub> — rewritten for the bash-only layout (2026-10-18)
- [ ] **drop** `~/.zshrc` (macOS only) <sub>`dot_zshrc`</sub>

## Git and GitHub

- [x] **drop** `~/.config/gh/config.yml` <sub>`dot_config/gh/config.yml`</sub> — matches what gh writes by default (2026-10-18)
- [x] **done** `~/.config/git/config` (template → esh `##template.esh` or plain file) <sub>`dot_config/git/config.tmpl`</sub> — signing via 1Password Agents key, gh credentials, global hooks, delta, zdiff3, .gitconfig.local; identity and signing key rendered from 1Password (2026-10-18)
- [x] **done** `~/.config/git/hooks/commit-msg` <sub>`dot_config/git/hooks/executable_commit-msg`</sub> — ported (2026-10-18)
- [x] **done** `~/.config/git/hooks/pre-push` <sub>`dot_config/git/hooks/executable_pre-push`</sub> — ported; uses `gitleaks git` (2026-10-18)
- [x] **done** `~/.config/git/ignore` <sub>`dot_config/git/ignore`</sub> — .DS_Store dropped (2026-10-18)
- [x] **done** `~/.config/lazygit/config.yml` (template → esh `##template.esh` or plain file) <sub>`dot_config/lazygit/config.yml.tmpl`</sub> — delta renderer only; Ollama commit commands deferred to AI agents, dots theme dropped (2026-10-18)

## SSH and 1Password

- [ ] **port** `~/.config/1password/ssh/agent.toml` <sub>`dot_config/1password/ssh/agent.toml`</sub>
- [ ] **rewrite** `~/.ssh/config` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_ssh/config.tmpl`</sub>

## Neovim

- [x] **drop** `~/.config/nvim/init.lua` <sub>`dot_config/nvim/init.lua`</sub> — Omarchy-owned (2026-10-18)
- [x] **done** `~/.config/nvim/lazy-lock.json` <sub>`dot_config/nvim/lazy-lock.json`</sub> — regenerated for the new plugin set (2026-10-18)
- [x] **done** `~/.config/nvim/lazyvim.json` <sub>`dot_config/nvim/lazyvim.json`</sub> — 31 extras; toml dropped, docker+helm added, typescript.tsc is now tsgo, chezmoi and Copilot dropped (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/config/autocmds.lua` <sub>`dot_config/nvim/lua/config/autocmds.lua`</sub> — Omarchy-owned (2026-10-18)
- [ ] **port** `~/.config/nvim/lua/config/keymaps.lua` <sub>`dot_config/nvim/lua/config/keymaps.lua`</sub> — deferred: Ollama commit keys go with the AI agents group; CopilotChat key dropped (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/config/lazy.lua` <sub>`dot_config/nvim/lua/config/lazy.lua`</sub> — Omarchy-owned (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/config/options.lua` <sub>`dot_config/nvim/lua/config/options.lua`</sub> — Omarchy-owned (2026-10-18)
- [x] **done** `~/.config/nvim/lua/plugins/blink-cmp.lua` <sub>`dot_config/nvim/lua/plugins/blink-cmp.lua`</sub> — super-tab only (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/plugins/copilot-lualine.lua` <sub>`dot_config/nvim/lua/plugins/copilot-lualine.lua`</sub> — no Copilot (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/plugins/copilot.lua` <sub>`dot_config/nvim/lua/plugins/copilot.lua`</sub> — no Copilot (2026-10-18)
- [x] **done** `~/.config/nvim/lua/plugins/dashboard-dots-identity.lua` <sub>`dot_config/nvim/lua/plugins/dashboard-dots-identity.lua`</sub> — replaced by dashboard-theme-art.lua (theme-synced ASCII art) (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/plugins/example.lua` <sub>`dot_config/nvim/lua/plugins/example.lua`</sub> — identical to Omarchy's (2026-10-18)
- [x] **done** `~/.config/nvim/lua/plugins/faster-smear-cursor.lua` <sub>`dot_config/nvim/lua/plugins/faster-smear-cursor.lua`</sub> — ported (2026-10-18)
- [x] **skip** `~/.config/nvim/lua/plugins/herdr-nvim.lua` <sub>`dot_config/nvim/lua/plugins/herdr-nvim.lua`</sub> — deferred to the herdr group (2026-10-18) — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **done** `~/.config/nvim/lua/plugins/html-preview.lua` <sub>`dot_config/nvim/lua/plugins/empty_html-preview.lua`</sub> — ported (2026-10-18)
- [x] **done** `~/.config/nvim/lua/plugins/mini-animate-disable-cursor.lua` <sub>`dot_config/nvim/lua/plugins/mini-animate-disable-cursor.lua`</sub> — ported (2026-10-18)
- [x] **drop** `~/.config/nvim/lua/plugins/theme.lua` (template → esh `##template.esh` or plain file) <sub>`dot_config/nvim/lua/plugins/theme.lua.tmpl`</sub> — Omarchy links the theme (2026-10-18)
- [x] **done** `~/.config/nvim/lua/plugins/vim-be-good.lua` <sub>`dot_config/nvim/lua/plugins/vim-be-good.lua`</sub> — ported (2026-10-18)

## Terminals and CLI tools

- [x] **done** `~/.config/atuin/config.toml` <sub>`dot_config/atuin/config.toml`</sub> — ported (2026-10-18)
- [x] **drop** `~/.config/bat/config` <sub>`dot_config/bat/config`</sub> — theme now comes from BAT_THEME=omarchy (2026-10-18)
- [x] **done** `~/.config/bat/themes/dots.tmTheme` (template → esh `##template.esh` or plain file) <sub>`dot_config/bat/themes/dots.tmTheme.tmpl`</sub> — now a theme-synced Omarchy template (themed/bat.tmTheme.tpl) (2026-10-18)
- [x] **drop** `~/.config/btop/btop.conf` (template → esh `##template.esh` or plain file) <sub>`dot_config/btop/btop.conf.tmpl`</sub> — identical apart from the theme, which Omarchy already syncs (2026-10-18)
- [x] **drop** `~/.config/btop/themes/dots.theme` (template → esh `##template.esh` or plain file) <sub>`dot_config/btop/themes/dots.theme.tmpl`</sub> — Omarchy themes btop itself (2026-10-18)
- [x] **done** `~/.config/delta/theme.gitconfig` (template → esh `##template.esh` or plain file) <sub>`dot_config/delta/theme.gitconfig.tmpl`</sub> — now themed/delta.gitconfig.tpl (2026-10-18)
- [x] **done** `~/.config/eza/theme.yml` (template → esh `##template.esh` or plain file) <sub>`dot_config/eza/theme.yml.tmpl`</sub> — now themed/eza-theme.yml.tpl (2026-10-18)
- [x] **drop** `~/.config/fastfetch/augustus.jpg` <sub>`dot_config/fastfetch/augustus.jpg`</sub> — no images; ASCII art per theme instead (2026-10-18)
- [x] **done** `~/.config/fastfetch/config.jsonc` (template → esh `##template.esh` or plain file) <sub>`dot_config/fastfetch/config.jsonc.tmpl`</sub> — Augustus layout is now themed/fastfetch.jsonc.tpl; themes can ship their own (2026-10-18)
- [x] **drop** `~/.config/fastfetch/vespasian.jpg` (WSL/Windows only) <sub>`dot_config/fastfetch/vespasian.jpg`</sub> — dropped (2026-10-18)
- [x] **done** `~/.config/fzf/theme.sh` (template → esh `##template.esh` or plain file) <sub>`dot_config/fzf/theme.sh.tmpl`</sub> — now themed/fzf.sh.tpl (2026-10-18)
- [x] **drop** `~/.config/ghostty/config` (template → esh `##template.esh` or plain file) <sub>`dot_config/ghostty/config.tmpl`</sub> — Omarchy's stock config matches; single-instance tweak not wanted (2026-10-18)
- [x] **done** `~/.config/ripgrep/rc` <sub>`dot_config/ripgrep/rc`</sub> — ported (2026-10-18)
- [x] **done** `~/.config/starship.toml` (template → esh `##template.esh` or plain file) <sub>`dot_config/starship.toml.tmpl`</sub> — Augustus prompt is now themed/starship.toml.tpl (2026-10-18)
- [x] **done** `~/.config/zoxide/config.toml` <sub>`dot_config/zoxide/config.toml`</sub> — zoxide ignores config files; ported as _ZO_* variables (2026-10-18)
- [x] **done** `~/.local/share/figlet/README.md` <sub>`dot_local/share/figlet/README.md`</sub> — ported (2026-10-18)
- [x] **done** `~/.local/share/figlet/Roman.flf` <sub>`dot_local/share/figlet/Roman.flf`</sub> — ported; used by the theme-art hook (2026-10-18)
- [x] **done** `~/.local/share/figlet/small.flf` <sub>`dot_local/share/figlet/small.flf`</sub> — ported; used by the theme-art hook (2026-10-18)

## herdr

- [x] **skip** `~/.config/herdr/config.toml` (template → esh `##template.esh` or plain file) <sub>`dot_config/herdr/config.toml.tmpl`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/herdr/plugins.json` (template → esh `##template.esh` or plain file) <sub>`dot_config/herdr/plugins.json.tmpl`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/herdr/plugins/config/hhdebb.herdr-radar/config.toml` <sub>`dot_config/herdr/plugins/config/hhdebb.herdr-radar/config.toml`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/herdr/plugins/config/hhdebb.herdr-radar/hook.js` <sub>`dot_config/herdr/plugins/config/hhdebb.herdr-radar/hook.js`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness

## mise

- [x] **drop** `~/.config/mise/conf.d/vespasian.toml` (WSL/Windows only) <sub>`dot_config/mise/conf.d/vespasian.toml`</sub> — dropped (2026-10-18)
- [x] **done** `~/.config/mise/config.toml` <sub>`dot_config/mise/config.toml`</sub> — bun/uv first (npm tools via bun), go, python, ruby, pnpm, terraform, tflint, playwright; chezmoi, 1password-cli dropped; gemini and oh-my-pi deferred to AI agents (2026-10-18)

## Hyprland

- [x] **done** `~/.config/hypr/bindings.lua` <sub>`dot_config/hypr/bindings.lua`</sub> — ported 2026-10-18: notifications, theme modes, Omaland, Keychron knob, omalt-tab loader; X Native, Reprieve and Local AI binds dropped with their plugins
- [x] **drop** `~/.config/hypr/hyprland.lua` <sub>`dot_config/hypr/hyprland.lua`</sub> — not ported 2026-10-18: Omaland opacity and hyprmoncfg loader not wanted; this machine's own hyprland.lua is tracked
- [x] **drop** `~/.config/hypr/hyprmoncfg-monitors.lua` — dropped
- [x] **done** `~/.config/hypr/input.lua` <sub>`dot_config/hypr/input.lua`</sub> — ported 2026-10-18: flat acceleration
- [x] **drop** `~/.config/hypr/looknfeel.lua` <sub>`dot_config/hypr/looknfeel.lua`</sub> — not ported 2026-10-18: keeping Omarchy's default look
- [x] **drop** `~/.config/hypr/monitors.lua` — dropped; this machine's own monitors.lua is tracked

## Omarchy

Plugins (2026-10-18): kept 23 of Augustus's 43 third-party plugins, listed in
`omarchy-plugins.txt`. Dropped: hw monitor/storage duplicates (disk-lens,
zakarch.storage), shelfish, simple-notifications, workspace-profiles,
hyprmoncfg, any-monitor (repo gone), omaproton-vpn, mouse-odometer, screen
time, AppImage, alias manager, resume, local-ai, umarchy, omabudget,
omafinance, LetsFG, omashift. Not recoverable from the old repo: the
`harlan.fan-control` and `harlan.agent-leaderboard` plugins were never in it.

- [ ] **port** `~/.config/chrome-flags.conf` <sub>`dot_config/chrome-flags.conf`</sub>
- [x] **done** `~/.config/omarchy/defaults/agent` (template → esh `##template.esh` or plain file) <sub>`dot_config/omarchy/defaults/agent.tmpl`</sub> — already tracked from this machine
- [x] **done** `~/.config/omarchy/hooks/post-boot.d/backdrop-split` <sub>`dot_config/omarchy/hooks/post-boot.d/executable_backdrop-split`</sub> — ported 2026-10-18, longer IPC timeout
- [x] **done** `~/.config/omarchy/hooks/theme-set.d/backdrop-split` <sub>`dot_config/omarchy/hooks/theme-set.d/executable_backdrop-split`</sub> — ported 2026-10-18
- [x] **done** `~/.config/omarchy/shell.json` (template → esh `##template.esh` or plain file; `create_` → copy-if-missing in bootstrap; chmod 600/700 in bootstrap) <sub>`dot_config/omarchy/create_private_shell.json.tmpl`</sub> — ported 2026-10-18: rebuilt on this machine's layout in Augustus order, plain tracked file
- [x] **done** `~/.local/share/omarchy-patches/io.github.codesmith28.omalt-tab-compact.patch` <sub>`dot_local/share/omarchy-patches/io.github.codesmith28.omalt-tab-compact.patch`</sub> — ported 2026-10-18: Dimensions.js only (the tests part no longer applies); applied by omarchy-plugin-patches

## Packages

- [x] **drop** `~/.Brewfile` (macOS only) <sub>`dot_Brewfile`</sub> — dropped (2026-10-18)
- [x] **drop** `~/.config/apt/pkglist.txt` (WSL/Windows only) <sub>`dot_config/apt/pkglist.txt`</sub> — dropped (2026-10-18)
- [x] **done** `~/.config/pacman/aurlist.txt` <sub>`dot_config/pacman/aurlist.txt`</sub> — slack-desktop (now in Omarchy's repo); google-chrome not wanted (2026-10-18)
- [x] **done** `~/.config/pacman/pkglist.txt` <sub>`dot_config/pacman/pkglist.txt`</sub> — 182 of 210 already installed; picks added to packages.txt; superseded ones dropped; ollama-cuda and cloudflared deferred (2026-10-18)

## systemd user units

- [ ] **port** `~/.config/systemd/user/dots-theme-agents.path` <sub>`dot_config/systemd/user/dots-theme-agents.path`</sub>
- [ ] **port** `~/.config/systemd/user/dots-theme-agents.service` <sub>`dot_config/systemd/user/dots-theme-agents.service`</sub>
- [x] **skip** `~/.config/systemd/user/herdr-cline-state.service` <sub>`dot_config/systemd/user/herdr-cline-state.service`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/systemd/user/herdr-cline-state.timer` <sub>`dot_config/systemd/user/herdr-cline-state.timer`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/systemd/user/herdr-outpost-relay.service` <sub>`dot_config/systemd/user/herdr-outpost-relay.service`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [ ] **port** `~/.config/systemd/user/ollama-omarchy-agents.service` <sub>`dot_config/systemd/user/ollama-omarchy-agents.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-agents-analysis.service` <sub>`dot_config/systemd/user/omarchy-agents-analysis.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-agents-analysis.timer` <sub>`dot_config/systemd/user/omarchy-agents-analysis.timer`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-agents-dashboard.service` <sub>`dot_config/systemd/user/omarchy-agents-dashboard.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-agents-tunnel.service` <sub>`dot_config/systemd/user/omarchy-agents-tunnel.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-camera-reset.service` <sub>`dot_config/systemd/user/omarchy-camera-reset.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-cline-usage-scrape.service` <sub>`dot_config/systemd/user/omarchy-cline-usage-scrape.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-cline-usage-scrape.timer` <sub>`dot_config/systemd/user/omarchy-cline-usage-scrape.timer`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-cursor-usage-scrape.service` <sub>`dot_config/systemd/user/omarchy-cursor-usage-scrape.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-cursor-usage-scrape.timer` <sub>`dot_config/systemd/user/omarchy-cursor-usage-scrape.timer`</sub>
- [ ] **drop** `~/.config/systemd/user/omarchy-drift-capture.path` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_config/systemd/user/omarchy-drift-capture.path`</sub>
- [ ] **drop** `~/.config/systemd/user/omarchy-drift-capture.service` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_config/systemd/user/omarchy-drift-capture.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.service` <sub>`dot_config/systemd/user/omarchy-opencode-go-usage-scrape.service`</sub>
- [ ] **port** `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.timer` <sub>`dot_config/systemd/user/omarchy-opencode-go-usage-scrape.timer`</sub>

## ~/.local/bin scripts

- [x] **done** `~/.local/bin/backdrop-split` <sub>`dot_local/bin/executable_backdrop-split`</sub> — ported 2026-10-18
- [ ] **port** `~/.local/bin/chrome-profile` <sub>`dot_local/bin/executable_chrome-profile`</sub>
- [ ] **port** `~/.local/bin/cline-safety/git` <sub>`dot_local/bin/cline-safety/executable_git`</sub>
- [ ] **port** `~/.local/bin/cursor` <sub>`dot_local/bin/executable_cursor`</sub>
- [ ] **drop** `~/.local/bin/dots` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots`</sub>
- [ ] **drop** `~/.local/bin/dots-cloud-status` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-cloud-status`</sub>
- [x] **drop** `~/.local/bin/dots-identity` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-identity`</sub> — replaced by fastfetch (2026-10-18)
- [ ] **drop** `~/.local/bin/dots-push` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-push`</sub>
- [ ] **drop** `~/.local/bin/dots-theme-agents` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-theme-agents`</sub>
- [ ] **drop** `~/.local/bin/dots-theme-import-aether` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-theme-import-aether`</sub>
- [x] **skip** `~/.local/bin/herdr-agent-lifecycle` <sub>`dot_local/bin/executable_herdr-agent-lifecycle`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.local/bin/herdr-cline-state` <sub>`dot_local/bin/executable_herdr-cline-state`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.local/bin/herdr-gemini-session` <sub>`dot_local/bin/executable_herdr-gemini-session`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.local/bin/herdr-subagents` <sub>`dot_local/bin/executable_herdr-subagents`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.local/bin/herdr-sync-hermes-plugin` <sub>`dot_local/bin/executable_herdr-sync-hermes-plugin`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.local/bin/herdr-verify` <sub>`dot_local/bin/executable_herdr-verify`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **done** `~/.local/bin/keychron-audio-toggle` <sub>`dot_local/bin/executable_keychron-audio-toggle`</sub> — ported 2026-10-18; sink names now come from a 1Password-rendered config
- [ ] **port** `~/.local/bin/lazygit-ollama-commit.sh` <sub>`dot_local/bin/executable_lazygit-ollama-commit.sh`</sub>
- [ ] **port** `~/.local/bin/ollama-commit-msg.sh` <sub>`dot_local/bin/executable_ollama-commit-msg.sh`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-antigravity` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-antigravity.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-cline` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-cline.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-codex` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-codex.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-cursor` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-cursor.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-opencode` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-opencode.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-pi` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-pi.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-agent-usage-update` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-agent-usage-update.tmpl`</sub>
- [ ] **port** `~/.local/bin/omarchy-camera-reset` <sub>`dot_local/bin/executable_omarchy-camera-reset`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cline-usage-login` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cline-usage-login.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cline-usage-override` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cline-usage-override.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cline-usage-scrape` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cline-usage-scrape.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cursor-statusline` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cursor-statusline.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cursor-usage-override` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cursor-usage-override.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-cursor-usage-scrape` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-cursor-usage-scrape.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-default-agent` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-default-agent.tmpl`</sub>
- [ ] **drop** `~/.local/bin/omarchy-dotfiles-sync` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_omarchy-dotfiles-sync`</sub>
- [ ] **drop** `~/.local/bin/omarchy-drift-capture` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_omarchy-drift-capture`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-opencode-go-usage-login` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-opencode-go-usage-login.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-opencode-go-usage-override` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-opencode-go-usage-override.tmpl`</sub>
- [ ] **rewrite** `~/.local/bin/omarchy-opencode-go-usage-scrape` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_omarchy-opencode-go-usage-scrape.tmpl`</sub>
- [x] **drop** `~/.local/bin/piper` — dropped: piper not installed, no mise Python
- [x] **drop** `~/.local/bin/ratbagctl` — dropped: no mise Python on this machine
- [x] **rewrite** `~/.local/bin/statusline` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_statusline.tmpl`</sub> — ported (2026-10-18)
- [ ] **drop** `~/.local/bin/wsl-windows-tool` (WSL/Windows only) <sub>`dot_local/bin/executable_wsl-windows-tool`</sub>

## Claude Code

- [x] **skip** `~/.claude/skills/project-doc-planner` (keep as symlink) <sub>`dot_claude/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)
- [x] **drop** `~/.claude/themes/omarchy.json` (template → esh `##template.esh` or plain file) <sub>`dot_claude/themes/omarchy.json.tmpl`</sub> — Omarchy themes Claude itself (2026-10-18)

## Codex

- [x] **done** `~/.codex/AGENTS.md` (chmod 600/700 in bootstrap) <sub>`dot_codex/private_AGENTS.md`</sub> — it was only the codebase-memory-mcp block; the installer writes it (2026-10-18)
- [x] **done** `~/.codex/config.toml` (`modify_` merge → jq/yq step in bootstrap; chmod 600/700 in bootstrap) <sub>`dot_codex/modify_private_config.toml`</sub> — tracked directly; Augustus's review/plan effort, features, TUI status line, desktop prefs, chrome-devtools (bunx) and OpenAI docs MCP, Claude plugin marketplaces, trust for ~; model kept at the current default (2026-10-18)
- [x] **done** `~/.codex/hooks.json` (template → esh `##template.esh` or plain file) <sub>`dot_codex/hooks.json.tmpl`</sub> — codebase-memory hooks now come from its installer; herdr hooks skipped (2026-10-18)
- [x] **done** `~/.codex/rules/default.rules` <sub>`dot_codex/rules/default.rules`</sub> — ported (2026-10-18)
- [x] **skip** `~/.codex/skills/dots/SKILL.md` <sub>`dot_codex/skills/dots/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/frontier-sweep/SKILL.md` <sub>`dot_codex/skills/frontier-sweep/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/grilling/SKILL.md` <sub>`dot_codex/skills/grilling/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/grilling/agents/openai.yaml` <sub>`dot_codex/skills/grilling/agents/openai.yaml`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/linear-agent-tracking/SKILL.md` <sub>`dot_codex/skills/linear-agent-tracking/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/linear-agent-tracking/agents/openai.yaml` <sub>`dot_codex/skills/linear-agent-tracking/agents/openai.yaml`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/linear-agent-tracking/references/issue-tracker-linear.md` <sub>`dot_codex/skills/linear-agent-tracking/references/issue-tracker-linear.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/linear-agent-tracking/references/linear-cli.md` <sub>`dot_codex/skills/linear-agent-tracking/references/linear-cli.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/project-doc-planner/SKILL.md` <sub>`dot_codex/skills/project-doc-planner/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.codex/skills/project-doc-planner/agents/openai.yaml` <sub>`dot_codex/skills/project-doc-planner/agents/openai.yaml`</sub> — skills left to Tern (2026-10-18)
- [x] **done** `~/.codex/themes/dots.tmTheme` (template → esh `##template.esh` or plain file) <sub>`dot_codex/themes/dots.tmTheme.tmpl`</sub> — ~/.codex/themes/omarchy.tmTheme links to the theme-synced bat theme (2026-10-18)

## Gemini

- [x] **done** `~/.gemini/GEMINI.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/private_GEMINI.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.gemini/agents/codebase-memory-auditor.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory-auditor.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.gemini/agents/codebase-memory-scout.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory-scout.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.gemini/agents/codebase-memory.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **skip** `~/.gemini/config/hooks.json` <sub>`dot_gemini/config/hooks.json`</sub> — herdr only (2026-10-18)
- [x] **skip** `~/.gemini/config/hooks/herdr-agent-metadata.sh` <sub>`dot_gemini/config/hooks/herdr-agent-metadata.sh`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **done** `~/.gemini/config/mcp_config.json` (template → esh `##template.esh` or plain file) <sub>`dot_gemini/config/mcp_config.json.tmpl`</sub> — Antigravity MCP servers ported (Cloudflare x5, nomads, codebase-memory) (2026-10-18)
- [x] **skip** `~/.gemini/config/skills/project-doc-planner` (keep as symlink) <sub>`dot_gemini/config/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)
- [x] **done** `~/.gemini/settings.json` (`modify_` merge → jq/yq step in bootstrap; chmod 600/700 in bootstrap) <sub>`dot_gemini/modify_private_settings.json`</sub> — tracked directly; theme now a theme-synced Omarchy template (themed/gemini-theme.json.tpl); codebase-memory MCP and hooks from its installer; herdr hooks skipped (2026-10-18)
- [x] **skip** `~/.gemini/skills/project-doc-planner` (keep as symlink) <sub>`dot_gemini/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)

## Grok

- [ ] **rewrite** `~/.grok/config.toml` (`modify_` merge → jq/yq step in bootstrap) <sub>`dot_grok/modify_config.toml`</sub>
- [x] **skip** `~/.grok/hooks/herdr-agent-metadata.sh` <sub>`dot_grok/hooks/executable_herdr-agent-metadata.sh`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.grok/hooks/herdr-agent-state.sh` <sub>`dot_grok/hooks/executable_herdr-agent-state.sh`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.grok/hooks/herdr.json` <sub>`dot_grok/hooks/herdr.json`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [ ] **port** `~/.grokbot/settings.json` (chmod 600/700 in bootstrap) <sub>`private_dot_grokbot/settings.json`</sub>

## OpenCode

- [x] **done** `~/.config/opencode/.gitignore` <sub>`dot_config/opencode/dot_gitignore`</sub> — ported (2026-10-18)
- [x] **done** `~/.config/opencode/AGENTS.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/private_AGENTS.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.config/opencode/agents/codebase-memory-auditor.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory-auditor.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.config/opencode/agents/codebase-memory-scout.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory-scout.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.config/opencode/agents/codebase-memory.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory.md`</sub> — codebase-memory installer writes it (2026-10-18)
- [x] **done** `~/.config/opencode/opencode.json` (encrypted → `secrets.list` + op:// template) <sub>`dot_config/opencode/encrypted_opencode.json.age`</sub> — Augustus's was age-encrypted and unreadable; started fresh from Omarchy's, plus the codebase-memory MCP (2026-10-18)
- [x] **skip** `~/.config/opencode/plugins/herdr-agent-metadata.js` <sub>`dot_config/opencode/plugins/herdr-agent-metadata.js`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/opencode/plugins/herdr-subagents.js` <sub>`dot_config/opencode/plugins/herdr-subagents.js`</sub> — skipped 2026-10-18: experimenting with Tern as the meta harness
- [x] **skip** `~/.config/opencode/skills/opencode-go-usage/SKILL.md` <sub>`dot_config/opencode/skills/opencode-go-usage/SKILL.md`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.config/opencode/skills/project-doc-planner` (keep as symlink) <sub>`dot_config/opencode/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)
- [x] **drop** `~/.config/opencode/themes/dots.json` (template → esh `##template.esh` or plain file) <sub>`dot_config/opencode/themes/dots.json.tmpl`</sub> — the system theme follows the terminal, which Omarchy themes (2026-10-18)
- [x] **drop** `~/.config/opencode/tui.json` <sub>`dot_config/opencode/tui.json`</sub> — same as the system theme setting already in place (2026-10-18)
- [x] **drop** `~/.config/opencode/tui.jsonc` <sub>`dot_config/opencode/tui.jsonc`</sub> — dots theme and herdr plugin not needed (2026-10-18)

## Hermes

- [ ] **port** `~/.hermes/SOUL.md` (chmod 600/700 in bootstrap) <sub>`private_dot_hermes/SOUL.md`</sub>
- [ ] **rewrite** `~/.hermes/config.yaml` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_hermes/config.yaml.tmpl`</sub>
- [ ] **rewrite** `~/.hermes/skins/omarchy.yaml` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_hermes/skins/omarchy.yaml.tmpl`</sub>

## Cline and Cursor

- [ ] **port** `~/.cline/data/settings/global-settings.json` <sub>`dot_cline/data/settings/global-settings.json`</sub>
- [x] **skip** `~/.cline/skills/project-doc-planner` (keep as symlink) <sub>`dot_cline/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)
- [ ] **port** `~/.config/Cursor/User/settings.json` (chmod 600/700 in bootstrap) <sub>`dot_config/private_Cursor/User/settings.json`</sub>
- [ ] **drop** `~/.local/share/applications/cursor-desktop.desktop` (hardcoded AppImage path) <sub>`dot_local/share/applications/cursor-desktop.desktop`</sub>
- [ ] **port** `~/Documents/Cline/Workflows/usage.md` <sub>`Documents/Cline/Workflows/usage.md`</sub>

## Other agent skill links

- [x] **skip** `~/.agents/skills/project-doc-planner` (keep as symlink) <sub>`dot_agents/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)
- [x] **skip** `~/.pi/agent/skills/project-doc-planner` (keep as symlink) <sub>`dot_pi/agent/skills/symlink_project-doc-planner`</sub> — skills left to Tern (2026-10-18)

## Other

- [ ] **port** `~/.config/dots/cloud-services` <sub>`dot_config/dots/cloud-services`</sub>
- [ ] **rewrite** `~/.config/dots/cloudflare.env` (encrypted → `secrets.list` + op:// template; chmod 600/700 in bootstrap) <sub>`dot_config/dots/encrypted_private_cloudflare.env.age`</sub>
- [ ] **drop** `~/.local/share/wsl-ssh-bridge/main.go` (WSL/Windows only) <sub>`dot_local/share/wsl-ssh-bridge/main.go`</sub>

## chezmoi run scripts → bootstrap steps

None of these copy over directly. Each becomes an idempotent bootstrap step, or is dropped. Read the script at the tag before deciding.

- [x] **skip** `run_after_23-sync-agent-skills.sh.tmpl` — skills left to Tern (2026-10-18)
- [x] **done** `run_after_34-augustus-backdrop-split.sh.tmpl` — replaced by the theme-set and post-boot hooks
- [ ] **rewrite** `run_after_35-augustus-theme-modes-converge.sh.tmpl`
- [ ] **rewrite** `run_once_after_24-setup-omarchy-agents.sh.tmpl`
- [ ] **rewrite** `run_once_before_00-verify-deps.sh.tmpl`
- [x] **skip** `run_once_before_05-sync-hermes-skills.sh.tmpl` — skills left to Tern (2026-10-18)
- [x] **done** `run_onchange_after_10-install-omarchy-plugins.sh.tmpl` — replaced by omarchy-plugins.txt + bootstrap + omarchy-plugin-patches
- [ ] **rewrite** `run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_26-setup-omarchy-cursor.sh.tmpl`
- [x] **done** `run_onchange_after_27-sync-claude-mcp.sh.tmpl` — codebase-memory-mcp reinstalled with its own installer (SETUP.md) (2026-10-18)
- [x] **done** `run_onchange_after_28-sync-claude-settings.sh.tmpl` — status line and plugins ported into the tracked settings.json; git deny rules and dangerous-mode skip not wanted; herdr hooks skipped (2026-10-18)
- [ ] **rewrite** `run_onchange_after_29-enable-omarchy-user-units.sh.tmpl`
- [ ] **drop** `run_onchange_after_30-hadrian-macos-defaults.sh.tmpl` (macOS only)
- [x] **done** `run_onchange_after_31-augustus-mouse-dpi.sh.tmpl` (same desk as Augustus; libratbag is installed) — ported 2026-10-18 as ~/.local/bin/mouse-dpi + bootstrap step
- [ ] **rewrite** `run_onchange_after_32-setup-omarchy-agent-registrations.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_33-augustus-machine-branding.sh.tmpl`
- [ ] **drop** `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_41-vespasian-nerd-font.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_42-vespasian-theme-state.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_43-vespasian-1password-ssh-bridge.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_44-vespasian-windows-debloat.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_46-vespasian-wallpaper.sh.tmpl` (WSL/Windows only)
- [ ] **drop** `run_onchange_after_47-vespasian-wsl-boot.sh.tmpl` (WSL/Windows only)
- [x] **skip** `run_onchange_before_09-install-agent-skills.sh.tmpl` — skills left to Tern (2026-10-18)
