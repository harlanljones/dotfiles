---
name: repo-scaffold
description: Scaffold a full repo with agent-facing docs from any input.
version: 0.1.0
author: Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [scaffolding, documentation, repositories, onboarding, agents]
    related_skills: [spike]
---

# Repo Scaffold Skill

Turns a loose prompt, a conversation, or a set of documents into a fully
scaffolded repository whose documentation is written for AGENTS first and
humans second. The deliverable is a working skeleton (deps install, tests
run, entry point executes) plus docs an agent can load cold and act on
without re-deriving context.

## When to Use

- "Set up a repo/project from this idea / spec / conversation"
- "Turn these docs into a project with structure and README"
- "Boilerplate this so an agent (or a fresh session) can pick it up"

Don't use for: adding a module to an existing repo (survey that repo's own
conventions instead), or pure one-file scripts (use `spike`).

## Inputs — gather before writing anything

Accept any mix of, and extract into a written brief before scaffolding:

1. A prompt or one-line idea.
2. A conversation: search prior sessions for decisions already made
   (requirements, stack choices, naming) so the scaffold doesn't contradict them.
3. Documents: read every provided doc with `read_file` / `web_extract` and
   mine them for: purpose, constraints, data models, external services,
   non-goals.

Completion criterion: a brief exists (in memory of the session or as
`docs/BRIEF.md`) listing purpose, stack, constraints, non-goals, and
success criteria. If a required decision is genuinely ambiguous and
changes the file layout (language, framework, monorepo vs single), ask
the user once with `clarify`; otherwise pick the obvious default and
record the assumption in the brief.

## Procedure

1. **Plan the tree on paper first.** Write the full directory listing
   (every file you will create) before creating any. Get user sign-off on
   the layout only if it is large or unusual.
2. **Scaffold minimal-but-runnable:**
   - Package/dependency manifest (`pyproject.toml`, `package.json`, etc.)
   - Entry point and one representative module
   - Test directory with at least one passing test
   - Lint/format config
   - `.gitignore`, `git init`, initial commit
   Completion criterion: `install` succeeds, tests pass, entry point runs.
   Run all three; do not claim the skeleton works otherwise.
3. **Write the agent-facing docs.** This is the core of the skill — see
   "Agent-Facing Documentation" below. `README.md` stays short and human;
   the depth lives in `AGENTS.md` and `docs/`.
4. **Verify cold-startability:** re-read `AGENTS.md` as if you had never
   seen the conversation. Every command it references must actually work
   — execute each one. Every claim about architecture must match the code.
5. **Final report:** list the tree, the commands verified, and any
   assumptions from the brief.

## Agent-Facing Documentation (the deliverable's core)

Produce these, in this order of priority:

### `AGENTS.md` (repo root) — the agent's operating manual
- What the project is, in 3 sentences.
- Environment: language/runtime versions, install command, env vars
  (names and purpose only — no secrets), required services.
- Commands that work, verbatim: build, test (single test too), lint,
  run locally. Every one verified in step 2.
- Layout map: one line per top-level directory saying what lives there
  and the convention for adding to it.
- Conventions: error handling, naming, where tests go, commit style.
- Non-goals and invariants: things an agent must NOT change or add.
- Pointers into `docs/` for depth.

### `docs/ARCHITECTURE.md`
- Components and their responsibilities; a diagram (mermaid) if >3 parts.
- Data flow for the primary use case, end to end.
- Key decisions and their WHY (from the brief/docs) — future agents
  need reasons, not just shapes.

### `docs/CONVENTIONS.md` (only if nontrivial)
- Code style specifics beyond the linter config; patterns to copy
  ("see src/example.py for the canonical service/handler pattern").

### `docs/ROADMAP.md` (if the input implies future work)
- Explicit next steps, each with acceptance criteria. Unimplemented
  stubs in code are forbidden — future work lives here, not as empty files.

Rules for all agent-facing docs:
- Commands must be copy-paste runnable and actually verified.
- No marketing prose. Facts, paths, commands.
- Every file documented must exist; every existing top-level file must be
  documented. Cross-check both directions before finishing.
- Keep `AGENTS.md` under ~150 lines; depth belongs in `docs/`.

## Pitfalls

- Scaffolding from memory of a similar project instead of from the brief —
  the user's stated constraints are the spec.
- Writing docs that describe an aspirational repo; docs must match the
  code that exists at the moment of writing.
- Secrets in README/AGENTS.md: never real keys; reference env var names only.
- Over-scaffolding: dozens of empty files. Every file must either run,
  test, or document something. If it's future work, it goes in ROADMAP.md.
- Skipping `git init` / first commit — agents and users both expect a
  clean, versioned starting point.

## Verification

- Install, test, and run commands all executed successfully (record output).
- `git status` clean after the initial commit.
- Every command in `AGENTS.md` executed and working.
- Every top-level file/directory mentioned in docs exists, and vice versa.
- The brief's constraints are each traceable to either code, docs, or a
  recorded assumption.
