# Manual setup steps

Steps that no tracked file captures. Do these after `yadm bootstrap`, and add
to this list whenever you set something up by hand.

## Omarchy
- `omarchy theme set diocletian`
- `omarchy plymouth set-by-theme diocletian` (boot splash; system-level)

## System services
- Network printer discovery: `sudo systemctl enable --now cups-browsed`
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
