# Inventory Notes

Inventory work owns only `inventory.py`, `test_inventory.py`, `inventory.json`,
`library/` and this file. Live configuration is read-only. Graph project,
generation and coverage are unknown; all evidence comes from bounded source
inspection. No candidate is reviewed, approved, installed or activated here.

## Acceptance Checks

- [x] I1: current plugin selection comes from installed manifests, not cache age.
- [x] I2: identity, full-tree variant, mirror and exclusion counts are explicit.
- [x] I3: complete retained trees materialize without live-pointing links.
- [x] I4: baseline verification checks file hashes, link strings and discovery membership.
- [x] I5: negative controls reject changed bytes, escaping links and candidate overwrites.
- [x] I6: unrelated dirty paths retain their baseline bytes and index state.

## Frozen Denominator

Snapshot: `2026-09-06T19:42:25.708819+00:00`. Output: `inventory.json` and
`library/<source>/<skill>/<12-character-tree-hash>/`. Every candidate is an
unchanged baseline with inventory `status: unreviewed`; no review files were
fabricated. The initial development snapshot was replaced before materialization
to correct Cursor's repository-relative `gitPath` declarations. The final
snapshot is immutable; the CLI refuses to overwrite it.

| Measure | Count |
| --- | ---: |
| Shared identities / shared variants | 112 / 112 |
| Total identities (directory basenames) | 440 |
| Distinct full retained trees / candidate variants | 482 |
| Distinct `SKILL.md` hashes | 481 |
| Locations / resolved physical skill roots | 3,130 / 1,114 |
| Installed skill-root symlink locations | 2,016 |
| Probed roots (present / absent) | 128 (105 / 23) |
| Current plugin selections (Claude / Cursor) | 43 (10 / 33) |
| Manifest packs / declared skills / tracked skill trees | 11 / 80 / 6 |
| Retained candidate files / bytes | 4,119 / 49,174,229 |
| Additional inherited license copies / bytes | 161 / 811,043 |
| Materialized total regular files / bytes | 4,280 / 49,985,272 |
| Supporting instruction-like files | 3,484 |
| Variants with license files / without found license files | 163 / 319 |
| Explicit exclusion records / excluded entrypoint occurrences | 487 / 507 |
| Live/source baseline paths | 20,338 |
| Recorded gaps | 16 |

Canonical candidate source buckets: 6 tracked-local, 80 declared-pack, 342
plugin, 26 provider (22 Cursor, 2 Omarchy, 2 Terminal Browser), 6 Codex builtin,
7 harness-specific, and 15 shared-only. This is a grouping label, not exclusive
provenance: every variant retains all source locations and provenance records.
Full-tree equality groups mirrors even across providers. Same-name differences
remain separate variants. Two Impeccable variants have identical entrypoints
but different supporting trees, demonstrating why entrypoint hashes are not
the review denominator.

Supporting instruction counts are an explicit extension-based proxy (Markdown,
text, metadata, code, templates), excluding `SKILL.md` itself. They are not a
claim that every counted file contains agent instructions or has been read by a
reviewer. Assets and all other retained files still require review.

## Selection Evidence

Claude selection uses `~/.claude/plugins/installed_plugins.json`, including each
record's scope, install path, version and commit when supplied. Cursor selection
uses `~/.cursor/plugins/cache/.cloud-plugin-manifest.json`: plugin ID directories,
resolved commit/release tag, and `.installed` marker matching `artifactDigest`.
Same-version named cache directories are additional mirrors, not independent
current selections. All declared Cursor skill paths resolve after stripping the
documented manifest `gitPath` prefix where the cached package is already rooted
there. Installed does not mean enabled in every session or demonstrated usage.

The full plugin records and declared-to-materialized source path mapping are in
`plugins`. Current versions are not inferred from cache mtimes. Unselected cache
versions, marketplace/catalog/staging content and outside-skill examples or
fixtures are in `exclusions`, not rewrite targets. Excluded entrypoints count
occurrences, not unique skills. Thirty-seven nested skill entrypoints inside
current skills remain supporting files, not separate candidates.

## Safety and Limits

- Discovery probes only the enumerated conventional harness roots, manifest and
  index sources, provider roots, plugin caches/catalogs, and current mise-selected
  provider installations. It does not search home, project workspaces or extension
  installations broadly. These bounds are explicit in `roots` and `inventory.py`.
- Eight pre-existing broken/non-skill links remain untouched: six `babysit` links
  and two Gemini `codebase-memory` links. Two copies of Snowflake plugin metadata
  are invalid JSON; current selection still has installed-manifest evidence.
- Six current CLI installation scans found no accessible builtin `SKILL.md`
  source outside examples/dependencies. Binary-embedded completeness remains
  unknown for OpenCode 1.18.27 (including `customize-opencode`), Codex 0.153.0,
  Claude 2.1.259, Gemini 0.58.0, Pi 0.84.4 and oh-my-pi 18.1.7. No payload was
  fabricated or fetched. Six installed Codex system skills and 22 Cursor provider
  skills are separately accessible and materialized; Codex's marker and Cursor's
  sync manifest are baseline-hashed, not misrepresented as upstream revisions.
- Upstream versions for manifest-installed packs are unknown unless another
  location provides specific evidence. A declared repo is not proof of the
  installed commit. Missing license files do not imply permission to redistribute;
  license searches stop at the bounded source ancestry. Inherited license bytes
  live under candidate `_inventory-licenses/`, outside the source-tree hash.
- Tree hashes include relative paths, file SHA-256/size/executable bits, directory
  entries and link strings, but not mtimes, ownership or excluded runtime/private
  subtrees. Root links are dereferenced only within the allowlist. Internal links
  must resolve inside the same tree; absolute internal links become relative
  candidate-local links. Escaping or broken supporting links reject the snapshot.
  This snapshot has zero internal candidate links; link behavior is fixture-tested.
- Private filenames are excluded without export; common key/token signatures
  reject content before copying. One plugin `.npmrc` path was
  conservatively excluded. VCS/cache/dependency exclusions record the pruning
  path/reason, not every descendant of an intentionally untraversed subtree.
  This heuristic scan is not a comprehensive secret-detection guarantee.
- Live verification covers observed files, directory membership, link strings,
  manifests and tracked discovery-link sources, not excluded historical payload
  bytes or provider executable bytes. It checks the frozen source locations, not
  whether mise later selects a different CLI version. The separate worktree check
  covers all 12 pre-existing unrelated dirty paths, HEAD and index hash; encrypted
  content was hashed only, never decrypted or displayed.
- Repo-wide generated indexes were checked and are current for the 225 tracked
  entries. These outputs remain untracked, as requested. The parent must regenerate
  repository indexes when these files are eventually staged/tracked; no root index,
  README, proposal, activation file, hook, live skill or provider original changed.

## Commands and Evidence

Run from `/home/harlan/.local/share/chezmoi`; Python 3 plus installed PyYAML 6.0.3.
All listed checks exited zero in bash. No install, apply, commit or staging ran.

```bash
# One-time snapshot; intentionally refuses if inventory.json or library exists.
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py snapshot
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py materialize

# Read-only verification, independently usable after parent review edits.
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py verify-live
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py verify-worktree
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/inventory.py check
PYTHONDONTWRITEBYTECODE=1 python3 docs/skill-review/test_inventory.py -v
python3 docs/generate_index.py --check
python3 docs/generate_readme_tree.py --check
git diff --check
```

Success tokens: `LIVE_BASELINE_OK`, `WORKTREE_BASELINE_OK`,
`MATERIALIZATION_OK`; 13 fixture tests pass. Controls cover full-tree variant
separation, changed live bytes, changed link strings, added directory members,
root dereference, internal link preservation/rewriting, escaping and broken
links, secrets, assets and inherited licenses, edited candidate refusal,
unexpected candidate layout and separate worktree/index drift detection.
Repeated materialization checks existing candidates and never overwrites edits.
`check` intentionally fails once candidates acquire reviews or edits; it is the
baseline oracle, not a review-completion checker. `verify-live` remains useful
through review. `verify-worktree` intentionally fails after parent-owned documents
or other previously dirty paths change; do not refresh the frozen baseline.

## Selecting Batches

```bash
python3 docs/skill-review/inventory.py select --source local-tracked
python3 docs/skill-review/inventory.py select --source pack-mattpocock
python3 docs/skill-review/inventory.py select --source plugin-cursor --offset 0 --limit 20
python3 docs/skill-review/inventory.py select --skill impeccable
python3 docs/skill-review/inventory.py summary
```

Selection uses stable candidate-path order with substring filters; `--offset`
and `--limit` paginate after filtering. Assign disjoint `candidatePath` values,
not skill names alone. Inspect `tree.entries`, `locations`, `licenses`, and each
location's `provenance` for the complete review scope. To select by *any* source
location instead of canonical bucket, query `variants[].locations[]` in the JSON.
All batches start unreviewed; the parent owns review status, integration and
Linear. Inventory acceptance is not G2 review completion or promotion approval.
