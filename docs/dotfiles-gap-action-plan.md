# Dotfiles Gap Action Plan

Generated 2026-09-15 from a multi-source research pass (14 public dotfile repos on
GitHub, X threads, r/unixporn + r/dotfiles + r/NixOS + r/neovim, HN/Lobsters/blogs)
cross-referenced with a local audit of this repo at HEAD `4a65cc6`.
Raw evidence: `/tmp/dotfiles-research/` (github.md, twitter.md, reddit.md, forums.md,
local-audit.md) — not tracked; re-copy here if the plan is executed long after generation.

Legend: effort S ≤1h, M ≤ half a day, L ≥ a day. Priority = recommended order.

---

## Phase 1 — Guardrails (prevent observed failure modes)

- [x] **1.1 Pre-push secret-scan git hook** — Priority 1, effort S
  - Done: 42ef122 (`dot_config/git/hooks/executable_pre-push`, wired via `core.hooksPath`)
  - Ship `gitleaks` (or `secretlint`) as a pre-push hook installed by a run_* hook
    (pattern: mizchi/chezmoi-dotfiles, craftzdog/dotfiles).
  - Files: new `run_onchange_after_33-install-git-hooks.sh.tmpl` (hooks live in
    `dot_config/git/hooks/` via `core.hooksPath`).
  - Why: CI gitleaks only covers this repo's git history; the hook makes scanning
    follow the repo to every machine and blocks secrets before they land.
  - Accept: pushing a staged fake token is rejected locally.

- [x] **1.2 commit-msg guard on the `dots push` AI-message path** — Priority 1, effort S
  - Done: a6ece61 + d94b9a2 (commit-msg hook + hardened `dots push`)
  - Recent history contains a corrupted AI-generated commit message (`ba99c33`).
  - Add a commit-msg hook validating Conventional Commit format + non-empty/no
    control characters, and harden the Ollama message generation in `dots` to
    fail closed (reject empty/garbled output instead of committing it).
  - Files: `dot_config/git/hooks/commit-msg`, `dot_local/bin/executable_dots`.
  - Accept: malformed message is refused by hook and by `dots push`.

- [x] **1.3 Backup before apply + uninstall path** — Priority 3, effort M
  - Done: 72f1309 (`dots backup`, `dots uninstall`)
  - Extend `dots` with `dots backup` (timestamped tar of managed targets that would
    change, computed from `chezmoi apply --dry-run` diff) and `dots uninstall`
    (remove managed files listed in INDEX, restore `.bak`).
  - Pattern: end-4/dots-hyprland `setup uninstall`, hyprdots `uninstall.sh`,
    gpakosz timestamped pre-overwrite backup.
  - Files: `dot_local/bin/executable_dots`.
  - Accept: backup→uninstall→apply round-trip restores a working shell on a test VM.

- [x] **1.4 Age-key backup & rotation runbook automation** — Priority 3, effort M
  - Done: 981948c (`dots doctor` age-key checks; 1Password backup/restore via `dots age`)
  - One age key (`~/.config/chezmoi/key.txt`) is a single point of failure for the
    only encrypted entry. Recovery is documented but unautomated.
  - Add `dots doctor` check: key present, backed up to approved location(s),
    `age`/`chezmoi` versions current. Optionally scripted export reminder.
  - Files: `dot_local/bin/executable_dots` (doctor subcommand), docs/recovery guide.

## Phase 2 — CI hardening

- [x] **2.1 Execute a real (non-dry-run) apply on the Linux runner** — Priority 2, effort M
  - Done: 3ba13b4 (nightly smoke-apply, asserts rc + shell modules parse)
  - Today every CI job is `--dry-run --exclude encrypted`; no hook except verify-deps
    is ever executed. Plugin/collector/WSL-hook regressions ship unvalidated.
  - Add a smoke-apply job: `chezmoi init --apply` with the augustus config on
    ubuntu-latest, tolerate expected network/tool failures per hook, then assert
    `~/.zshrc` and `~/.config/shell/` exist and are loadable (`zsh -n`, `bash -n`).
  - Files: `.github/workflows/ci.yml`.
  - Accept: workflow runs weekly + on push; hook script regressions caught.

- [x] **2.2 Pin and harden the hadrian (macOS) CI job** — Priority 2, effort S
  - Done: b86b3df (hadrian pinned on macos-14, hadrian-scoped script rendered+shellchecked)
  - macOS job is dry-run only, no machine pin, `30-hadrian-macos-defaults` never
    rendered/shellchecked. Pin via the same sed-on-rendered-config trick used for
    vespasian; shellcheck rendered hadrian-scoped scripts.
  - Files: `.github/workflows/ci.yml`.

- [x] **2.3 Nightly scheduled CI** — Priority 2, effort S
  - Done: 3ba13b4 (`schedule: cron '17 6 * * *'`)
  - `schedule: - cron: '17 6 * * *'` on the apply + shellcheck jobs (kaihowl pattern)
    to catch upstream tool breakage between personal commits.
  - Files: `.github/workflows/ci.yml`.

- [x] **2.4 yamllint / TOML validation of `.chezmoidata/*.yaml`** — Priority 2, effort S
  - Done: d82dc1e (yamllint + yaml.safe_load / toml checks)
  - Malformed data files currently fail only at apply time on a real machine.
  - Add yamllint + a `python3 -c yaml.safe_load` loop (or `taplo`) over
    `.chezmoidata/` and `dot_config/mise/**.toml` to CI.
  - Files: `.github/workflows/ci.yml`, `.yamllint.yml`.

- [x] **2.5 Raise shellcheck severity + test the dual-shell modules** — Priority 3, effort M
  - Done: 2026-09-15: fixed all 16 style findings (SC2015/2016/2024/2012), raised to `-S style`, pinned shellcheck v0.10.0 in CI, added `docs/test_shell_modules.py` loader-order smoke test
  - Threshold is `-S warning`; shell modules (~580 lines sourced by both bash and
    zsh) have no unit tests and no zsh/bash compatibility test.
  - Raise to `-S style` (kaihowl does this), pin the shellcheck version, add a CI
    step sourcing each `dot_config/shell/*.sh` under both `bash -n` and `zsh -n`
    plus a minimal smoke harness for the numeric loader order.
  - Files: `.github/workflows/ci.yml`, optional `dot_config/shell/tests/`.

- [x] **2.6 Machine pin coverage for augustus + the `unknown` fallback** — Priority 3, effort S
  - Done: b86b3df (augustus + unknown-machine matrix legs)
  - Only vespasian is pinned; the default guess and `machine=unknown` path are
    untested. Add explicit pins for augustus and one unknown-hostname job, assert
    templates render without the Omarchy-only files.
  - Files: `.github/workflows/ci.yml`, `.chezmoi.toml.tmpl` if needed.

- [x] **2.7 Scan rendered output, not just the git repo** — Priority 4, effort S
  - Done: 3ba13b4 (gitleaks over rendered $HOME, `.github/gitleaks-smoke.toml`)
  - CI gitleaks covers git history; rendered files that land on disk are never
    scanned. In the smoke-apply job, run gitleaks over the rendered target dir.
  - Files: `.github/workflows/ci.yml`.

## Phase 3 — Bootstrap & machine identity

- [x] **3.1 One-line bootstrap install.sh** — Priority 4, effort M
  - Done: 248d41a (`setup.sh` bootstrap)
  - Canonical pattern (twpayne/dotfiles, chezmoi/dotfiles, mizchi): script installs
    chezmoi itself (`curl -fsLS chezmoi.io/get | sh`) then
    `exec chezmoi init --apply <repo>`. Guard: refuse root (gpakosz/end-4 pattern).
  - Files: `setup.sh` (extend or replace), README quick-start, `.chezmoiignore`.
  - Accept: fresh VM reaches a usable shell with one copy-paste command.

- [x] **3.2 Interactive first-run wizard for unknown hosts** — Priority 4, effort M
  - Done: 9b48e60 (prompt-once wizard + unknown-machine fallback)
  - `.chezmoi.toml.tmpl`: `promptStringOnce`/`promptBoolOnce` for machine identity
    and role when hostname heuristics miss (natelandau, chezmoi template repo).
    Prompts must be skipped when non-interactive (CI already covered).
  - Eliminates the untested `machine=unknown` path becoming a silent mis-apply.
  - Files: `.chezmoi.toml.tmpl`, AGENTS.md §1 machine-resolution text.

- [x] **3.3 Machine-role feature booleans** — Priority 5, effort M
  - Done: 9b48e60 (role booleans in `.chezmoi.toml.tmpl`)
  - Beyond per-machine: compute `work/personal/headless/ephemeral` style booleans
    in `.chezmoi.toml.tmpl` (twpayne pattern) so templates gate on role, not
    hostname. Reduces per-machine template sprawl.
  - Files: `.chezmoi.toml.tmpl`, consumers across `*.tmpl` as touched.

- [x] **3.4 Sanctioned local-override layer** — Priority 5, effort M
  - Done: d005966 (sanctioned local-override layer for shell + git)
  - `*.local` mechanism per tool so machine-local/personal edits never enter the
    repo (thoughtbot dotfiles-local, holman gitconfig.local.symlink, gpakosz
    `.tmux.conf.local`). At minimum: document + hook the convention for git
    (`~/.gitconfig.local` includeIf) and shell (`60-local.sh` guarded include).
  - Files: `dot_config/shell/`, `dot_config/git/config.tmpl`, AGENTS.md.

- [x] **3.5 `dots diagnose`** — Priority 6, effort S
  - Done: 2026-09-15: `dots diagnose` writes a self-contained snapshot (os-release, versions, systemd user units/services, manifests, git state) to /tmp/dots-diagnose-<host>-<ts>.txt
  - Complement `dots doctor`: dump versions, distro/OS release, systemd user units,
    running services, manifest state into one self-contained file for
    cross-machine debugging (end-4 pattern).
  - Files: `dot_local/bin/executable_dots`.

## Phase 4 — Manifests & drift

- [x] **4.1 Package manifest drift detection** — Priority 5, effort M
  - Done: 2026-09-15: `dots doctor` §10 diffs installed vs declared per machine (brew bundle check / pacman -Qqen+-Qqem / apt-mark showmanual); exits 1 on drift. Already surfaced real drift on augustus (mise vs mise-bin, 7 undeclared AUR packages)
  - Three manifests (Brewfile, pacman pkglist+aurlist, apt pkglist, mise conf.d)
    with no check that installed packages match the manifests — the classic
    "forgot to add it to the manifest" rot.
  - Add `dots doctor` checks and/or CI job: `brew bundle check`, pacman
    `pacman -Qqen`/`-Qqem` diff vs pkglist/aurlist, apt `comm` vs pkglist.
  - Files: `dot_local/bin/executable_dots`, CI, README.

- [x] **4.2 Surface tool-ownership + install order in README** — Priority 6, effort S
  - Done: 2026-09-15: README 'Tool ownership (one manager per tool)' table + install order added under Tool Management
  - §5 table exists in AGENTS.md; mirror a condensed ownership + install-order
    diagram in README (mizchi's layer table is best-in-class).
  - Files: `README.md` (manual section, not generated tree).

## Phase 5 — Repo weight & maintenance debt

- [x] **5.1 Slim docs/ (71M) and theme-assets (15M)** — Priority 6, effort L
  - 2026-09-16: RESOLVED differently — the skills review was retired outright
    (agent skills migrating to a Hermes-inspired setup; new models need less
    instruction). `docs/skill-review/` pruned (git rm; recoverable from history,
    index entries 5187 → 831). Remaining finding: `theme-assets/` (15M) is
    load-bearing (wallpapers read by run_onchange_after_46; must live outside
    .chezmoitemplates per docs/vespasian-theming.md) and stays. `.gitleaks.toml`
    allowlist entries for docs/skill-review/* paths stay: flagged bytes persist
    in git history and CI scans full history (docs/test_gitleaks.py passes,
    creates its own fixtures). Original options: move vendored libraries to a
    separate branch/repo or submodule pin; `git filter-repo` only if history
    weight becomes painful (breaking change — coordinate across machines).
  - Files: `docs/skill-review/`, `.gitignore`, licenses.

- [x] **5.2 CI check: AGENTS.md §3 hook table vs actual run_* filenames** — Priority 6, effort S
  - Done: 2026-09-15: `generate_index.py` parses AGENTS.md §3 and diffs against tracked `run_*` hooks (order, trigger, machine scoping); enforced in both modes, CI-gated via `--check`
  - Table is hand-maintained and can drift; INDEX/README-tree are checked but not
    this table. Extend `docs/generate_index.py` to parse §3 and diff against the
    source root (then regenerate).
  - Files: `docs/generate_index.py`, `AGENTS.md`.

- [x] **5.3 Fold structurally identical omarchy collector hooks** — Priority 7, effort M
  - Done: 2026-09-15: folded 21+32 into run_onchange_after_32-setup-omarchy-agent-registrations.sh.tmpl (data-driven from new .chezmoidata/omarchy_agents.yaml) and 22+29 into run_onchange_after_29-enable-omarchy-user-units.sh.tmpl. Hooks 20 (599-line Python collector deployer) and 26 (cross-machine statusline) deliberately kept separate — they are not collector-shaped. Verified live on augustus: first run completed pi's missing registration, second run byte-identical (idempotent). AGENTS.md §3 table updated by hand; generate_index --check passes.
  - Hooks 20, 21, 22, 26, 29, 32 are all "usage-collector setup". Refactor into one
    data-driven hook iterating a `.chezmoidata/` collector definition list.
    Caution: run_onchange_* re-triggers on content change — a merged script will
    re-run every collector on first apply; acceptable once.
  - Files: the six hooks → one, `.chezmoidata/omarchy_collectors.yaml`, AGENTS.md §3.

- [x] **5.4 Simplify `.chezmoiignore` negation rules** — Priority 7, effort S
  - Done: 2026-09-15: docs/check_ignore_consistency.py lints .gitignore vs .chezmoiignore for ignore-vs-negate contradictions (lint-ok escape hatch for the parent-dir un-ignore idiom); interaction matrix documented in .chezmoiignore header; wired into CI lint job
  - Subtle `!` negations (systemd, omarchy aliases) + dual source of truth with
    `.gitignore` kept in sync manually. Document the interaction matrix in a
    comment block and add a CI lint that flags paths appearing in both ignores
    with contradictory intent.
  - Files: `.chezmoiignore.tmpl`, `.gitignore`, CI.

- [x] **5.5 codex_projects.yaml trust-list sync** — Priority 8, effort S
  - Done: 2026-09-15: `dots codex-sync` diff-reconciles live ~/.codex/config.toml trust entries back into .chezmoidata/codex_projects.yaml (dry-run flag, skips ephemeral Documents/Codex scratch dirs, idempotent); reconciled 3 missing entries on augustus
  - Hand-synced because Codex appends to the rendered config and re-add can't absorb
    it. Options: a `dots` subcommand that diff-reconciles live trust entries back
    into `.chezmoidata/codex_projects.yaml` (re-add with template-aware merge).

- [x] **5.6 lazy-lock.json first re-add** — Priority 8, effort S (one-time, manual)
  - Done: 2026-09-15: `chezmoi re-add ~/.config/nvim/lazy-lock.json` run on augustus; live file byte-identical to seeded pins, no rollback risk
  - AGENTS.md §6 flags the seeded `lazy-lock.json`: run
    `chezmoi re-add ~/.config/nvim/lazy-lock.json` on augustus before any apply to
    a second machine, then note it here as done.

## Phase 6 — Watch list (no action now)

- [ ] **6.1 mise bootstrap bidirectional sync** — jdx shipped live-file two-way sync
  (mise 2026.9.2, "dotfiles that save themselves"). We already own mise; track it.
  Do not migrate — r/NixOS + r/dotfiles consensus: chezmoi working = keep.
- [ ] **6.2 Nix/home-manager** — rejected: nix-translation of frequently-edited
  configs (hypr, nvim) is a known pain; HM's real wins (exact-version env, rollback
  generations) don't justify a rewrite. Revisit only if machine count grows.
- [ ] **6.3 Reassess `dots` vs Justfile** — research validates task runners, but
  `dots` is strictly better-scoped. No action; keep documenting it as the interface.

## Deliberately not adopted

- Per-OS git branches (mitxela warns they rot; we template instead). Bare-git-repo
  tracking (Neotree perf issues reported). Tool migration of any kind.
