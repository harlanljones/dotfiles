# Optional Agent Skill Packs — Implementation Plan (v1)

Companion to [`optional-agent-skill-packs-ux-proposal.md`](optional-agent-skill-packs-ux-proposal.md),
which defines the UX goals and user stories. This document records the locked
design decisions and the concrete implementation plan. Status: **planned, not
yet implemented**.

---

## 1. Locked decisions

| Decision | Choice | Notes |
| --- | --- | --- |
| Core pack membership | `mattpocock`, `vercel-labs`, `agent-reach`, `unlazy`, `flyai` | Always active on every machine. `emil`, `remotion`, `cloudflare`, `supabase`, `diffusionstudio`, `prime-skills` become optional. |
| Activation state location | Shared repo, per-machine sections | New `.chezmoidata/agent_skill_state.yaml`; `dots skill enable` edits it, then re-applies. Reproducible and reviewable in git. |
| Per-harness scope | Included in v1 | `dots skill enable <pack> --harness <h>` from day one. |
| Migration of existing skills | Move into store | `mv` real dirs from `~/.agents/skills` into the cache store and replace with symlinks. Offline-safe, zero data loss, no re-download. |

## 2. Architecture

Today `~/.agents/skills` holds canonical content as real directories and is read
directly by Codex and OpenCode; `run_after_23-sync-agent-skills.sh.tmpl` mirrors
every skill it finds into the other harness roots. Inactive packs are therefore
impossible without separating **cache** from **discovery**:

```text
~/.local/share/agent-skill-packs/        NEW — cache store (never discovered)
  └── <pack>/<skill>/SKILL.md            canonical pack content

~/.agents/skills/                        shared discovery root (Codex + OpenCode)
  ├── dots/…, diagnose-crash/…           core skills: unchanged layout
  └── remotion-create -> store symlink   pack skill, active for this machine

~/.claude/skills/remotion-create         harness root links, now scope-aware
```

Three states, never conflated:

- **Cached** — present in the store; usable offline.
- **Active for machine** — linked into `~/.agents/skills` (visible to Codex/OpenCode).
- **Active for harness** — linked into that harness's discovery root.

Core skills (portableLocal, sharedExtras, core packs) keep today's layout and
all-harness mirroring. Only pack skills move behind the store.

## 3. State and manifest

### `.chezmoidata/agent_skill_state.yaml` (new file)

Kept separate from the skill manifest so enable/disable churn does not collide
with pack-definition edits.

```yaml
agentSkillState:
  enabledPacks:
    default: {}                          # fallback for unregistered machines
    augustus: {}                         # e.g. cloudflare: ['*']  remotion: [codex]
    hadrian: {}
```

- Keys are pack names; values are harness-scope lists.
- `'*'` means all harnesses. A bare list scopes the pack to those harnesses.
- Effective active set for a machine = core packs
  ∪ `enabledPacks[machine]` ∪ `enabledPacks.default`.
- `machine` comes from `.chezmoi.toml.tmpl` (`augustus` / `hadrian` / `unknown`).

### `.chezmoidata/agent_skills.yaml` (extended)

```yaml
agentSkills:
  storePath: .local/share/agent-skill-packs   # NEW, resolved against $HOME
  packs:
    mattpocock:
      repo: mattpocock/skills
      category: core                          # NEW: core | optional
      skills: [...]
    remotion:
      repo: remotion-dev/skills
      category: optional
      skills: [...]
  # portableLocal, sharedExtras, impeccableProviders, clineFallbacks unchanged
```

### Harness keys and roots

| Key | Discovery root(s) |
| --- | --- |
| `codex` | `~/.agents/skills` (shared root) — plus prune of the `~/.codex/skills` link the `skills` CLI auto-creates when not scoped |
| `opencode` | `~/.agents/skills` (shared root) |
| `claude` | `~/.claude/skills` |
| `cline` | `~/.cline/skills` |
| `cursor` | `~/.cursor/skills` |
| `gemini` | `~/.gemini/config/skills` **and** `~/.gemini/skills` |
| `grok` | `~/.grok/skills` |
| `pi` | `~/.pi/agent/skills` |
| `'*'` | all of the above |

## 4. File-by-file changes

### 4.1 `run_onchange_before_09-install-agent-skills.sh.tmpl` (rewrite)

- Hash line covers **both** data files, so enable/disable re-triggers the hook;
  the per-pack missing-skills logic keeps re-runs cheap no-ops.
- Per pack skill, the missing-check moves to the **store**
  (`storePath/<pack>/<skill>/SKILL.md`) instead of the shared root.
- Install path: `npx -y skills add <repo> -g -a codex -y -s <missing...>`
  (keeps the CLI's repo-layout resolution), then **relocate**:
  1. `mv ~/.agents/skills/<skill> storePath/<pack>/<skill>` (also performs the
     one-time migration of existing real dirs).
  2. If the skill is active for this machine/scope, symlink the shared root
     entry back to the store; otherwise leave it cached-only.
- When the pack is not codex-scoped, remove the `~/.codex/skills/<skill>` link
  the CLI created, or it would leak into Codex discovery.
- Impeccable provider restoration unchanged; install failures stay non-fatal
  with stderr warnings (offline enables retry on the next apply).

### 4.2 `run_after_23-sync-agent-skills.sh.tmpl` (rewrite)

- Template computes the active set for `.machine`: `portableLocal` +
  `sharedExtras` + core-pack skills + enabled packs (per-machine, `default`
  fallback) with their harness scopes.
- `link_skill` is generalized to accept an explicit source directory
  (shared root **or** store path). Harness-scoped-only packs link directly to
  the store when they are not shared-root exposed.
- Core skills keep the current mirror-to-all-roots behavior.
- **Pruning** makes deactivation real:
  - In each harness root, remove symlinks that resolve into the shared root or
    the store for a *manifest-declared pack skill* that is inactive for that root.
  - In the shared root, remove symlinks pointing into the store for inactive
    pack skills.
  - Never remove real directories, provider-owned files, or user content.
    Every removal is logged.

### 4.3 `dot_local/bin/executable_dots` (extend)

New `cmd_skill` subcommand surface:

```text
dots skill list
dots skill enable <pack> [--harness <h> ...] [--yes] [--no-apply]
dots skill disable <pack> [--yes]
dots skill run <skill>          # v1 stub -> points at enable
```

- `list` — status view from `chezmoi data` (JSON) plus filesystem checks:
  pack, category, scope, active/inactive/cached, skill counts, and
  pack-vs-core name collisions.
- `enable` — validates the pack exists and is optional (core packs print an
  explanation instead); shows the confirmation proposed in the UX doc
  (skills that will become discoverable, cached status, target harnesses);
  records state via `python3` + PyYAML (deliberately not `yq`, whose flavor
  varies across machines); then runs `dots sync` unless `--no-apply`.
  Explicit `--harness` replaces any prior scope; default scope is `'*'`.
  Offline + uncached: state is still recorded, with a clear warning that the
  install retries on the next apply (declarative-first, matches the UX doc).
- `disable` — removes the state entry, re-syncs; the store is preserved.
- `usage()` updated; `doctor` gains an agent-skills line reporting active vs
  cached pack counts.

### 4.4 Docs and housekeeping

- Register the new command and hook semantics in `AGENTS.md` (§4/§6) and `README.md`.
- Regenerate `INDEX.json` / `INDEX.md` (`python3 docs/generate_index.py`) and the
  README tree (`python3 docs/generate_readme_tree.py`) once the changes are
  git-tracked.
- Mark the UX proposal's open questions with their v1 resolutions.

## 5. Edge cases

| Case | Behavior |
| --- | --- |
| `machine == unknown` | Fall back to `enabledPacks.default` (core only) and warn in the sync log. |
| Re-enable an enabled pack | Idempotent. |
| Pack skill name collides with a core skill | Pack skill is never installed/relocated (the missing-check is store-based) and never linked; surfaced in `dots skill list` as a collision. Core wins, matching the UX doc's conflict rule. |
| Enable while offline, pack uncached | State recorded; install warns non-fatally; sync skips missing store sources with a warning; retries on next apply. |
| First apply after switchover | The `mv` migration relocates ~100 existing pack skills; no network needed. |
| `run_onchange` re-triggering | Expected: both scripts re-run once after the manifest change; both are incremental. |

## 6. Validation plan

1. `chezmoi apply --dry-run` must succeed.
2. Render both `run_*` scripts with `chezmoi execute-template` and run
   `shellcheck` over the output (CI does this on Linux + macOS).
3. Live cycle on augustus: `dots skill list` →
   `dots skill enable cloudflare --harness codex` → verify the shared-root
   symlink exists and `~/.claude/skills` is untouched →
   `dots skill disable cloudflare` → link gone, store intact, `list` shows
   cached/inactive.
4. Verify the migration preserved content: store copies match the pre-move
   real dirs; no skill lost from core.
5. Repeat `dots skill list` on hadrian after its first apply to confirm
   per-machine state resolves independently.

## 7. Deferred to v2

- `dots skill run <skill>` one-off activation (stub only in v1).
- Token/discovery overhead estimation beyond raw skill counts.
- Pack version pinning and `dots skill update`.
- A local dashboard/status UI beyond the CLI (UX open question 1).
