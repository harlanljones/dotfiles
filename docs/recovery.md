# Recovery & Bootstrap Guide

What breaks on a lost laptop, a dead disk, or a fresh machine -- and how to get
back to a fully applied setup.

---

## 1. The age key is the crown jewel

Everything sensitive in this repo (currently `encrypted_private_dot_linear.toml.age`)
is encrypted with [age](https://github.com/FiloSottile/age) against:

| Item | Location / Value |
| --- | --- |
| Identity (private key) | `~/.config/chezmoi/key.txt` |
| Recipient (public key) | `age1hf4200nhdqg0l3xs68v4gef6mn0nuvmh72573m3nfj8kqpcs7pnsmfkuw6` |
| Config wiring | `.chezmoi.toml.tmpl` |

**Without `key.txt`, every encrypted file in the repo is permanently
unreadable.** The repo alone is not a backup.

### Back it up now

1. Copy `key.txt` to at least one offline location:
   - Encrypted USB drive, or
   - A password manager secure note (it is a short text file), or
   - An encrypted cloud vault.
2. Verify the copy: `diff ~/.config/chezmoi/key.txt /path/to/backup/key.txt`
3. Record where the backup lives somewhere other than this machine.

### If the key is lost

Encrypted entries cannot be recovered. Delete the `.age` files, re-create their
plaintext contents by hand (`chezmoi add --encrypt <file>` after restoring the
secret values from their original providers), and rotate nothing else -- age
keys are not shared with anyone else.

### Rotating the key

```bash
age-keygen -o ~/.config/chezmoi/key.txt.new   # generates new identity + prints recipient
# Update recipient in .chezmoi.toml.tmpl, then:
chezmoi state delete-bucket --bucket=entryState  # force re-evaluation of entries
for f in *.age; do chezmoi forget "/$(echo "$f" | sed -E 's/^encrypted_private_dot_//; s/\.age$//')"; done
# Re-add each secret: chezmoi add --encrypt <plaintext-file>
```

Simplest path if you still have both keys: decrypt everything with the old
identity, swap the key + recipient, and `chezmoi add --encrypt` again.

---

## 2. New-machine bootstrap order

```bash
# 1. Restore the age key BEFORE applying
mkdir -p ~/.config/chezmoi
# copy key.txt from your backup into ~/.config/chezmoi/key.txt

# 2. Initialize and apply
chezmoi init --apply https://github.com/harlanljones/dotfiles.git
```

The first script that runs (`run_once_before_00-verify-deps.sh`) checks for
`git` and `age` and fails early with install hints if they are missing.

Then install system packages:

- **macOS**: `brew bundle --file=~/.Brewfile`
- **Linux**: `pacman -S --needed - < ~/.config/pacman/pkglist.txt` then AUR
  entries via paru/yay: `paru -S --needed - < ~/.config/pacman/aurlist.txt`

Finally review what the apply produced:

```bash
chezmoi doctor          # health check (see checklist below)
systemctl --user status omarchy-agents-dashboard.service   # Linux only
```

---

## 3. `chezmoi doctor` checklist

Run `chezmoi doctor` and confirm:

- [ ] `config file` points at your `~/.config/chezmoi/chezmoi.toml` (generated
      from `.chezmoi.toml.tmpl`) and shows the age encryption config
- [ ] `age identity file exists` / is readable (`ls -l ~/.config/chezmoi/key.txt`)
- [ ] `source directory` is a git repo with a clean-ish working tree
      (`cd ~/.local/share/chezmoi && git status`)
- [ ] `git command` version reported without warnings
- [ ] suspicious-warnings section is empty (unexpected file modes, etc.)

Known-good baseline for comparison: run `chezmoi doctor` on this machine and
save the output next to this doc before making big changes.

---

## 4. What is deliberately NOT managed here

- **SSH private keys** (`~/.ssh/id_*`) -- provision out-of-band; only
  `~/.ssh/config` is managed. Prefer the configured **1Password SSH agent**
  (`~/.config/1password/ssh/agent.toml`): save keys as vault items so they
  never touch disk; on-disk `~/.ssh/id_ed25519` remains the fallback.
- **Age key itself** (`~/.config/chezmoi/key.txt`) -- never put it in the repo.
- **Browser profiles / gh auth state** -- log in per machine
  (`gh auth login` restores the git credential helper used by `dot_config/git/config`).
