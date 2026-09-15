# Dotfiles

This repository manages personal dotfiles across Linux and macOS.
It uses [chezmoi](https://www.chezmoi.io/) for configuration management.
It uses [age](https://github.com/FiloSottile/age) for secret encryption.
It keeps tools, editors, and shells aligned across multiple workstations.

## Quick Start

### New Machine Setup

Run the interactive setup wizard to inspect system information, clarify machine profiles, and configure all tools and dotfiles:

```bash
# Clone and run the interactive setup wizard:
git clone https://github.com/harlanljones/dotfiles.git ~/.local/share/chezmoi
~/.local/share/chezmoi/setup.sh

# Or on an existing setup, re-run onboarding anytime:
dots setup
```

Alternatively, initialize directly with chezmoi:

```bash
chezmoi init --apply https://github.com/harlanljones/dotfiles.git
```

The setup scripts check system info automatically, prompt for any missing dependencies or machine choices interactively, and verify age encryption keys.
For full recovery instructions, see [docs/recovery.md](docs/recovery.md).

### Daily Workflow

You can manage your configuration using the `dots` wrapper:

```bash
dots status       # Check for local file changes
dots diff         # Review pending changes
dots sync         # Apply repository changes to your home directory
dots push         # Commit with an AI-generated message and push to git
```

You can also run standard chezmoi commands directly:

```bash
chezmoi status    # Show modified files
chezmoi diff      # Show file diffs
chezmoi apply     # Apply changes to home
chezmoi update    # Pull remote changes and apply
```

## The `dots` CLI

The repository provides an ergonomic command-line helper named `dots`.
It wraps common chezmoi commands to simplify daily tasks.

| Command | Description |
| :--- | :--- |
| `dots sync` | Applies managed files to your home directory. |
| `dots diff` | Displays pending changes between the repo and your home directory. |
| `dots status` | Displays the status of modified, added, or untracked files. |
| `dots absorb <file>` | Captures modified local files back into the chezmoi repository. |
| `dots edit <file>` | Opens the source template for a managed file in your editor. |
| `dots update` | Pulls the latest changes from git and applies them. |
| `dots push` | Adds modified files, generates a commit message, and pushes to git. |
| `dots theme` | Lists available color themes or switches the active theme. |
| `dots doctor` | Runs health checks on tools, encryption keys, and agent skills. |
| `dots setup` | Runs the interactive system onboarding and setup wizard. |
| `dots cd` | Opens a shell inside the chezmoi source directory. |

The `dots push` command uses a local Ollama model to write conventional commit messages.
If Ollama is unavailable, it falls back to a clean default message.

## Target Machines

The repository detects your machine automatically by hostname or operating system.
Templates adjust settings to match each system.

| Machine | Environment | Primary Role |
| :--- | :--- | :--- |
| **Augustus** | Arch Linux (Omarchy) | Main Linux desktop with Hyprland. |
| **Hadrian** | macOS (Apple Silicon) | MacBook Pro portable workstation. |
| **Vespasian** | Ubuntu 24.04 on WSL2 | Windows workstation development environment. |

Machine definitions live in `.chezmoidata/machines.yaml`.
Platform ignore rules live in `.chezmoiignore.tmpl`.
Templates render only the files needed for the current operating system.

## Core Subsystems

### Shell and Terminal

The shell environment works identically across bash and zsh.
Modular shell scripts live in `~/.config/shell/`.
They load environment variables, navigation helpers, aliases, and tool hooks.
The prompt uses [Starship](https://starship.rs/).
The prompt turns red when a command fails.
The terminal multiplexer is [Herdr](https://github.com/harlanljones/herdr-outpost).
Herdr provides tmux-compatible keybindings and workspace navigation.
On Vespasian, WezTerm runs as the preferred native GPU-accelerated Windows terminal launching directly into WSL; Windows Terminal remains available as the `Alt+Enter` fallback.

### Editor

The primary editor is [Neovim](https://neovim.io/).
It runs a [LazyVim](https://www.lazyvim.org/) distribution.
Configurations live in `~/.config/nvim/`.
Neovim includes language support for TypeScript, Python, Tailwind, Markdown, and Lua.
It uses `blink.cmp` for auto-completion.

### AI Coding Agents

The repository provides shared configuration for multiple AI coding tools.
Supported agents include Claude Code, Codex, Cursor, Google Antigravity, Cline, and OpenCode.
Shared agent skills live in `~/.agents/skills/`.
A unified status line displays active models and token costs across Claude Code, Cursor, and Codex.
Safety rules prevent automated agents from pushing or committing to git directly.

### Tool Management

Tool versions are managed declaratively with [mise](https://mise.jdx.dev/).
Configuration lives in `~/.config/mise/config.toml`.
Mise manages runtimes for Node.js, Bun, Python, Go, and Terraform.
System package manifests live in `dot_config/pacman/`, `dot_config/apt/`, and `dot_Brewfile`.
Health checks verify that required mise tools are installed on the local system.

### Unified Theming

The entire environment shares a consistent color palette.
The default theme is Tokyo Night.
Theme settings synchronize across Ghostty, WezTerm, Windows Terminal, Neovim, lazygit, delta, bat, eza, and fzf.
On Windows WSL2 systems, WezTerm runs natively on Windows with DirectWrite rendering and connects directly into WSL Ubuntu by default, with Windows Terminal retained as a fallback.

You can switch themes across all tools by running:

```bash
dots theme set <theme-name>
dots theme              # List all available themes
dots theme inspect <name>  # Show theme details and palette
```

#### Aether Integration

The repository includes an Aether/Omarchy importer that bridges public themes from Omarchy into Vespasian's Windows environment without requiring Aether or Omarchy to be installed locally. Four public Omarchy themes are included as fixtures:

- `omarchy-tokyo-night` — Tokyo Night from basecamp/omarchy
- `omarchy-kanagawa` — Kanagawa from basecamp/omarchy
- `omarchy-everforest` — Everforest from basecamp/omarchy
- `omarchy-nord` — Nord from basecamp/omarchy

Each theme includes generated adapters for all terminal tools, a Windows Terminal color scheme, CSS styling for the desktop taskbar (Zebar), and a procedurally generated wallpaper gradient.

#### Vespasian (Windows WSL2) Theming

On Vespasian, theming extends to Windows surfaces:

- **Dark/light mode sync:** Windows Registry is updated and a `WM_SETTINGCHANGE` broadcast notifies running apps (Settings, Notepad, Windows Terminal, VS Code, etc.) to refresh immediately without restarting.
- **Desktop wallpaper:** Procedurally generated from the theme palette (deterministic gradient from dark background to accent color).
- **Windows Terminal:** Color scheme, profile settings, opacity, and acrylic effects.
- **GlazeWM:** Window manager borders use theme accent (focused) and muted colors (unfocused).
- **Zebar:** Theme-driven CSS styling for the status bar.

Vespasian's Windows GUI tools start at Windows logon. A hidden scheduled task
keeps the WSL instance alive so portable user services can start under systemd;
see [`docs/vespasian-boot.md`](docs/vespasian-boot.md).

See [`docs/vespasian-theming.md`](docs/vespasian-theming.md) for detailed Vespasian setup and troubleshooting.

## Documentation and Index

The repository includes several guides for maintenance and recovery:

- [`INDEX.md`](INDEX.md): A complete categorized directory of all tracked dotfiles.
- [`docs/recovery.md`](docs/recovery.md): Step-by-step disaster recovery and age key management.
- [`dot_config/shell/README.md`](dot_config/shell/README.md): Detailed guide to the modular shell setup.
- [`docs/vespasian-boot.md`](docs/vespasian-boot.md): WSL2 boot model, keepalive background task, and desktop keybindings for Windows.
- [`docs/vespasian-theming.md`](docs/vespasian-theming.md): Cross-platform theme synchronization across Windows, Windows Terminal, and GlazeWM/Zebar.
- [`docs/agents/issue-tracker.md`](docs/agents/issue-tracker.md): Guide for coding agent coordination.

The index file `INDEX.md` is generated automatically by `docs/generate_index.py`.

## 📂 Repository Structure

<!-- BEGIN REPO TREE (generated by docs/generate_readme_tree.py) -->
```text
.
├── .chezmoi.toml.tmpl
├── .chezmoidata
│   ├── agent_skills.yaml
│   ├── claude_mcp.yaml
│   ├── claude_settings.yaml
│   ├── codex_projects.yaml
│   ├── hermes_skills.yaml
│   ├── machines.yaml
│   ├── omarchy_plugins.yaml
│   └── themes.yaml
├── .chezmoiignore.tmpl
├── .chezmoitemplates
│   ├── aether-adapters
│   │   ├── bat.tmTheme.tmpl
│   │   ├── delta.gitconfig.tmpl
│   │   ├── eza.yml.tmpl
│   │   ├── fzf.sh.tmpl
│   │   ├── gemini.json.tmpl
│   │   ├── lazygit.yml.tmpl
│   │   ├── manifest.yaml.tmpl
│   │   ├── nvim.lua.tmpl
│   │   ├── windows_terminal.json.tmpl
│   │   └── zebar.css.tmpl
│   ├── codex-config.toml
│   ├── gemini-settings.json
│   ├── littlebigmouse
│   │   └── Current.xml
│   └── themes
│       ├── omarchy-catppuccin
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-catppuccin-latte
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-everforest
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-gruvbox
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-kanagawa
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-nord
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-rose-pine
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── omarchy-tokyo-night
│       │   ├── bat.tmTheme
│       │   ├── colors.toml
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── manifest.yaml
│       │   ├── nvim.lua
│       │   ├── windows_terminal.json
│       │   └── zebar.css
│       ├── tokyonight-day
│       │   ├── bat.tmTheme
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── wallpaper.png
│       │   └── windows_terminal.json
│       ├── tokyonight-moon
│       │   ├── bat.tmTheme
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── wallpaper.png
│       │   └── windows_terminal.json
│       ├── tokyonight-night
│       │   ├── bat.tmTheme
│       │   ├── delta.gitconfig
│       │   ├── eza.yml
│       │   ├── fzf.sh
│       │   ├── gemini.json
│       │   ├── lazygit.yml
│       │   ├── wallpaper.png
│       │   └── windows_terminal.json
│       └── tokyonight-storm
│           ├── bat.tmTheme
│           ├── delta.gitconfig
│           ├── eza.yml
│           ├── fzf.sh
│           ├── gemini.json
│           ├── lazygit.yml
│           ├── wallpaper.png
│           └── windows_terminal.json
├── dot_Brewfile
├── dot_agents
│   └── skills
│       └── symlink_project-doc-planner
├── dot_bash_profile
├── dot_bashrc
├── dot_claude
│   └── skills
│       └── symlink_project-doc-planner
├── dot_cline
│   ├── data
│   │   └── settings
│   │       └── global-settings.json
│   └── skills
│       └── symlink_project-doc-planner
├── dot_codex
│   ├── hooks.json
│   ├── modify_private_config.toml
│   ├── private_AGENTS.md
│   ├── rules
│   │   └── default.rules
│   └── skills
│       ├── dots
│       │   └── SKILL.md
│       ├── frontier-sweep
│       │   └── SKILL.md
│       ├── grilling
│       │   ├── SKILL.md
│       │   └── agents
│       │       └── openai.yaml
│       ├── linear-agent-tracking
│       │   ├── SKILL.md
│       │   ├── agents
│       │   │   └── openai.yaml
│       │   └── references
│       │       ├── issue-tracker-linear.md
│       │       └── linear-cli.md
│       └── project-doc-planner
│           ├── SKILL.md
│           └── agents
│               └── openai.yaml
├── dot_config
│   ├── 1password
│   │   └── ssh
│   │       └── agent.toml
│   ├── apt
│   │   └── pkglist.txt
│   ├── atuin
│   │   └── config.toml
│   ├── bat
│   │   ├── config
│   │   └── themes
│   │       └── dots.tmTheme.tmpl
│   ├── btop
│   │   └── btop.conf
│   ├── chrome-flags.conf
│   ├── delta
│   │   └── theme.gitconfig.tmpl
│   ├── environment.d
│   │   ├── 10-defaults.conf
│   │   └── 10-machine.conf.tmpl
│   ├── eza
│   │   └── theme.yml.tmpl
│   ├── fzf
│   │   └── theme.sh.tmpl
│   ├── gh
│   │   └── config.yml
│   ├── ghostty
│   │   └── config.tmpl
│   ├── git
│   │   ├── config.tmpl
│   │   └── ignore
│   ├── herdr
│   │   ├── config.toml.tmpl
│   │   └── plugins.json.tmpl
│   ├── hypr
│   │   ├── bindings.lua
│   │   ├── hyprland.lua
│   │   ├── hyprmoncfg-monitors.lua
│   │   ├── input.lua
│   │   ├── looknfeel.lua
│   │   └── monitors.lua
│   ├── lazygit
│   │   └── config.yml.tmpl
│   ├── mise
│   │   ├── conf.d
│   │   │   └── vespasian.toml
│   │   └── config.toml
│   ├── nvim
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   ├── lazyvim.json
│   │   └── lua
│   │       ├── config
│   │       │   ├── autocmds.lua
│   │       │   ├── keymaps.lua
│   │       │   ├── lazy.lua
│   │       │   └── options.lua
│   │       └── plugins
│   │           ├── blink-cmp.lua
│   │           ├── copilot-lualine.lua
│   │           ├── copilot.lua
│   │           ├── empty_html-preview.lua
│   │           ├── example.lua
│   │           ├── faster-smear-cursor.lua
│   │           ├── mini-animate-disable-cursor.lua
│   │           ├── theme.lua.tmpl
│   │           └── vim-be-good.lua
│   ├── omarchy
│   │   ├── create_private_shell.json.tmpl
│   │   └── defaults
│   │       └── agent.tmpl
│   ├── opencode
│   │   ├── agents
│   │   │   ├── private_codebase-memory-auditor.md
│   │   │   ├── private_codebase-memory-scout.md
│   │   │   └── private_codebase-memory.md
│   │   ├── dot_gitignore
│   │   ├── encrypted_opencode.json.age
│   │   ├── private_AGENTS.md
│   │   ├── skills
│   │   │   ├── opencode-go-usage
│   │   │   │   └── SKILL.md
│   │   │   └── symlink_project-doc-planner
│   │   ├── tui.json
│   │   └── tui.jsonc
│   ├── pacman
│   │   ├── aurlist.txt
│   │   └── pkglist.txt
│   ├── private_Cursor
│   │   └── User
│   │       └── settings.json
│   ├── ripgrep
│   │   └── rc
│   ├── shell
│   │   ├── 00-env.sh
│   │   ├── 05-omarchy-detect.sh
│   │   ├── 10-tools.sh
│   │   ├── 15-base-bash.sh
│   │   ├── 20-integrations.sh
│   │   ├── 30-navigation.sh
│   │   ├── 40-aliases.sh
│   │   ├── 45-omarchy-portable-aliases.sh
│   │   ├── 50-agents.sh
│   │   ├── 55-apps.sh
│   │   ├── 60-prompt.sh
│   │   ├── 65-theme.sh
│   │   ├── 70-cloud.sh
│   │   ├── 75-tool-paths.sh
│   │   └── README.md
│   ├── starship.toml.tmpl
│   ├── systemd
│   │   └── user
│   │       ├── herdr-outpost-relay.service
│   │       ├── ollama-omarchy-agents.service
│   │       ├── omarchy-agents-analysis.service
│   │       ├── omarchy-agents-analysis.timer
│   │       ├── omarchy-agents-dashboard.service
│   │       ├── omarchy-agents-tunnel.service
│   │       ├── omarchy-camera-reset.service
│   │       ├── omarchy-cline-usage-scrape.service
│   │       ├── omarchy-cline-usage-scrape.timer
│   │       ├── omarchy-cursor-usage-scrape.service
│   │       ├── omarchy-cursor-usage-scrape.timer
│   │       ├── omarchy-drift-capture.path
│   │       ├── omarchy-drift-capture.service
│   │       ├── omarchy-opencode-go-usage-scrape.service
│   │       └── omarchy-opencode-go-usage-scrape.timer
│   └── zoxide
│       └── config.toml
├── dot_evotai
│   └── evot.env
├── dot_gemini
│   ├── agents
│   │   ├── private_codebase-memory-auditor.md
│   │   ├── private_codebase-memory-scout.md
│   │   └── private_codebase-memory.md
│   ├── config
│   │   ├── mcp_config.json
│   │   └── skills
│   │       └── symlink_project-doc-planner
│   ├── modify_private_settings.json
│   ├── private_GEMINI.md
│   └── skills
│       └── symlink_project-doc-planner
├── dot_grok
│   └── hooks
│       ├── executable_herdr-agent-state.sh
│       └── herdr.json
├── dot_hermes
│   ├── SOUL.md
│   ├── config.yaml.tmpl
│   └── skills
│       ├── apple
│       │   ├── DESCRIPTION.md
│       │   ├── apple-notes
│       │   │   └── SKILL.md
│       │   ├── apple-reminders
│       │   │   └── SKILL.md
│       │   ├── findmy
│       │   │   └── SKILL.md
│       │   └── imessage
│       │       └── SKILL.md
│       ├── autonomous-ai-agents
│       │   ├── DESCRIPTION.md
│       │   ├── claude-code
│       │   │   └── SKILL.md
│       │   ├── codex
│       │   │   └── SKILL.md
│       │   ├── computer-use
│       │   │   └── SKILL.md
│       │   ├── hermes-agent
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── background-systems.md
│       │   │   │   ├── cli-reference.md
│       │   │   │   ├── configuration.md
│       │   │   │   ├── contributor-guide.md
│       │   │   │   ├── delegate-task-concurrency-diagnosis.md
│       │   │   │   ├── desktop-plugins.md
│       │   │   │   ├── native-mcp.md
│       │   │   │   ├── petdex.md
│       │   │   │   ├── portal-auth-for-third-party-apps.md
│       │   │   │   ├── project-context-files.md
│       │   │   │   ├── providers-and-models.md
│       │   │   │   ├── security-privacy.md
│       │   │   │   ├── slash-commands.md
│       │   │   │   ├── themes.md
│       │   │   │   ├── troubleshooting.md
│       │   │   │   ├── tui-widgets.md
│       │   │   │   ├── webhooks.md
│       │   │   │   └── windows-quirks.md
│       │   │   └── templates
│       │   │       ├── clock.mjs
│       │   │       ├── plugin.js
│       │   │       └── skin.yaml
│       │   └── opencode
│       │       └── SKILL.md
│       ├── creative
│       │   ├── DESCRIPTION.md
│       │   ├── architecture-diagram
│       │   │   ├── SKILL.md
│       │   │   └── templates
│       │   │       └── template.html
│       │   ├── ascii-video
│       │   │   ├── README.md
│       │   │   ├── SKILL.md
│       │   │   └── references
│       │   │       ├── architecture.md
│       │   │       ├── composition.md
│       │   │       ├── effects.md
│       │   │       ├── inputs.md
│       │   │       ├── optimization.md
│       │   │       ├── scenes.md
│       │   │       ├── shaders.md
│       │   │       └── troubleshooting.md
│       │   ├── baoyu-infographic
│       │   │   ├── PORT_NOTES.md
│       │   │   ├── SKILL.md
│       │   │   └── references
│       │   │       ├── analysis-framework.md
│       │   │       ├── base-prompt.md
│       │   │       ├── layouts
│       │   │       │   ├── bento-grid.md
│       │   │       │   ├── binary-comparison.md
│       │   │       │   ├── bridge.md
│       │   │       │   ├── circular-flow.md
│       │   │       │   ├── comic-strip.md
│       │   │       │   ├── comparison-matrix.md
│       │   │       │   ├── dashboard.md
│       │   │       │   ├── dense-modules.md
│       │   │       │   ├── funnel.md
│       │   │       │   ├── hierarchical-layers.md
│       │   │       │   ├── hub-spoke.md
│       │   │       │   ├── iceberg.md
│       │   │       │   ├── isometric-map.md
│       │   │       │   ├── jigsaw.md
│       │   │       │   ├── linear-progression.md
│       │   │       │   ├── periodic-table.md
│       │   │       │   ├── story-mountain.md
│       │   │       │   ├── structural-breakdown.md
│       │   │       │   ├── tree-branching.md
│       │   │       │   ├── venn-diagram.md
│       │   │       │   └── winding-roadmap.md
│       │   │       ├── structured-content-template.md
│       │   │       └── styles
│       │   │           ├── aged-academia.md
│       │   │           ├── bold-graphic.md
│       │   │           ├── chalkboard.md
│       │   │           ├── claymation.md
│       │   │           ├── corporate-memphis.md
│       │   │           ├── craft-handmade.md
│       │   │           ├── cyberpunk-neon.md
│       │   │           ├── hand-drawn-edu.md
│       │   │           ├── ikea-manual.md
│       │   │           ├── kawaii.md
│       │   │           ├── knolling.md
│       │   │           ├── lego-brick.md
│       │   │           ├── morandi-journal.md
│       │   │           ├── origami.md
│       │   │           ├── pixel-art.md
│       │   │           ├── pop-laboratory.md
│       │   │           ├── retro-pop-grid.md
│       │   │           ├── storybook-watercolor.md
│       │   │           ├── subway-map.md
│       │   │           ├── technical-schematic.md
│       │   │           └── ui-wireframe.md
│       │   ├── claude-design
│       │   │   └── SKILL.md
│       │   ├── design-md
│       │   │   ├── SKILL.md
│       │   │   └── templates
│       │   │       └── starter.md
│       │   ├── humanizer
│       │   │   ├── LICENSE
│       │   │   └── SKILL.md
│       │   ├── impeccable
│       │   │   ├── SKILL.md
│       │   │   ├── reference
│       │   │   │   ├── adapt.md
│       │   │   │   ├── adapt.native.md
│       │   │   │   ├── android.md
│       │   │   │   ├── animate.md
│       │   │   │   ├── audit.md
│       │   │   │   ├── audit.native.md
│       │   │   │   ├── bolder.md
│       │   │   │   ├── clarify.md
│       │   │   │   ├── colorize.md
│       │   │   │   ├── craft-floor.md
│       │   │   │   ├── craft.md
│       │   │   │   ├── critique.md
│       │   │   │   ├── degraded
│       │   │   │   │   ├── asset-producer.md
│       │   │   │   │   ├── documenter.md
│       │   │   │   │   ├── finish-reviewer.md
│       │   │   │   │   └── manual-edit-applier.md
│       │   │   │   ├── delight.md
│       │   │   │   ├── distill.md
│       │   │   │   ├── doctor.md
│       │   │   │   ├── document.md
│       │   │   │   ├── extract.md
│       │   │   │   ├── generate.md
│       │   │   │   ├── harden.md
│       │   │   │   ├── hooks.md
│       │   │   │   ├── init.md
│       │   │   │   ├── ios.md
│       │   │   │   ├── layout.md
│       │   │   │   ├── live-setup.md
│       │   │   │   ├── live.md
│       │   │   │   ├── new-work.md
│       │   │   │   ├── onboard.md
│       │   │   │   ├── operate.md
│       │   │   │   ├── optimize.md
│       │   │   │   ├── overdrive.md
│       │   │   │   ├── polish.md
│       │   │   │   ├── quieter.md
│       │   │   │   ├── routing.md
│       │   │   │   ├── shape.md
│       │   │   │   ├── typeset.md
│       │   │   │   └── visualize.md
│       │   │   └── scripts
│       │   │       ├── VERSION
│       │   │       ├── command-metadata.json
│       │   │       ├── data
│       │   │       │   ├── font-index-failures.json
│       │   │       │   └── font-index.json
│       │   │       ├── impeccable
│       │   │       ├── impeccable.cmd
│       │   │       ├── live-browser-dom.js
│       │   │       ├── live-browser-ignores.js
│       │   │       ├── live-browser-session.js
│       │   │       ├── live-browser.js
│       │   │       └── modern-screenshot.umd.js
│       │   ├── manim-video
│       │   │   ├── README.md
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── animation-design-thinking.md
│       │   │   │   ├── animations.md
│       │   │   │   ├── camera-and-3d.md
│       │   │   │   ├── decorations.md
│       │   │   │   ├── equations.md
│       │   │   │   ├── graphs-and-data.md
│       │   │   │   ├── mobjects.md
│       │   │   │   ├── paper-explainer.md
│       │   │   │   ├── production-quality.md
│       │   │   │   ├── rendering.md
│       │   │   │   ├── scene-planning.md
│       │   │   │   ├── troubleshooting.md
│       │   │   │   ├── updaters-and-trackers.md
│       │   │   │   └── visual-design.md
│       │   │   └── scripts
│       │   │       └── executable_setup.sh
│       │   ├── p5js
│       │   │   ├── README.md
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── animation.md
│       │   │   │   ├── color-systems.md
│       │   │   │   ├── core-api.md
│       │   │   │   ├── export-pipeline.md
│       │   │   │   ├── interaction.md
│       │   │   │   ├── shapes-and-geometry.md
│       │   │   │   ├── troubleshooting.md
│       │   │   │   ├── typography.md
│       │   │   │   ├── visual-effects.md
│       │   │   │   └── webgl-and-3d.md
│       │   │   ├── scripts
│       │   │   │   ├── executable_export-frames.js
│       │   │   │   ├── executable_render.sh
│       │   │   │   ├── executable_serve.sh
│       │   │   │   └── executable_setup.sh
│       │   │   └── templates
│       │   │       └── viewer.html
│       │   ├── popular-web-designs
│       │   │   ├── SKILL.md
│       │   │   └── templates
│       │   │       ├── airbnb.md
│       │   │       ├── airtable.md
│       │   │       ├── apple.md
│       │   │       ├── bmw.md
│       │   │       ├── cal.md
│       │   │       ├── claude.md
│       │   │       ├── clay.md
│       │   │       ├── clickhouse.md
│       │   │       ├── cohere.md
│       │   │       ├── coinbase.md
│       │   │       ├── composio.md
│       │   │       ├── cursor.md
│       │   │       ├── elevenlabs.md
│       │   │       ├── expo.md
│       │   │       ├── figma.md
│       │   │       ├── framer.md
│       │   │       ├── hashicorp.md
│       │   │       ├── ibm.md
│       │   │       ├── intercom.md
│       │   │       ├── kraken.md
│       │   │       ├── linear.app.md
│       │   │       ├── lovable.md
│       │   │       ├── minimax.md
│       │   │       ├── mintlify.md
│       │   │       ├── miro.md
│       │   │       ├── mistral.ai.md
│       │   │       ├── mongodb.md
│       │   │       ├── notion.md
│       │   │       ├── nvidia.md
│       │   │       ├── ollama.md
│       │   │       ├── opencode.ai.md
│       │   │       ├── pinterest.md
│       │   │       ├── posthog.md
│       │   │       ├── raycast.md
│       │   │       ├── replicate.md
│       │   │       ├── resend.md
│       │   │       ├── revolut.md
│       │   │       ├── runwayml.md
│       │   │       ├── sanity.md
│       │   │       ├── sentry.md
│       │   │       ├── spacex.md
│       │   │       ├── spotify.md
│       │   │       ├── stripe.md
│       │   │       ├── supabase.md
│       │   │       ├── superhuman.md
│       │   │       ├── together.ai.md
│       │   │       ├── uber.md
│       │   │       ├── vercel.md
│       │   │       ├── voltagent.md
│       │   │       ├── warp.md
│       │   │       ├── webflow.md
│       │   │       ├── wise.md
│       │   │       ├── x.ai.md
│       │   │       └── zapier.md
│       │   └── songwriting-and-ai-music
│       │       └── SKILL.md
│       ├── devops
│       │   ├── chezmoi-dotfiles
│       │   │   └── SKILL.md
│       │   ├── hermes-repo-devsetup
│       │   │   └── SKILL.md
│       │   └── sdlc-review
│       │       └── SKILL.md
│       ├── email
│       │   ├── DESCRIPTION.md
│       │   ├── email-inbox-triage
│       │   │   └── SKILL.md
│       │   └── himalaya
│       │       ├── SKILL.md
│       │       └── references
│       │           ├── configuration.md
│       │           └── message-composition.md
│       ├── market-competitor-research
│       │   └── SKILL.md
│       ├── media
│       │   ├── DESCRIPTION.md
│       │   ├── gif-search
│       │   │   └── SKILL.md
│       │   ├── songsee
│       │   │   └── SKILL.md
│       │   └── youtube-content
│       │       ├── SKILL.md
│       │       ├── references
│       │       │   └── output-formats.md
│       │       └── scripts
│       │           └── fetch_transcript.py
│       ├── note-taking
│       │   ├── DESCRIPTION.md
│       │   └── obsidian
│       │       └── SKILL.md
│       ├── productivity
│       │   ├── DESCRIPTION.md
│       │   ├── airtable
│       │   │   └── SKILL.md
│       │   ├── box
│       │   │   ├── SKILL.md
│       │   │   └── references
│       │   │       ├── bulk-operations.md
│       │   │       ├── cli-guide.md
│       │   │       ├── content-workflows.md
│       │   │       ├── hubs.md
│       │   │       ├── oauth-setup.md
│       │   │       ├── rest-api.md
│       │   │       ├── sdk-development.md
│       │   │       ├── search-and-ai.md
│       │   │       ├── troubleshooting.md
│       │   │       └── webhooks-and-events.md
│       │   ├── document-to-action-items
│       │   │   └── SKILL.md
│       │   ├── docx
│       │   │   ├── LICENSE
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   └── revisions-and-comments.md
│       │   │   ├── scripts
│       │   │   │   ├── docx_comments.py
│       │   │   │   ├── docx_common.py
│       │   │   │   ├── docx_create.py
│       │   │   │   ├── docx_edit.py
│       │   │   │   ├── docx_read.py
│       │   │   │   ├── docx_revisions.py
│       │   │   │   ├── docx_template.py
│       │   │   │   └── docx_validate.py
│       │   │   └── tests
│       │   │       └── test_docx_skill.py
│       │   ├── google-workspace
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── daily-brief.md
│       │   │   │   └── gmail-search-syntax.md
│       │   │   └── scripts
│       │   │       ├── _hermes_home.py
│       │   │       ├── executable_gws_bridge.py
│       │   │       ├── google_api.py
│       │   │       └── setup.py
│       │   ├── maps
│       │   │   ├── SKILL.md
│       │   │   └── scripts
│       │   │       └── maps_client.py
│       │   ├── meeting-action-items
│       │   │   └── SKILL.md
│       │   ├── notion
│       │   │   ├── SKILL.md
│       │   │   └── references
│       │   │       └── block-types.md
│       │   ├── pdf
│       │   │   ├── LICENSE
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── forms.md
│       │   │   │   ├── nano-pdf-editing.md
│       │   │   │   └── ocr-extraction.md
│       │   │   ├── scripts
│       │   │   │   ├── _raster.py
│       │   │   │   ├── extract_marker.py
│       │   │   │   ├── extract_pymupdf.py
│       │   │   │   ├── pdf_create.py
│       │   │   │   ├── pdf_fill_form.py
│       │   │   │   ├── pdf_form_layout.py
│       │   │   │   ├── pdf_make_form.py
│       │   │   │   ├── pdf_merge.py
│       │   │   │   ├── pdf_meta.py
│       │   │   │   ├── pdf_page_image.py
│       │   │   │   ├── pdf_read.py
│       │   │   │   ├── pdf_secure.py
│       │   │   │   ├── pdf_split.py
│       │   │   │   ├── pdf_stamp.py
│       │   │   │   └── pdf_watermark.py
│       │   │   └── tests
│       │   │       └── test_pdf_skill.py
│       │   ├── powerpoint
│       │   │   ├── LICENSE
│       │   │   ├── SKILL.md
│       │   │   ├── scripts
│       │   │   │   ├── pptx_create.py
│       │   │   │   ├── pptx_edit.py
│       │   │   │   ├── pptx_from_template.py
│       │   │   │   ├── pptx_read.py
│       │   │   │   └── pptx_render.py
│       │   │   └── tests
│       │   │       └── test_powerpoint_skill.py
│       │   ├── product-price-monitor
│       │   │   └── SKILL.md
│       │   ├── teams-meeting-pipeline
│       │   │   └── SKILL.md
│       │   ├── weekly-review-planning
│       │   │   └── SKILL.md
│       │   └── xlsx
│       │       ├── LICENSE
│       │       ├── SKILL.md
│       │       ├── references
│       │       │   └── restructuring.md
│       │       ├── scripts
│       │       │   ├── csv_to_xlsx.py
│       │       │   ├── xlsx_create.py
│       │       │   ├── xlsx_edit.py
│       │       │   ├── xlsx_read.py
│       │       │   ├── xlsx_recalc.py
│       │       │   ├── xlsx_restructure.py
│       │       │   └── xlsx_to_csv.py
│       │       └── tests
│       │           └── test_xlsx_skill.py
│       ├── ratatui-tui
│       │   ├── SKILL.md
│       │   ├── assets
│       │   │   └── templates
│       │   │       ├── async-app
│       │   │       │   ├── Cargo.toml
│       │   │       │   └── src
│       │   │       │       └── main.rs
│       │   │       ├── component-app
│       │   │       │   ├── Cargo.toml
│       │   │       │   └── src
│       │   │       │       ├── action.rs
│       │   │       │       ├── app.rs
│       │   │       │       ├── config.rs
│       │   │       │       ├── event.rs
│       │   │       │       ├── logging.rs
│       │   │       │       ├── main.rs
│       │   │       │       ├── tui.rs
│       │   │       │       └── ui.rs
│       │   │       ├── hello-world
│       │   │       │   ├── Cargo.toml
│       │   │       │   └── src
│       │   │       │       └── main.rs
│       │   │       └── simple-app
│       │   │           ├── Cargo.toml
│       │   │           └── src
│       │   │               └── main.rs
│       │   ├── references
│       │   │   ├── architecture-patterns.md
│       │   │   ├── async-patterns.md
│       │   │   ├── image-integration.md
│       │   │   └── style-guide.md
│       │   └── workflows
│       │       └── tui-review.js
│       ├── repo-scaffold
│       │   └── SKILL.md
│       ├── research
│       │   ├── DESCRIPTION.md
│       │   ├── arxiv
│       │   │   ├── SKILL.md
│       │   │   └── scripts
│       │   │       └── search_arxiv.py
│       │   ├── competitor-news-monitor
│       │   │   └── SKILL.md
│       │   ├── grounded-citations
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── citation-formats.md
│       │   │   │   └── grounding-rationale.md
│       │   │   └── scripts
│       │   │       ├── _hermes_home.py
│       │   │       └── sources.py
│       │   └── llm-wiki
│       │       └── SKILL.md
│       ├── social-media
│       │   ├── DESCRIPTION.md
│       │   └── xurl
│       │       └── SKILL.md
│       ├── software-development
│       │   ├── codebase-inspection
│       │   │   └── SKILL.md
│       │   ├── dogfood
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   └── issue-taxonomy.md
│       │   │   └── templates
│       │   │       └── dogfood-report-template.md
│       │   ├── github
│       │   │   ├── SKILL.md
│       │   │   ├── references
│       │   │   │   ├── auth.md
│       │   │   │   ├── ci-troubleshooting.md
│       │   │   │   ├── code-review.md
│       │   │   │   ├── conventional-commits.md
│       │   │   │   ├── github-api-cheatsheet.md
│       │   │   │   ├── issue-to-pr.md
│       │   │   │   ├── issues.md
│       │   │   │   ├── pr-workflow.md
│       │   │   │   ├── repo-management.md
│       │   │   │   └── review-output-template.md
│       │   │   ├── scripts
│       │   │   │   ├── executable_gh-env.sh
│       │   │   │   └── git-credential-token.py
│       │   │   └── templates
│       │   │       ├── bug-report.md
│       │   │       ├── feature-request.md
│       │   │       ├── pr-body-bugfix.md
│       │   │       └── pr-body-feature.md
│       │   ├── grill-me
│       │   │   └── SKILL.md
│       │   ├── hermes-agent-skill-authoring
│       │   │   └── SKILL.md
│       │   ├── hermes-repo-profiles
│       │   │   └── SKILL.md
│       │   ├── inspecting-hermes-desktop-dom
│       │   │   └── SKILL.md
│       │   ├── node-inspect-debugger
│       │   │   └── SKILL.md
│       │   ├── python-debugpy
│       │   │   └── SKILL.md
│       │   ├── requesting-code-review
│       │   │   └── SKILL.md
│       │   ├── rust
│       │   │   └── SKILL.md
│       │   ├── simplify-code
│       │   │   └── SKILL.md
│       │   ├── spike
│       │   │   └── SKILL.md
│       │   ├── subagent-driven-development
│       │   │   ├── SKILL.md
│       │   │   └── references
│       │   │       ├── context-budget-discipline.md
│       │   │       └── gates-taxonomy.md
│       │   ├── systematic-debugging
│       │   │   └── SKILL.md
│       │   └── test-driven-development
│       │       └── SKILL.md
│       ├── sqlite
│       │   ├── SKILL.md
│       │   ├── _meta.json
│       │   └── skill-card.md
│       ├── symlink_agent-reach
│       ├── symlink_ai-image-generation
│       ├── symlink_animate
│       ├── symlink_animate-expo
│       ├── symlink_animation-vocabulary
│       ├── symlink_apple-design
│       ├── symlink_ask-sonner
│       ├── symlink_editor
│       ├── symlink_emil-design-eng
│       ├── symlink_find-animation-opportunities
│       ├── symlink_flyai
│       ├── symlink_improve-animations
│       ├── symlink_pick-ui-library
│       ├── symlink_review-animations
│       ├── symlink_supabase
│       ├── symlink_supabase-postgres-best-practices
│       ├── symlink_unlazy
│       ├── symlink_watch
│       ├── symlink_write-swift
│       ├── web
│       │   ├── DESCRIPTION.md
│       │   └── blocked-page-recovery
│       │       ├── SKILL.md
│       │       └── scripts
│       │           └── recover_page.py
│       └── web-development
│           └── scrollcraft
│               ├── LICENSE.txt
│               ├── SKILL.md
│               ├── engine
│               │   ├── scrollcraft.css
│               │   └── scrollcraft.js
│               ├── references
│               │   ├── assets.md
│               │   ├── device-diag.html
│               │   ├── devices.md
│               │   ├── feel.md
│               │   ├── taste.md
│               │   ├── template.html
│               │   ├── uniqueness.md
│               │   ├── verify.md
│               │   ├── worldflight.md
│               │   └── worlds.md
│               ├── scripts
│               │   ├── doctor.mjs
│               │   ├── encode.sh
│               │   ├── kie.mjs
│               │   ├── serve.mjs
│               │   ├── shoot.mjs
│               │   ├── workspace.mjs
│               │   └── worldflight-assert.mjs
│               └── templates
│                   └── FINGERPRINTS.md
├── dot_local
│   ├── bin
│   │   ├── cline-safety
│   │   │   └── executable_git
│   │   ├── executable_chrome-profile
│   │   ├── executable_cursor
│   │   ├── executable_dots
│   │   ├── executable_dots-push
│   │   ├── executable_dots-theme-import-aether
│   │   ├── executable_herdr-agent-lifecycle
│   │   ├── executable_lazygit-ollama-commit.sh
│   │   ├── executable_ollama-commit-msg.sh
│   │   ├── executable_omarchy-agent-usage-antigravity.tmpl
│   │   ├── executable_omarchy-agent-usage-cline.tmpl
│   │   ├── executable_omarchy-agent-usage-codex.tmpl
│   │   ├── executable_omarchy-agent-usage-cursor.tmpl
│   │   ├── executable_omarchy-agent-usage-opencode.tmpl
│   │   ├── executable_omarchy-agent-usage-pi.tmpl
│   │   ├── executable_omarchy-agent-usage-update.tmpl
│   │   ├── executable_omarchy-agent.tmpl
│   │   ├── executable_omarchy-camera-reset
│   │   ├── executable_omarchy-cline-usage-login.tmpl
│   │   ├── executable_omarchy-cline-usage-override.tmpl
│   │   ├── executable_omarchy-cline-usage-scrape.tmpl
│   │   ├── executable_omarchy-cursor-statusline.tmpl
│   │   ├── executable_omarchy-cursor-usage-override.tmpl
│   │   ├── executable_omarchy-cursor-usage-scrape.tmpl
│   │   ├── executable_omarchy-default-agent.tmpl
│   │   ├── executable_omarchy-dotfiles-sync
│   │   ├── executable_omarchy-drift-capture
│   │   ├── executable_omarchy-opencode-go-usage-login.tmpl
│   │   ├── executable_omarchy-opencode-go-usage-override.tmpl
│   │   ├── executable_omarchy-opencode-go-usage-scrape.tmpl
│   │   ├── executable_piper
│   │   ├── executable_ratbagctl
│   │   ├── executable_statusline.tmpl
│   │   ├── executable_wsl-windows-tool
│   │   └── symlink_evot
│   └── share
│       ├── applications
│       │   └── cursor-desktop.desktop
│       ├── omarchy-patches
│       │   └── esemczak.theme-modes-profiles.patch
│       └── wsl-ssh-bridge
│           └── main.go
├── dot_pi
│   └── agent
│       └── skills
│           └── symlink_project-doc-planner
├── dot_zshrc
├── private_dot_grokbot
│   └── settings.json
├── private_dot_ssh
│   └── config.tmpl
├── run_after_23-sync-agent-skills.sh.tmpl
├── run_once_after_24-setup-omarchy-agents.sh.tmpl
├── run_once_before_00-verify-deps.sh.tmpl
├── run_onchange_after_10-install-omarchy-plugins.sh.tmpl
├── run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl
├── run_onchange_after_21-setup-omarchy-cline.sh.tmpl
├── run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl
├── run_onchange_after_25-sync-omarchy-agents-workspace.sh.tmpl
├── run_onchange_after_26-setup-omarchy-cursor.sh.tmpl
├── run_onchange_after_27-sync-claude-mcp.sh.tmpl
├── run_onchange_after_28-sync-claude-settings.sh.tmpl
├── run_onchange_after_29-setup-omarchy-drift-capture.sh.tmpl
├── run_onchange_after_30-hadrian-macos-defaults.sh.tmpl
├── run_onchange_after_31-augustus-mouse-dpi.sh.tmpl
├── run_onchange_after_32-setup-omarchy-pi.sh.tmpl
├── run_onchange_after_40-vespasian-windows-terminal.sh.tmpl
├── run_onchange_after_41-vespasian-nerd-font.sh.tmpl
├── run_onchange_after_42-vespasian-theme-state.sh.tmpl
├── run_onchange_after_43-vespasian-1password-ssh-bridge.sh.tmpl
├── run_onchange_after_44-vespasian-windows-debloat.sh.tmpl
├── run_onchange_after_45-vespasian-desktop-tools.sh.tmpl
├── run_onchange_after_46-vespasian-wallpaper.sh.tmpl
├── run_onchange_after_47-vespasian-wsl-boot.sh.tmpl
├── run_onchange_before_09-install-agent-skills.sh.tmpl
└── theme-assets
    ├── omarchy-catppuccin
    │   └── wallpaper.png
    ├── omarchy-catppuccin-latte
    │   └── wallpaper.png
    ├── omarchy-everforest
    │   └── wallpaper.png
    ├── omarchy-gruvbox
    │   └── wallpaper.png
    ├── omarchy-kanagawa
    │   └── wallpaper.png
    ├── omarchy-nord
    │   └── wallpaper.png
    ├── omarchy-rose-pine
    │   └── wallpaper.png
    └── omarchy-tokyo-night
        └── wallpaper.png
```
<!-- END REPO TREE -->