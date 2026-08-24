# Dotfiles

Personal dotfiles managed across macOS and Linux (Omarchy / Arch Linux) using [chezmoi](https://www.chezmoi.io/) and [age](https://github.com/FiloSottile/age) encryption.

---

## 🛠️ Components & Configurations

### 🐚 Shell & Prompt
- **Zsh** (`.zshrc` on macOS): Includes Starship prompt init with failure-recoloring wrapper, mise environment activation, editor defaults, `eza` alias shortcuts (`ls`, `lsa`, `lt`, `lta`), and guarded modern shell QoL hooks.
- **Bash** (`.bashrc` on Linux/Omarchy): Integrates with Omarchy shell defaults, Google Cloud SDK PATH and autocompletion, user PATH entries, coding-agent launch aliases (`codex`, `oc`, `cursor`, sandboxed `cline`), and guarded modern shell QoL hooks.
- **[Starship](https://starship.rs/)** (`~/.config/starship.toml`): Fast, cyan-accented prompt displaying `user@host` (SSH sessions only), directory path with smart repo-root formatting, git branch with a compact dirty-repo dot indicator, in-progress rebase/merge state, detached-HEAD commit hash, and long command duration (`>=3s`).
- **Prompt failure recoloring** (`.zshrc` + `.bashrc`): Both shells hook Starship so every prompt segment renders red after a non-zero exit status and returns to cyan on success — zsh via a `starship_status_prompt` PROMPT wrapper, bash via a `starship_precmd` override.
- **[herdr](https://github.com/harlanljones/herdr)** (`~/.config/herdr/config.toml`): Modern terminal multiplexer configured with tmux-parity keybindings (`Ctrl+Space` prefix), follow-CWD panes/splits, and terminal-native palette.
- **[Ghostty](https://ghostty.org/)** (`~/.config/ghostty/config`): Terminal emulator config with Omarchy theme integration, JetBrainsMono Nerd Font, copy/paste keybindings, and split-resize bindings.
- **Modern shell QoL** (both `.zshrc` and `.bashrc`, each guarded so missing tools never break the shell):
  - **[zoxide](https://github.com/ajeetdsouza/zoxide)**: Smarter `cd` with directory jumping.
  - **[fzf](https://github.com/junegunn/fzf)**: Fuzzy keybindings and completion (`Ctrl-R` history, `Ctrl-T` files).
  - **[atuin](https://github.com/atuinsh/atuin)**: Searchable, synced shell history.
  - **[direnv](https://direnv.net/)**: Per-directory environment loading.

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

### 📦 System Package Manifests
Declarative tracking for system-level packages that mise does not manage:
- **macOS** (`~/.Brewfile`): Homebrew Bundle manifest (`brews` + `casks`, including Ghostty and JetBrainsMono Nerd Font).
  - Restore: `brew bundle --file=~/.Brewfile`
- **Linux / Arch** (`~/.config/pacman/pkglist.txt` + `aurlist.txt`): Explicit native packages and foreign (AUR) packages.
  - Restore: `pacman -S --needed - < pkglist.txt`, then `paru -S --needed - < aurlist.txt`
  - Regenerate: `pacman -Qqen > ~/.config/pacman/pkglist.txt && pacman -Qqem > ~/.config/pacman/aurlist.txt`
- **Dependency gate**: `run_once_before_00-verify-deps.sh.tmpl` fails the first `chezmoi apply` early with per-OS install hints when `git`/`age` are missing, and warns about optional tools.

### 💻 Editor
- **[Neovim](https://neovim.io/) / [LazyVim](https://www.lazyvim.org/)** (`~/.config/nvim/`):
  - **LazyVim Extras**: Configured via `lazyvim.json` for TypeScript, Python, Tailwind, Astro, JSON, Markdown, TOML, Neo-tree, inc-rename, dial, and chezmoi/dotfile utilities.
  - **[blink.cmp](https://github.com/Saghen/blink.cmp)**: Super-tab completion configuration.
  - **vim-be-good**: Vim practice plugin.

### 🐙 Git, Lazygit & Safety Guardrails
- **Git Configuration** (`~/.config/git/config` + `~/.config/git/ignore`):
  - Identity, aliases, rebase-on-pull, histogram diffs, rerere, and `gh`-based credential helpers (gh path templated per-OS).
  - Global ignore for `.claude/settings.local.json` and macOS cruft.
- **[Lazygit](https://github.com/jesseduffield/lazygit)** (`~/.config/lazygit/config.yml`):
  - Custom keybinding `<Ctrl-g>` to generate conventional git commit messages from staged diffs using local LLMs via Ollama.
- **Ollama Commit Generator** (`~/.local/bin/lazygit-ollama-commit.sh`):
  - Automated commit message generation script using `qwen2.5-coder:7b` (configurable via `OLLAMA_COMMIT_MODEL`) with fallback handling and `$EDITOR` review step.
- **Agent Git Safety Policies**:
  - Enforced denial of automated `git commit` and `git push` operations across all coding agent harnesses:
    - **Cline**: `~/.local/bin/cline-safety/git` wrapper intercepting automated commits/pushes.
    - **Codex**: `~/.codex/rules/default.rules` rule definitions blocking direct commits and pushes.
    - **Claude Code**: `~/.claude/settings.json` deny permissions on `Bash(git push *)` and `Bash(git commit *)`.
    - **OpenCode**: `~/.config/opencode/opencode.json` bash permission rules denying `git commit*` and `git push*`.

### 🔐 Secret Management & Issue Tracking
- **[age Encryption](https://github.com/FiloSottile/age)** (`.chezmoi.toml.tmpl`): Chezmoi encrypts sensitive credentials and configurations at rest using age with identity key located at `~/.config/chezmoi/key.txt`.
- **SSH Config** (`~/.ssh/config`): Managed starter with safe defaults (`AddKeysToAgent`) and per-host template; private keys are deliberately NOT managed (see `docs/recovery.md`).
- **[Linear](https://linear.app/) Integration** (`encrypted_private_dot_linear.toml.age` -> `~/.linear.toml`):
  - Encrypted configuration for `@schpet/linear-cli`.
  - **Linear Agent Tracking Skill** (`dot_codex/skills/linear-agent-tracking/`): Enables coding agents to read/query issues, claim tasks, create Wayfinder decision maps, track dependencies, and update ticket statuses.

### 🖥️ Window Management & Hardware (Linux / Omarchy)
- **[Hyprland](https://hyprland.org/)** (`~/.config/hypr/`):
  - **Monitors** (`monitors.lua`): Dual-monitor setup with DP-1 (32" 4K 60Hz on left, 1.6x scale) and DP-2 (27" 2K 240Hz on right, 1.25x scale).
  - **Input** (`input.lua`): Pointer sensitivity and custom input overrides.

### 🤖 Omarchy & AI Coding Agent Integration
- **Cross-Harness Agent Skills** (`.chezmoidata/agent_skills.yaml`, `run_onchange_before_09-install-agent-skills.sh.tmpl`, and `run_after_23-sync-agent-skills.sh.tmpl`):
  - Restores missing third-party skills and safely reconciles the complete shared `~/.agents/skills` catalog into Claude, Cline, Antigravity, Gemini, and Pi without replacing provider-owned variants. Codex and OpenCode consume the shared catalog directly.
  - Keeps custom skills such as `project-doc-planner` and `linear-agent-tracking` in chezmoi while preserving harness-specific `impeccable` builds.
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
  - `run_once_after_24-setup-omarchy-agents.sh.tmpl` configures local state directories and user systemd daemon.
- **Agent Leaderboard Plugin** (`~/dev/omarchy-agents/apps/omarchy-agent-leaderboard/`, deployed to `~/.config/omarchy/plugins/harlan.agent-leaderboard/`):
  - Custom bar widget (`harlan.agent-leaderboard`) ranking token usage across all coding agents (Antigravity, Claude, Cline, Codex, Cursor, Fireworks, OpenCode, Grok, Hermes) across daily, 7-day, and all-time windows.
  - Bundles embedded collectors for Antigravity (`collect-antigravity.py`) and Fireworks (`collect-fireworks.py`).
- **Agents Plugin** (`~/dev/omarchy-agents/apps/omarchy-agent-usage/`, deployed to `~/.config/omarchy/plugins/harlan.agents/`):
  - Custom multi-agent status widget (`harlan.agents`) providing live rate-limit meters, pace, 7-day usage trends, and model breakdown across Claude Code, Cline, Codex, Cursor, Fireworks, and OpenCode.
- **Antigravity CLI Integration** (`run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl`):
  - Sets up `collect-antigravity.py` collector to parse Antigravity CLI sessions, model attribution, and context-weighted token usage.
- **Cline CLI Integration & Automated Scraping** (`run_onchange_after_21-setup-omarchy-cline.sh.tmpl` & `run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl`):
  - Registers Cline in the Agent Leaderboard and Agents widgets; parses `~/.cline/data/sessions` transcripts for per-model, per-day token metrics (`omarchy-agent-usage-cline`).
  - **Automated Rate Limit Scraper**: Headless Google Chrome scraping via Playwright (`omarchy-cline-usage-scrape` and `omarchy-cline-usage-login`) running on a systemd timer (`omarchy-cline-usage-scrape.timer`) to keep real ClinePass limits up to date without manual dashboard visits.
  - **Cline Pass estimated limits & manual override**: When scraping is inactive, estimates windows using reference rates, or accepts manual overrides via `omarchy-cline-usage-override` / `/usage` workflow.
- **Cursor CLI Integration & Automated Scraping** (`run_onchange_after_26-setup-omarchy-cursor.sh.tmpl`):
  - Registers Cursor in the Agent Leaderboard; `omarchy-agent-usage-cursor` parses `~/.config/cursor/chats/*/*/store.db` chat stores for prompt/session/model counts, and combines them with real per-API-call token usage logged by `omarchy-cursor-statusline`.
  - **Token tracking via statusLine hook**: Cursor CLI `statusLine` hook registers `omarchy-cursor-statusline` in `~/.cursor/cli-config.json` to log deduplicated per-call token counts to `~/.local/state/omarchy/agents/cursor/`.
  - **Automated Usage Scraper**: Headless scraping via Playwright (`omarchy-cursor-usage-scrape`) running periodically on a systemd timer (`omarchy-cursor-usage-scrape.timer`) to capture dashboard usage.
  - **Manual override fallback**: `omarchy-cursor-usage-override` allows setting manually-read percentage metrics.
  - `omarchy default agent cursor` / `omarchy agent` launches `cursor-agent --yolo`.
- **OpenCode & OpenCode Go Integration**:
  - `omarchy-agent-usage-opencode`: SQLite collector parsing prompt history, session stats, token usage, and provider rate limits from `~/.local/share/opencode/opencode.db`.
  - **Automated OpenCode Go Scraper**: Headless browser scraper (`omarchy-opencode-go-usage-scrape`) running on a systemd timer (`omarchy-opencode-go-usage-scrape.timer`), interactive login helper (`omarchy-opencode-go-usage-login`), and manual override (`omarchy-opencode-go-usage-override`).
  - **OpenCode Go Skill** (`~/.config/opencode/skills/opencode-go-usage/SKILL.md`): Skill for reading and recording OpenCode Go rolling/weekly/monthly quota figures.
  - **Custom Subagents & MCP**: Defines specialized `codebase-memory`, `codebase-memory-scout`, and `codebase-memory-auditor` personas (`~/.config/opencode/agents/`) configured with `codebase-memory-mcp`.
- **Codex & Claude Code Configuration**:
  - `omarchy-agent-usage-codex`: Collects Codex CLI session logs and app-server RPC metrics.
  - `~/.claude/settings.json`: Configures Claude Code tool execution permissions, git safety hooks, and session hooks for `herdr` agent state and codebase memory reminders.
- **Background Systemd User Services & Timers** (`~/.config/systemd/user/`):
  - `omarchy-agents-dashboard.service`: Web dashboard server for agent monitoring.
  - `omarchy-agents-tunnel.service`: Cloudflare tunnel service exposing the local dashboard securely.
  - `omarchy-agents-analysis.service` & `omarchy-agents-analysis.timer`: Background agent analytics powered by local LLMs via Ollama.
  - `ollama-omarchy-agents.service`: Dedicated local Ollama service for agent analysis tasks.
  - `omarchy-cline-usage-scrape.timer`: Periodic automated scraping of ClinePass rate limits.
  - `omarchy-cursor-usage-scrape.timer`: Periodic automated scraping of Cursor dashboard usage.
  - `omarchy-opencode-go-usage-scrape.timer`: Periodic automated scraping of OpenCode Go usage limits.
- **Omarchy Agent Wrappers & Utilities** (`~/.local/bin/`):
  - `omarchy-agent`: Launch default coding agent with support for Antigravity (`agy`) and Cursor.
  - `omarchy-default-agent`: Quick switcher to configure default coding agent (`omarchy default agent agy`, `omarchy default agent cursor`).
  - `omarchy-agent-usage-update`: Master aggregator running all active collectors (`omarchy-agent-usage-*`) to write standard JSON records into `~/.local/state/omarchy/agents/usage/`.
  - `omarchy-agent-usage-antigravity`, `omarchy-agent-usage-cline`, `omarchy-agent-usage-codex`, `omarchy-agent-usage-cursor`, `omarchy-agent-usage-opencode`: Standalone usage collectors.
  - `omarchy-cursor-statusline`: Cursor CLI `statusLine` hook; logs real per-call token usage.
  - `omarchy-cursor-usage-scrape`, `omarchy-cursor-usage-override`: Cursor limit scraping and override tools.
  - `omarchy-cline-usage-login`, `omarchy-cline-usage-scrape`, `omarchy-cline-usage-override`: ClinePass limit scraper and override utilities.
  - `omarchy-opencode-go-usage-login`, `omarchy-opencode-go-usage-scrape`, `omarchy-opencode-go-usage-override`: OpenCode Go limit scraper and override utilities.

---

## 📂 Repository Structure

```text
.
├── .chezmoidata/
│   ├── agent_skills.yaml                         # Cross-harness global skill manifest
│   └── omarchy_plugins.yaml                      # Manifest for Omarchy desktop plugins
├── .chezmoiignore.tmpl                           # OS-specific ignore rules (Darwin vs. Linux)
├── .chezmoi.toml.tmpl                            # Age encryption configuration
├── .github/workflows/ci.yml                      # CI: dry-run apply validation on Linux + macOS
├── Documents/
│   └── Cline/Workflows/usage.md                  # Interactive ClinePass usage workflow
├── docs/
│   └── recovery.md                               # Age key backup, bootstrap order, doctor checklist
├── dot_Brewfile                                  # Homebrew Bundle manifest (macOS)
├── dot_bashrc                                    # Bash shell configuration (Linux)
├── dot_zshrc                                     # Zsh shell configuration (macOS)
├── dot_claude/
│   └── settings.json                             # Claude Code permissions and session hooks
├── dot_cline/
│   └── data/settings/global-settings.json        # Cline CLI global settings
├── dot_codex/
│   ├── rules/default.rules                       # Codex git commit/push safety policies
│   └── skills/                                   # Custom skills (linear-agent-tracking, project-doc-planner)
├── dot_config/
│   ├── ghostty/                                  # Ghostty terminal emulator config
│   ├── git/                                      # Global git config and ignore file
│   ├── herdr/                                    # Herdr terminal multiplexer config and plugins
│   ├── hypr/                                     # Hyprland monitor & input configs
│   ├── lazygit/                                  # Lazygit configuration
│   ├── mise/                                     # Mise runtime tool configurations
│   ├── nvim/                                     # Neovim / LazyVim configurations
│   ├── omarchy/                                  # Omarchy defaults and shell placement/settings
│   ├── opencode/                                 # OpenCode config, subagent personas, and skills
│   ├── pacman/                                   # Explicit native + AUR package lists (Linux)
│   ├── starship.toml                             # Starship cross-shell prompt configuration
│   └── systemd/user/                             # Systemd services & timers for dashboard, scrapers, and analytics
├── dot_gemini/
│   └── config/mcp_config.json                    # Gemini CLI / Antigravity MCP server definitions
├── dot_local/
│   └── bin/                                      # Custom scripts, usage collectors, scrapers, and AI agent hooks
│       └── cline-safety/                         # Git interceptor for Cline safety
├── encrypted_private_dot_linear.toml.age         # Age-encrypted Linear configuration
├── private_dot_ssh/
│   └── config                                    # SSH client config starter (0600)
├── run_once_before_00-verify-deps.sh.tmpl        # Early dependency gate (git, age, optional tools)
├── run_onchange_before_09-install-agent-skills.sh.tmpl
├── run_onchange_after_10-install-omarchy-plugins.sh.tmpl
├── run_onchange_after_20-setup-omarchy-antigravity.sh.tmpl
├── run_onchange_after_21-setup-omarchy-cline.sh.tmpl
├── run_onchange_after_22-setup-omarchy-cline-usage-scrape.sh.tmpl
├── run_after_23-sync-agent-skills.sh.tmpl
├── run_once_after_24-setup-omarchy-agents.sh.tmpl
├── run_after_25-sync-omarchy-agents-workspace.sh.tmpl
└── run_onchange_after_26-setup-omarchy-cursor.sh.tmpl
```

---

## 🧪 Repo Hygiene & Recovery

- **CI** (`.github/workflows/ci.yml`): On every push/PR, `chezmoi apply --dry-run --exclude encrypted` validates all templates and ignore rules on both Linux and macOS runners (encrypted entries are skipped since CI has no age key), plus a render-and-syntax check of the dependency gate script.
- **Recovery guide** (`docs/recovery.md`): Age key backup procedure, key rotation, new-machine bootstrap order, and the `chezmoi doctor` checklist.

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
- **macOS (`darwin`)**: Installs `.zshrc`, Starship, Mise, Neovim, Lazygit configs, git config, Ghostty, SSH config, and the Homebrew `Brewfile`.
- **Linux (`omarchy`)**: Installs `.bashrc`, Hyprland, Herdr, Omarchy agent integrations, systemd user services/timers, plugin sync hooks, pacman package manifests, and usage collectors/scrapers.

---

## 🔗 Related & Parent Projects

### 🏛️ Parent & Sister Projects
- **[Omarchy Desktop](https://github.com/omarchy/omarchy)**: The core Linux desktop environment providing window management defaults, bar shell placement, plugin hooks, and system-level agent skills.
- **[`harlanljones/omarchy-agents`](https://github.com/harlanljones/omarchy-agents)**: Turborepo monorepo housing the multi-agent web dashboard, background Ollama analytics service, and both custom desktop bar plugins (`harlan.agent-leaderboard` and `harlan.agents`).
- **[`harlanljones/herdr-outpost`](https://github.com/harlanljones/herdr-outpost)**: A lightweight, secure remote dashboard and relay gateway for Herdr.

### 🤖 Coding Agent Harnesses & Knowledge Infrastructure
- **[Google Antigravity & Gemini CLI](https://github.com/google-deepmind)**: Advanced multi-turn agentic coding tool with MCP support and project knowledge graphs.
- **[Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)** ([`anthropics/claude-code`](https://github.com/anthropics/claude-code)): Terminal-based AI agent harness by Anthropic.
- **[Cline](https://github.com/cline/cline)**: Autonomous coding assistant supporting custom tools, workflows, and browser automation.
- **[OpenCode](https://github.com/opencode-ai/opencode)**: Terminal AI coding agent featuring subagent personas and MCP integration.
- **[Cursor](https://cursor.com/)**: AI-first code editor and CLI agent (`cursor-agent`).
- **[OpenAI Codex CLI](https://github.com/openai/codex)**: OpenAI coding agent harness.
- **[codebase-memory-mcp](https://github.com/codebase-memory/codebase-memory-mcp)**: MCP server maintaining knowledge graphs for structural codebase queries and architecture analysis.
- **[Cloudflare Agent Skills](https://github.com/cloudflare/skills)**: Official Cloudflare skills catalog for building Cloudflare Workers, Durable Objects, and agentic workflows.
- **[Linear CLI](https://github.com/schpet/linear-cli)** (`@schpet/linear-cli`): Command-line interface for Linear issue tracking, dependencies, and autonomous ticket management.

### 🛠️ Upstream Tools & Dotfile Foundations
- **[chezmoi](https://www.chezmoi.io/)** ([`twpayne/chezmoi`](https://github.com/twpayne/chezmoi)): Multi-machine dotfile manager.
- **[age](https://github.com/FiloSottile/age)**: Modern file encryption tool used for securing chezmoi secrets.
- **[mise](https://mise.jdx.dev/)** ([`jdx/mise`](https://github.com/jdx/mise)): Polyglot runtime and tool version manager.
- **[Starship](https://starship.rs/)** ([`starship/starship`](https://github.com/starship/starship)): Cross-shell customizable prompt.
- **[LazyVim](https://www.lazyvim.org/)** ([`LazyVim/LazyVim`](https://github.com/LazyVim/LazyVim)) & **[Neovim](https://neovim.io/)**: Modal text editor ecosystem.
- **[Lazygit](https://github.com/jesseduffield/lazygit)** ([`jesseduffield/lazygit`](https://github.com/jesseduffield/lazygit)): Terminal UI for Git commands.
- **[Hyprland](https://hyprland.org/)** ([`hyprwm/Hyprland`](https://github.com/hyprwm/Hyprland)): Dynamic tiling Wayland compositor.
- **[Playwright](https://playwright.dev/)** ([`microsoft/playwright`](https://github.com/microsoft/playwright)): Browser automation framework powering headless usage scrapers.
- **[Ollama](https://ollama.com/)** ([`ollama/ollama`](https://github.com/ollama/ollama)): Local LLM runtime used for automated commit generation and offline agent analytics.

### 🧩 Omarchy Desktop Community Plugins
- **[`anagrius/omarchy-resume`](https://github.com/anagrius/omarchy-resume)**: Desktop resume and session restorer.
- **[`gigor/omarchy-simple-notifications`](https://github.com/gigor/omarchy-simple-notifications)**: Lightweight notification widget.
- **[`IM0001GT/omarchy-hw-tooltip`](https://github.com/IM0001GT/omarchy-hw-tooltip)**: Hardware status and tooltip monitor.
- **[`This-Is-NPC/dockmarchy`](https://github.com/This-Is-NPC/dockmarchy)**: Dock and launcher integration.
- **[`shmall03/omarchy-shmall.lock-plugin`](https://github.com/shmall03/omarchy-shmall.lock-plugin)**: Screen lock and authentication plugin.
- **[`cgmccarron/omarchy-sportsbar`](https://github.com/cgmccarron/omarchy-sportsbar)**: Live sports scores and status widget.


