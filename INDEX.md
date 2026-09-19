# Dotfiles Index

<!-- GENERATED FILE — DO NOT EDIT. Regenerate with `python3 docs/generate_index.py`; CI gates freshness. -->

> **Generated file — do not edit.** Produced by `docs/generate_index.py`
> from `git ls-files`. Run `python3 docs/generate_index.py` after adding or
> moving a file; CI fails when this file is stale.

Machine-readable equivalent: [`INDEX.json`](INDEX.json) — that is the file
agents and the showcase app should read. This page is the same data for humans.

**418 tracked entries** across 16 categories.

| Category | Entries |
| --- | ---: |
| [Shell](#shell) | 20 |
| [Prompt](#prompt) | 1 |
| [Terminal & multiplexer](#terminal--multiplexer) | 7 |
| [Editors](#editors) | 19 |
| [Desktop & window manager](#desktop--window-manager) | 11 |
| [Version control](#version-control) | 6 |
| [Navigation & search](#navigation--search) | 3 |
| [Toolchain & packages](#toolchain--packages) | 5 |
| [AI agent harnesses](#ai-agent-harnesses) | 50 |
| [Background services](#background-services) | 21 |
| [Custom executables](#custom-executables) | 42 |
| [Credentials & SSH](#credentials--ssh) | 2 |
| [Other configuration](#other-configuration) | 162 |
| [Apply hooks (`run_*`)](#apply-hooks-run) | 26 |
| [Chezmoi control files](#chezmoi-control-files) | 12 |
| [Repository material (not applied)](#repository-material-not-applied) | 31 |

---

## Shell

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.bash_profile` | `dot_bash_profile` | bash | — |
| `~/.bashrc` | `dot_bashrc` | bash | — |
| `~/.config/shell/00-env.sh` | `dot_config/shell/00-env.sh` | shared shell modules | — |
| `~/.config/shell/05-omarchy-detect.sh` | `dot_config/shell/05-omarchy-detect.sh` | shared shell modules | — |
| `~/.config/shell/10-tools.sh` | `dot_config/shell/10-tools.sh` | shared shell modules | — |
| `~/.config/shell/15-base-bash.sh` | `dot_config/shell/15-base-bash.sh` | shared shell modules | — |
| `~/.config/shell/20-integrations.sh` | `dot_config/shell/20-integrations.sh` | shared shell modules | — |
| `~/.config/shell/30-navigation.sh` | `dot_config/shell/30-navigation.sh` | shared shell modules | — |
| `~/.config/shell/40-aliases.sh` | `dot_config/shell/40-aliases.sh` | shared shell modules | — |
| `~/.config/shell/45-omarchy-portable-aliases.sh` | `dot_config/shell/45-omarchy-portable-aliases.sh` | shared shell modules | — |
| `~/.config/shell/50-agents.sh` | `dot_config/shell/50-agents.sh` | shared shell modules | — |
| `~/.config/shell/55-apps.sh` | `dot_config/shell/55-apps.sh` | shared shell modules | — |
| `~/.config/shell/60-prompt.sh` | `dot_config/shell/60-prompt.sh` | shared shell modules | — |
| `~/.config/shell/61-splash.sh` | `dot_config/shell/61-splash.sh` | shared shell modules | — |
| `~/.config/shell/65-theme.sh` | `dot_config/shell/65-theme.sh` | shared shell modules | — |
| `~/.config/shell/70-cloud.sh` | `dot_config/shell/70-cloud.sh` | shared shell modules | — |
| `~/.config/shell/75-tool-paths.sh` | `dot_config/shell/75-tool-paths.sh` | shared shell modules | — |
| `~/.config/shell/80-local.sh` | `dot_config/shell/80-local.sh` | shared shell modules | — |
| `~/.config/shell/README.md` | `dot_config/shell/README.md` | shared shell modules | — |
| `~/.zshrc` | `dot_zshrc` | zsh | — |

## Prompt

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/starship.toml` | `dot_config/starship.toml.tmpl` | starship | template |

## Terminal & multiplexer

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/btop/btop.conf` | `dot_config/btop/btop.conf.tmpl` | btop | template |
| `~/.config/btop/themes/dots.theme` | `dot_config/btop/themes/dots.theme.tmpl` | btop | template |
| `~/.config/ghostty/config` | `dot_config/ghostty/config.tmpl` | ghostty | template |
| `~/.config/herdr/config.toml` | `dot_config/herdr/config.toml.tmpl` | herdr multiplexer | template |
| `~/.config/herdr/plugins.json` | `dot_config/herdr/plugins.json.tmpl` | herdr multiplexer | template |
| `~/.config/herdr/plugins/config/hhdebb.herdr-radar/config.toml` | `dot_config/herdr/plugins/config/hhdebb.herdr-radar/config.toml` | herdr multiplexer | — |
| `~/.config/herdr/plugins/config/hhdebb.herdr-radar/hook.js` | `dot_config/herdr/plugins/config/hhdebb.herdr-radar/hook.js` | herdr multiplexer | — |

## Editors

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/nvim/init.lua` | `dot_config/nvim/init.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lazy-lock.json` | `dot_config/nvim/lazy-lock.json` | neovim / LazyVim | — |
| `~/.config/nvim/lazyvim.json` | `dot_config/nvim/lazyvim.json` | neovim / LazyVim | — |
| `~/.config/nvim/lua/config/autocmds.lua` | `dot_config/nvim/lua/config/autocmds.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/config/keymaps.lua` | `dot_config/nvim/lua/config/keymaps.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/config/lazy.lua` | `dot_config/nvim/lua/config/lazy.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/config/options.lua` | `dot_config/nvim/lua/config/options.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/blink-cmp.lua` | `dot_config/nvim/lua/plugins/blink-cmp.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/copilot-lualine.lua` | `dot_config/nvim/lua/plugins/copilot-lualine.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/copilot.lua` | `dot_config/nvim/lua/plugins/copilot.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/dashboard-dots-identity.lua` | `dot_config/nvim/lua/plugins/dashboard-dots-identity.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/html-preview.lua` | `dot_config/nvim/lua/plugins/empty_html-preview.lua` | neovim / LazyVim | empty |
| `~/.config/nvim/lua/plugins/example.lua` | `dot_config/nvim/lua/plugins/example.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/faster-smear-cursor.lua` | `dot_config/nvim/lua/plugins/faster-smear-cursor.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/herdr-nvim.lua` | `dot_config/nvim/lua/plugins/herdr-nvim.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/mini-animate-disable-cursor.lua` | `dot_config/nvim/lua/plugins/mini-animate-disable-cursor.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/theme.lua` | `dot_config/nvim/lua/plugins/theme.lua.tmpl` | neovim / LazyVim | template |
| `~/.config/nvim/lua/plugins/vim-be-good.lua` | `dot_config/nvim/lua/plugins/vim-be-good.lua` | neovim / LazyVim | — |
| `~/.config/Cursor/User/settings.json` | `dot_config/private_Cursor/User/settings.json` | cursor | private |

## Desktop & window manager

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/chrome-flags.conf` | `dot_config/chrome-flags.conf` | chromium | — |
| `~/.config/hypr/bindings.lua` | `dot_config/hypr/bindings.lua` | hyprland | — |
| `~/.config/hypr/hyprland.lua` | `dot_config/hypr/hyprland.lua` | hyprland | — |
| `~/.config/hypr/hyprmoncfg-monitors.lua` | `dot_config/hypr/hyprmoncfg-monitors.lua` | hyprland | — |
| `~/.config/hypr/input.lua` | `dot_config/hypr/input.lua` | hyprland | — |
| `~/.config/hypr/looknfeel.lua` | `dot_config/hypr/looknfeel.lua` | hyprland | — |
| `~/.config/hypr/monitors.lua` | `dot_config/hypr/monitors.lua` | hyprland | — |
| `~/.config/omarchy/shell.json` | `dot_config/omarchy/create_private_shell.json.tmpl` | omarchy | create, private, template |
| `~/.config/omarchy/defaults/agent` | `dot_config/omarchy/defaults/agent.tmpl` | omarchy | template |
| `~/.config/omarchy/hooks/theme-set.d/backdrop-split` | `dot_config/omarchy/hooks/theme-set.d/executable_backdrop-split` | omarchy | executable |
| `~/.local/share/applications/cursor-desktop.desktop` | `dot_local/share/applications/cursor-desktop.desktop` | desktop entries | — |

## Version control

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/gh/config.yml` | `dot_config/gh/config.yml` | github cli | — |
| `~/.config/git/config` | `dot_config/git/config.tmpl` | git | template |
| `~/.config/git/hooks/commit-msg` | `dot_config/git/hooks/executable_commit-msg` | git | executable |
| `~/.config/git/hooks/pre-push` | `dot_config/git/hooks/executable_pre-push` | git | executable |
| `~/.config/git/ignore` | `dot_config/git/ignore` | git | — |
| `~/.config/lazygit/config.yml` | `dot_config/lazygit/config.yml.tmpl` | lazygit | template |

## Navigation & search

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/atuin/config.toml` | `dot_config/atuin/config.toml` | atuin | — |
| `~/.config/ripgrep/rc` | `dot_config/ripgrep/rc` | ripgrep | — |
| `~/.config/zoxide/config.toml` | `dot_config/zoxide/config.toml` | zoxide | — |

## Toolchain & packages

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.Brewfile` | `dot_Brewfile` | homebrew | — |
| `~/.config/mise/conf.d/vespasian.toml` | `dot_config/mise/conf.d/vespasian.toml` | mise | — |
| `~/.config/mise/config.toml` | `dot_config/mise/config.toml` | mise | — |
| `~/.config/pacman/aurlist.txt` | `dot_config/pacman/aurlist.txt` | pacman / AUR | — |
| `~/.config/pacman/pkglist.txt` | `dot_config/pacman/pkglist.txt` | pacman / AUR | — |

## AI agent harnesses

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.agents/skills/project-doc-planner` | `dot_agents/skills/symlink_project-doc-planner` | shared skills | symlink |
| `~/.claude/skills/project-doc-planner` | `dot_claude/skills/symlink_project-doc-planner` | claude code | symlink |
| `~/.claude/themes/omarchy.json` | `dot_claude/themes/omarchy.json.tmpl` | claude code | template |
| `~/.cline/data/settings/global-settings.json` | `dot_cline/data/settings/global-settings.json` | cline | — |
| `~/.cline/skills/project-doc-planner` | `dot_cline/skills/symlink_project-doc-planner` | cline | symlink |
| `~/.codex/hooks.json` | `dot_codex/hooks.json` | codex | — |
| `~/.codex/config.toml` | `dot_codex/modify_private_config.toml` | codex | modify, private |
| `~/.codex/AGENTS.md` | `dot_codex/private_AGENTS.md` | codex | private |
| `~/.codex/rules/default.rules` | `dot_codex/rules/default.rules` | codex | — |
| `~/.codex/skills/dots/SKILL.md` | `dot_codex/skills/dots/SKILL.md` | codex | — |
| `~/.codex/skills/frontier-sweep/SKILL.md` | `dot_codex/skills/frontier-sweep/SKILL.md` | codex | — |
| `~/.codex/skills/grilling/SKILL.md` | `dot_codex/skills/grilling/SKILL.md` | codex | — |
| `~/.codex/skills/grilling/agents/openai.yaml` | `dot_codex/skills/grilling/agents/openai.yaml` | codex | — |
| `~/.codex/skills/linear-agent-tracking/SKILL.md` | `dot_codex/skills/linear-agent-tracking/SKILL.md` | codex | — |
| `~/.codex/skills/linear-agent-tracking/agents/openai.yaml` | `dot_codex/skills/linear-agent-tracking/agents/openai.yaml` | codex | — |
| `~/.codex/skills/linear-agent-tracking/references/issue-tracker-linear.md` | `dot_codex/skills/linear-agent-tracking/references/issue-tracker-linear.md` | codex | — |
| `~/.codex/skills/linear-agent-tracking/references/linear-cli.md` | `dot_codex/skills/linear-agent-tracking/references/linear-cli.md` | codex | — |
| `~/.codex/skills/project-doc-planner/SKILL.md` | `dot_codex/skills/project-doc-planner/SKILL.md` | codex | — |
| `~/.codex/skills/project-doc-planner/agents/openai.yaml` | `dot_codex/skills/project-doc-planner/agents/openai.yaml` | codex | — |
| `~/.codex/themes/dots.tmTheme` | `dot_codex/themes/dots.tmTheme.tmpl` | codex | template |
| `~/.config/opencode/agents/codebase-memory-auditor.md` | `dot_config/opencode/agents/private_codebase-memory-auditor.md` | opencode | private |
| `~/.config/opencode/agents/codebase-memory-scout.md` | `dot_config/opencode/agents/private_codebase-memory-scout.md` | opencode | private |
| `~/.config/opencode/agents/codebase-memory.md` | `dot_config/opencode/agents/private_codebase-memory.md` | opencode | private |
| `~/.config/opencode/.gitignore` | `dot_config/opencode/dot_gitignore` | opencode | — |
| `~/.config/opencode/opencode.json` | `dot_config/opencode/encrypted_opencode.json.age` | opencode | encrypted |
| `~/.config/opencode/plugins/herdr-agent-metadata.js` | `dot_config/opencode/plugins/herdr-agent-metadata.js` | opencode | — |
| `~/.config/opencode/plugins/herdr-subagents.js` | `dot_config/opencode/plugins/herdr-subagents.js` | opencode | — |
| `~/.config/opencode/AGENTS.md` | `dot_config/opencode/private_AGENTS.md` | opencode | private |
| `~/.config/opencode/skills/opencode-go-usage/SKILL.md` | `dot_config/opencode/skills/opencode-go-usage/SKILL.md` | opencode | — |
| `~/.config/opencode/skills/project-doc-planner` | `dot_config/opencode/skills/symlink_project-doc-planner` | opencode | symlink |
| `~/.config/opencode/themes/dots.json` | `dot_config/opencode/themes/dots.json.tmpl` | opencode | template |
| `~/.config/opencode/tui.json` | `dot_config/opencode/tui.json` | opencode | — |
| `~/.config/opencode/tui.jsonc` | `dot_config/opencode/tui.jsonc` | opencode | — |
| `~/.gemini/agents/codebase-memory-auditor.md` | `dot_gemini/agents/private_codebase-memory-auditor.md` | gemini | private |
| `~/.gemini/agents/codebase-memory-scout.md` | `dot_gemini/agents/private_codebase-memory-scout.md` | gemini | private |
| `~/.gemini/agents/codebase-memory.md` | `dot_gemini/agents/private_codebase-memory.md` | gemini | private |
| `~/.gemini/config/hooks.json` | `dot_gemini/config/hooks.json` | gemini | — |
| `~/.gemini/config/hooks/herdr-agent-metadata.sh` | `dot_gemini/config/hooks/herdr-agent-metadata.sh` | gemini | — |
| `~/.gemini/config/mcp_config.json` | `dot_gemini/config/mcp_config.json` | gemini | — |
| `~/.gemini/config/skills/project-doc-planner` | `dot_gemini/config/skills/symlink_project-doc-planner` | gemini | symlink |
| `~/.gemini/settings.json` | `dot_gemini/modify_private_settings.json` | gemini | modify, private |
| `~/.gemini/GEMINI.md` | `dot_gemini/private_GEMINI.md` | gemini | private |
| `~/.gemini/skills/project-doc-planner` | `dot_gemini/skills/symlink_project-doc-planner` | gemini | symlink |
| `~/.grok/hooks/herdr-agent-state.sh` | `dot_grok/hooks/executable_herdr-agent-state.sh` | grok | executable |
| `~/.grok/hooks/herdr.json` | `dot_grok/hooks/herdr.json` | grok | — |
| `~/.pi/agent/skills/project-doc-planner` | `dot_pi/agent/skills/symlink_project-doc-planner` | pi | symlink |
| `~/.grokbot/settings.json` | `private_dot_grokbot/settings.json` | grokbot | private |
| `~/.hermes/SOUL.md` | `private_dot_hermes/SOUL.md` | hermes | private |
| `~/.hermes/config.yaml` | `private_dot_hermes/config.yaml.tmpl` | hermes | private, template |
| `~/.hermes/skins/omarchy.yaml` | `private_dot_hermes/skins/omarchy.yaml.tmpl` | hermes | private, template |

## Background services

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/environment.d/10-defaults.conf` | `dot_config/environment.d/10-defaults.conf` | session environment | — |
| `~/.config/environment.d/10-machine.conf` | `dot_config/environment.d/10-machine.conf.tmpl` | session environment | template |
| `~/.config/systemd/user/dots-theme-agents.path` | `dot_config/systemd/user/dots-theme-agents.path` | user systemd units | — |
| `~/.config/systemd/user/dots-theme-agents.service` | `dot_config/systemd/user/dots-theme-agents.service` | user systemd units | — |
| `~/.config/systemd/user/herdr-cline-state.service` | `dot_config/systemd/user/herdr-cline-state.service` | user systemd units | — |
| `~/.config/systemd/user/herdr-cline-state.timer` | `dot_config/systemd/user/herdr-cline-state.timer` | user systemd units | — |
| `~/.config/systemd/user/herdr-outpost-relay.service` | `dot_config/systemd/user/herdr-outpost-relay.service` | user systemd units | — |
| `~/.config/systemd/user/ollama-omarchy-agents.service` | `dot_config/systemd/user/ollama-omarchy-agents.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-agents-analysis.service` | `dot_config/systemd/user/omarchy-agents-analysis.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-agents-analysis.timer` | `dot_config/systemd/user/omarchy-agents-analysis.timer` | user systemd units | — |
| `~/.config/systemd/user/omarchy-agents-dashboard.service` | `dot_config/systemd/user/omarchy-agents-dashboard.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-agents-tunnel.service` | `dot_config/systemd/user/omarchy-agents-tunnel.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-camera-reset.service` | `dot_config/systemd/user/omarchy-camera-reset.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cline-usage-scrape.service` | `dot_config/systemd/user/omarchy-cline-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cline-usage-scrape.timer` | `dot_config/systemd/user/omarchy-cline-usage-scrape.timer` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cursor-usage-scrape.service` | `dot_config/systemd/user/omarchy-cursor-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cursor-usage-scrape.timer` | `dot_config/systemd/user/omarchy-cursor-usage-scrape.timer` | user systemd units | — |
| `~/.config/systemd/user/omarchy-drift-capture.path` | `dot_config/systemd/user/omarchy-drift-capture.path` | user systemd units | — |
| `~/.config/systemd/user/omarchy-drift-capture.service` | `dot_config/systemd/user/omarchy-drift-capture.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.service` | `dot_config/systemd/user/omarchy-opencode-go-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.timer` | `dot_config/systemd/user/omarchy-opencode-go-usage-scrape.timer` | user systemd units | — |

## Custom executables

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.local/bin/cline-safety/git` | `dot_local/bin/cline-safety/executable_git` | cline git interceptor | executable |
| `~/.local/bin/backdrop-split` | `dot_local/bin/executable_backdrop-split` | custom executables | executable |
| `~/.local/bin/chrome-profile` | `dot_local/bin/executable_chrome-profile` | custom executables | executable |
| `~/.local/bin/cursor` | `dot_local/bin/executable_cursor` | custom executables | executable |
| `~/.local/bin/dots` | `dot_local/bin/executable_dots` | custom executables | executable |
| `~/.local/bin/dots-identity` | `dot_local/bin/executable_dots-identity` | custom executables | executable |
| `~/.local/bin/dots-push` | `dot_local/bin/executable_dots-push` | custom executables | executable |
| `~/.local/bin/dots-theme-agents` | `dot_local/bin/executable_dots-theme-agents` | custom executables | executable |
| `~/.local/bin/dots-theme-import-aether` | `dot_local/bin/executable_dots-theme-import-aether` | custom executables | executable |
| `~/.local/bin/herdr-agent-lifecycle` | `dot_local/bin/executable_herdr-agent-lifecycle` | custom executables | executable |
| `~/.local/bin/herdr-cline-state` | `dot_local/bin/executable_herdr-cline-state` | custom executables | executable |
| `~/.local/bin/herdr-gemini-session` | `dot_local/bin/executable_herdr-gemini-session` | custom executables | executable |
| `~/.local/bin/herdr-subagents` | `dot_local/bin/executable_herdr-subagents` | custom executables | executable |
| `~/.local/bin/herdr-sync-hermes-plugin` | `dot_local/bin/executable_herdr-sync-hermes-plugin` | custom executables | executable |
| `~/.local/bin/herdr-verify` | `dot_local/bin/executable_herdr-verify` | custom executables | executable |
| `~/.local/bin/lazygit-ollama-commit.sh` | `dot_local/bin/executable_lazygit-ollama-commit.sh` | custom executables | executable |
| `~/.local/bin/ollama-commit-msg.sh` | `dot_local/bin/executable_ollama-commit-msg.sh` | custom executables | executable |
| `~/.local/bin/omarchy-agent-usage-antigravity` | `dot_local/bin/executable_omarchy-agent-usage-antigravity.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-cline` | `dot_local/bin/executable_omarchy-agent-usage-cline.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-codex` | `dot_local/bin/executable_omarchy-agent-usage-codex.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-cursor` | `dot_local/bin/executable_omarchy-agent-usage-cursor.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-opencode` | `dot_local/bin/executable_omarchy-agent-usage-opencode.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-pi` | `dot_local/bin/executable_omarchy-agent-usage-pi.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-update` | `dot_local/bin/executable_omarchy-agent-usage-update.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent` | `dot_local/bin/executable_omarchy-agent.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-camera-reset` | `dot_local/bin/executable_omarchy-camera-reset` | custom executables | executable |
| `~/.local/bin/omarchy-cline-usage-login` | `dot_local/bin/executable_omarchy-cline-usage-login.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cline-usage-override` | `dot_local/bin/executable_omarchy-cline-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cline-usage-scrape` | `dot_local/bin/executable_omarchy-cline-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-statusline` | `dot_local/bin/executable_omarchy-cursor-statusline.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-usage-override` | `dot_local/bin/executable_omarchy-cursor-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-usage-scrape` | `dot_local/bin/executable_omarchy-cursor-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-default-agent` | `dot_local/bin/executable_omarchy-default-agent.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-dotfiles-sync` | `dot_local/bin/executable_omarchy-dotfiles-sync` | custom executables | executable |
| `~/.local/bin/omarchy-drift-capture` | `dot_local/bin/executable_omarchy-drift-capture` | custom executables | executable |
| `~/.local/bin/omarchy-opencode-go-usage-login` | `dot_local/bin/executable_omarchy-opencode-go-usage-login.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-opencode-go-usage-override` | `dot_local/bin/executable_omarchy-opencode-go-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-opencode-go-usage-scrape` | `dot_local/bin/executable_omarchy-opencode-go-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/piper` | `dot_local/bin/executable_piper` | custom executables | executable |
| `~/.local/bin/ratbagctl` | `dot_local/bin/executable_ratbagctl` | custom executables | executable |
| `~/.local/bin/statusline` | `dot_local/bin/executable_statusline.tmpl` | custom executables | executable, template |
| `~/.local/bin/wsl-windows-tool` | `dot_local/bin/executable_wsl-windows-tool` | custom executables | executable |

## Credentials & SSH

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/1password/ssh/agent.toml` | `dot_config/1password/ssh/agent.toml` | 1password | — |
| `~/.ssh/config` | `private_dot_ssh/config.tmpl` | ssh | private, template |

## Other configuration

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.chezmoitemplates/aether-adapters/bat.tmTheme` | `.chezmoitemplates/aether-adapters/bat.tmTheme.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/delta.gitconfig` | `.chezmoitemplates/aether-adapters/delta.gitconfig.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/eza.yml` | `.chezmoitemplates/aether-adapters/eza.yml.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/fzf.sh` | `.chezmoitemplates/aether-adapters/fzf.sh.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/gemini.json` | `.chezmoitemplates/aether-adapters/gemini.json.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/lazygit.yml` | `.chezmoitemplates/aether-adapters/lazygit.yml.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/manifest.yaml` | `.chezmoitemplates/aether-adapters/manifest.yaml.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/nvim.lua` | `.chezmoitemplates/aether-adapters/nvim.lua.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/windows_terminal.json` | `.chezmoitemplates/aether-adapters/windows_terminal.json.tmpl` | — | template |
| `~/.chezmoitemplates/aether-adapters/zebar.css` | `.chezmoitemplates/aether-adapters/zebar.css.tmpl` | — | template |
| `~/.chezmoitemplates/codex-config.toml` | `.chezmoitemplates/codex-config.toml` | — | — |
| `~/.chezmoitemplates/gemini-settings.json` | `.chezmoitemplates/gemini-settings.json` | — | — |
| `~/.chezmoitemplates/gen-palette` | `.chezmoitemplates/gen-palette.tmpl` | — | template |
| `~/.chezmoitemplates/littlebigmouse/Current.xml` | `.chezmoitemplates/littlebigmouse/Current.xml` | — | — |
| `~/.chezmoitemplates/machine-theme-name` | `.chezmoitemplates/machine-theme-name.tmpl` | — | template |
| `~/.chezmoitemplates/theme-palette` | `.chezmoitemplates/theme-palette.tmpl` | — | template |
| `~/.chezmoitemplates/themes/gen-6bd5de2cd3e4/windows_terminal.json` | `.chezmoitemplates/themes/gen-6bd5de2cd3e4/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/colors.toml` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/eza.yml` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/fzf.sh` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/gemini.json` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/lazygit.yml` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/manifest.yaml` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/nvim.lua` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin-latte/zebar.css` | `.chezmoitemplates/themes/omarchy-catppuccin-latte/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-catppuccin/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/colors.toml` | `.chezmoitemplates/themes/omarchy-catppuccin/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-catppuccin/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/eza.yml` | `.chezmoitemplates/themes/omarchy-catppuccin/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/fzf.sh` | `.chezmoitemplates/themes/omarchy-catppuccin/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/gemini.json` | `.chezmoitemplates/themes/omarchy-catppuccin/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/lazygit.yml` | `.chezmoitemplates/themes/omarchy-catppuccin/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/manifest.yaml` | `.chezmoitemplates/themes/omarchy-catppuccin/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/nvim.lua` | `.chezmoitemplates/themes/omarchy-catppuccin/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-catppuccin/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-catppuccin/zebar.css` | `.chezmoitemplates/themes/omarchy-catppuccin/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-everforest/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/colors.toml` | `.chezmoitemplates/themes/omarchy-everforest/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-everforest/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/eza.yml` | `.chezmoitemplates/themes/omarchy-everforest/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/fzf.sh` | `.chezmoitemplates/themes/omarchy-everforest/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/gemini.json` | `.chezmoitemplates/themes/omarchy-everforest/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/lazygit.yml` | `.chezmoitemplates/themes/omarchy-everforest/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/manifest.yaml` | `.chezmoitemplates/themes/omarchy-everforest/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/nvim.lua` | `.chezmoitemplates/themes/omarchy-everforest/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-everforest/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-everforest/zebar.css` | `.chezmoitemplates/themes/omarchy-everforest/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-gruvbox/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/colors.toml` | `.chezmoitemplates/themes/omarchy-gruvbox/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-gruvbox/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/eza.yml` | `.chezmoitemplates/themes/omarchy-gruvbox/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/fzf.sh` | `.chezmoitemplates/themes/omarchy-gruvbox/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/gemini.json` | `.chezmoitemplates/themes/omarchy-gruvbox/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/lazygit.yml` | `.chezmoitemplates/themes/omarchy-gruvbox/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/manifest.yaml` | `.chezmoitemplates/themes/omarchy-gruvbox/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/nvim.lua` | `.chezmoitemplates/themes/omarchy-gruvbox/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-gruvbox/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-gruvbox/zebar.css` | `.chezmoitemplates/themes/omarchy-gruvbox/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-kanagawa/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/colors.toml` | `.chezmoitemplates/themes/omarchy-kanagawa/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-kanagawa/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/eza.yml` | `.chezmoitemplates/themes/omarchy-kanagawa/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/fzf.sh` | `.chezmoitemplates/themes/omarchy-kanagawa/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/gemini.json` | `.chezmoitemplates/themes/omarchy-kanagawa/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/lazygit.yml` | `.chezmoitemplates/themes/omarchy-kanagawa/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/manifest.yaml` | `.chezmoitemplates/themes/omarchy-kanagawa/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/nvim.lua` | `.chezmoitemplates/themes/omarchy-kanagawa/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-kanagawa/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-kanagawa/zebar.css` | `.chezmoitemplates/themes/omarchy-kanagawa/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-nord/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/colors.toml` | `.chezmoitemplates/themes/omarchy-nord/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-nord/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/eza.yml` | `.chezmoitemplates/themes/omarchy-nord/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/fzf.sh` | `.chezmoitemplates/themes/omarchy-nord/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/gemini.json` | `.chezmoitemplates/themes/omarchy-nord/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/lazygit.yml` | `.chezmoitemplates/themes/omarchy-nord/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/manifest.yaml` | `.chezmoitemplates/themes/omarchy-nord/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/nvim.lua` | `.chezmoitemplates/themes/omarchy-nord/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-nord/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-nord/zebar.css` | `.chezmoitemplates/themes/omarchy-nord/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-rose-pine/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/colors.toml` | `.chezmoitemplates/themes/omarchy-rose-pine/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-rose-pine/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/eza.yml` | `.chezmoitemplates/themes/omarchy-rose-pine/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/fzf.sh` | `.chezmoitemplates/themes/omarchy-rose-pine/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/gemini.json` | `.chezmoitemplates/themes/omarchy-rose-pine/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/lazygit.yml` | `.chezmoitemplates/themes/omarchy-rose-pine/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/manifest.yaml` | `.chezmoitemplates/themes/omarchy-rose-pine/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/nvim.lua` | `.chezmoitemplates/themes/omarchy-rose-pine/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-rose-pine/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-rose-pine/zebar.css` | `.chezmoitemplates/themes/omarchy-rose-pine/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/bat.tmTheme` | `.chezmoitemplates/themes/omarchy-tokyo-night/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/colors.toml` | `.chezmoitemplates/themes/omarchy-tokyo-night/colors.toml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/delta.gitconfig` | `.chezmoitemplates/themes/omarchy-tokyo-night/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/eza.yml` | `.chezmoitemplates/themes/omarchy-tokyo-night/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/fzf.sh` | `.chezmoitemplates/themes/omarchy-tokyo-night/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/gemini.json` | `.chezmoitemplates/themes/omarchy-tokyo-night/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/lazygit.yml` | `.chezmoitemplates/themes/omarchy-tokyo-night/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/manifest.yaml` | `.chezmoitemplates/themes/omarchy-tokyo-night/manifest.yaml` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/nvim.lua` | `.chezmoitemplates/themes/omarchy-tokyo-night/nvim.lua` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/windows_terminal.json` | `.chezmoitemplates/themes/omarchy-tokyo-night/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/omarchy-tokyo-night/zebar.css` | `.chezmoitemplates/themes/omarchy-tokyo-night/zebar.css` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/bat.tmTheme` | `.chezmoitemplates/themes/tokyonight-day/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/delta.gitconfig` | `.chezmoitemplates/themes/tokyonight-day/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/eza.yml` | `.chezmoitemplates/themes/tokyonight-day/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/fzf.sh` | `.chezmoitemplates/themes/tokyonight-day/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/gemini.json` | `.chezmoitemplates/themes/tokyonight-day/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/lazygit.yml` | `.chezmoitemplates/themes/tokyonight-day/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/wallpaper.png` | `.chezmoitemplates/themes/tokyonight-day/wallpaper.png` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-day/windows_terminal.json` | `.chezmoitemplates/themes/tokyonight-day/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/bat.tmTheme` | `.chezmoitemplates/themes/tokyonight-moon/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/delta.gitconfig` | `.chezmoitemplates/themes/tokyonight-moon/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/eza.yml` | `.chezmoitemplates/themes/tokyonight-moon/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/fzf.sh` | `.chezmoitemplates/themes/tokyonight-moon/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/gemini.json` | `.chezmoitemplates/themes/tokyonight-moon/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/lazygit.yml` | `.chezmoitemplates/themes/tokyonight-moon/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/wallpaper.png` | `.chezmoitemplates/themes/tokyonight-moon/wallpaper.png` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-moon/windows_terminal.json` | `.chezmoitemplates/themes/tokyonight-moon/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/bat.tmTheme` | `.chezmoitemplates/themes/tokyonight-night/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/delta.gitconfig` | `.chezmoitemplates/themes/tokyonight-night/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/eza.yml` | `.chezmoitemplates/themes/tokyonight-night/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/fzf.sh` | `.chezmoitemplates/themes/tokyonight-night/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/gemini.json` | `.chezmoitemplates/themes/tokyonight-night/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/lazygit.yml` | `.chezmoitemplates/themes/tokyonight-night/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/wallpaper.png` | `.chezmoitemplates/themes/tokyonight-night/wallpaper.png` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-night/windows_terminal.json` | `.chezmoitemplates/themes/tokyonight-night/windows_terminal.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/bat.tmTheme` | `.chezmoitemplates/themes/tokyonight-storm/bat.tmTheme` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/delta.gitconfig` | `.chezmoitemplates/themes/tokyonight-storm/delta.gitconfig` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/eza.yml` | `.chezmoitemplates/themes/tokyonight-storm/eza.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/fzf.sh` | `.chezmoitemplates/themes/tokyonight-storm/fzf.sh` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/gemini.json` | `.chezmoitemplates/themes/tokyonight-storm/gemini.json` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/lazygit.yml` | `.chezmoitemplates/themes/tokyonight-storm/lazygit.yml` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/wallpaper.png` | `.chezmoitemplates/themes/tokyonight-storm/wallpaper.png` | — | — |
| `~/.chezmoitemplates/themes/tokyonight-storm/windows_terminal.json` | `.chezmoitemplates/themes/tokyonight-storm/windows_terminal.json` | — | — |
| `~/.hermes.md` | `.hermes.md` | — | — |
| `~/.yamllint.yml` | `.yamllint.yml` | — | — |
| `~/dev` | `dev` | — | — |
| `~/.config/apt/pkglist.txt` | `dot_config/apt/pkglist.txt` | — | — |
| `~/.config/bat/config` | `dot_config/bat/config` | — | — |
| `~/.config/bat/themes/dots.tmTheme` | `dot_config/bat/themes/dots.tmTheme.tmpl` | — | template |
| `~/.config/delta/theme.gitconfig` | `dot_config/delta/theme.gitconfig.tmpl` | — | template |
| `~/.config/eza/theme.yml` | `dot_config/eza/theme.yml.tmpl` | — | template |
| `~/.config/fastfetch/augustus.jpg` | `dot_config/fastfetch/augustus.jpg` | — | — |
| `~/.config/fastfetch/config.jsonc` | `dot_config/fastfetch/config.jsonc.tmpl` | — | template |
| `~/.config/fzf/theme.sh` | `dot_config/fzf/theme.sh.tmpl` | — | template |
| `~/.local/share/figlet/README.md` | `dot_local/share/figlet/README.md` | — | — |
| `~/.local/share/figlet/Roman.flf` | `dot_local/share/figlet/Roman.flf` | — | — |
| `~/.local/share/omarchy-patches/io.github.codesmith28.omalt-tab-compact.patch` | `dot_local/share/omarchy-patches/io.github.codesmith28.omalt-tab-compact.patch` | — | — |
| `~/.local/share/wsl-ssh-bridge/main.go` | `dot_local/share/wsl-ssh-bridge/main.go` | — | — |
| `~/install.sh` | `install.sh` | — | — |
| `~/tests/test-dev.sh` | `tests/test-dev.sh` | — | — |
| `~/theme-assets/omarchy-catppuccin-latte/wallpaper.png` | `theme-assets/omarchy-catppuccin-latte/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-catppuccin/wallpaper.png` | `theme-assets/omarchy-catppuccin/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-everforest/wallpaper.png` | `theme-assets/omarchy-everforest/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-gruvbox/wallpaper.png` | `theme-assets/omarchy-gruvbox/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-kanagawa/wallpaper.png` | `theme-assets/omarchy-kanagawa/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-nord/wallpaper.png` | `theme-assets/omarchy-nord/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-rose-pine/wallpaper.png` | `theme-assets/omarchy-rose-pine/wallpaper.png` | — | — |
| `~/theme-assets/omarchy-tokyo-night/wallpaper.png` | `theme-assets/omarchy-tokyo-night/wallpaper.png` | — | — |

## Apply hooks (`run_*`)

| Order | Source | Trigger | Phase |
| ---: | --- | --- | --- |
| 00 | `run_once_before_00-verify-deps.sh.tmpl` | runs once ever | before |
| 05 | `run_once_before_05-sync-hermes-skills.sh.tmpl` | runs once ever | before |
| 09 | `run_onchange_before_09-install-agent-skills.sh.tmpl` | runs when this script's contents change | before |
| 10 | `run_onchange_after_10-install-omarchy-plugins.sh.tmpl` | runs when this script's contents change | after |
| 20 | `run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl` | runs when this script's contents change | after |
| 23 | `run_after_23-sync-agent-skills.sh.tmpl` | runs after every apply | after |
| 24 | `run_once_after_24-setup-omarchy-agents.sh.tmpl` | runs once ever | after |
| 25 | `run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl` | runs when this script's contents change | after |
| 26 | `run_onchange_after_26-setup-omarchy-cursor.sh.tmpl` | runs when this script's contents change | after |
| 27 | `run_onchange_after_27-sync-claude-mcp.sh.tmpl` | runs when this script's contents change | after |
| 28 | `run_onchange_after_28-sync-claude-settings.sh.tmpl` | runs when this script's contents change | after |
| 29 | `run_onchange_after_29-enable-omarchy-user-units.sh.tmpl` | runs when this script's contents change | after |
| 30 | `run_onchange_after_30-hadrian-macos-defaults.sh.tmpl` | runs when this script's contents change | after |
| 31 | `run_onchange_after_31-augustus-mouse-dpi.sh.tmpl` | runs when this script's contents change | after |
| 32 | `run_onchange_after_32-setup-omarchy-agent-registrations.sh.tmpl` | runs when this script's contents change | after |
| 33 | `run_onchange_after_33-augustus-machine-branding.sh.tmpl` | runs when this script's contents change | after |
| 34 | `run_after_34-augustus-backdrop-split.sh.tmpl` | runs after every apply | after |
| 35 | `run_after_35-augustus-theme-modes-converge.sh.tmpl` | runs after every apply | after |
| 40 | `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` | runs when this script's contents change | after |
| 41 | `run_onchange_after_41-vespasian-nerd-font.sh.tmpl` | runs when this script's contents change | after |
| 42 | `run_onchange_after_42-vespasian-theme-state.sh.tmpl` | runs when this script's contents change | after |
| 43 | `run_onchange_after_43-vespasian-1password-ssh-bridge.sh.tmpl` | runs when this script's contents change | after |
| 44 | `run_onchange_after_44-vespasian-windows-debloat.sh.tmpl` | runs when this script's contents change | after |
| 45 | `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` | runs when this script's contents change | after |
| 46 | `run_onchange_after_46-vespasian-wallpaper.sh.tmpl` | runs when this script's contents change | after |
| 47 | `run_onchange_after_47-vespasian-wsl-boot.sh.tmpl` | runs when this script's contents change | after |

## Chezmoi control files

| Path | Role |
| --- | --- |
| `.chezmoi.toml.tmpl` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/agent_skills.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/claude_mcp.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/claude_settings.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/codex_projects.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/generated/gen-6bd5de2cd3e4/windows_terminal.json` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/hermes_sync.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/machines.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/omarchy_agents.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/omarchy_plugins.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/themes.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoiignore.tmpl` | Controls how chezmoi renders and applies this tree |

## Repository material (not applied)

| Path | Role |
| --- | --- |
| `.github/gitleaks-smoke.toml` | CI workflows |
| `.github/workflows/ci.yml` | CI workflows |
| `.gitignore` | Git tracking rules |
| `.gitleaks.toml` | Secret-scan defaults and narrow verified example exceptions |
| `.gitleaksignore` | Documented secret-scan finding fingerprints |
| `.gitmodules` | Submodule registration |
| `AGENTS.md` | Authoritative contract for agents working in this repo |
| `Documents/Cline/Workflows/usage.md` | Non-config content (Cline workflow docs) |
| `INDEX.json` | Generated machine-readable index (this artifact) |
| `INDEX.md` | Generated human-readable index (this artifact) |
| `README.md` | Human-facing repository overview |
| `bun.lock` | Lockfile for the above |
| `docs/aether-theming-integration-proposal.md` | Recovery guide and repository maintenance scripts |
| `docs/agents/issue-tracker.md` | Recovery guide and repository maintenance scripts |
| `docs/check-shell-modules.sh` | Recovery guide and repository maintenance scripts |
| `docs/check_ignore_consistency.py` | Recovery guide and repository maintenance scripts |
| `docs/dotfiles-gap-action-plan.md` | Recovery guide and repository maintenance scripts |
| `docs/generate_index.py` | Recovery guide and repository maintenance scripts |
| `docs/generate_readme_tree.py` | Recovery guide and repository maintenance scripts |
| `docs/optional-agent-skill-packs-implementation-plan.md` | Recovery guide and repository maintenance scripts |
| `docs/optional-agent-skill-packs-ux-proposal.md` | Recovery guide and repository maintenance scripts |
| `docs/recovery.md` | Recovery guide and repository maintenance scripts |
| `docs/reorganization-proposal.md` | Recovery guide and repository maintenance scripts |
| `docs/test_gitleaks.py` | Recovery guide and repository maintenance scripts |
| `docs/test_readme_tree.py` | Recovery guide and repository maintenance scripts |
| `docs/test_shell_modules.py` | Recovery guide and repository maintenance scripts |
| `docs/vespasian-boot.md` | Recovery guide and repository maintenance scripts |
| `docs/vespasian-theming.md` | Recovery guide and repository maintenance scripts |
| `dotfiles-showcase` | Submodule — the showcase web app; never applied |
| `package.json` | Runtime CLI deps installed outside mise |
| `setup.sh` | Interactive new machine onboarding & setup wizard |
