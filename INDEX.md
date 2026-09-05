# Dotfiles Index

<!-- GENERATED FILE — DO NOT EDIT. Regenerate with `python3 docs/generate_index.py`; CI gates freshness. -->

> **Generated file — do not edit.** Produced by `docs/generate_index.py`
> from `git ls-files`. Run `python3 docs/generate_index.py` after adding or
> moving a file; CI fails when this file is stale.

Machine-readable equivalent: [`INDEX.json`](INDEX.json) — that is the file
agents and the showcase app should read. This page is the same data for humans.

**219 tracked entries** across 15 categories.

| Category | Entries |
| --- | ---: |
| [Shell](#shell) | 13 |
| [Prompt](#prompt) | 1 |
| [Terminal & multiplexer](#terminal--multiplexer) | 4 |
| [Editors](#editors) | 12 |
| [Desktop & window manager](#desktop--window-manager) | 58 |
| [Version control](#version-control) | 4 |
| [Navigation & search](#navigation--search) | 3 |
| [Toolchain & packages](#toolchain--packages) | 4 |
| [AI agent harnesses](#ai-agent-harnesses) | 41 |
| [Background services](#background-services) | 14 |
| [Custom executables](#custom-executables) | 27 |
| [Credentials & SSH](#credentials--ssh) | 2 |
| [Apply hooks (`run_*`)](#apply-hooks-run) | 13 |
| [Chezmoi control files](#chezmoi-control-files) | 7 |
| [Repository material (not applied)](#repository-material-not-applied) | 16 |

---

## Shell

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.bash_profile` | `dot_bash_profile` | bash | — |
| `~/.bashrc` | `dot_bashrc` | bash | — |
| `~/.config/shell/00-env.sh` | `dot_config/shell/00-env.sh` | shared shell modules | — |
| `~/.config/shell/10-tools.sh` | `dot_config/shell/10-tools.sh` | shared shell modules | — |
| `~/.config/shell/20-integrations.sh` | `dot_config/shell/20-integrations.sh` | shared shell modules | — |
| `~/.config/shell/30-navigation.sh` | `dot_config/shell/30-navigation.sh` | shared shell modules | — |
| `~/.config/shell/40-aliases.sh` | `dot_config/shell/40-aliases.sh` | shared shell modules | — |
| `~/.config/shell/50-agents.sh` | `dot_config/shell/50-agents.sh` | shared shell modules | — |
| `~/.config/shell/55-apps.sh` | `dot_config/shell/55-apps.sh` | shared shell modules | — |
| `~/.config/shell/60-prompt.sh` | `dot_config/shell/60-prompt.sh` | shared shell modules | — |
| `~/.config/shell/70-cloud.sh` | `dot_config/shell/70-cloud.sh` | shared shell modules | — |
| `~/.config/shell/README.md` | `dot_config/shell/README.md` | shared shell modules | — |
| `~/.zshrc` | `dot_zshrc` | zsh | — |

## Prompt

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/starship.toml` | `dot_config/starship.toml.tmpl` | starship | template |

## Terminal & multiplexer

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/btop/btop.conf` | `dot_config/btop/btop.conf` | btop | — |
| `~/.config/ghostty/config` | `dot_config/ghostty/config` | ghostty | — |
| `~/.config/herdr/config.toml` | `dot_config/herdr/config.toml.tmpl` | herdr multiplexer | template |
| `~/.config/herdr/plugins.json` | `dot_config/herdr/plugins.json.tmpl` | herdr multiplexer | template |

## Editors

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/nvim/lazy-lock.json` | `dot_config/nvim/lazy-lock.json` | neovim / LazyVim | — |
| `~/.config/nvim/lazyvim.json` | `dot_config/nvim/lazyvim.json` | neovim / LazyVim | — |
| `~/.config/nvim/lua/config/keymaps.lua` | `dot_config/nvim/lua/config/keymaps.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/blink-cmp.lua` | `dot_config/nvim/lua/plugins/blink-cmp.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/copilot-lualine.lua` | `dot_config/nvim/lua/plugins/copilot-lualine.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/copilot.lua` | `dot_config/nvim/lua/plugins/copilot.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/html-preview.lua` | `dot_config/nvim/lua/plugins/empty_html-preview.lua` | neovim / LazyVim | empty |
| `~/.config/nvim/lua/plugins/example.lua` | `dot_config/nvim/lua/plugins/example.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/faster-smear-cursor.lua` | `dot_config/nvim/lua/plugins/faster-smear-cursor.lua` | neovim / LazyVim | — |
| `~/.config/nvim/lua/plugins/mini-animate-disable-cursor.lua` | `dot_config/nvim/lua/plugins/mini-animate-disable-cursor.lua` | neovim / LazyVim | — |
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
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/aether.zed.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/aether.zed.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/alacritty.toml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/alacritty.toml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/backgrounds/5d0e5451240b8b7f.jpg` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/backgrounds/5d0e5451240b8b7f.jpg` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/btop.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/btop.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/chromium.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/chromium.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/colors.toml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/colors.toml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/foot.ini` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/foot.ini` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/ghostty.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/ghostty.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/hyprland.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/hyprland.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/hyprlock.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/hyprlock.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/icons.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/icons.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/kitty.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/kitty.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/mako.ini` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/mako.ini` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/neovim.lua` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/neovim.lua` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/swayosd.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/swayosd.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vencord.theme.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vencord.theme.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode-extension/package.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode-extension/package.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode-extension/themes/aether-color-theme.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode-extension/themes/aether-color-theme.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/vscode.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/walker.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/walker.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/warp.yaml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/warp.yaml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/waybar.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/waybar.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/wofi.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/wofi.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/zellij.kdl` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-aether/zellij.kdl` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/aether.zed.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/aether.zed.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/alacritty.toml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/alacritty.toml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/backgrounds/5d0e5451240b8b7f.jpg` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/backgrounds/5d0e5451240b8b7f.jpg` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/btop.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/btop.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/chromium.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/chromium.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/colors.toml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/colors.toml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/foot.ini` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/foot.ini` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/ghostty.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/ghostty.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/hyprland.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/hyprland.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/hyprlock.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/hyprlock.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/icons.theme` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/icons.theme` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/kitty.conf` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/kitty.conf` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/mako.ini` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/mako.ini` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/neovim.lua` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/neovim.lua` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/swayosd.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/swayosd.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vencord.theme.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vencord.theme.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode-extension/package.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode-extension/package.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode-extension/themes/aether-color-theme.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode-extension/themes/aether-color-theme.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode.json` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/vscode.json` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/walker.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/walker.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/warp.yaml` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/warp.yaml` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/waybar.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/waybar.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/wofi.css` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/wofi.css` | omarchy | — |
| `~/.config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/zellij.kdl` | `dot_config/omarchy/themes/red-mountain-peaks-at-dusk-01-red-palette/zellij.kdl` | omarchy | — |
| `~/.local/share/applications/cursor-desktop.desktop` | `dot_local/share/applications/cursor-desktop.desktop` | desktop entries | — |

## Version control

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/gh/config.yml` | `dot_config/gh/config.yml` | github cli | — |
| `~/.config/git/config` | `dot_config/git/config.tmpl` | git | template |
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
| `~/.codex/AGENTS.md` | `dot_codex/private_AGENTS.md` | codex | private |
| `~/.codex/config.toml` | `dot_codex/private_config.toml` | codex | private |
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
| `~/.gemini/GEMINI.md` | `dot_gemini/private_GEMINI.md` | gemini | private |
| `~/.gemini/settings.json` | `dot_gemini/private_settings.json` | gemini | private |
| `~/.gemini/skills/project-doc-planner` | `dot_gemini/skills/symlink_project-doc-planner` | gemini | symlink |
| `~/.grok/hooks/herdr-agent-state.sh` | `dot_grok/hooks/executable_herdr-agent-state.sh` | grok | executable |
| `~/.grok/hooks/herdr.json` | `dot_grok/hooks/herdr.json` | grok | — |
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
| `~/.config/systemd/user/omarchy-cline-usage-scrape.service` | `dot_config/systemd/user/omarchy-cline-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cline-usage-scrape.timer` | `dot_config/systemd/user/omarchy-cline-usage-scrape.timer` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cursor-usage-scrape.service` | `dot_config/systemd/user/omarchy-cursor-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-cursor-usage-scrape.timer` | `dot_config/systemd/user/omarchy-cursor-usage-scrape.timer` | user systemd units | — |
| `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.service` | `dot_config/systemd/user/omarchy-opencode-go-usage-scrape.service` | user systemd units | — |
| `~/.config/systemd/user/omarchy-opencode-go-usage-scrape.timer` | `dot_config/systemd/user/omarchy-opencode-go-usage-scrape.timer` | user systemd units | — |

## Custom executables

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.local/bin/cline-safety/git` | `dot_local/bin/cline-safety/executable_git` | cline git interceptor | executable |
| `~/.local/bin/cursor` | `dot_local/bin/executable_cursor` | custom executables | executable |
| `~/.local/bin/dots` | `dot_local/bin/executable_dots` | custom executables | executable |
| `~/.local/bin/dots-push` | `dot_local/bin/executable_dots-push` | custom executables | executable |
| `~/.local/bin/grok` | `dot_local/bin/executable_grok` | custom executables | executable |
| `~/.local/bin/lazygit-ollama-commit.sh` | `dot_local/bin/executable_lazygit-ollama-commit.sh` | custom executables | executable |
| `~/.local/bin/ollama-commit-msg.sh` | `dot_local/bin/executable_ollama-commit-msg.sh` | custom executables | executable |
| `~/.local/bin/omarchy-agent-usage-antigravity` | `dot_local/bin/executable_omarchy-agent-usage-antigravity.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-cline` | `dot_local/bin/executable_omarchy-agent-usage-cline.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-codex` | `dot_local/bin/executable_omarchy-agent-usage-codex.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-cursor` | `dot_local/bin/executable_omarchy-agent-usage-cursor.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-opencode` | `dot_local/bin/executable_omarchy-agent-usage-opencode.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent-usage-update` | `dot_local/bin/executable_omarchy-agent-usage-update.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-agent` | `dot_local/bin/executable_omarchy-agent.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cline-usage-login` | `dot_local/bin/executable_omarchy-cline-usage-login.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cline-usage-override` | `dot_local/bin/executable_omarchy-cline-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cline-usage-scrape` | `dot_local/bin/executable_omarchy-cline-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-statusline` | `dot_local/bin/executable_omarchy-cursor-statusline.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-usage-override` | `dot_local/bin/executable_omarchy-cursor-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-cursor-usage-scrape` | `dot_local/bin/executable_omarchy-cursor-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-default-agent` | `dot_local/bin/executable_omarchy-default-agent.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-dotfiles-sync` | `dot_local/bin/executable_omarchy-dotfiles-sync` | custom executables | executable |
| `~/.local/bin/omarchy-opencode-go-usage-login` | `dot_local/bin/executable_omarchy-opencode-go-usage-login.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-opencode-go-usage-override` | `dot_local/bin/executable_omarchy-opencode-go-usage-override.tmpl` | custom executables | executable, template |
| `~/.local/bin/omarchy-opencode-go-usage-scrape` | `dot_local/bin/executable_omarchy-opencode-go-usage-scrape.tmpl` | custom executables | executable, template |
| `~/.local/bin/statusline` | `dot_local/bin/executable_statusline.tmpl` | custom executables | executable, template |
| `~/.local/bin/evot` | `dot_local/bin/symlink_evot` | custom executables | symlink |

## Credentials & SSH

| Target | Source | Subsystem | Attributes |
| --- | --- | --- | --- |
| `~/.config/1password/ssh/agent.toml` | `dot_config/1password/ssh/agent.toml` | 1password | — |
| `~/.ssh/config` | `private_dot_ssh/config` | ssh | private |

## Apply hooks (`run_*`)

| Order | Source | Trigger | Phase |
| ---: | --- | --- | --- |
| 00 | `run_once_before_00-verify-deps.sh.tmpl` | runs once ever | before |
| 09 | `run_onchange_before_09-install-agent-skills.sh.tmpl` | runs when this script's contents change | before |
| 10 | `run_onchange_after_10-install-omarchy-plugins.sh.tmpl` | runs when this script's contents change | after |
| 20 | `run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl` | runs when this script's contents change | after |
| 21 | `run_onchange_after_21-setup-omarchy-cline.sh.tmpl` | runs when this script's contents change | after |
| 22 | `run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl` | runs when this script's contents change | after |
| 23 | `run_after_23-sync-agent-skills.sh.tmpl` | runs after every apply | after |
| 24 | `run_once_after_24-setup-omarchy-agents.sh.tmpl` | runs once ever | after |
| 25 | `run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl` | runs when this script's contents change | after |
| 26 | `run_onchange_after_26-setup-omarchy-cursor.sh.tmpl` | runs when this script's contents change | after |
| 27 | `run_onchange_after_27-sync-claude-mcp.sh.tmpl` | runs when this script's contents change | after |
| 28 | `run_onchange_after_28-sync-claude-settings.sh.tmpl` | runs when this script's contents change | after |
| 30 | `run_onchange_after_30-macos-defaults.sh.tmpl` | runs when this script's contents change | after |

## Chezmoi control files

| Path | Role |
| --- | --- |
| `.chezmoi.toml.tmpl` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/agent_skills.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/claude_mcp.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/claude_settings.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/machines.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoidata/omarchy_plugins.yaml` | Controls how chezmoi renders and applies this tree |
| `.chezmoiignore.tmpl` | Controls how chezmoi renders and applies this tree |

## Repository material (not applied)

| Path | Role |
| --- | --- |
| `.github/workflows/ci.yml` | CI workflows |
| `.gitignore` | Git tracking rules |
| `.gitmodules` | Submodule registration |
| `AGENTS.md` | Authoritative contract for agents working in this repo |
| `Documents/Cline/Workflows/usage.md` | Non-config content (Cline workflow docs) |
| `INDEX.json` | Generated machine-readable index (this artifact) |
| `INDEX.md` | Generated human-readable index (this artifact) |
| `README.md` | Human-facing repository overview |
| `bun.lock` | Lockfile for the above |
| `docs/generate_index.py` | Recovery guide and repository maintenance scripts |
| `docs/generate_readme_tree.py` | Recovery guide and repository maintenance scripts |
| `docs/recovery.md` | Recovery guide and repository maintenance scripts |
| `docs/reorganization-proposal.md` | Recovery guide and repository maintenance scripts |
| `dotfiles-showcase` | Submodule — the showcase web app; never applied |
| `package.json` | Runtime CLI deps installed outside mise |
| `to-questionnaire-dotfiles-sync-cli.md` | Scratch planning documents |
