# Dotfiles Index

<!-- GENERATED FILE — DO NOT EDIT. Regenerate with `python3 docs/generate_index.py`; CI gates freshness. -->

> **Generated file — do not edit.** Produced by `docs/generate_index.py`
> from `git ls-files`. Run `python3 docs/generate_index.py` after adding or
> moving a file; CI fails when this file is stale.

Machine-readable equivalent: [`INDEX.json`](INDEX.json) — that is the file
agents and the showcase app should read. This page is the same data for humans.

**843 tracked entries** across 16 categories.

| Category | Entries |
| --- | ---: |
| [Shell](#shell) | 20 |
| [Prompt](#prompt) | 1 |
| [Terminal & multiplexer](#terminal--multiplexer) | 5 |
| [Editors](#editors) | 18 |
| [Desktop & window manager](#desktop--window-manager) | 11 |
| [Version control](#version-control) | 6 |
| [Navigation & search](#navigation--search) | 3 |
| [Toolchain & packages](#toolchain--packages) | 5 |
| [AI agent harnesses](#ai-agent-harnesses) | 497 |
| [Background services](#background-services) | 17 |
| [Custom executables](#custom-executables) | 37 |
| [Credentials & SSH](#credentials--ssh) | 2 |
| [Other configuration](#other-configuration) | 156 |
| [Apply hooks (`run_*`)](#apply-hooks-run) | 24 |
| [Chezmoi control files](#chezmoi-control-files) | 11 |
| [Repository material (not applied)](#repository-material-not-applied) | 30 |

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
| `~/.config/opencode/agents/codebase-memory-auditor.md` | `dot_config/opencode/agents/private_codebase-memory-auditor.md` | opencode | private |
| `~/.config/opencode/agents/codebase-memory-scout.md` | `dot_config/opencode/agents/private_codebase-memory-scout.md` | opencode | private |
| `~/.config/opencode/agents/codebase-memory.md` | `dot_config/opencode/agents/private_codebase-memory.md` | opencode | private |
| `~/.config/opencode/.gitignore` | `dot_config/opencode/dot_gitignore` | opencode | — |
| `~/.config/opencode/opencode.json` | `dot_config/opencode/encrypted_opencode.json.age` | opencode | encrypted |
| `~/.config/opencode/AGENTS.md` | `dot_config/opencode/private_AGENTS.md` | opencode | private |
| `~/.config/opencode/skills/opencode-go-usage/SKILL.md` | `dot_config/opencode/skills/opencode-go-usage/SKILL.md` | opencode | — |
| `~/.config/opencode/skills/project-doc-planner` | `dot_config/opencode/skills/symlink_project-doc-planner` | opencode | symlink |
| `~/.config/opencode/tui.json` | `dot_config/opencode/tui.json` | opencode | — |
| `~/.config/opencode/tui.jsonc` | `dot_config/opencode/tui.jsonc` | opencode | — |
| `~/.evotai/evot.env` | `dot_evotai/evot.env` | evot | — |
| `~/.gemini/agents/codebase-memory-auditor.md` | `dot_gemini/agents/private_codebase-memory-auditor.md` | gemini | private |
| `~/.gemini/agents/codebase-memory-scout.md` | `dot_gemini/agents/private_codebase-memory-scout.md` | gemini | private |
| `~/.gemini/agents/codebase-memory.md` | `dot_gemini/agents/private_codebase-memory.md` | gemini | private |
| `~/.gemini/config/mcp_config.json` | `dot_gemini/config/mcp_config.json` | gemini | — |
| `~/.gemini/config/skills/project-doc-planner` | `dot_gemini/config/skills/symlink_project-doc-planner` | gemini | symlink |
| `~/.gemini/settings.json` | `dot_gemini/modify_private_settings.json` | gemini | modify, private |
| `~/.gemini/GEMINI.md` | `dot_gemini/private_GEMINI.md` | gemini | private |
| `~/.gemini/skills/project-doc-planner` | `dot_gemini/skills/symlink_project-doc-planner` | gemini | symlink |
| `~/.grok/hooks/herdr-agent-state.sh` | `dot_grok/hooks/executable_herdr-agent-state.sh` | grok | executable |
| `~/.grok/hooks/herdr.json` | `dot_grok/hooks/herdr.json` | grok | — |
| `~/.hermes/SOUL.md` | `dot_hermes/SOUL.md` | hermes | — |
| `~/.hermes/config.yaml` | `dot_hermes/config.yaml.tmpl` | hermes | template |
| `~/.hermes/skills/apple/DESCRIPTION.md` | `dot_hermes/skills/apple/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/apple/apple-notes/SKILL.md` | `dot_hermes/skills/apple/apple-notes/SKILL.md` | hermes | — |
| `~/.hermes/skills/apple/apple-reminders/SKILL.md` | `dot_hermes/skills/apple/apple-reminders/SKILL.md` | hermes | — |
| `~/.hermes/skills/apple/findmy/SKILL.md` | `dot_hermes/skills/apple/findmy/SKILL.md` | hermes | — |
| `~/.hermes/skills/apple/imessage/SKILL.md` | `dot_hermes/skills/apple/imessage/SKILL.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/DESCRIPTION.md` | `dot_hermes/skills/autonomous-ai-agents/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/claude-code/SKILL.md` | `dot_hermes/skills/autonomous-ai-agents/claude-code/SKILL.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/codex/SKILL.md` | `dot_hermes/skills/autonomous-ai-agents/codex/SKILL.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/computer-use/SKILL.md` | `dot_hermes/skills/autonomous-ai-agents/computer-use/SKILL.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/SKILL.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/SKILL.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/background-systems.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/background-systems.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/cli-reference.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/cli-reference.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/configuration.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/configuration.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/contributor-guide.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/contributor-guide.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/delegate-task-concurrency-diagnosis.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/delegate-task-concurrency-diagnosis.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/desktop-plugins.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/desktop-plugins.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/native-mcp.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/native-mcp.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/petdex.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/petdex.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/portal-auth-for-third-party-apps.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/portal-auth-for-third-party-apps.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/project-context-files.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/project-context-files.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/providers-and-models.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/providers-and-models.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/security-privacy.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/security-privacy.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/slash-commands.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/slash-commands.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/themes.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/themes.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/troubleshooting.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/troubleshooting.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/tui-widgets.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/tui-widgets.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/webhooks.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/webhooks.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/references/windows-quirks.md` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/references/windows-quirks.md` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/templates/clock.mjs` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/templates/clock.mjs` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/templates/plugin.js` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/templates/plugin.js` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/hermes-agent/templates/skin.yaml` | `dot_hermes/skills/autonomous-ai-agents/hermes-agent/templates/skin.yaml` | hermes | — |
| `~/.hermes/skills/autonomous-ai-agents/opencode/SKILL.md` | `dot_hermes/skills/autonomous-ai-agents/opencode/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/DESCRIPTION.md` | `dot_hermes/skills/creative/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/creative/architecture-diagram/SKILL.md` | `dot_hermes/skills/creative/architecture-diagram/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/architecture-diagram/templates/template.html` | `dot_hermes/skills/creative/architecture-diagram/templates/template.html` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/README.md` | `dot_hermes/skills/creative/ascii-video/README.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/SKILL.md` | `dot_hermes/skills/creative/ascii-video/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/architecture.md` | `dot_hermes/skills/creative/ascii-video/references/architecture.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/composition.md` | `dot_hermes/skills/creative/ascii-video/references/composition.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/effects.md` | `dot_hermes/skills/creative/ascii-video/references/effects.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/inputs.md` | `dot_hermes/skills/creative/ascii-video/references/inputs.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/optimization.md` | `dot_hermes/skills/creative/ascii-video/references/optimization.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/scenes.md` | `dot_hermes/skills/creative/ascii-video/references/scenes.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/shaders.md` | `dot_hermes/skills/creative/ascii-video/references/shaders.md` | hermes | — |
| `~/.hermes/skills/creative/ascii-video/references/troubleshooting.md` | `dot_hermes/skills/creative/ascii-video/references/troubleshooting.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/PORT_NOTES.md` | `dot_hermes/skills/creative/baoyu-infographic/PORT_NOTES.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/SKILL.md` | `dot_hermes/skills/creative/baoyu-infographic/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/analysis-framework.md` | `dot_hermes/skills/creative/baoyu-infographic/references/analysis-framework.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/base-prompt.md` | `dot_hermes/skills/creative/baoyu-infographic/references/base-prompt.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/bento-grid.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/bento-grid.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/binary-comparison.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/binary-comparison.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/bridge.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/bridge.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/circular-flow.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/circular-flow.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/comic-strip.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/comic-strip.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/comparison-matrix.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/comparison-matrix.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/dashboard.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/dashboard.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/dense-modules.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/dense-modules.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/funnel.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/funnel.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/hierarchical-layers.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/hierarchical-layers.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/hub-spoke.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/hub-spoke.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/iceberg.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/iceberg.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/isometric-map.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/isometric-map.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/jigsaw.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/jigsaw.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/linear-progression.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/linear-progression.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/periodic-table.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/periodic-table.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/story-mountain.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/story-mountain.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/structural-breakdown.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/structural-breakdown.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/tree-branching.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/tree-branching.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/venn-diagram.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/venn-diagram.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/layouts/winding-roadmap.md` | `dot_hermes/skills/creative/baoyu-infographic/references/layouts/winding-roadmap.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/structured-content-template.md` | `dot_hermes/skills/creative/baoyu-infographic/references/structured-content-template.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/aged-academia.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/aged-academia.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/bold-graphic.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/bold-graphic.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/chalkboard.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/chalkboard.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/claymation.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/claymation.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/corporate-memphis.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/corporate-memphis.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/craft-handmade.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/craft-handmade.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/cyberpunk-neon.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/cyberpunk-neon.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/hand-drawn-edu.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/hand-drawn-edu.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/ikea-manual.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/ikea-manual.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/kawaii.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/kawaii.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/knolling.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/knolling.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/lego-brick.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/lego-brick.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/morandi-journal.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/morandi-journal.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/origami.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/origami.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/pixel-art.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/pixel-art.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/pop-laboratory.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/pop-laboratory.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/retro-pop-grid.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/retro-pop-grid.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/storybook-watercolor.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/storybook-watercolor.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/subway-map.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/subway-map.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/technical-schematic.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/technical-schematic.md` | hermes | — |
| `~/.hermes/skills/creative/baoyu-infographic/references/styles/ui-wireframe.md` | `dot_hermes/skills/creative/baoyu-infographic/references/styles/ui-wireframe.md` | hermes | — |
| `~/.hermes/skills/creative/claude-design/SKILL.md` | `dot_hermes/skills/creative/claude-design/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/design-md/SKILL.md` | `dot_hermes/skills/creative/design-md/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/design-md/templates/starter.md` | `dot_hermes/skills/creative/design-md/templates/starter.md` | hermes | — |
| `~/.hermes/skills/creative/humanizer/LICENSE` | `dot_hermes/skills/creative/humanizer/LICENSE` | hermes | — |
| `~/.hermes/skills/creative/humanizer/SKILL.md` | `dot_hermes/skills/creative/humanizer/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/SKILL.md` | `dot_hermes/skills/creative/impeccable/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/adapt.md` | `dot_hermes/skills/creative/impeccable/reference/adapt.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/adapt.native.md` | `dot_hermes/skills/creative/impeccable/reference/adapt.native.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/android.md` | `dot_hermes/skills/creative/impeccable/reference/android.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/animate.md` | `dot_hermes/skills/creative/impeccable/reference/animate.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/audit.md` | `dot_hermes/skills/creative/impeccable/reference/audit.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/audit.native.md` | `dot_hermes/skills/creative/impeccable/reference/audit.native.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/bolder.md` | `dot_hermes/skills/creative/impeccable/reference/bolder.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/clarify.md` | `dot_hermes/skills/creative/impeccable/reference/clarify.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/colorize.md` | `dot_hermes/skills/creative/impeccable/reference/colorize.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/craft-floor.md` | `dot_hermes/skills/creative/impeccable/reference/craft-floor.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/craft.md` | `dot_hermes/skills/creative/impeccable/reference/craft.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/critique.md` | `dot_hermes/skills/creative/impeccable/reference/critique.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/degraded/asset-producer.md` | `dot_hermes/skills/creative/impeccable/reference/degraded/asset-producer.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/degraded/documenter.md` | `dot_hermes/skills/creative/impeccable/reference/degraded/documenter.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/degraded/finish-reviewer.md` | `dot_hermes/skills/creative/impeccable/reference/degraded/finish-reviewer.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/degraded/manual-edit-applier.md` | `dot_hermes/skills/creative/impeccable/reference/degraded/manual-edit-applier.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/delight.md` | `dot_hermes/skills/creative/impeccable/reference/delight.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/distill.md` | `dot_hermes/skills/creative/impeccable/reference/distill.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/doctor.md` | `dot_hermes/skills/creative/impeccable/reference/doctor.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/document.md` | `dot_hermes/skills/creative/impeccable/reference/document.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/extract.md` | `dot_hermes/skills/creative/impeccable/reference/extract.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/generate.md` | `dot_hermes/skills/creative/impeccable/reference/generate.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/harden.md` | `dot_hermes/skills/creative/impeccable/reference/harden.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/hooks.md` | `dot_hermes/skills/creative/impeccable/reference/hooks.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/init.md` | `dot_hermes/skills/creative/impeccable/reference/init.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/ios.md` | `dot_hermes/skills/creative/impeccable/reference/ios.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/layout.md` | `dot_hermes/skills/creative/impeccable/reference/layout.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/live-setup.md` | `dot_hermes/skills/creative/impeccable/reference/live-setup.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/live.md` | `dot_hermes/skills/creative/impeccable/reference/live.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/new-work.md` | `dot_hermes/skills/creative/impeccable/reference/new-work.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/onboard.md` | `dot_hermes/skills/creative/impeccable/reference/onboard.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/operate.md` | `dot_hermes/skills/creative/impeccable/reference/operate.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/optimize.md` | `dot_hermes/skills/creative/impeccable/reference/optimize.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/overdrive.md` | `dot_hermes/skills/creative/impeccable/reference/overdrive.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/polish.md` | `dot_hermes/skills/creative/impeccable/reference/polish.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/quieter.md` | `dot_hermes/skills/creative/impeccable/reference/quieter.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/routing.md` | `dot_hermes/skills/creative/impeccable/reference/routing.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/shape.md` | `dot_hermes/skills/creative/impeccable/reference/shape.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/typeset.md` | `dot_hermes/skills/creative/impeccable/reference/typeset.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/reference/visualize.md` | `dot_hermes/skills/creative/impeccable/reference/visualize.md` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/VERSION` | `dot_hermes/skills/creative/impeccable/scripts/VERSION` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/command-metadata.json` | `dot_hermes/skills/creative/impeccable/scripts/command-metadata.json` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/data/font-index-failures.json` | `dot_hermes/skills/creative/impeccable/scripts/data/font-index-failures.json` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/data/font-index.json` | `dot_hermes/skills/creative/impeccable/scripts/data/font-index.json` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/impeccable` | `dot_hermes/skills/creative/impeccable/scripts/impeccable` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/impeccable.cmd` | `dot_hermes/skills/creative/impeccable/scripts/impeccable.cmd` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/live-browser-dom.js` | `dot_hermes/skills/creative/impeccable/scripts/live-browser-dom.js` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/live-browser-ignores.js` | `dot_hermes/skills/creative/impeccable/scripts/live-browser-ignores.js` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/live-browser-session.js` | `dot_hermes/skills/creative/impeccable/scripts/live-browser-session.js` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/live-browser.js` | `dot_hermes/skills/creative/impeccable/scripts/live-browser.js` | hermes | — |
| `~/.hermes/skills/creative/impeccable/scripts/modern-screenshot.umd.js` | `dot_hermes/skills/creative/impeccable/scripts/modern-screenshot.umd.js` | hermes | — |
| `~/.hermes/skills/creative/manim-video/README.md` | `dot_hermes/skills/creative/manim-video/README.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/SKILL.md` | `dot_hermes/skills/creative/manim-video/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/animation-design-thinking.md` | `dot_hermes/skills/creative/manim-video/references/animation-design-thinking.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/animations.md` | `dot_hermes/skills/creative/manim-video/references/animations.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/camera-and-3d.md` | `dot_hermes/skills/creative/manim-video/references/camera-and-3d.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/decorations.md` | `dot_hermes/skills/creative/manim-video/references/decorations.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/equations.md` | `dot_hermes/skills/creative/manim-video/references/equations.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/graphs-and-data.md` | `dot_hermes/skills/creative/manim-video/references/graphs-and-data.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/mobjects.md` | `dot_hermes/skills/creative/manim-video/references/mobjects.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/paper-explainer.md` | `dot_hermes/skills/creative/manim-video/references/paper-explainer.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/production-quality.md` | `dot_hermes/skills/creative/manim-video/references/production-quality.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/rendering.md` | `dot_hermes/skills/creative/manim-video/references/rendering.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/scene-planning.md` | `dot_hermes/skills/creative/manim-video/references/scene-planning.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/troubleshooting.md` | `dot_hermes/skills/creative/manim-video/references/troubleshooting.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/updaters-and-trackers.md` | `dot_hermes/skills/creative/manim-video/references/updaters-and-trackers.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/references/visual-design.md` | `dot_hermes/skills/creative/manim-video/references/visual-design.md` | hermes | — |
| `~/.hermes/skills/creative/manim-video/scripts/setup.sh` | `dot_hermes/skills/creative/manim-video/scripts/executable_setup.sh` | hermes | executable |
| `~/.hermes/skills/creative/p5js/README.md` | `dot_hermes/skills/creative/p5js/README.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/SKILL.md` | `dot_hermes/skills/creative/p5js/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/animation.md` | `dot_hermes/skills/creative/p5js/references/animation.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/color-systems.md` | `dot_hermes/skills/creative/p5js/references/color-systems.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/core-api.md` | `dot_hermes/skills/creative/p5js/references/core-api.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/export-pipeline.md` | `dot_hermes/skills/creative/p5js/references/export-pipeline.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/interaction.md` | `dot_hermes/skills/creative/p5js/references/interaction.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/shapes-and-geometry.md` | `dot_hermes/skills/creative/p5js/references/shapes-and-geometry.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/troubleshooting.md` | `dot_hermes/skills/creative/p5js/references/troubleshooting.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/typography.md` | `dot_hermes/skills/creative/p5js/references/typography.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/visual-effects.md` | `dot_hermes/skills/creative/p5js/references/visual-effects.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/references/webgl-and-3d.md` | `dot_hermes/skills/creative/p5js/references/webgl-and-3d.md` | hermes | — |
| `~/.hermes/skills/creative/p5js/scripts/export-frames.js` | `dot_hermes/skills/creative/p5js/scripts/executable_export-frames.js` | hermes | executable |
| `~/.hermes/skills/creative/p5js/scripts/render.sh` | `dot_hermes/skills/creative/p5js/scripts/executable_render.sh` | hermes | executable |
| `~/.hermes/skills/creative/p5js/scripts/serve.sh` | `dot_hermes/skills/creative/p5js/scripts/executable_serve.sh` | hermes | executable |
| `~/.hermes/skills/creative/p5js/scripts/setup.sh` | `dot_hermes/skills/creative/p5js/scripts/executable_setup.sh` | hermes | executable |
| `~/.hermes/skills/creative/p5js/templates/viewer.html` | `dot_hermes/skills/creative/p5js/templates/viewer.html` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/SKILL.md` | `dot_hermes/skills/creative/popular-web-designs/SKILL.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/airbnb.md` | `dot_hermes/skills/creative/popular-web-designs/templates/airbnb.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/airtable.md` | `dot_hermes/skills/creative/popular-web-designs/templates/airtable.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/apple.md` | `dot_hermes/skills/creative/popular-web-designs/templates/apple.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/bmw.md` | `dot_hermes/skills/creative/popular-web-designs/templates/bmw.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/cal.md` | `dot_hermes/skills/creative/popular-web-designs/templates/cal.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/claude.md` | `dot_hermes/skills/creative/popular-web-designs/templates/claude.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/clay.md` | `dot_hermes/skills/creative/popular-web-designs/templates/clay.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/clickhouse.md` | `dot_hermes/skills/creative/popular-web-designs/templates/clickhouse.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/cohere.md` | `dot_hermes/skills/creative/popular-web-designs/templates/cohere.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/coinbase.md` | `dot_hermes/skills/creative/popular-web-designs/templates/coinbase.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/composio.md` | `dot_hermes/skills/creative/popular-web-designs/templates/composio.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/cursor.md` | `dot_hermes/skills/creative/popular-web-designs/templates/cursor.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/elevenlabs.md` | `dot_hermes/skills/creative/popular-web-designs/templates/elevenlabs.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/expo.md` | `dot_hermes/skills/creative/popular-web-designs/templates/expo.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/figma.md` | `dot_hermes/skills/creative/popular-web-designs/templates/figma.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/framer.md` | `dot_hermes/skills/creative/popular-web-designs/templates/framer.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/hashicorp.md` | `dot_hermes/skills/creative/popular-web-designs/templates/hashicorp.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/ibm.md` | `dot_hermes/skills/creative/popular-web-designs/templates/ibm.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/intercom.md` | `dot_hermes/skills/creative/popular-web-designs/templates/intercom.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/kraken.md` | `dot_hermes/skills/creative/popular-web-designs/templates/kraken.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/linear.app.md` | `dot_hermes/skills/creative/popular-web-designs/templates/linear.app.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/lovable.md` | `dot_hermes/skills/creative/popular-web-designs/templates/lovable.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/minimax.md` | `dot_hermes/skills/creative/popular-web-designs/templates/minimax.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/mintlify.md` | `dot_hermes/skills/creative/popular-web-designs/templates/mintlify.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/miro.md` | `dot_hermes/skills/creative/popular-web-designs/templates/miro.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/mistral.ai.md` | `dot_hermes/skills/creative/popular-web-designs/templates/mistral.ai.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/mongodb.md` | `dot_hermes/skills/creative/popular-web-designs/templates/mongodb.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/notion.md` | `dot_hermes/skills/creative/popular-web-designs/templates/notion.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/nvidia.md` | `dot_hermes/skills/creative/popular-web-designs/templates/nvidia.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/ollama.md` | `dot_hermes/skills/creative/popular-web-designs/templates/ollama.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/opencode.ai.md` | `dot_hermes/skills/creative/popular-web-designs/templates/opencode.ai.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/pinterest.md` | `dot_hermes/skills/creative/popular-web-designs/templates/pinterest.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/posthog.md` | `dot_hermes/skills/creative/popular-web-designs/templates/posthog.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/raycast.md` | `dot_hermes/skills/creative/popular-web-designs/templates/raycast.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/replicate.md` | `dot_hermes/skills/creative/popular-web-designs/templates/replicate.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/resend.md` | `dot_hermes/skills/creative/popular-web-designs/templates/resend.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/revolut.md` | `dot_hermes/skills/creative/popular-web-designs/templates/revolut.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/runwayml.md` | `dot_hermes/skills/creative/popular-web-designs/templates/runwayml.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/sanity.md` | `dot_hermes/skills/creative/popular-web-designs/templates/sanity.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/sentry.md` | `dot_hermes/skills/creative/popular-web-designs/templates/sentry.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/spacex.md` | `dot_hermes/skills/creative/popular-web-designs/templates/spacex.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/spotify.md` | `dot_hermes/skills/creative/popular-web-designs/templates/spotify.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/stripe.md` | `dot_hermes/skills/creative/popular-web-designs/templates/stripe.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/supabase.md` | `dot_hermes/skills/creative/popular-web-designs/templates/supabase.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/superhuman.md` | `dot_hermes/skills/creative/popular-web-designs/templates/superhuman.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/together.ai.md` | `dot_hermes/skills/creative/popular-web-designs/templates/together.ai.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/uber.md` | `dot_hermes/skills/creative/popular-web-designs/templates/uber.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/vercel.md` | `dot_hermes/skills/creative/popular-web-designs/templates/vercel.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/voltagent.md` | `dot_hermes/skills/creative/popular-web-designs/templates/voltagent.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/warp.md` | `dot_hermes/skills/creative/popular-web-designs/templates/warp.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/webflow.md` | `dot_hermes/skills/creative/popular-web-designs/templates/webflow.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/wise.md` | `dot_hermes/skills/creative/popular-web-designs/templates/wise.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/x.ai.md` | `dot_hermes/skills/creative/popular-web-designs/templates/x.ai.md` | hermes | — |
| `~/.hermes/skills/creative/popular-web-designs/templates/zapier.md` | `dot_hermes/skills/creative/popular-web-designs/templates/zapier.md` | hermes | — |
| `~/.hermes/skills/creative/songwriting-and-ai-music/SKILL.md` | `dot_hermes/skills/creative/songwriting-and-ai-music/SKILL.md` | hermes | — |
| `~/.hermes/skills/devops/chezmoi-dotfiles/SKILL.md` | `dot_hermes/skills/devops/chezmoi-dotfiles/SKILL.md` | hermes | — |
| `~/.hermes/skills/devops/hermes-repo-devsetup/SKILL.md` | `dot_hermes/skills/devops/hermes-repo-devsetup/SKILL.md` | hermes | — |
| `~/.hermes/skills/devops/sdlc-review/SKILL.md` | `dot_hermes/skills/devops/sdlc-review/SKILL.md` | hermes | — |
| `~/.hermes/skills/email/DESCRIPTION.md` | `dot_hermes/skills/email/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/email/email-inbox-triage/SKILL.md` | `dot_hermes/skills/email/email-inbox-triage/SKILL.md` | hermes | — |
| `~/.hermes/skills/email/himalaya/SKILL.md` | `dot_hermes/skills/email/himalaya/SKILL.md` | hermes | — |
| `~/.hermes/skills/email/himalaya/references/configuration.md` | `dot_hermes/skills/email/himalaya/references/configuration.md` | hermes | — |
| `~/.hermes/skills/email/himalaya/references/message-composition.md` | `dot_hermes/skills/email/himalaya/references/message-composition.md` | hermes | — |
| `~/.hermes/skills/market-competitor-research/SKILL.md` | `dot_hermes/skills/market-competitor-research/SKILL.md` | hermes | — |
| `~/.hermes/skills/media/DESCRIPTION.md` | `dot_hermes/skills/media/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/media/gif-search/SKILL.md` | `dot_hermes/skills/media/gif-search/SKILL.md` | hermes | — |
| `~/.hermes/skills/media/songsee/SKILL.md` | `dot_hermes/skills/media/songsee/SKILL.md` | hermes | — |
| `~/.hermes/skills/media/youtube-content/SKILL.md` | `dot_hermes/skills/media/youtube-content/SKILL.md` | hermes | — |
| `~/.hermes/skills/media/youtube-content/references/output-formats.md` | `dot_hermes/skills/media/youtube-content/references/output-formats.md` | hermes | — |
| `~/.hermes/skills/media/youtube-content/scripts/fetch_transcript.py` | `dot_hermes/skills/media/youtube-content/scripts/fetch_transcript.py` | hermes | — |
| `~/.hermes/skills/note-taking/DESCRIPTION.md` | `dot_hermes/skills/note-taking/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/note-taking/obsidian/SKILL.md` | `dot_hermes/skills/note-taking/obsidian/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/DESCRIPTION.md` | `dot_hermes/skills/productivity/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/productivity/airtable/SKILL.md` | `dot_hermes/skills/productivity/airtable/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/box/SKILL.md` | `dot_hermes/skills/productivity/box/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/bulk-operations.md` | `dot_hermes/skills/productivity/box/references/bulk-operations.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/cli-guide.md` | `dot_hermes/skills/productivity/box/references/cli-guide.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/content-workflows.md` | `dot_hermes/skills/productivity/box/references/content-workflows.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/hubs.md` | `dot_hermes/skills/productivity/box/references/hubs.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/oauth-setup.md` | `dot_hermes/skills/productivity/box/references/oauth-setup.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/rest-api.md` | `dot_hermes/skills/productivity/box/references/rest-api.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/sdk-development.md` | `dot_hermes/skills/productivity/box/references/sdk-development.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/search-and-ai.md` | `dot_hermes/skills/productivity/box/references/search-and-ai.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/troubleshooting.md` | `dot_hermes/skills/productivity/box/references/troubleshooting.md` | hermes | — |
| `~/.hermes/skills/productivity/box/references/webhooks-and-events.md` | `dot_hermes/skills/productivity/box/references/webhooks-and-events.md` | hermes | — |
| `~/.hermes/skills/productivity/document-to-action-items/SKILL.md` | `dot_hermes/skills/productivity/document-to-action-items/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/docx/LICENSE` | `dot_hermes/skills/productivity/docx/LICENSE` | hermes | — |
| `~/.hermes/skills/productivity/docx/SKILL.md` | `dot_hermes/skills/productivity/docx/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/docx/references/revisions-and-comments.md` | `dot_hermes/skills/productivity/docx/references/revisions-and-comments.md` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_comments.py` | `dot_hermes/skills/productivity/docx/scripts/docx_comments.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_common.py` | `dot_hermes/skills/productivity/docx/scripts/docx_common.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_create.py` | `dot_hermes/skills/productivity/docx/scripts/docx_create.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_edit.py` | `dot_hermes/skills/productivity/docx/scripts/docx_edit.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_read.py` | `dot_hermes/skills/productivity/docx/scripts/docx_read.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_revisions.py` | `dot_hermes/skills/productivity/docx/scripts/docx_revisions.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_template.py` | `dot_hermes/skills/productivity/docx/scripts/docx_template.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/scripts/docx_validate.py` | `dot_hermes/skills/productivity/docx/scripts/docx_validate.py` | hermes | — |
| `~/.hermes/skills/productivity/docx/tests/test_docx_skill.py` | `dot_hermes/skills/productivity/docx/tests/test_docx_skill.py` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/SKILL.md` | `dot_hermes/skills/productivity/google-workspace/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/references/daily-brief.md` | `dot_hermes/skills/productivity/google-workspace/references/daily-brief.md` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/references/gmail-search-syntax.md` | `dot_hermes/skills/productivity/google-workspace/references/gmail-search-syntax.md` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/scripts/_hermes_home.py` | `dot_hermes/skills/productivity/google-workspace/scripts/_hermes_home.py` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/scripts/gws_bridge.py` | `dot_hermes/skills/productivity/google-workspace/scripts/executable_gws_bridge.py` | hermes | executable |
| `~/.hermes/skills/productivity/google-workspace/scripts/google_api.py` | `dot_hermes/skills/productivity/google-workspace/scripts/google_api.py` | hermes | — |
| `~/.hermes/skills/productivity/google-workspace/scripts/setup.py` | `dot_hermes/skills/productivity/google-workspace/scripts/setup.py` | hermes | — |
| `~/.hermes/skills/productivity/maps/SKILL.md` | `dot_hermes/skills/productivity/maps/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/maps/scripts/maps_client.py` | `dot_hermes/skills/productivity/maps/scripts/maps_client.py` | hermes | — |
| `~/.hermes/skills/productivity/meeting-action-items/SKILL.md` | `dot_hermes/skills/productivity/meeting-action-items/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/notion/SKILL.md` | `dot_hermes/skills/productivity/notion/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/notion/references/block-types.md` | `dot_hermes/skills/productivity/notion/references/block-types.md` | hermes | — |
| `~/.hermes/skills/productivity/pdf/LICENSE` | `dot_hermes/skills/productivity/pdf/LICENSE` | hermes | — |
| `~/.hermes/skills/productivity/pdf/SKILL.md` | `dot_hermes/skills/productivity/pdf/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/pdf/references/forms.md` | `dot_hermes/skills/productivity/pdf/references/forms.md` | hermes | — |
| `~/.hermes/skills/productivity/pdf/references/nano-pdf-editing.md` | `dot_hermes/skills/productivity/pdf/references/nano-pdf-editing.md` | hermes | — |
| `~/.hermes/skills/productivity/pdf/references/ocr-extraction.md` | `dot_hermes/skills/productivity/pdf/references/ocr-extraction.md` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/_raster.py` | `dot_hermes/skills/productivity/pdf/scripts/_raster.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/extract_marker.py` | `dot_hermes/skills/productivity/pdf/scripts/extract_marker.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/extract_pymupdf.py` | `dot_hermes/skills/productivity/pdf/scripts/extract_pymupdf.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_create.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_create.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_fill_form.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_fill_form.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_form_layout.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_form_layout.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_make_form.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_make_form.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_merge.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_merge.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_meta.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_meta.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_page_image.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_page_image.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_read.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_read.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_secure.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_secure.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_split.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_split.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_stamp.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_stamp.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/scripts/pdf_watermark.py` | `dot_hermes/skills/productivity/pdf/scripts/pdf_watermark.py` | hermes | — |
| `~/.hermes/skills/productivity/pdf/tests/test_pdf_skill.py` | `dot_hermes/skills/productivity/pdf/tests/test_pdf_skill.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/LICENSE` | `dot_hermes/skills/productivity/powerpoint/LICENSE` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/SKILL.md` | `dot_hermes/skills/productivity/powerpoint/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/scripts/pptx_create.py` | `dot_hermes/skills/productivity/powerpoint/scripts/pptx_create.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/scripts/pptx_edit.py` | `dot_hermes/skills/productivity/powerpoint/scripts/pptx_edit.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/scripts/pptx_from_template.py` | `dot_hermes/skills/productivity/powerpoint/scripts/pptx_from_template.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/scripts/pptx_read.py` | `dot_hermes/skills/productivity/powerpoint/scripts/pptx_read.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/scripts/pptx_render.py` | `dot_hermes/skills/productivity/powerpoint/scripts/pptx_render.py` | hermes | — |
| `~/.hermes/skills/productivity/powerpoint/tests/test_powerpoint_skill.py` | `dot_hermes/skills/productivity/powerpoint/tests/test_powerpoint_skill.py` | hermes | — |
| `~/.hermes/skills/productivity/product-price-monitor/SKILL.md` | `dot_hermes/skills/productivity/product-price-monitor/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/teams-meeting-pipeline/SKILL.md` | `dot_hermes/skills/productivity/teams-meeting-pipeline/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/weekly-review-planning/SKILL.md` | `dot_hermes/skills/productivity/weekly-review-planning/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/LICENSE` | `dot_hermes/skills/productivity/xlsx/LICENSE` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/SKILL.md` | `dot_hermes/skills/productivity/xlsx/SKILL.md` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/references/restructuring.md` | `dot_hermes/skills/productivity/xlsx/references/restructuring.md` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/csv_to_xlsx.py` | `dot_hermes/skills/productivity/xlsx/scripts/csv_to_xlsx.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_create.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_create.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_edit.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_edit.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_read.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_read.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_recalc.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_recalc.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_restructure.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_restructure.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/scripts/xlsx_to_csv.py` | `dot_hermes/skills/productivity/xlsx/scripts/xlsx_to_csv.py` | hermes | — |
| `~/.hermes/skills/productivity/xlsx/tests/test_xlsx_skill.py` | `dot_hermes/skills/productivity/xlsx/tests/test_xlsx_skill.py` | hermes | — |
| `~/.hermes/skills/ratatui-tui/SKILL.md` | `dot_hermes/skills/ratatui-tui/SKILL.md` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/async-app/Cargo.toml` | `dot_hermes/skills/ratatui-tui/assets/templates/async-app/Cargo.toml` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/async-app/src/main.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/async-app/src/main.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/Cargo.toml` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/Cargo.toml` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/action.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/action.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/app.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/app.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/config.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/config.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/event.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/event.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/logging.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/logging.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/main.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/main.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/tui.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/tui.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/component-app/src/ui.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/component-app/src/ui.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/hello-world/Cargo.toml` | `dot_hermes/skills/ratatui-tui/assets/templates/hello-world/Cargo.toml` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/hello-world/src/main.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/hello-world/src/main.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/simple-app/Cargo.toml` | `dot_hermes/skills/ratatui-tui/assets/templates/simple-app/Cargo.toml` | hermes | — |
| `~/.hermes/skills/ratatui-tui/assets/templates/simple-app/src/main.rs` | `dot_hermes/skills/ratatui-tui/assets/templates/simple-app/src/main.rs` | hermes | — |
| `~/.hermes/skills/ratatui-tui/references/architecture-patterns.md` | `dot_hermes/skills/ratatui-tui/references/architecture-patterns.md` | hermes | — |
| `~/.hermes/skills/ratatui-tui/references/async-patterns.md` | `dot_hermes/skills/ratatui-tui/references/async-patterns.md` | hermes | — |
| `~/.hermes/skills/ratatui-tui/references/image-integration.md` | `dot_hermes/skills/ratatui-tui/references/image-integration.md` | hermes | — |
| `~/.hermes/skills/ratatui-tui/references/style-guide.md` | `dot_hermes/skills/ratatui-tui/references/style-guide.md` | hermes | — |
| `~/.hermes/skills/ratatui-tui/workflows/tui-review.js` | `dot_hermes/skills/ratatui-tui/workflows/tui-review.js` | hermes | — |
| `~/.hermes/skills/repo-scaffold/SKILL.md` | `dot_hermes/skills/repo-scaffold/SKILL.md` | hermes | — |
| `~/.hermes/skills/research/DESCRIPTION.md` | `dot_hermes/skills/research/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/research/arxiv/SKILL.md` | `dot_hermes/skills/research/arxiv/SKILL.md` | hermes | — |
| `~/.hermes/skills/research/arxiv/scripts/search_arxiv.py` | `dot_hermes/skills/research/arxiv/scripts/search_arxiv.py` | hermes | — |
| `~/.hermes/skills/research/competitor-news-monitor/SKILL.md` | `dot_hermes/skills/research/competitor-news-monitor/SKILL.md` | hermes | — |
| `~/.hermes/skills/research/grounded-citations/SKILL.md` | `dot_hermes/skills/research/grounded-citations/SKILL.md` | hermes | — |
| `~/.hermes/skills/research/grounded-citations/references/citation-formats.md` | `dot_hermes/skills/research/grounded-citations/references/citation-formats.md` | hermes | — |
| `~/.hermes/skills/research/grounded-citations/references/grounding-rationale.md` | `dot_hermes/skills/research/grounded-citations/references/grounding-rationale.md` | hermes | — |
| `~/.hermes/skills/research/grounded-citations/scripts/_hermes_home.py` | `dot_hermes/skills/research/grounded-citations/scripts/_hermes_home.py` | hermes | — |
| `~/.hermes/skills/research/grounded-citations/scripts/sources.py` | `dot_hermes/skills/research/grounded-citations/scripts/sources.py` | hermes | — |
| `~/.hermes/skills/research/llm-wiki/SKILL.md` | `dot_hermes/skills/research/llm-wiki/SKILL.md` | hermes | — |
| `~/.hermes/skills/social-media/DESCRIPTION.md` | `dot_hermes/skills/social-media/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/social-media/xurl/SKILL.md` | `dot_hermes/skills/social-media/xurl/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/codebase-inspection/SKILL.md` | `dot_hermes/skills/software-development/codebase-inspection/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/dogfood/SKILL.md` | `dot_hermes/skills/software-development/dogfood/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/dogfood/references/issue-taxonomy.md` | `dot_hermes/skills/software-development/dogfood/references/issue-taxonomy.md` | hermes | — |
| `~/.hermes/skills/software-development/dogfood/templates/dogfood-report-template.md` | `dot_hermes/skills/software-development/dogfood/templates/dogfood-report-template.md` | hermes | — |
| `~/.hermes/skills/software-development/github/SKILL.md` | `dot_hermes/skills/software-development/github/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/auth.md` | `dot_hermes/skills/software-development/github/references/auth.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/ci-troubleshooting.md` | `dot_hermes/skills/software-development/github/references/ci-troubleshooting.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/code-review.md` | `dot_hermes/skills/software-development/github/references/code-review.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/conventional-commits.md` | `dot_hermes/skills/software-development/github/references/conventional-commits.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/github-api-cheatsheet.md` | `dot_hermes/skills/software-development/github/references/github-api-cheatsheet.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/issue-to-pr.md` | `dot_hermes/skills/software-development/github/references/issue-to-pr.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/issues.md` | `dot_hermes/skills/software-development/github/references/issues.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/pr-workflow.md` | `dot_hermes/skills/software-development/github/references/pr-workflow.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/repo-management.md` | `dot_hermes/skills/software-development/github/references/repo-management.md` | hermes | — |
| `~/.hermes/skills/software-development/github/references/review-output-template.md` | `dot_hermes/skills/software-development/github/references/review-output-template.md` | hermes | — |
| `~/.hermes/skills/software-development/github/scripts/gh-env.sh` | `dot_hermes/skills/software-development/github/scripts/executable_gh-env.sh` | hermes | executable |
| `~/.hermes/skills/software-development/github/scripts/git-credential-token.py` | `dot_hermes/skills/software-development/github/scripts/git-credential-token.py` | hermes | — |
| `~/.hermes/skills/software-development/github/templates/bug-report.md` | `dot_hermes/skills/software-development/github/templates/bug-report.md` | hermes | — |
| `~/.hermes/skills/software-development/github/templates/feature-request.md` | `dot_hermes/skills/software-development/github/templates/feature-request.md` | hermes | — |
| `~/.hermes/skills/software-development/github/templates/pr-body-bugfix.md` | `dot_hermes/skills/software-development/github/templates/pr-body-bugfix.md` | hermes | — |
| `~/.hermes/skills/software-development/github/templates/pr-body-feature.md` | `dot_hermes/skills/software-development/github/templates/pr-body-feature.md` | hermes | — |
| `~/.hermes/skills/software-development/grill-me/SKILL.md` | `dot_hermes/skills/software-development/grill-me/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/hermes-agent-skill-authoring/SKILL.md` | `dot_hermes/skills/software-development/hermes-agent-skill-authoring/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/hermes-repo-profiles/SKILL.md` | `dot_hermes/skills/software-development/hermes-repo-profiles/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/inspecting-hermes-desktop-dom/SKILL.md` | `dot_hermes/skills/software-development/inspecting-hermes-desktop-dom/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/node-inspect-debugger/SKILL.md` | `dot_hermes/skills/software-development/node-inspect-debugger/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/python-debugpy/SKILL.md` | `dot_hermes/skills/software-development/python-debugpy/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/requesting-code-review/SKILL.md` | `dot_hermes/skills/software-development/requesting-code-review/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/rust/SKILL.md` | `dot_hermes/skills/software-development/rust/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/simplify-code/SKILL.md` | `dot_hermes/skills/software-development/simplify-code/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/spike/SKILL.md` | `dot_hermes/skills/software-development/spike/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/subagent-driven-development/SKILL.md` | `dot_hermes/skills/software-development/subagent-driven-development/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/subagent-driven-development/references/context-budget-discipline.md` | `dot_hermes/skills/software-development/subagent-driven-development/references/context-budget-discipline.md` | hermes | — |
| `~/.hermes/skills/software-development/subagent-driven-development/references/gates-taxonomy.md` | `dot_hermes/skills/software-development/subagent-driven-development/references/gates-taxonomy.md` | hermes | — |
| `~/.hermes/skills/software-development/systematic-debugging/SKILL.md` | `dot_hermes/skills/software-development/systematic-debugging/SKILL.md` | hermes | — |
| `~/.hermes/skills/software-development/test-driven-development/SKILL.md` | `dot_hermes/skills/software-development/test-driven-development/SKILL.md` | hermes | — |
| `~/.hermes/skills/sqlite/SKILL.md` | `dot_hermes/skills/sqlite/SKILL.md` | hermes | — |
| `~/.hermes/skills/sqlite/_meta.json` | `dot_hermes/skills/sqlite/_meta.json` | hermes | — |
| `~/.hermes/skills/sqlite/skill-card.md` | `dot_hermes/skills/sqlite/skill-card.md` | hermes | — |
| `~/.hermes/skills/agent-reach` | `dot_hermes/skills/symlink_agent-reach` | hermes | symlink |
| `~/.hermes/skills/ai-image-generation` | `dot_hermes/skills/symlink_ai-image-generation` | hermes | symlink |
| `~/.hermes/skills/animate` | `dot_hermes/skills/symlink_animate` | hermes | symlink |
| `~/.hermes/skills/animate-expo` | `dot_hermes/skills/symlink_animate-expo` | hermes | symlink |
| `~/.hermes/skills/animation-vocabulary` | `dot_hermes/skills/symlink_animation-vocabulary` | hermes | symlink |
| `~/.hermes/skills/apple-design` | `dot_hermes/skills/symlink_apple-design` | hermes | symlink |
| `~/.hermes/skills/ask-sonner` | `dot_hermes/skills/symlink_ask-sonner` | hermes | symlink |
| `~/.hermes/skills/editor` | `dot_hermes/skills/symlink_editor` | hermes | symlink |
| `~/.hermes/skills/emil-design-eng` | `dot_hermes/skills/symlink_emil-design-eng` | hermes | symlink |
| `~/.hermes/skills/find-animation-opportunities` | `dot_hermes/skills/symlink_find-animation-opportunities` | hermes | symlink |
| `~/.hermes/skills/flyai` | `dot_hermes/skills/symlink_flyai` | hermes | symlink |
| `~/.hermes/skills/improve-animations` | `dot_hermes/skills/symlink_improve-animations` | hermes | symlink |
| `~/.hermes/skills/pick-ui-library` | `dot_hermes/skills/symlink_pick-ui-library` | hermes | symlink |
| `~/.hermes/skills/review-animations` | `dot_hermes/skills/symlink_review-animations` | hermes | symlink |
| `~/.hermes/skills/supabase` | `dot_hermes/skills/symlink_supabase` | hermes | symlink |
| `~/.hermes/skills/supabase-postgres-best-practices` | `dot_hermes/skills/symlink_supabase-postgres-best-practices` | hermes | symlink |
| `~/.hermes/skills/unlazy` | `dot_hermes/skills/symlink_unlazy` | hermes | symlink |
| `~/.hermes/skills/watch` | `dot_hermes/skills/symlink_watch` | hermes | symlink |
| `~/.hermes/skills/write-swift` | `dot_hermes/skills/symlink_write-swift` | hermes | symlink |
| `~/.hermes/skills/web-development/scrollcraft/LICENSE.txt` | `dot_hermes/skills/web-development/scrollcraft/LICENSE.txt` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/SKILL.md` | `dot_hermes/skills/web-development/scrollcraft/SKILL.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/engine/scrollcraft.css` | `dot_hermes/skills/web-development/scrollcraft/engine/scrollcraft.css` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/engine/scrollcraft.js` | `dot_hermes/skills/web-development/scrollcraft/engine/scrollcraft.js` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/assets.md` | `dot_hermes/skills/web-development/scrollcraft/references/assets.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/device-diag.html` | `dot_hermes/skills/web-development/scrollcraft/references/device-diag.html` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/devices.md` | `dot_hermes/skills/web-development/scrollcraft/references/devices.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/feel.md` | `dot_hermes/skills/web-development/scrollcraft/references/feel.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/taste.md` | `dot_hermes/skills/web-development/scrollcraft/references/taste.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/template.html` | `dot_hermes/skills/web-development/scrollcraft/references/template.html` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/uniqueness.md` | `dot_hermes/skills/web-development/scrollcraft/references/uniqueness.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/verify.md` | `dot_hermes/skills/web-development/scrollcraft/references/verify.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/worldflight.md` | `dot_hermes/skills/web-development/scrollcraft/references/worldflight.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/references/worlds.md` | `dot_hermes/skills/web-development/scrollcraft/references/worlds.md` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/doctor.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/doctor.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/encode.sh` | `dot_hermes/skills/web-development/scrollcraft/scripts/encode.sh` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/kie.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/kie.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/serve.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/serve.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/shoot.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/shoot.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/workspace.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/workspace.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/scripts/worldflight-assert.mjs` | `dot_hermes/skills/web-development/scrollcraft/scripts/worldflight-assert.mjs` | hermes | — |
| `~/.hermes/skills/web-development/scrollcraft/templates/FINGERPRINTS.md` | `dot_hermes/skills/web-development/scrollcraft/templates/FINGERPRINTS.md` | hermes | — |
| `~/.hermes/skills/web/DESCRIPTION.md` | `dot_hermes/skills/web/DESCRIPTION.md` | hermes | — |
| `~/.hermes/skills/web/blocked-page-recovery/SKILL.md` | `dot_hermes/skills/web/blocked-page-recovery/SKILL.md` | hermes | — |
| `~/.hermes/skills/web/blocked-page-recovery/scripts/recover_page.py` | `dot_hermes/skills/web/blocked-page-recovery/scripts/recover_page.py` | hermes | — |
| `~/.pi/agent/skills/project-doc-planner` | `dot_pi/agent/skills/symlink_project-doc-planner` | pi | symlink |
| `~/.grokbot/settings.json` | `private_dot_grokbot/settings.json` | grokbot | private |

## Background services

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/environment.d/10-defaults.conf` | `dot_config/environment.d/10-defaults.conf` | session environment | — |
| `~/.config/environment.d/10-machine.conf` | `dot_config/environment.d/10-machine.conf.tmpl` | session environment | template |
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
| `~/.local/bin/dots-theme-import-aether` | `dot_local/bin/executable_dots-theme-import-aether` | custom executables | executable |
| `~/.local/bin/herdr-agent-lifecycle` | `dot_local/bin/executable_herdr-agent-lifecycle` | custom executables | executable |
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
| `~/.local/bin/evot` | `dot_local/bin/symlink_evot` | custom executables | symlink |

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
| `~/.chezmoitemplates/littlebigmouse/Current.xml` | `.chezmoitemplates/littlebigmouse/Current.xml` | — | — |
| `~/.chezmoitemplates/machine-theme-name` | `.chezmoitemplates/machine-theme-name.tmpl` | — | template |
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
| `~/.yamllint.yml` | `.yamllint.yml` | — | — |
| `~/.config/apt/pkglist.txt` | `dot_config/apt/pkglist.txt` | — | — |
| `~/.config/bat/config` | `dot_config/bat/config` | — | — |
| `~/.config/bat/themes/dots.tmTheme` | `dot_config/bat/themes/dots.tmTheme.tmpl` | — | template |
| `~/.config/delta/theme.gitconfig` | `dot_config/delta/theme.gitconfig.tmpl` | — | template |
| `~/.config/eza/theme.yml` | `dot_config/eza/theme.yml.tmpl` | — | template |
| `~/.config/fzf/theme.sh` | `dot_config/fzf/theme.sh.tmpl` | — | template |
| `~/.config/hyprshell/config.ron` | `dot_config/hyprshell/config.ron` | — | — |
| `~/.config/hyprshell/styles.css` | `dot_config/hyprshell/styles.css` | — | — |
| `~/.local/share/figlet/README.md` | `dot_local/share/figlet/README.md` | — | — |
| `~/.local/share/figlet/Roman.flf` | `dot_local/share/figlet/Roman.flf` | — | — |
| `~/.local/share/omarchy-patches/esemczak.theme-modes-profiles.patch` | `dot_local/share/omarchy-patches/esemczak.theme-modes-profiles.patch` | — | — |
| `~/.local/share/wsl-ssh-bridge/main.go` | `dot_local/share/wsl-ssh-bridge/main.go` | — | — |
| `~/install.sh` | `install.sh` | — | — |
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
| `.chezmoidata/hermes_skills.yaml` | Controls how chezmoi renders and applies this tree |
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
| `docs/test_shell_modules.py` | Recovery guide and repository maintenance scripts |
| `docs/vespasian-boot.md` | Recovery guide and repository maintenance scripts |
| `docs/vespasian-theming.md` | Recovery guide and repository maintenance scripts |
| `dotfiles-showcase` | Submodule — the showcase web app; never applied |
| `package.json` | Runtime CLI deps installed outside mise |
| `setup.sh` | Interactive new machine onboarding & setup wizard |
