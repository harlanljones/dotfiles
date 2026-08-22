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
  - `codex`
  - `gh`
  - `node`
  - `npm:playwright`
  - `opencode`
  - `python`
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
- **Cline Git Safety Wrapper** (`~/.local/bin/cline-safety/git`):
  - Intercepting Git wrapper for Cline agents to prevent unintentional automated commits and pushes.

### 🖥️ Window Management & Hardware (Linux / Omarchy)
- **[Hyprland](https://hyprland.org/)** (`~/.config/hypr/`):
  - **Monitors** (`monitors.lua`): Dual-monitor setup with DP-1 (32" 4K 60Hz on left, 1.6x scale) and DP-2 (27" 2K 240Hz on right, 1.25x scale).
  - **Input** (`input.lua`): Pointer sensitivity and custom input overrides.

### 🤖 Omarchy & AI Coding Agent Integration
- **Cross-Harness Agent Skills** (`.chezmoidata/agent_skills.yaml`, `run_onchange_before_09-install-agent-skills.sh.tmpl`, and `run_after_23-sync-agent-skills.sh.tmpl`):
  - Tracks the portable global skill catalog, restores missing third-party skills, and safely links it into Claude, Cline, Antigravity, Gemini, and Pi without replacing provider-owned variants. Codex and OpenCode consume the shared `~/.agents/skills` catalog directly.
  - Keeps custom skills such as `project-doc-planner` in chezmoi and preserves harness-specific `impeccable` builds.
- **Plugin Management** (`.chezmoidata/omarchy_plugins.yaml` & `run_onchange_after_10-install-omarchy-plugins.sh.tmpl`):
  - Declarative tracking and automatic installation/updating of Omarchy desktop plugins:
    - `omarchy-resume`
    - `omarchy-simple-notifications`
    - `omarchy-hw-tooltip`
    - `dockmarchy`
    - `omarchy-shmall.lock-plugin`
    - `omarchy-sportsbar`
- **Omarchy Agents Workspace** ([`harlanljones/omarchy-agents`](https://github.com/harlanljones/omarchy-agents), checked out at `~/dev/omarchy-agents/`):
  - Turborepo source of truth for the web dashboard and both Omarchy plugin forks. Chezmoi retains only machine configuration and invokes the workspace's deployment task after apply.
  - Kept outside `.chezmoidata/omarchy_plugins.yaml` because the repository contains multiple apps; `run_after_25-sync-omarchy-agents-workspace.sh.tmpl` validates and deploys both plugin builds.
- **Agent Leaderboard Plugin** (`~/dev/omarchy-agents/apps/omarchy-agent-leaderboard/`, deployed to `~/.config/omarchy/plugins/harlan.agent-leaderboard/`):
  - Custom bar widget (`harlan.agent-leaderboard`) ranking token usage across all coding agents (Antigravity, Claude, Cline, Codex, Cursor, Fireworks, OpenCode, Grok, Hermes) across daily, 7-day, and all-time windows.
  - Bundles embedded collectors for Antigravity (`collect-antigravity.py`) and Fireworks (`collect-fireworks.py`).
- **Agents Plugin** (`~/dev/omarchy-agents/apps/omarchy-agent-usage/`, deployed to `~/.config/omarchy/plugins/harlan.agents/`):
  - Custom multi-agent status widget (`harlan.agents`) providing live rate-limit meters, pace, 7-day usage trends, and model breakdown across Claude Code, Cline, Codex, Fireworks, and OpenCode.
- **Antigravity CLI Integration** (`run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl`):
  - Sets up `collect-antigravity.py` collector to parse Antigravity CLI sessions, model attribution, and context-weighted token usage.
- **Cline CLI Integration & Automated Scraping** (`run_onchange_after_21-setup-omarchy-cline.sh.tmpl` & `run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl`):
  - Registers Cline in the Agent Leaderboard and Agents widgets; parses `~/.cline/data/sessions` transcripts for per-model, per-day token metrics (`omarchy-agent-usage-cline`).
  - **Automated Rate Limit Scraper**: Headless Google Chrome scraping via Playwright (`omarchy-cline-usage-scrape` and `omarchy-cline-usage-login`) running on a systemd timer (`omarchy-cline-usage-scrape.timer`) to keep real ClinePass limits up to date without manual dashboard visits.
  - **Cline Pass estimated limits & manual override**: When scraping is inactive, estimates windows using reference rates, or accepts manual overrides via `omarchy-cline-usage-override` / `/usage` workflow.
- **Codex & OpenCode Usage Collectors**:
  - `omarchy-agent-usage-codex`: Collects Codex CLI session logs and app-server RPC metrics.
  - `omarchy-agent-usage-opencode`: SQLite collector parsing prompt history, session stats, and token usage from `~/.local/share/opencode/opencode.db`.
- **Cursor CLI Integration** (`run_onchange_after_26-setup-omarchy-cursor.sh.tmpl`):
  - Registers Cursor in the Agent Leaderboard; `omarchy-agent-usage-cursor` parses `~/.config/cursor/chats/*/*/store.db` chat stores for prompt/session/model counts. Cursor's local storage has no token or rate-limit data, so — unlike the other collectors — usage shown is counts-only, never totals or cost.
  - `omarchy default agent cursor` / `omarchy agent` launch `cursor-agent --yolo`; Cursor CLI itself installs separately (`curl https://cursor.com/install -fsS | bash`), same as Antigravity.
- **Cline CLI Settings** (`~/.cline/data/settings/global-settings.json`):
  - Global Cline CLI preferences managed via chezmoi (provider credentials in `providers.json` are intentionally not managed).
- **Omarchy Agent Wrappers & Utilities** (`~/.local/bin/`):
  - `omarchy-agent`: Launch default coding agent with support for Antigravity (`agy`) and Cursor.
  - `omarchy-default-agent`: Quick switcher to configure default coding agent (e.g. `omarchy default agent agy`, `omarchy default agent cursor`).
  - `omarchy-agent-usage-update`: Master aggregator running all active collectors (`omarchy-agent-usage-*`) to write standard JSON records into `~/.local/state/omarchy/agents/usage/`.
  - `omarchy-agent-usage-antigravity`, `omarchy-agent-usage-cline`, `omarchy-agent-usage-codex`, `omarchy-agent-usage-cursor`, `omarchy-agent-usage-opencode`: Standalone usage collectors.
  - `omarchy-cline-usage-login`, `omarchy-cline-usage-scrape`, `omarchy-cline-usage-override`: ClinePass limit scraper and override utilities.

---

## 📂 Repository Structure

```text
.
├── .chezmoidata/
│   ├── agent_skills.yaml              # Cross-harness global skill manifest
│   └── omarchy_plugins.yaml           # Manifest for Omarchy desktop plugins
├── .chezmoiignore.tmpl                # OS-specific ignore rules (Darwin vs. Linux)
├── Documents/
│   └── Cline/Workflows/usage.md       # Interactive ClinePass usage workflow
├── dot_bashrc                         # Bash shell configuration (Linux)
├── dot_zshrc                          # Zsh shell configuration (macOS)
├── dot_config/
│   ├── hypr/                          # Hyprland monitor & input configs
│   ├── lazygit/                       # Lazygit configuration
│   ├── mise/                          # Mise runtime tool configurations
│   ├── nvim/                          # Neovim / LazyVim configurations
│   ├── omarchy/                       # Omarchy defaults and shell placement/settings
│   └── starship.toml                  # Starship cross-shell prompt configuration
├── dot_cline/                         # Cline CLI global settings
├── dot_codex/skills/                  # Custom skill source and metadata
├── dot_local/
│   └── bin/                           # Custom scripts, usage collectors, and AI agent hooks
│       └── cline-safety/              # Git interceptor for Cline safety
├── run_onchange_before_09-install-agent-skills.sh.tmpl
├── run_onchange_after_10-install-omarchy-plugins.sh.tmpl
├── run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl
├── run_onchange_after_21-setup-omarchy-cline.sh.tmpl
├── run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl
├── run_after_23-sync-agent-skills.sh.tmpl
├── run_after_25-sync-omarchy-agents-workspace.sh.tmpl
└── run_onchange_after_26-setup-omarchy-cursor.sh.tmpl
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
