# Skill Installer Candidate Review

Disposition: retain as a provider-owned Codex builtin after correcting overwrite
guidance and multi-install failure semantics; do not merge with `skill-creator`.
Proposed pack: `skill-management`, optional outside the Codex builtin set.
Invocation: task-triggered for listing installable skills or an explicit request
to install from the curated collection or a GitHub repository. Execution: list
directly as a read-only network operation; install in-session only after the user
has requested the source and destination mutation. Prefer one skill per operation
until batch preflight/atomicity is implemented.

## Full-tree evidence

All eight frozen files were read: the 58-line `SKILL.md`, five-line
`agents/openai.yaml`, three Python helpers (21, 355, and 106 lines), the three-line
SVG, the 100x100 RGBA PNG, and the 202-line `LICENSE.txt`. The icons depict
interlocking puzzle pieces and match both metadata paths. The license is an
in-tree Apache License 2.0 copy whose SHA-256 matches the frozen inventory. The
inventory records tree
`bd391a97dbaef49c3d2126167e3924866ae62a3fa089629d9aa0e03909639bdb`, one
local installed Codex source mirror, unknown upstream version, and preserved
license status.

Retain the task routing, curated/experimental distinction, installed annotations,
GitHub API listing, public ZIP download, credential-aware sparse-checkout
fallback, destination collision guard, relative-path and archive containment
checks, symlink/file-type validation, temporary cleanup, and clear network
escalation warning. The skill has a distinct job from authoring and should remain
separate.

## Findings and proposed changes

- `SKILL.md:57` says an insistent user can overwrite a preinstalled system skill,
  but `SKILL.md:47` and the installer at lines 219-223 and 337-338 always abort on
  an existing destination. Generic overwrite guidance is also the wrong ownership
  boundary for provider-managed builtins.
- The multi-path loop at `scripts/install-skill-from-github.py:329-345` copies
  each skill immediately. If a later path is missing or invalid, earlier copies
  remain even though the command returns failure.
- For arbitrary GitHub sources, the checks establish path containment and the
  presence of `SKILL.md`; they do not establish provenance, signature, semantic
  validity, or safety of instructions/scripts that a later turn may load.

Detailed remedies and stable questions are in `review-notes.md`. No provider
source, metadata, script, asset, or license byte was changed.

## Authority and execution recommendation

Listing authorizes a read-only GitHub request, not installation. An install
request authorizes copying the named source into the selected Codex skills
directory, but not overwriting existing skills, changing provider-managed system
content, exposing credentials, executing installed scripts, committing, or
publishing. Private access may use existing Git credentials or `GITHUB_TOKEN` /
`GH_TOKEN`; tokens must never be logged. Dependencies are Python 3, network access,
GitHub/codeload availability, and `git` for fallback. SSH fallback also depends on
existing SSH configuration.

Static walkthroughs covered curated and experimental listing, public ZIP install,
private fallback, destination collision, unsafe ZIP/path input, arbitrary-repo
trust disclosure, system-skill requests, and second-member batch failure.
Executed temporary fixtures used mocked repository/listing data and no network or
live destination. They confirmed parsing, listing sort/filter behavior, traversal
rejection, and the current partial batch result.

## Promotion boundary and limitations

Promotion means readiness for human review, not approval, installation, or
provider update. Keep this as a provider-maintained builtin. Shared promotion
should wait for decisions on system-skill ownership and batch atomicity, corrected
communication, explicit arbitrary-source trust disclosure, cross-harness
destination/invocation checks, and an upstream maintenance owner. No GitHub call,
Git command, credential use, live install, or provider behavior test was run.
Graph coverage was clean for indexed code/text and excluded both icons by suffix;
both were inspected directly. Authoring and verification were done by the same
reviewer.
