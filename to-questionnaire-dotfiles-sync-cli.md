# Discovery Questionnaire: Dotfiles Sync Workflow & Chezmoi CLI Wrapper

**Purpose:** Align on IT/DevOps standards, drift resolution policies, hook execution costs, and ergonomics for a unified dotfiles CLI wrapper around chezmoi.

**From:** Harlan, **To:** Lead DevOps / IT Maintainer, **How your answers will be used:** These answers will directly define the architecture, configuration drift handling, hook lifecycle policies, and command surface of the new dotfiles CLI wrapper.

## Context

Our daily development workflow relies on `chezmoi` to manage environment configurations, agent harnesses (Claude Code, Gemini, Cline, Codex), and workstation hooks. Currently, running `chezmoi diff` and `chezmoi apply` creates friction: out-of-band updates from dynamic tools (such as `.claude/settings.json`) trigger persistent interactive drift warnings, and post-apply lifecycle hooks trigger expensive test suites and workspace rebuilds on every run. We are designing a tailored CLI wrapper to streamline syncing, automate drift handling, and enforce sane hook execution.

## How to answer

Please provide your inputs by end of week (~15–20 minutes). Partial answers and "I don't know" or "No preference" are completely acceptable—flag anything that needs discussion rather than skipping it.

## Drift Management & Dynamic Configuration Files

### How should the CLI wrapper handle out-of-band modifications made by AI tools and IDEs (e.g., `.claude/settings.json`)?

_Why this matters: Tools automatically mutate runtime configs (like learned environments or project state), causing chezmoi to halt on every apply with drift warnings._

>

### Is auto-absorbing local changes back into the chezmoi source repo acceptable, or should source templates remain strictly authoritative?

_Why this matters: Determines whether `dots sync` can automatically commit and push local parameter updates or if changes must follow a dedicated PR/approval path._

>

### What strategy do you prefer for files containing both managed baseline settings and ephemeral local state (e.g., JSON patching vs template separation vs partial gitignoring)?

>

## Sync Granularity & Lifecycle Hooks

### Should lifecycle hooks (workspace builds, test suites, daemon reloads) run on every sync, or only when their underlying files change?

_Why this matters: Currently, `run_after_` scripts execute 90+ tests and Turbo builds on every apply even when only dotfiles configs were edited._

>

### Would you support introducing tiered sync commands (e.g., `dots sync --fast` for configs only vs `dots sync --all` for full rebuilds)?

>

### How should hook failures be treated during an active sync operation (fail-fast and rollback vs warning and partial apply)?

>

## CLI Ergonomics & Command Surface

### What primary subcommands and workflow shortcuts do you expect developers to use daily (e.g., `sync`, `diff`, `status`, `edit`, `doctor`)?

>

### How should diffs and dry-runs be presented to minimize terminal noise while maintaining safety?

_Why this matters: `chezmoi diff` often dumps massive script templates alongside actual file diffs, making it hard to spot unintended config mutations._

>

### Should the wrapper enforce automated pre-flight health checks (e.g., verifying age encryption keys, Mise/Bun toolchains, systemd state) before applying changes?

>

## Security, Secrets & Baseline Governance

### Which dotfiles and environment configurations must remain strictly enforced across all workstations versus open to developer customization?

>

### Are there specific secrets management or key rotation standards (e.g., age keys, 1Password CLI, Bitwarden) that the wrapper must integrate with?

>

## Anything else?

Is there anything we didn't ask regarding workstation provisioning, multi-OS support (Linux/Omarchy vs macOS), or toolchain management that should shape this wrapper?

>
