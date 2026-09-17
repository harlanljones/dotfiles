# Dotfiles

This repository manages personal dotfiles across Linux and macOS.
It uses [chezmoi](https://www.chezmoi.io/) for configuration management.
It uses [age](https://github.com/FiloSottile/age) for secret encryption.
It keeps tools, editors, and shells aligned across multiple workstations.

## Quick Start

### New Machine Setup

One line on a bare machine (installs chezmoi if needed, then applies the dotfiles):

```bash
curl -fsLS https://raw.githubusercontent.com/harlanljones/dotfiles/main/install.sh -o /tmp/dotfiles-install.sh \
    && sh /tmp/dotfiles-install.sh
```

Downloading to a file (rather than piping into `sh`) means a failed download errors out instead of silently doing nothing.

An interactive TTY is expected on first apply (the encrypted opencode entry prompts for the age identity). The script refuses to run as root, checks for git/curl with a per-OS install hint (pacman / dnf / apt based on the OS family), and is safe to re-run. If it finds pre-existing dotfiles that chezmoi does not yet manage (e.g. an existing `~/.zshrc` on a machine with no `~/.config/chezmoi` state), it warns prominently that they will be overwritten: with a TTY it asks for confirmation, non-interactively it proceeds but prints the same warning (set `CHEZMOI_INSTALL_ASSUME_YES=0` to abort instead). To inspect before overwriting, run `chezmoi init` without `--apply`, or use the guided `setup.sh` below.

For a guided interactive onboarding (machine role, theme, age key from 1Password), clone and run the setup wizard instead:

```bash
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
| `dots backup` | Archives the current state of files an apply would change to `~/.local/share/dots-backups/` (tar + sha256 manifest) for rollback. |
| `dots uninstall` | Restores the latest backup, then removes chezmoi-managed files from the home directory (TTY confirmation or `--yes` required). |
| `dots edit <file>` | Opens the source template for a managed file in your editor. |
| `dots update` | Pulls the latest changes from git and applies them. |
| `dots push` | Adds modified files, generates a commit message, and pushes to git. |
| `dots theme` | Lists available color themes or switches the active theme. |
| `dots doctor` | Runs health checks on tools, agent skills, template drift, and age-key safety (presence, 0600 mode, rotation age, documented 1Password backup). |
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

### Machine identity, role, and unknown hosts

`.chezmoi.toml.tmpl` resolves the machine once and exposes it to every
template, together with derived feature booleans:

| Variable | Meaning |
| :--- | :--- |
| `.machine` | Resolved machine key: `augustus`, `hadrian`, `vespasian`, `unknown`, or a validated freeform wizard answer (lowercase letters, digits and dashes only). |
| `.role` | `work` or `personal`, from the `type` field in `machines.yaml`. |
| `.headless` | True when there is no local desktop session to configure (WSL, unregistered hosts). |
| `.isCI` | Running in CI (`CI=true` in the environment). |
| `.isSSH` | Connected over SSH (`SSH_CONNECTION` set). |
| `.isWSL` | Running under WSL (kernel reports `microsoft`). |

On an unrecognized host, templates consult the `unknown` entry in
`machines.yaml` (through the `.chezmoitemplates/machine-theme-name` partial
and guarded lookups), so ANY machine name — registered key, freeform wizard
answer, or `unknown` — resolves to sane defaults instead of failing. If no
valid machine is resolved, a prompt-once wizard asks which machine this is
and stores the answer in the chezmoi config (validated as lowercase letters,
digits and dashes; anything else falls back to `unknown`), so re-runs never
re-ask: the stored name takes precedence over the hostname/OS heuristics on
every later run. Because the OS fallback resolves every linux/darwin host,
the wizard can only actually appear on non-Unix hosts, or on a Unix host
whose stored name is missing or invalid. Non-interactive contexts (CI,
scripts) skip the prompt and render with `machine = unknown`.

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

### Secret Scanning

Gitleaks scans commits for secrets. CI runs a full-history scan, and a
pre-push hook (`~/.config/git/hooks/pre-push`, wired via `core.hooksPath` in
`~/.config/git/config`) scans outgoing commits with `--redact` on every
machine before a push leaves it. Gitleaks itself is installed by mise
(`~/.config/mise/config.toml`); if it is missing, the hook warns and lets the
push through.

### Commit Message Guard

A commit-msg hook (`~/.config/git/hooks/commit-msg`, wired via the same
`core.hooksPath`) validates every commit message as a Conventional Commit —
`type(scope)?: subject`, non-empty subject, ≤ 100 chars, no control/garbled
characters — while allowing git's own default merge/revert/fixup messages.
`dots push` reuses the same hook to validate its Ollama-generated message and
falls back to a safe `chore: dots sync` default if generation produces
empty, garbled, or non-conventional output.

Side effect of the machine-global `core.hooksPath = ~/.config/git/hooks`:
plain `.git/hooks/` scripts in other repos on this machine are bypassed and
will not run. Repo-local `core.hooksPath` settings (e.g. Husky in a JS
project) still win over the global one.

### Tool Management

Tool versions are managed declaratively with [mise](https://mise.jdx.dev/).
Configuration lives in `~/.config/mise/config.toml`.
Mise manages runtimes for Node.js, Bun, Python, Go, and Terraform.
System package manifests live in `dot_config/pacman/`, `dot_config/apt/`, and `dot_Brewfile`.
Health checks verify that required mise tools are installed on the local system.
`dots doctor` also diffs each package manifest against what is actually
installed (brew bundle check / `pacman -Qqen|-Qqem` / `apt-mark showmanual`),
so "installed it manually and forgot the manifest" drift is caught per machine.

#### Tool ownership (one manager per tool)

Each CLI/runtime is owned by exactly one manager — never install a tool through
two of these, or an apply will fight your package manager:

| Manager | Manifest | Owns |
| --- | --- | --- |
| mise | `~/.config/mise/config.toml` (+ `conf.d/vespasian.toml` on WSL) | bun, chezmoi, claude, codex, copilot, gemini, gh, go, node, opencode, pi, pnpm, python, ruby, terraform, tflint, uv; on Vespasian also the CLI utilities (atuin, bat, delta, eza, fd, fzf, lazygit, neovim, ripgrep, starship, zoxide) |
| npm/bun | root `package.json` + `bun.lock` | @magnitudedev/cli, @nanonets/graft, @schpet/linear-cli, cline, freebuff, supabase, wrangler |
| Homebrew (macOS) | `~/.Brewfile` | brews + casks (Ghostty, JetBrainsMono Nerd Font, …) |
| pacman/paru (Augustus) | `dot_config/pacman/pkglist.txt` + `aurlist.txt` | native + AUR packages |
| apt (Vespasian) | `dot_config/apt/pkglist.txt` | age, build-essential, curl, erlang-nox, jq, postgresql, sqlite3, tailscale, unzip |
| standalone/scripts | `dot_local/bin/`, `~/.fly/bin` | flyctl, evot, chrome-profile, custom usage collectors |

Install order on a new machine: system packages first (Brewfile / pkglist /
apt), then `mise install`, then the npm-layer `bun install` at the repo root —
later layers never own something an earlier one provides.

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

## Local overrides

Machine-local or personal edits should never enter the repo. Two sanctioned,
unmanaged files exist for them:

- `~/.config/shell/local.sh` — loaded last by the managed
  `dot_config/shell/80-local.sh` (works in both bash and zsh). Because
  `local.sh` has no entry in the source tree, chezmoi never creates, overwrites
  or deletes it; every `chezmoi apply` leaves it untouched.
- `~/.gitconfig.local` — included from `dot_config/git/config.tmpl`; git
  silently skips the include until the file exists, and chezmoi never touches it.

Edit these instead of managed files (`~/.bashrc`, `~/.zshrc`,
`~/.config/git/config`): managed files are clobbered on the next apply. See
[`dot_config/shell/README.md`](dot_config/shell/README.md) for details.

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
│   ├── generated
│   │   └── gen-6bd5de2cd3e4
│   │       └── windows_terminal.json
│   ├── hermes_skills.yaml
│   ├── machines.yaml
│   ├── omarchy_agents.yaml
│   ├── omarchy_plugins.yaml
│   └── themes.yaml
├── .chezmoiignore.tmpl
├── .chezmoitemplates
│   ├── aether-adapters/ (10 files — per-tool theme adapters)
│   ├── codex-config.toml
│   ├── gemini-settings.json
│   ├── gen-palette.tmpl
│   ├── littlebigmouse
│   │   └── Current.xml
│   ├── machine-theme-name.tmpl
│   └── themes/ (121 files across 13 themes — see .chezmoidata/themes.yaml)
├── .yamllint.yml
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
│   │   ├── btop.conf.tmpl
│   │   └── themes
│   │       └── dots.theme.tmpl
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
│   │   ├── hooks
│   │   │   ├── executable_commit-msg
│   │   │   └── executable_pre-push
│   │   └── ignore
│   ├── herdr
│   │   ├── config.toml.tmpl
│   │   ├── plugins
│   │   │   └── config
│   │   │       └── hhdebb.herdr-radar
│   │   │           ├── config.toml
│   │   │           └── hook.js
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
│   │           ├── dashboard-dots-identity.lua
│   │           ├── empty_html-preview.lua
│   │           ├── example.lua
│   │           ├── faster-smear-cursor.lua
│   │           ├── herdr-nvim.lua
│   │           ├── mini-animate-disable-cursor.lua
│   │           ├── theme.lua.tmpl
│   │           └── vim-be-good.lua
│   ├── omarchy
│   │   ├── create_private_shell.json.tmpl
│   │   ├── defaults
│   │   │   └── agent.tmpl
│   │   └── hooks
│   │       └── theme-set.d
│   │           └── executable_backdrop-split
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
│   │   ├── 61-splash.sh
│   │   ├── 65-theme.sh
│   │   ├── 70-cloud.sh
│   │   ├── 75-tool-paths.sh
│   │   ├── 80-local.sh
│   │   └── README.md
│   ├── starship.toml.tmpl
│   ├── systemd
│   │   └── user
│   │       ├── herdr-outpost-relay.service
│   │       ├── ollama-omarchy-agents.service
│   │       └── omarchy-* units (13 — scrapers, relays, daemons)
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
│   └── skills/ (456 files across 36 skill groups — see .chezmoidata/hermes_skills.yaml)
├── dot_local
│   ├── bin
│   │   ├── cline-safety
│   │   │   └── executable_git
│   │   ├── executable_agent-console-home
│   │   ├── executable_backdrop-split
│   │   ├── executable_chrome-profile
│   │   ├── executable_cursor
│   │   ├── executable_dots
│   │   ├── executable_dots-identity
│   │   ├── executable_dots-push
│   │   ├── executable_dots-theme-import-aether
│   │   ├── executable_herdr-agent-lifecycle
│   │   ├── executable_lazygit-ollama-commit.sh
│   │   ├── executable_ollama-commit-msg.sh
│   │   ├── executable_omarchy-agent-usage-<agent>.tmpl (7 agents)
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
│       ├── figlet
│       │   ├── README.md
│       │   └── Roman.flf
│       ├── omarchy-patches
│       │   ├── esemczak.theme-modes-profiles.patch
│       │   └── io.github.codesmith28.omalt-tab-compact.patch
│       └── wsl-ssh-bridge
│           └── main.go
├── dot_pi
│   └── agent
│       └── skills
│           └── symlink_project-doc-planner
├── dot_zshrc
├── install.sh
├── private_dot_grokbot
│   └── settings.json
├── private_dot_ssh
│   └── config.tmpl
├── run_* apply hooks (24 — see INDEX.md § Apply hooks for trigger/phase)
└── theme-assets/ (8 files across 8 wallpaper sets)
```
<!-- END REPO TREE -->