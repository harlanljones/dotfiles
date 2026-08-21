# Dotfiles

Personal dotfiles managed across macOS and Linux (Omarchy / Arch Linux) using [chezmoi](https://www.chezmoi.io/).

---

## 🛠️ Components & Configurations

### 🐚 Shell & Prompt
- **Zsh** (`.zshrc` on macOS): Includes Starship prompt init, mise environment activation, editor defaults, and `eza` alias shortcuts (`ls`, `lsa`, `lt`, `lta`).
- **Bash** (`.bashrc` on Linux/Omarchy): Integrates with Omarchy shell defaults, Google Cloud SDK PATH and autocompletion, and user PATH entries.
- **[Starship](https://starship.rs/)** (`~/.config/starship.toml`): Fast, cyan-accented minimal prompt displaying directory path (with smart repo-root formatting), git branch, and detailed status symbols.

### 🧰 Version & Tool Management
- **[mise](https://mise.jdx.dev/)** (`~/.config/mise/config.toml`): Manages CLI tools and runtime versions:
  - `bun`
  - `chezmoi`
  - `claude`
  - `gh`
  - `node`
  - `uv`

### 💻 Editor
- **[Neovim](https://neovim.io/) / [LazyVim](https://www.lazyvim.org/)** (`~/.config/nvim/`):
  - **LazyVim Extras**: Configured via `lazyvim.json` for TypeScript, Python, Tailwind, Astro, JSON, Markdown, TOML, Neo-tree, inc-rename, dial, and chezmoi/dotfile utilities.
  - **[blink.cmp](https://github.com/Saghen/blink.cmp)**: Super-tab completion configuration.
  - **vim-be-good**: Vim practice plugin.

### 🐙 Git & Lazygit
- **[Lazygit](https://github.com/jesseduffield/lazygit)** (`~/.config/lazygit/config.yml`):
  - Custom keybinding `<Ctrl-g>` to generate conventional git commit messages from staged diffs using local LLMs via Ollama.
- **Ollama Commit Generator** (`~/.local/bin/lazygit-ollama-commit.sh`):
  - Automated commit message generation script using `qwen2.5-coder:7b` (configurable via `OLLAMA_COMMIT_MODEL`) with fallback handling and `$EDITOR` review step.

### 🖥️ Window Management & Hardware (Linux / Omarchy)
- **[Hyprland](https://hyprland.org/)** (`~/.config/hypr/`):
  - **Monitors** (`monitors.lua`): Dual-monitor setup with DP-1 (32" 4K 60Hz on left, 1.6x scale) and DP-2 (27" 2K 240Hz on right, 1.25x scale).
  - **Input** (`input.lua`): Pointer sensitivity and custom input overrides.

### 🤖 Omarchy & AI Coding Agent Integration
- **Plugin Management** (`.chezmoidata/omarchy_plugins.yaml` & `run_onchange_after_10-install-omarchy-plugins.sh.tmpl`):
  - Declarative tracking and automatic installation/updating of Omarchy desktop plugins:
    - `omarchy-resume`
    - `omarchy-simple-notifications`
    - `omarchy-hw-tooltip`
    - `dockmarchy`
    - `omarchy-shmall.lock-plugin`
    - `omarchy-sportsbar`
    - `omarchy-agent-leaderboard`
- **Antigravity CLI Integration** (`run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl`):
  - Sets up `collect-antigravity.py` collector script to parse Antigravity CLI sessions, model attribution, and context-weighted token usage for the Agent Leaderboard widget.
- **Cline CLI Integration** (`run_onchange_after_21-setup-omarchy-cline.sh.tmpl`):
  - Registers Cline in the Agent Leaderboard widget (icon and accent color) and ships `omarchy-agent-usage-cline`, a collector that parses `~/.cline/data/sessions` transcripts for per-model, per-day token usage.
  - **Cline Pass estimated limits**: Cline exposes no rate-limit API, so ClinePass usage is *estimated*, not read live (each limit's label is suffixed "(estimated)" in the panel). Messages billed through ClinePass (raw model id prefixed `cline-pass/`) are rated against Cline's published reference per-token prices and rolled into the three windows ClinePass documents (5-hour rolling, calendar week, calendar month), then compared against a quota. ClinePass's real quota size is unpublished — only "2–5x standard API rate" is documented — but rating a day's spend against the reference prices and comparing it to the actual dashboard reading (app.cline.bot → Subscription) on 2026-08-21 fit a clean 1 : 2.5 : 5 ratio, so the collector defaults to session ≈ $50 / weekly ≈ $125 / monthly ≈ $250. Override any of them in `~/.config/omarchy/agents/cline.json`:
    ```json
    { "monthlyQuotaUsd": 250, "weeklyQuotaUsd": 125, "sessionQuotaUsd": 50 }
    ```
    Omitted `weeklyQuotaUsd`/`sessionQuotaUsd` derive from `monthlyQuotaUsd` as `monthly/2` and `monthly/5`. Check [app.cline.bot](https://app.cline.bot) periodically for the authoritative reading and adjust the config if your account's allowance differs.
- **Cline CLI Settings** (`~/.cline/data/settings/global-settings.json`):
  - Global Cline CLI preferences managed via chezmoi (provider credentials in `providers.json` are intentionally not managed).
- **Omarchy Agent Wrappers** (`~/.local/bin/`):
  - `omarchy-agent`: Launch default coding agent with support for Antigravity (`agy`).
  - `omarchy-default-agent`: Quick switcher to configure default coding agent (e.g. `omarchy default agent agy`).
  - `omarchy-agent-usage-update`, `omarchy-agent-usage-antigravity` & `omarchy-agent-usage-cline`: Multi-agent usage metric updates.

---

## 📂 Repository Structure

```text
.
├── .chezmoidata/
│   └── omarchy_plugins.yaml           # Manifest for Omarchy desktop plugins
├── .chezmoiignore.tmpl                # OS-specific ignore rules (Darwin vs. Linux)
├── dot_bashrc                         # Bash shell configuration (Linux)
├── dot_zshrc                          # Zsh shell configuration (macOS)
├── dot_config/
│   ├── hypr/                          # Hyprland monitor & input configs
│   ├── lazygit/                       # Lazygit configuration
│   ├── mise/                          # Mise runtime tool configurations
│   ├── nvim/                          # Neovim / LazyVim configurations
│   ├── omarchy/                       # Omarchy defaults & agent configuration
│   └── starship.toml                  # Starship cross-shell prompt configuration
├── dot_cline/                         # Cline CLI global settings
├── dot_local/
│   └── bin/                           # Custom scripts and AI agent hooks
├── run_onchange_after_10-install-omarchy-plugins.sh.tmpl
├── run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl
└── run_onchange_after_21-setup-omarchy-cline.sh.tmpl
```

---

## 🚀 Quick Start

### Initialize and Apply

```bash
# Clone and apply in one step
chezmoi init --apply https://github.com/harlanljones/dotfiles.git

# Or if already initialized
chezmoi apply
```

### Daily Workflow

```bash
# Check differences between repo and target
chezmoi diff

# Edit a file managed by chezmoi
chezmoi edit ~/.config/starship.toml

# Pull remote changes and apply
chezmoi update

# Check status of managed files
chezmoi status
```

---

## 💻 OS Support

Templates use `.chezmoiignore.tmpl` to ensure only platform-relevant configurations are applied:
- **macOS (`darwin`)**: Installs `.zshrc`, Starship, Mise, Neovim, Lazygit configs.
- **Linux (`omarchy`)**: Installs `.bashrc`, Hyprland, Omarchy agent integrations, plugin sync hooks, and usage collectors.