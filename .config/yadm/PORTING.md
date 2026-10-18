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

Rules while porting:
- Files that Omarchy also edits get tracked directly, never as alternates.
- Symlinks stay symlinks.
- Look for hardcoded `/home/harlan` paths, the old machine name `augustus`, and
  installer leftovers (for example the old `.bashrc` had `. ~/.cargo/env` and
  Ubuntu `OPENSSL_*` paths).
- The old repo's `INDEX.json` describes most files and is worth checking.
<!-- generated from harlanljones/dotfiles @ ff7687d (tag chezmoi-final); names only -->

## Shell

- [ ] **port** `~/.bash_profile` <sub>`dot_bash_profile`</sub>
- [ ] **port** `~/.bashrc` <sub>`dot_bashrc`</sub>
- [ ] **port** `~/.config/environment.d/10-defaults.conf` <sub>`dot_config/environment.d/10-defaults.conf`</sub>
- [ ] **rewrite** `~/.config/environment.d/10-machine.conf` (template → esh `##template.esh` or plain file) <sub>`dot_config/environment.d/10-machine.conf.tmpl`</sub>
- [ ] **port** `~/.config/shell/00-env.sh` <sub>`dot_config/shell/00-env.sh`</sub>
- [ ] **port** `~/.config/shell/05-omarchy-detect.sh` <sub>`dot_config/shell/05-omarchy-detect.sh`</sub>
- [ ] **port** `~/.config/shell/10-tools.sh` <sub>`dot_config/shell/10-tools.sh`</sub>
- [ ] **port** `~/.config/shell/15-base-bash.sh` <sub>`dot_config/shell/15-base-bash.sh`</sub>
- [ ] **port** `~/.config/shell/20-integrations.sh` <sub>`dot_config/shell/20-integrations.sh`</sub>
- [ ] **port** `~/.config/shell/30-navigation.sh` <sub>`dot_config/shell/30-navigation.sh`</sub>
- [ ] **port** `~/.config/shell/40-aliases.sh` <sub>`dot_config/shell/40-aliases.sh`</sub>
- [ ] **port** `~/.config/shell/45-omarchy-portable-aliases.sh` <sub>`dot_config/shell/45-omarchy-portable-aliases.sh`</sub>
- [ ] **port** `~/.config/shell/50-agents.sh` <sub>`dot_config/shell/50-agents.sh`</sub>
- [ ] **port** `~/.config/shell/55-apps.sh` <sub>`dot_config/shell/55-apps.sh`</sub>
- [ ] **port** `~/.config/shell/60-prompt.sh` <sub>`dot_config/shell/60-prompt.sh`</sub>
- [ ] **port** `~/.config/shell/61-splash.sh` <sub>`dot_config/shell/61-splash.sh`</sub>
- [ ] **port** `~/.config/shell/65-theme.sh` <sub>`dot_config/shell/65-theme.sh`</sub>
- [ ] **port** `~/.config/shell/70-cloud.sh` <sub>`dot_config/shell/70-cloud.sh`</sub>
- [ ] **port** `~/.config/shell/75-tool-paths.sh` <sub>`dot_config/shell/75-tool-paths.sh`</sub>
- [ ] **port** `~/.config/shell/80-local.sh` <sub>`dot_config/shell/80-local.sh`</sub>
- [ ] **port** `~/.config/shell/README.md` <sub>`dot_config/shell/README.md`</sub>
- [ ] **drop** `~/.zshrc` (macOS only) <sub>`dot_zshrc`</sub>

## Git and GitHub

- [ ] **port** `~/.config/gh/config.yml` <sub>`dot_config/gh/config.yml`</sub>
- [ ] **rewrite** `~/.config/git/config` (template → esh `##template.esh` or plain file) <sub>`dot_config/git/config.tmpl`</sub>
- [ ] **port** `~/.config/git/hooks/commit-msg` <sub>`dot_config/git/hooks/executable_commit-msg`</sub>
- [ ] **port** `~/.config/git/hooks/pre-push` <sub>`dot_config/git/hooks/executable_pre-push`</sub>
- [ ] **port** `~/.config/git/ignore` <sub>`dot_config/git/ignore`</sub>
- [ ] **rewrite** `~/.config/lazygit/config.yml` (template → esh `##template.esh` or plain file) <sub>`dot_config/lazygit/config.yml.tmpl`</sub>

## SSH and 1Password

- [ ] **port** `~/.config/1password/ssh/agent.toml` <sub>`dot_config/1password/ssh/agent.toml`</sub>
- [ ] **rewrite** `~/.ssh/config` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_ssh/config.tmpl`</sub>

## Neovim

- [ ] **port** `~/.config/nvim/init.lua` <sub>`dot_config/nvim/init.lua`</sub>
- [ ] **port** `~/.config/nvim/lazy-lock.json` <sub>`dot_config/nvim/lazy-lock.json`</sub>
- [ ] **port** `~/.config/nvim/lazyvim.json` <sub>`dot_config/nvim/lazyvim.json`</sub>
- [ ] **port** `~/.config/nvim/lua/config/autocmds.lua` <sub>`dot_config/nvim/lua/config/autocmds.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/config/keymaps.lua` <sub>`dot_config/nvim/lua/config/keymaps.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/config/lazy.lua` <sub>`dot_config/nvim/lua/config/lazy.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/config/options.lua` <sub>`dot_config/nvim/lua/config/options.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/blink-cmp.lua` <sub>`dot_config/nvim/lua/plugins/blink-cmp.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/copilot-lualine.lua` <sub>`dot_config/nvim/lua/plugins/copilot-lualine.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/copilot.lua` <sub>`dot_config/nvim/lua/plugins/copilot.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/dashboard-dots-identity.lua` <sub>`dot_config/nvim/lua/plugins/dashboard-dots-identity.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/example.lua` <sub>`dot_config/nvim/lua/plugins/example.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/faster-smear-cursor.lua` <sub>`dot_config/nvim/lua/plugins/faster-smear-cursor.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/herdr-nvim.lua` <sub>`dot_config/nvim/lua/plugins/herdr-nvim.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/html-preview.lua` <sub>`dot_config/nvim/lua/plugins/empty_html-preview.lua`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/mini-animate-disable-cursor.lua` <sub>`dot_config/nvim/lua/plugins/mini-animate-disable-cursor.lua`</sub>
- [ ] **rewrite** `~/.config/nvim/lua/plugins/theme.lua` (template → esh `##template.esh` or plain file) <sub>`dot_config/nvim/lua/plugins/theme.lua.tmpl`</sub>
- [ ] **port** `~/.config/nvim/lua/plugins/vim-be-good.lua` <sub>`dot_config/nvim/lua/plugins/vim-be-good.lua`</sub>

## Terminals and CLI tools

- [ ] **port** `~/.config/atuin/config.toml` <sub>`dot_config/atuin/config.toml`</sub>
- [ ] **port** `~/.config/bat/config` <sub>`dot_config/bat/config`</sub>
- [ ] **rewrite** `~/.config/bat/themes/dots.tmTheme` (template → esh `##template.esh` or plain file) <sub>`dot_config/bat/themes/dots.tmTheme.tmpl`</sub>
- [ ] **rewrite** `~/.config/btop/btop.conf` (template → esh `##template.esh` or plain file) <sub>`dot_config/btop/btop.conf.tmpl`</sub>
- [ ] **rewrite** `~/.config/btop/themes/dots.theme` (template → esh `##template.esh` or plain file) <sub>`dot_config/btop/themes/dots.theme.tmpl`</sub>
- [ ] **rewrite** `~/.config/delta/theme.gitconfig` (template → esh `##template.esh` or plain file) <sub>`dot_config/delta/theme.gitconfig.tmpl`</sub>
- [ ] **rewrite** `~/.config/eza/theme.yml` (template → esh `##template.esh` or plain file) <sub>`dot_config/eza/theme.yml.tmpl`</sub>
- [ ] **port** `~/.config/fastfetch/augustus.jpg` <sub>`dot_config/fastfetch/augustus.jpg`</sub>
- [ ] **rewrite** `~/.config/fastfetch/config.jsonc` (template → esh `##template.esh` or plain file) <sub>`dot_config/fastfetch/config.jsonc.tmpl`</sub>
- [ ] **drop** `~/.config/fastfetch/vespasian.jpg` (WSL/Windows only) <sub>`dot_config/fastfetch/vespasian.jpg`</sub>
- [ ] **rewrite** `~/.config/fzf/theme.sh` (template → esh `##template.esh` or plain file) <sub>`dot_config/fzf/theme.sh.tmpl`</sub>
- [ ] **rewrite** `~/.config/ghostty/config` (template → esh `##template.esh` or plain file) <sub>`dot_config/ghostty/config.tmpl`</sub>
- [ ] **port** `~/.config/ripgrep/rc` <sub>`dot_config/ripgrep/rc`</sub>
- [ ] **rewrite** `~/.config/starship.toml` (template → esh `##template.esh` or plain file) <sub>`dot_config/starship.toml.tmpl`</sub>
- [ ] **port** `~/.config/zoxide/config.toml` <sub>`dot_config/zoxide/config.toml`</sub>
- [ ] **port** `~/.local/share/figlet/README.md` <sub>`dot_local/share/figlet/README.md`</sub>
- [ ] **port** `~/.local/share/figlet/Roman.flf` <sub>`dot_local/share/figlet/Roman.flf`</sub>
- [ ] **port** `~/.local/share/figlet/small.flf` <sub>`dot_local/share/figlet/small.flf`</sub>

## herdr

- [ ] **rewrite** `~/.config/herdr/config.toml` (template → esh `##template.esh` or plain file) <sub>`dot_config/herdr/config.toml.tmpl`</sub>
- [ ] **rewrite** `~/.config/herdr/plugins.json` (template → esh `##template.esh` or plain file) <sub>`dot_config/herdr/plugins.json.tmpl`</sub>
- [ ] **port** `~/.config/herdr/plugins/config/hhdebb.herdr-radar/config.toml` <sub>`dot_config/herdr/plugins/config/hhdebb.herdr-radar/config.toml`</sub>
- [ ] **port** `~/.config/herdr/plugins/config/hhdebb.herdr-radar/hook.js` <sub>`dot_config/herdr/plugins/config/hhdebb.herdr-radar/hook.js`</sub>

## mise

- [ ] **drop** `~/.config/mise/conf.d/vespasian.toml` (WSL/Windows only) <sub>`dot_config/mise/conf.d/vespasian.toml`</sub>
- [ ] **port** `~/.config/mise/config.toml` <sub>`dot_config/mise/config.toml`</sub>

## Hyprland

- [x] **done** `~/.config/hypr/bindings.lua` <sub>`dot_config/hypr/bindings.lua`</sub> — ported 2026-10-18: notifications, theme modes, Omaland, Keychron knob, omalt-tab loader; X Native, Reprieve and Local AI binds dropped with their plugins
- [ ] **port** `~/.config/hypr/hyprland.lua` <sub>`dot_config/hypr/hyprland.lua`</sub>
- [ ] **drop** `~/.config/hypr/hyprmoncfg-monitors.lua` (superseded by this machine's monitors.lua) <sub>`dot_config/hypr/hyprmoncfg-monitors.lua`</sub>
- [ ] **port** `~/.config/hypr/input.lua` <sub>`dot_config/hypr/input.lua`</sub>
- [ ] **port** `~/.config/hypr/looknfeel.lua` <sub>`dot_config/hypr/looknfeel.lua`</sub>
- [ ] **drop** `~/.config/hypr/monitors.lua` (superseded by this machine's monitors.lua) <sub>`dot_config/hypr/monitors.lua`</sub>

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

- [ ] **drop** `~/.Brewfile` (macOS only) <sub>`dot_Brewfile`</sub>
- [ ] **drop** `~/.config/apt/pkglist.txt` (WSL/Windows only) <sub>`dot_config/apt/pkglist.txt`</sub>
- [ ] **port** `~/.config/pacman/aurlist.txt` <sub>`dot_config/pacman/aurlist.txt`</sub>
- [ ] **port** `~/.config/pacman/pkglist.txt` <sub>`dot_config/pacman/pkglist.txt`</sub>

## systemd user units

- [ ] **port** `~/.config/systemd/user/dots-theme-agents.path` <sub>`dot_config/systemd/user/dots-theme-agents.path`</sub>
- [ ] **port** `~/.config/systemd/user/dots-theme-agents.service` <sub>`dot_config/systemd/user/dots-theme-agents.service`</sub>
- [ ] **port** `~/.config/systemd/user/herdr-cline-state.service` <sub>`dot_config/systemd/user/herdr-cline-state.service`</sub>
- [ ] **port** `~/.config/systemd/user/herdr-cline-state.timer` <sub>`dot_config/systemd/user/herdr-cline-state.timer`</sub>
- [ ] **port** `~/.config/systemd/user/herdr-outpost-relay.service` <sub>`dot_config/systemd/user/herdr-outpost-relay.service`</sub>
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
- [ ] **drop** `~/.local/bin/dots-identity` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-identity`</sub>
- [ ] **drop** `~/.local/bin/dots-push` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-push`</sub>
- [ ] **drop** `~/.local/bin/dots-theme-agents` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-theme-agents`</sub>
- [ ] **drop** `~/.local/bin/dots-theme-import-aether` (chezmoi-coupled; replaced by yadm + the post-update drift hook) <sub>`dot_local/bin/executable_dots-theme-import-aether`</sub>
- [ ] **port** `~/.local/bin/herdr-agent-lifecycle` <sub>`dot_local/bin/executable_herdr-agent-lifecycle`</sub>
- [ ] **port** `~/.local/bin/herdr-cline-state` <sub>`dot_local/bin/executable_herdr-cline-state`</sub>
- [ ] **port** `~/.local/bin/herdr-gemini-session` <sub>`dot_local/bin/executable_herdr-gemini-session`</sub>
- [ ] **port** `~/.local/bin/herdr-subagents` <sub>`dot_local/bin/executable_herdr-subagents`</sub>
- [ ] **port** `~/.local/bin/herdr-sync-hermes-plugin` <sub>`dot_local/bin/executable_herdr-sync-hermes-plugin`</sub>
- [ ] **port** `~/.local/bin/herdr-verify` <sub>`dot_local/bin/executable_herdr-verify`</sub>
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
- [ ] **port** `~/.local/bin/piper` (libratbag is installed here; check the mouse is the same) <sub>`dot_local/bin/executable_piper`</sub>
- [ ] **port** `~/.local/bin/ratbagctl` (libratbag is installed here; check the mouse is the same) <sub>`dot_local/bin/executable_ratbagctl`</sub>
- [ ] **rewrite** `~/.local/bin/statusline` (template → esh `##template.esh` or plain file) <sub>`dot_local/bin/executable_statusline.tmpl`</sub>
- [ ] **drop** `~/.local/bin/wsl-windows-tool` (WSL/Windows only) <sub>`dot_local/bin/executable_wsl-windows-tool`</sub>

## Claude Code

- [ ] **port** `~/.claude/skills/project-doc-planner` (keep as symlink) <sub>`dot_claude/skills/symlink_project-doc-planner`</sub>
- [ ] **rewrite** `~/.claude/themes/omarchy.json` (template → esh `##template.esh` or plain file) <sub>`dot_claude/themes/omarchy.json.tmpl`</sub>

## Codex

- [ ] **port** `~/.codex/AGENTS.md` (chmod 600/700 in bootstrap) <sub>`dot_codex/private_AGENTS.md`</sub>
- [ ] **rewrite** `~/.codex/config.toml` (`modify_` merge → jq/yq step in bootstrap; chmod 600/700 in bootstrap) <sub>`dot_codex/modify_private_config.toml`</sub>
- [ ] **rewrite** `~/.codex/hooks.json` (template → esh `##template.esh` or plain file) <sub>`dot_codex/hooks.json.tmpl`</sub>
- [ ] **port** `~/.codex/rules/default.rules` <sub>`dot_codex/rules/default.rules`</sub>
- [ ] **port** `~/.codex/skills/dots/SKILL.md` <sub>`dot_codex/skills/dots/SKILL.md`</sub>
- [ ] **port** `~/.codex/skills/frontier-sweep/SKILL.md` <sub>`dot_codex/skills/frontier-sweep/SKILL.md`</sub>
- [ ] **port** `~/.codex/skills/grilling/SKILL.md` <sub>`dot_codex/skills/grilling/SKILL.md`</sub>
- [ ] **port** `~/.codex/skills/grilling/agents/openai.yaml` <sub>`dot_codex/skills/grilling/agents/openai.yaml`</sub>
- [ ] **port** `~/.codex/skills/linear-agent-tracking/SKILL.md` <sub>`dot_codex/skills/linear-agent-tracking/SKILL.md`</sub>
- [ ] **port** `~/.codex/skills/linear-agent-tracking/agents/openai.yaml` <sub>`dot_codex/skills/linear-agent-tracking/agents/openai.yaml`</sub>
- [ ] **port** `~/.codex/skills/linear-agent-tracking/references/issue-tracker-linear.md` <sub>`dot_codex/skills/linear-agent-tracking/references/issue-tracker-linear.md`</sub>
- [ ] **port** `~/.codex/skills/linear-agent-tracking/references/linear-cli.md` <sub>`dot_codex/skills/linear-agent-tracking/references/linear-cli.md`</sub>
- [ ] **port** `~/.codex/skills/project-doc-planner/SKILL.md` <sub>`dot_codex/skills/project-doc-planner/SKILL.md`</sub>
- [ ] **port** `~/.codex/skills/project-doc-planner/agents/openai.yaml` <sub>`dot_codex/skills/project-doc-planner/agents/openai.yaml`</sub>
- [ ] **rewrite** `~/.codex/themes/dots.tmTheme` (template → esh `##template.esh` or plain file) <sub>`dot_codex/themes/dots.tmTheme.tmpl`</sub>

## Gemini

- [ ] **port** `~/.gemini/GEMINI.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/private_GEMINI.md`</sub>
- [ ] **port** `~/.gemini/agents/codebase-memory-auditor.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory-auditor.md`</sub>
- [ ] **port** `~/.gemini/agents/codebase-memory-scout.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory-scout.md`</sub>
- [ ] **port** `~/.gemini/agents/codebase-memory.md` (chmod 600/700 in bootstrap) <sub>`dot_gemini/agents/private_codebase-memory.md`</sub>
- [ ] **port** `~/.gemini/config/hooks.json` <sub>`dot_gemini/config/hooks.json`</sub>
- [ ] **port** `~/.gemini/config/hooks/herdr-agent-metadata.sh` <sub>`dot_gemini/config/hooks/herdr-agent-metadata.sh`</sub>
- [ ] **rewrite** `~/.gemini/config/mcp_config.json` (template → esh `##template.esh` or plain file) <sub>`dot_gemini/config/mcp_config.json.tmpl`</sub>
- [ ] **port** `~/.gemini/config/skills/project-doc-planner` (keep as symlink) <sub>`dot_gemini/config/skills/symlink_project-doc-planner`</sub>
- [ ] **rewrite** `~/.gemini/settings.json` (`modify_` merge → jq/yq step in bootstrap; chmod 600/700 in bootstrap) <sub>`dot_gemini/modify_private_settings.json`</sub>
- [ ] **port** `~/.gemini/skills/project-doc-planner` (keep as symlink) <sub>`dot_gemini/skills/symlink_project-doc-planner`</sub>

## Grok

- [ ] **rewrite** `~/.grok/config.toml` (`modify_` merge → jq/yq step in bootstrap) <sub>`dot_grok/modify_config.toml`</sub>
- [ ] **port** `~/.grok/hooks/herdr-agent-metadata.sh` <sub>`dot_grok/hooks/executable_herdr-agent-metadata.sh`</sub>
- [ ] **port** `~/.grok/hooks/herdr-agent-state.sh` <sub>`dot_grok/hooks/executable_herdr-agent-state.sh`</sub>
- [ ] **port** `~/.grok/hooks/herdr.json` <sub>`dot_grok/hooks/herdr.json`</sub>
- [ ] **port** `~/.grokbot/settings.json` (chmod 600/700 in bootstrap) <sub>`private_dot_grokbot/settings.json`</sub>

## OpenCode

- [ ] **port** `~/.config/opencode/.gitignore` <sub>`dot_config/opencode/dot_gitignore`</sub>
- [ ] **port** `~/.config/opencode/AGENTS.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/private_AGENTS.md`</sub>
- [ ] **port** `~/.config/opencode/agents/codebase-memory-auditor.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory-auditor.md`</sub>
- [ ] **port** `~/.config/opencode/agents/codebase-memory-scout.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory-scout.md`</sub>
- [ ] **port** `~/.config/opencode/agents/codebase-memory.md` (chmod 600/700 in bootstrap) <sub>`dot_config/opencode/agents/private_codebase-memory.md`</sub>
- [ ] **rewrite** `~/.config/opencode/opencode.json` (encrypted → `secrets.list` + op:// template) <sub>`dot_config/opencode/encrypted_opencode.json.age`</sub>
- [ ] **port** `~/.config/opencode/plugins/herdr-agent-metadata.js` <sub>`dot_config/opencode/plugins/herdr-agent-metadata.js`</sub>
- [ ] **port** `~/.config/opencode/plugins/herdr-subagents.js` <sub>`dot_config/opencode/plugins/herdr-subagents.js`</sub>
- [ ] **port** `~/.config/opencode/skills/opencode-go-usage/SKILL.md` <sub>`dot_config/opencode/skills/opencode-go-usage/SKILL.md`</sub>
- [ ] **port** `~/.config/opencode/skills/project-doc-planner` (keep as symlink) <sub>`dot_config/opencode/skills/symlink_project-doc-planner`</sub>
- [ ] **rewrite** `~/.config/opencode/themes/dots.json` (template → esh `##template.esh` or plain file) <sub>`dot_config/opencode/themes/dots.json.tmpl`</sub>
- [ ] **port** `~/.config/opencode/tui.json` <sub>`dot_config/opencode/tui.json`</sub>
- [ ] **port** `~/.config/opencode/tui.jsonc` <sub>`dot_config/opencode/tui.jsonc`</sub>

## Hermes

- [ ] **port** `~/.hermes/SOUL.md` (chmod 600/700 in bootstrap) <sub>`private_dot_hermes/SOUL.md`</sub>
- [ ] **rewrite** `~/.hermes/config.yaml` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_hermes/config.yaml.tmpl`</sub>
- [ ] **rewrite** `~/.hermes/skins/omarchy.yaml` (template → esh `##template.esh` or plain file; chmod 600/700 in bootstrap) <sub>`private_dot_hermes/skins/omarchy.yaml.tmpl`</sub>

## Cline and Cursor

- [ ] **port** `~/.cline/data/settings/global-settings.json` <sub>`dot_cline/data/settings/global-settings.json`</sub>
- [ ] **port** `~/.cline/skills/project-doc-planner` (keep as symlink) <sub>`dot_cline/skills/symlink_project-doc-planner`</sub>
- [ ] **port** `~/.config/Cursor/User/settings.json` (chmod 600/700 in bootstrap) <sub>`dot_config/private_Cursor/User/settings.json`</sub>
- [ ] **drop** `~/.local/share/applications/cursor-desktop.desktop` (hardcoded AppImage path) <sub>`dot_local/share/applications/cursor-desktop.desktop`</sub>
- [ ] **port** `~/Documents/Cline/Workflows/usage.md` <sub>`Documents/Cline/Workflows/usage.md`</sub>

## Other agent skill links

- [ ] **port** `~/.agents/skills/project-doc-planner` (keep as symlink) <sub>`dot_agents/skills/symlink_project-doc-planner`</sub>
- [ ] **port** `~/.pi/agent/skills/project-doc-planner` (keep as symlink) <sub>`dot_pi/agent/skills/symlink_project-doc-planner`</sub>

## Other

- [ ] **port** `~/.config/dots/cloud-services` <sub>`dot_config/dots/cloud-services`</sub>
- [ ] **rewrite** `~/.config/dots/cloudflare.env` (encrypted → `secrets.list` + op:// template; chmod 600/700 in bootstrap) <sub>`dot_config/dots/encrypted_private_cloudflare.env.age`</sub>
- [ ] **drop** `~/.local/share/wsl-ssh-bridge/main.go` (WSL/Windows only) <sub>`dot_local/share/wsl-ssh-bridge/main.go`</sub>

## chezmoi run scripts → bootstrap steps

None of these copy over directly. Each becomes an idempotent bootstrap step, or is dropped. Read the script at the tag before deciding.

- [ ] **rewrite** `run_after_23-sync-agent-skills.sh.tmpl`
- [x] **done** `run_after_34-augustus-backdrop-split.sh.tmpl` — replaced by the theme-set and post-boot hooks
- [ ] **rewrite** `run_after_35-augustus-theme-modes-converge.sh.tmpl`
- [ ] **rewrite** `run_once_after_24-setup-omarchy-agents.sh.tmpl`
- [ ] **rewrite** `run_once_before_00-verify-deps.sh.tmpl`
- [ ] **rewrite** `run_once_before_05-sync-hermes-skills.sh.tmpl`
- [x] **done** `run_onchange_after_10-install-omarchy-plugins.sh.tmpl` — replaced by omarchy-plugins.txt + bootstrap + omarchy-plugin-patches
- [ ] **rewrite** `run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_26-setup-omarchy-cursor.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_27-sync-claude-mcp.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_28-sync-claude-settings.sh.tmpl`
- [ ] **rewrite** `run_onchange_after_29-enable-omarchy-user-units.sh.tmpl`
- [ ] **drop** `run_onchange_after_30-hadrian-macos-defaults.sh.tmpl` (macOS only)
- [ ] **rewrite** `run_onchange_after_31-augustus-mouse-dpi.sh.tmpl` (same desk as Augustus; libratbag is installed)
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
- [ ] **rewrite** `run_onchange_before_09-install-agent-skills.sh.tmpl`
