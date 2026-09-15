---
name: dots
description: MUST USE whenever creating, modifying, deleting, reviewing, or syncing user configuration files, dotfiles, or application settings (~/.config/*, ~/.zshrc, ~/.bash*, ~/.local/*, ~/.agents/*, Hyprland, Neovim, tmux, git configs, scripts, etc.). Provides workflows for chezmoi drift capture (dots absorb), previewing diffs (dots diff), applying changes (dots sync), health diagnostics (dots doctor), and committing/pushing with Ollama conventional commit messages (dots push).
---

# Dots: Dotfiles Management & Synchronization

This environment manages user dotfiles and system configurations using `chezmoi` via the `dots` CLI wrapper (`~/.local/bin/dots`).

Always follow this skill whenever modifying or inspecting dotfiles or configuration files on this system to ensure changes are properly tracked in version control and deployed without configuration drift.

---

## Core Workflows

### 1. Workflow: Modifying Live Files in `$HOME`
When editing configuration files directly in their target locations (e.g., `~/.config/nvim/init.lua`, `~/.zshrc`, `~/.config/hypr/hyprland.conf`):

1. **Perform the edit** in the target file located under `$HOME`.
2. **Absorb changes into chezmoi source repo**:
   ```bash
   dots absorb <path-to-modified-file>
   ```
   *(Or `dots add <path>` / `chezmoi re-add <path>`)*
3. **Verify diff and status**:
   ```bash
   dots diff
   dots status
   ```
4. **Re-sync to ensure clean alignment**:
   ```bash
   dots sync
   ```
5. **Commit and push** (if committing changes was requested or is appropriate):
   ```bash
   dots push
   ```

---

### 2. Workflow: Editing Files Directly in the Chezmoi Source Repo
When editing source files directly in the repository (`~/.local/share/chezmoi` or `dot_*` files):

1. **Perform the edit** on the appropriate template or source file in `~/.local/share/chezmoi/`.
2. **Preview the changes**:
   ```bash
   dots diff
   ```
   *(Add `-a` or `--all` if you modified `run_*` scripts or templates)*
3. **Apply the changes to `$HOME`**:
   ```bash
   dots sync
   ```
   *(Use `dots sync --dry-run` if you want a safety check before applying)*
4. **Validate target configuration** (e.g., test command syntax, run linter, or run `dots doctor`).
5. **Commit and push**:
   ```bash
   dots push
   ```

---

## CLI Command Reference (`dots`)

| Command | Description | Common Flags / Usage |
| :--- | :--- | :--- |
| `dots sync` / `dots apply` | Apply managed dotfiles from source repo to `$HOME` | `-n` / `--dry-run` (preview actions)<br>`-v` / `--verbose`<br>`-f` / `--force` |
| `dots diff` | Show clean diff of pending changes between repo and `$HOME` | `-a` / `--all` (includes generated `run_*` script contents) |
| `dots status` / `dots st` | Show drift and status of managed files (`modified`, `added`, `deleted`, `untracked`) | `dots status` |
| `dots absorb` / `dots add` | Re-add / capture modified live files from `$HOME` into chezmoi source repo | `dots absorb ~/.config/nvim/lua/config/keymaps.lua` |
| `dots edit` / `dots ed` | Edit the source template corresponding to a managed file | `dots edit ~/.zshrc` |
| `dots update` / `dots pull` | Pull latest remote changes from git with rebase and apply | `dots update` |
| `dots push` / `dots pp` | Re-add modified targets, generate a conventional commit message with Ollama (`qwen2.5-coder:7b`), commit, and push | `dots push` |
| `dots doctor` | Run diagnostics on toolchains (`chezmoi`, `mise`, `bun`), age encryption keys, agent skill links, and settings drift | `dots doctor` |
| `dots cd` | Print or navigate to the chezmoi source directory (`~/.local/share/chezmoi`) | `dots cd` |

---

## Key Rules & Guidelines for Agents

- **Never bypass chezmoi**: If you create a new configuration file in `$HOME` that should be persisted across machines, add it via `chezmoi add <path>` or `dots absorb <path>`.
- **Always absorb before committing**: If you modified a live target file, run `dots absorb <path>` or `chezmoi re-add` before running git commands in the chezmoi source repository.
- **Inspect diffs before applying**: Use `dots diff` when making complex template edits to confirm the expanded output matches your expectations.
- **Encrypted Secrets**: Sensitive files (e.g., private keys, API credentials) must use `age` encryption (e.g. `encrypted_private_*.toml.age`). Check key availability with `dots doctor`. Never commit raw secrets in plain files.
- **Templates and Scripts**:
  - Files with `.tmpl` are processed by the Go template engine.
  - Scripts prefixed with `run_onchange_` or `run_after_` execute during `dots sync` when modified.
