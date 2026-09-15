---
name: rust
version: 0.1.0
description: "Use when writing, building, or reviewing Rust code."
---

# Rust Development

Always-on rules for writing and structuring Rust in this environment
(Cargo workspaces, library+binary crates, git2/serde-heavy tooling).

## Gates (run before declaring any change done)

- `cargo fmt --all` then `cargo fmt --all -- --check` must pass. Run fmt
  ONCE after all files exist — bulk-written code arrives slightly
  off-format, and fmt diffs are not compile errors.
- `cargo clippy --workspace --all-targets` must report zero warnings.
- `cargo test` green; report the exact test counts you saw.
- After ANY Cargo.toml dependency edit, rebuild before moving on — a
  missing `[dev-dependencies]` entry only surfaces when tests compile, not
  during the main build.

## Workspace structure

- Declare all dependencies in the root `Cargo.toml` `[workspace.dependencies]`;
  crates reference them as `name.workspace = true`. Never pin a version
  inside a member crate.
- Shared lint config goes in root `[workspace.lints]` (at minimum
  `unsafe_code = "forbid"`, `clippy.all = "warn"`); each crate opts in
  with an empty `[lints] workspace = true` table.
- Tests that only need a dependency at test time (e.g. serde_json for a
  round-trip assertion) go under `[dev-dependencies]`, not `[dependencies]`.

## Error handling

- Libraries: typed error enums with `thiserror` (`#[from]` for wrapping
  io/git errors). Binaries: `anyhow::Result` and `?`. Never `anyhow` in a
  library's public API, never a bespoke enum in main.

## Parsing external formats (JSONL, hook output, transcripts)

- Every struct that crosses a boundary derives
  `Serialize, Deserialize` with explicit `#[serde(default)]` on optional
  numeric fields — external formats add and drop fields between versions.
- Unknown/extra input is SKIPPED, never an error; a parse failure of a
  KNOWN shape is an error. A parser that errors on unknown event types
  breaks on every upstream format change.
- Pin exact numbers in fixture-based test assertions (token totals,
  payload sizes) so format drift is caught, and keep fixtures in a
  `testdata/` dir, sanitized.

## git2 (libgit2) patterns

- `diff.foreach` takes FOUR closures, and the delta callback and line
  callback both need the same accumulator — plain captures fail E0499
  (two mutable borrows). Put the shared state in a `RefCell` and
  `borrow_mut()` inside each closure, then `into_inner()` after.
- The delta callback fires once per file; the line callback fires right
  after it, so a "last pushed file" index tracks which file a line
  belongs to.
- `std::str::from_utf8(...).ok()` in a `if let Some` triggers clippy
  `match_result_ok` — write `if let Ok(x) = from_utf8(...)` instead.

## Numbers and estimation

- Pricing/cost math returns `Option<f64>`: unknown model/entity yields
  `None`, never a guessed default and never `0`.
- Derive `Default` and `Copy` on small token/usage structs; they get
  accumulated everywhere.
