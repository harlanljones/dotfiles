# Reorganization proposal — shell modularization, the index, and repo QOL

Scope: Linear **HJ-728** (*Reorganize dotfiles repository and modularize shell
configuration*, project *Dotfiles Showcase*). Written after reading the existing
Linear backlog so nothing here duplicates planned work — §4 records the overlap
that was checked.

The index (§2) is **implemented** in this change. §1 and §3 are proposals
awaiting your call, because they change applied shell behaviour and touch files
the showcase reads.

---

## 1. Splitting the shell configuration

### What the problem actually is

`dot_bashrc` is 169 lines and `dot_zshrc` is 111 — not large. Length is not why
they are hard to read. Three measurable things are:

1. **They duplicate each other.** 29 non-blank lines are byte-identical across
   the two files: the guarded `zoxide`/`fzf`/`atuin`/`direnv` init block, the
   entire `zj`/`zp` functions, and the `FZF_*` / `RIPGREP_CONFIG_PATH` / `PAGER`
   / `MANPAGER` exports. Every change to shell QOL has to be made twice, and
   nothing enforces that it is.

2. **Installers append to them, so intent and accretion are interleaved.**
   `~/.local/bin` is prepended to `PATH` three separate times in `dot_bashrc`
   (lines 51, 140, 168) and a fourth in `dot_bash_profile` — once deliberately,
   then again by the Antigravity installer and the Codex installer. Careful,
   commented code (the `ft()` rationale, the `cline()` safety wrapper) sits
   between blocks labelled `# Added by <installer>`.

3. **Neither file is linted.** CI shellchecks managed scripts by matching
   `*.sh`, `*.sh.tmpl`, and `dot_local/bin/*.tmpl`, then requires a shebang.
   `dot_bashrc` and `dot_zshrc` match no pattern and have no shebang, so the two
   most complex shell files in the repo are the only ones with **zero** static
   analysis. This is the strongest argument for the split: modules named `*.sh`
   are picked up by the existing CI loop with no workflow change.

A fourth issue is not about readability but is worth fixing in the same pass:
**hardcoded absolute home paths** — `/home/harlan/…` four times in `dot_bashrc`,
`/Users/harlan/…` in `dot_zshrc`. The repo has a machine abstraction
(`.chezmoi.toml.tmpl`, `.chezmoidata/machines.yaml`) that these bypass, so the
rc files are the one place a new machine name would not propagate.

### Proposed layout

One shared, numbered module directory, sourced by both shells:

```
dot_config/shell/
  00-env.sh.tmpl        PATH, EDITOR/VISUAL, XDG, PAGER   (templated home dir)
  10-tools.sh           RIPGREP_CONFIG_PATH, FZF_*, MANPAGER
  20-integrations.sh    zoxide / fzf / atuin / direnv init
  30-navigation.sh      zj, zp, their keybindings and completion
  40-aliases.sh         eza aliases, .., codex / oc / cursor
  50-agents.sh          cline() safety wrapper, ft()
  60-prompt.sh          starship init + the failure recolor
  99-local.sh           untracked; where installer appends land
```

Each rc file collapses to a loader:

```bash
export SHELL_KIND=bash           # or zsh
for _m in "${XDG_CONFIG_HOME:-$HOME/.config}"/shell/*.sh; do
  [ -r "$_m" ] && . "$_m"
done
unset _m
```

Two design points worth stating explicitly:

- **Shell differences live inside a module, not in duplicate files.** A module
  that must differ branches on `$SHELL_KIND`. Splitting into `bash/` and `zsh/`
  trees would recreate the duplication the split is meant to remove.

- **`60-prompt.sh` is the deliberate exception and stays divergent by design.**
  The bash and zsh recolor implementations differ in real semantics (bash
  recolors all foreground colors, zsh is cyan-only), and ROADMAP decision **F1**
  makes that divergence a *feature the showcase demonstrates* via its shell
  toggle. Keep both implementations, in one file, with the existing comments —
  do not "unify" them.

- **`99-local.sh` is the point of the exercise as much as the split is.** It is
  untracked and sourced last, so the next installer's append lands somewhere
  harmless instead of in a tracked file. Without it, the accretion problem
  returns within weeks.

### Migration order

Deliberately incremental; each phase is independently verifiable and revertible.

| Phase | Change | Verify |
|---|---|---|
| 1 | Extract only the 29 duplicated lines into `10-`/`20-`/`30-`; both rcs source the directory and their copies are deleted | `chezmoi apply --dry-run`; open a new shell; `zj`/`zp`/Alt-Z/Alt-X still work |
| 2 | Move shell-specific content into the remaining modules; template out the hardcoded home paths | `diff <(bash -lic 'echo $PATH') …` before/after |
| 3 | Reduce both rcs to the loader; add untracked `99-local.sh` | new login shell; `type ft cline zj` all resolve |
| 4 | Update the showcase manifest + fallbacks (see below); regenerate the index | `python3 docs/generate_index.py --audit-showcase` clean |

### Phase 4 is not optional

The showcase's `shell-env` card reads `~/.zshrc`, `~/.bashrc`, and
`~/.config/environment.d`. After phase 3 those rc files are ~15 lines of loader,
so **the card would silently render almost nothing** — it degrades to fallback
rather than erroring, which is exactly the kind of failure nobody notices. The
manifest must gain `~/.config/shell/` and `fallback/shell-env.json` must be
refreshed. `--audit-showcase` (§2) is what catches this class of drift; it
already caught two live instances of it (§3).

---

## 2. The index (implemented)

Two generated artifacts at the repository root, both produced by
`docs/generate_index.py`:

- **`INDEX.json`** — canonical and machine-readable. This is what agents and the
  showcase should read.
- **`INDEX.md`** — the same data rendered for humans, grouped by category.

Neither is hand-editable: both carry a `DO NOT EDIT` banner, and CI runs
`python3 docs/generate_index.py --check`, which fails the build when either is
stale. That satisfies the "generated by a script, not modified by agents or
humans" requirement in the same way the README tree already is.

**How it is derived.** From `git ls-files`, so it can never describe an
untracked file, and every tracked file is accounted for exactly once (204
entries; zero fall through to an `other` bucket). Chezmoi source names are
decoded to home-directory targets with a pure-Python implementation of the
documented prefix grammar — `dot_config/opencode/encrypted_opencode.json.age`
resolves to `~/.config/opencode/opencode.json` with attribute `encrypted`.
Nothing is executed and chezmoi is not required, so it behaves identically on a
laptop and on a CI runner.

**Why it answers questions the README tree cannot.** Each entry carries the
decoded target path, the chezmoi attributes (`template`, `encrypted`, `private`,
`executable`, `symlink`), a category, and a subsystem label. An agent asking
"where is the prompt configured?" reads one field instead of inferring intent
from a filename. `run_*` hooks are decoded into structured trigger semantics
(`once` / `onchange` / every apply, before/after phase, numeric order) rather
than being left as opaque filenames.

**Categories are a declarative table** (`CATEGORY_RULES`) matched longest-prefix
against the *decoded target*, so grouping reflects what a file does rather than
where chezmoi's naming happens to put it. Adding a category is one tuple.

**Deliberate non-coupling to the showcase.** An earlier draft annotated each
entry with the showcase cards that consume it. That was removed: the showcase is
a submodule pinned to a commit, so folding its manifest into the artifact would
make `--check` depend on whether submodules were checked out and on which commit
is pinned — a plain `actions/checkout` would report false staleness. The
dependency runs one way instead. The reverse check survives as an opt-in mode:

```
python3 docs/generate_index.py --audit-showcase
```

which reports every `livePath` the showcase declares, classified as matched,
external (runtime state such as `~/.local/state/omarchy/…`, legitimately outside
chezmoi), or **orphaned** — a path the showcase reads that this repo does not
manage. Orphans exit non-zero.

---

## 3. Other QOL improvements

### Fixed in this change

**The Packages card never read the live Brewfile.** `--audit-showcase` flagged
`~/Brewfile` as an orphan on its first run. This repo manages `dot_Brewfile` →
`~/.Brewfile`; the showcase manifest declared `~/Brewfile`. The showcase's own
`fallback/Brewfile` header even documents the correct path. The card therefore
degraded to the bundled fallback on every macOS load, silently and
indistinguishably from working. Fixed in `src/manifest.ts`; `searchIndex.ts`
regenerated (14 entries corrected).

**The secret-scan guard fails on short hostnames.** `findHostLeaks` in the
showcase's `refresh-fallbacks.ts` tested `content.includes(host)` as a bare
substring, so any hostname short enough to occur inside an unrelated word failed
the run on content that leaks nothing — a host named `vm` matches
`nvml_measure_pcie_speeds` in `fallback/btop.conf`, blocking
`search-index:build` and failing two tests outright. Now matched on identifier
boundaries, which still catches a real leak (`/home/vm/…`, `host = "vm"`) since
a genuine occurrence is always delimited by a non-identifier character. Four
regression tests added.

### Recommended, not done

1. **Manage `~/.config/nvim/lazy-lock.json`.** The remaining `--audit-showcase`
   orphan. It is the LazyVim plugin lockfile: unmanaged, plugin versions are not
   reproducible across Augustus and Hadrian, and the showcase's Neovim card
   declares it as a live source it can never actually find. Adding it needs the
   real file from your machine, so it is left to you.

2. **Give the two `--check` generators one entry point.** The dotfiles repo now
   has `generate_readme_tree.py --check` and `generate_index.py --check`; the
   showcase has `fallbacks:check` and `search-index:check`. Four instances of one
   convention, each remembered separately. A `dots gen` / `dots gen --check`
   verb (dotfiles) and a `bun run gates` script (showcase) would make "am I
   about to fail CI?" a single command in each repo.

3. **Showcase repo hygiene — ~432 KB of tracked duplication.** All 11 PNGs in
   `docs/review/` are byte-identical to their counterparts in
   `.impeccable/review/` (884 KB of tracked PNGs, roughly half redundant). Also
   tracked: `.impeccable/review/desktop.png.bak`, `.impeccable/questions/*.json`
   (agent scratch state), `.playwright-mcp/page-2026-09-04T01-14-55-556Z.yml`
   (a stray tool dump), and `PR_DESCRIPTION.md` (a spent artifact of one PR).
   Suggest keeping one copy of the screenshots, deleting the rest, and adding
   `.impeccable/`, `.playwright-mcp/`, and `*.bak` to `.gitignore`. Left undone
   because deleting tracked files is your call, not a cleanup to slip into an
   unrelated change.

4. **Add `worker-configuration.d.ts` generation to the showcase's test path.**
   `bun test` passes on a fresh clone but `tsc --noEmit` reports three
   `Cannot find name 'Env' / 'ExecutionContext'` errors until `wrangler types`
   has been run. The `typecheck` script chains them correctly; nothing else
   does, so a contributor's first standalone `tsc` run looks broken.

---

## 4. Overlap with the existing Linear backlog

Checked before proposing, so none of the above collides with planned work:

- **HJ-728** is this ticket; §1 and §2 are its two halves.
- **HJ-725** (`/` palette searching real configuration content) and **HJ-719**
  (config search index generator, merged) build `scripts/generate-search-index.ts`
  and `server/lib/searchIndex.ts`. That index is a *content* index — setting keys
  and values extracted from `fallback/*`, for end-user search. `INDEX.json` is a
  *file* index — where things live and how chezmoi treats them, for agents and
  tooling. They are complementary and neither replaces the other. The Brewfile
  fix in §3 corrects 14 entries in the HJ-725 index as a side effect.
- **HJ-715** and its children (HJ-720…HJ-726) restructure the Explorer shell —
  UI work, no overlap with either repo's file layout.
- **HJ-700** (theme overhaul wayfinding) is a design-direction map, not
  implementation.

Nothing in §1 or §3 has an existing ticket. If §1 proceeds, it is worth cutting
the four phases as sub-issues of HJ-728, since phase 4 has a real dependency on
the showcase repo.
