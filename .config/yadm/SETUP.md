# Manual setup steps

Steps that no tracked file captures. Do these after `yadm bootstrap`, and add
to this list whenever you set something up by hand.

## Omarchy
- `omarchy theme set diocletian`
- `omarchy plymouth set-by-theme diocletian` (boot splash; system-level)

## System services
- Network printer discovery: `sudo systemctl enable --now cups-browsed`
- Ollama (local models on the NVIDIA GPU): `sudo systemctl enable --now ollama`
  (cups itself is enabled by Omarchy).

## 1Password
- Sign in to the desktop app.
- Settings → Developer → turn on "Use the SSH agent". The tracked
  `~/.ssh/config` points every host at `~/.1password/agent.sock`, and the
  tracked `~/.config/1Password/ssh/agent.toml` limits the agent to keys in the
  **Agents** vault.
- Keep every secret and SSH key this repo uses in the **Agents** vault. No
  other vault is used.
- Settings → Developer → turn on "Integrate with 1Password CLI", so
  `op inject` in bootstrap can render secrets.
- Log in to GitHub: `gh auth login`, then
  `gh auth refresh -h github.com -s admin:ssh_signing_key`. Don't let gh create
  an SSH key on disk; the Agents vault key ("SSH Key") is registered on GitHub
  for both authentication and commit signing. Check with
  `ssh -T git@github.com`.

## Apps installed outside the package manager
- **Hermes**: `omarchy install ai hermes`. `~/.hermes/config.yaml` and
  `SOUL.md` are tracked; sign in to Nous (the configured provider) on first run.
- **codebase-memory-mcp** (code knowledge graph MCP for Claude): download
  https://raw.githubusercontent.com/DeusData/codebase-memory-mcp/main/install.sh,
  read it, then run `bash install.sh --clients=claude,codex,opencode,gemini,hermes`. It installs the binary
  and its updater (`install.sh`) in `~/.local/bin`, registers the MCP server in
  `~/.claude.json`, `~/.codex/config.toml` `~/.config/opencode/opencode.json` and `~/.gemini/settings.json`, and writes its hooks, subagents,
  skill and `~/.codex/AGENTS.md` block; the hook entries in the tracked
  `~/.claude/settings.json` and `~/.codex/config.toml` come back as-is. It also appends a
  PATH line to `~/.bashrc`: delete it (Omarchy already puts `~/.local/bin` on PATH).
- **Claude Code plugins**: `~/.claude/settings.json` (tracked) lists them, but
  install them with `claude plugin install <name>@claude-plugins-official` and,
  for impeccable, `claude plugin marketplace add pbakaus/impeccable` then
  `claude plugin install impeccable@impeccable`.
- **Tern 0.9.4** (deferred: downloads are invite-only for now). Currently
  extracted under `~/Downloads/Tern-0.9.4-linux-x86_64/` and linked as
  `~/.local/bin/tern`. When it's publicly downloadable, record the source URL
  here and move it to `~/.local/opt/tern/<version>/`. Tern manages its own
  runtime in `~/.local/share/tern` (not tracked).

## Not tracked on purpose
- `~/.XCompose`: the Omarchy installer generates it from your name and email.
- WirePlumber's saved volumes and default devices in `~/.local/state/wireplumber/`.
  The audio defaults rule (`~/.config/wireplumber/wireplumber.conf.d/51-audio-defaults.conf`)
  is rendered from the Agents vault item `wireplumber-audio-defaults`, because
  it names specific hardware; it applies when no saved state exists.
- `~/.config/git/identity`: rendered from the Agents vault item `git-identity`.
