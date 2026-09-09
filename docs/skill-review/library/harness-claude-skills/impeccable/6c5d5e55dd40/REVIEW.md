# Impeccable Candidate Review

Disposition: retain the frontend-design expertise, but do not promote this
Claude-specific 4.1.1 tree unchanged. The instructional system is unusually deep
and coherent; its default network activity, broad shell allowance, implicit
project writes, local-agent spawning, and unresolved redistribution evidence need
an explicit safety/provider pass first.

Proposed pack: `frontend-design-advanced` (optional). Keep the ordinary design,
review, accessibility, responsive, typography, motion, copy, and design-system
branches available task-triggered. Keep `live`, hooks, pinning, image generation,
concept rolls, and automated copy-edit application as separately invoked advanced
capabilities, not automatic consequences of a general frontend request.

Invocation: task-triggered for a clearly requested frontend design or evaluation
task, with explicit subcommands preserved. A bare invocation should remain a menu.
`shape`, `audit`, and `critique` must preserve their planning/read-only boundaries;
write-capable refinement commands require an actual edit request. `init`,
`document`, `extract`, `live`, `hooks`, `doctor --fix`, pin/unpin, image generation,
server startup, and local-agent execution need their own disclosed write, process,
network, credential, and cost authority.

## Full-tree checkpoint

All 148 frozen baseline files (3,255,891 bytes; tree SHA-256
`6c5d5e55dd406c10c556431531e9440f1f26a1ee2a2daa5b88a4c44ce2053168`)
were inspected in eight bounded passes against the frozen inventory and HEAD.
The exact path, baseline SHA-256, byte count, pass, and completed status are
recorded in `evaluations/HJ-736-impeccable.md`; `review.json.reviewedFiles`
repeats the complete exact path set. No candidate workflow was executed. The
generated and vendored browser bundles were inspected as code and hash-checked
rather than reformatted.

| Pass | Files | Scope |
| --- | ---: | --- |
| P1 | 13 | Entrypoint and command/reference fundamentals through `critique.md` |
| P2 | 14 | Degraded roles and workflow references through `layout.md` |
| P3 | 13 | Live/new-work and remaining command references |
| P4 | 30 | Command metadata, context, detector engines, registry, and core rules |
| P5 | 25 | Hook administration, shared libraries, staleness, and initial live helpers |
| P6 | 20 | Live orchestration, source mutation, server, poll, and first framework adapters |
| P7 | 25 | Remaining framework adapters, transactions, stores, source search, and Svelte machinery |
| P8 | 8 | TanStack adapter, browser vocabulary/bundle, palette, pinning, question server, surface brief |

Graph evidence was Tier 2 at generation `2026-09-08T16:26:16Z`. Scoped coverage
reported no recorded gaps, which is a best-effort signal rather than proof of
completeness. Direct source reads covered Markdown, JSON, generated/minified files,
privileged operations, external endpoints, and command-line entrypoints.

## Preservation failure at handoff

The current worktree does **not** preserve the frozen candidate. Before this final
handoff began, five tracked candidate source files already differed from HEAD:
`SKILL.md`, `reference/live.md`, `reference/new-work.md`,
`scripts/concept-seed.mjs`, and `scripts/context.mjs`. The combined diff is 41
insertions and 8 deletions. It adds authority/network/cost/live/provider/license
guidance and changes network/telemetry behavior. Those changes overlap this
review's recommendations, but they are not review artifacts, are not approved,
and must not be inferred to be an accepted rewrite.

This handoff neither edited nor repaired those five files. Exact baseline and
working-tree SHA-256 values, byte counts, and diff statistics are recorded in
`evaluations/HJ-736-impeccable.md`. All semantic findings below refer to the HEAD
baseline unless explicitly labeled as an observed dirty-worktree change. The
dispatcher must exclude the five candidate source paths from any staged or
published change and reconcile the preservation failure separately. Until then,
the candidate preservation gate is failed even if the additive review contract
passes against the dirty worktree.

## Retained expertise

The tree should retain its four surface modes (Persuade, Operate, Read,
Experience), the preserve-versus-replace distinction, evidence-based visual
authority, bounded screenshot passes, and the command-specific depth rather than
collapsing everything into generic design advice. Particularly valuable material
includes:

- web/native splits for adaptation and audit, with iOS/Android platform floors;
- accessibility, reduced-motion, responsive, performance, internationalization,
  error-state, copy, typography, hierarchy, and design-token guidance;
- the critique separation between independent design judgment and deterministic
  detector/browser evidence, including false-positive handling;
- the craft floor, product-specificity checks, explicit visual-world contract,
  source-versus-generated-file safeguards, transaction journals, locks, rollback,
  acceptance postconditions, and framework-specific live adapters;
- deterministic detector configuration and inline waivers, provenance embedding
  for generated/sourced rasters, and clear degraded-role contracts when the
  harness lacks subagents.

The script tree is not incidental support. It implements a 108-file system for
context discovery, design parsing, anti-pattern detection, hook installation,
browser injection, SSE/HTTP coordination, copy-edit agent execution, source
mutation and rollback, image generation, and per-framework adapters. Promotion
must therefore treat this as an application/tooling bundle, not a prompt-only
skill.

## Consequential findings and proposed changes

1. **Authority is too broad at entry.** `SKILL.md:8-10` allows
   `Bash(npx impeccable *)` and every bundled Node script, while `SKILL.md:13`
   describes the skill as granting permission to create. The command branches
   include read-only review, ordinary code edits, persistent project artifacts,
   `.git/info/exclude` changes, hook manifests, source injection, server processes,
   local-agent spawning, external API calls, and paid image calls. Replace the
   blanket implication with a capability matrix and derive authority from the
   user's actual request. Prefer pinned/local executables over an unrestricted
   `npx` surface. See Q-impeccable-authority.

2. **Setup performs undisclosed external work.** The mandatory context step is
   run once per session (`SKILL.md:20-24`). `scripts/context.mjs:70-82` defines a
   daily version request and a home-directory cache. `scripts/concept-seed.mjs:
   112-180` falls back to `https://impeccable.style/api/roll`, and lines 188-228
   send a default-on choice ping unless an environment opt-out is present. Network
   use, submitted fields, retention/owner, and opt-out behavior should be disclosed
   before contact; telemetry should be opt-in. See Q-impeccable-network.

3. **Cost and credentials exist behind normal design flow.** `scripts/
   generate-image.mjs:1-16` documents the user's OpenAI key and roughly
   $0.05-$0.25 per image; lines 206-275 read the key, call the image API, write the
   output, and embed provenance. `reference/new-work.md:71-101` can make a
   three-comp image round mandatory whenever generation is available. Require a
   visible cost/credential confirmation before the first paid call and a no-image
   alternative. See Q-impeccable-paid-generation.

4. **Live mode is an invasive application workflow.** `reference/live.md` and
   `scripts/live*.mjs` start/reuse a local server, inject framework-specific code,
   patch CSP, stage variants and copy edits, mutate source, spawn Codex or Claude,
   validate edits, and roll back files. The implementation contains meaningful
   defenses—loopback origin checks, tokens, journals, locks, bounded roots,
   receipts, and postconditions—but a general design request does not authorize
   this topology. Promote `live` only as explicit invocation with a preflight
   listing processes, files, network endpoints, agent choice, and rollback scope.
   See Q-impeccable-live.

5. **Hook and pin operations cross configuration boundaries.** `scripts/
   hook-admin.mjs:390-435,730-775`, `scripts/hook-lib.mjs:590-660`, and
   `scripts/pin.mjs:121-199` write harness manifests, project config, Git exclude
   files, and standalone skills; reset/unpin removes files. These are useful tools,
   but must stay explicit maintenance operations with previewed targets and should
   not run as repair side effects. The existing `doctor` reference mostly observes
   this boundary and should be the model for all maintenance branches.

6. **Provider packaging is only partially evidenced.** `scripts/lib/provider.mjs`
   identifies `claude-code`, while degraded references substitute inline work for
   missing subagents. Other references name Codex, Cursor, Copilot and provider
   command syntax. The review did not verify that Claude Code enforces these
   `allowed-tools` patterns, that every named subagent ships with the candidate,
   or that metadata rewrites preserve semantics across providers. Keep this exact
   variant Claude-only until provider fixtures prove the permission and invocation
   contract. See Q-impeccable-provider.

7. **License evidence is incomplete.** Frontmatter says `license: Apache 2.0`
   (`SKILL.md:7`), and generated detector files carry SPDX/attribution headers,
   but the bounded source ancestry contains no license file. The frozen inventory
   therefore records permission as unknown. Do not redistribute or promote the
   full 3.2 MB tree until the authoritative license text and third-party notices
   (especially `modern-screenshot.umd.js`) are supplied and matched to this
   version. See Q-impeccable-license.

8. **Some performance/quality claims are presented as measured without portable
   evidence.** Comments and `reference/new-work.md` contain numerical or causal
   claims about concept repetition, seed performance, composition quality, and
   agent behavior. Retain them as upstream rationale only where evidence is
   available; otherwise rewrite as design hypotheses or operational heuristics.
   Static inspection does not validate model-quality gains.

## Execution recommendation

- `shape`, `audit`, and source-only critique: execute in-session and remain
  read-only unless the user separately requests persistence.
- Ordinary build/refine/fix commands: execute in-session within named files after
  explicit edit authority; preserve existing stack and project checks.
- Visual/browser critique: use browser automation only when requested or necessary
  for the chosen evaluation and disclose any server lifecycle.
- Finish reviewer/documenter/asset producer: use bounded fresh delegation only
  when the harness actually provides it and the task scale warrants it; otherwise
  use the documented inline degraded role and disclose the substitution.
- `live`, hooks, pinning, doctor fixes, image generation, concept service calls,
  and automated copy-edit agents: separately opt-in, with target/process/network/
  credential/cost preview and deterministic cleanup. Safer alternatives are a
  static source patch, read-only detector, user-provided image, or manual copy-edit
  diff.

## Static walkthroughs

These are source-grounded walkthroughs, not executed skill tests or live harness
evaluation:

- A request to critique source returns findings; it does not grant fixes, snapshot
  persistence, browser injection, or server startup.
- A request to shape returns a confirmed brief and stops before code or
  persistence, matching `reference/shape.md`.
- A request to refine one component permits only that component and relevant
  tests; it does not authorize PRODUCT.md/DESIGN.md creation, hooks, pins, or live
  mode.
- A bare invocation presents the menu and never auto-runs a command.
- A native audit uses source plus platform guidance and never runs the HTML/CSS
  detector or browser overlay.
- An explicit live request first presents injection targets, server lifecycle,
  external/local-agent behavior and rollback scope; declining falls back to a
  static patch.
- Image generation is skipped until the user accepts credential use and estimated
  cost; a user-provided or code-rendered asset remains available.
- Hook reset and pin removal preview exact paths and remove only managed entries.

## Questions for human decision

### Q-impeccable-authority

Should one general Impeccable invocation authorize every Bash/Node branch in the
tree? Recommendation: no. Define read, project-write, process, harness-config,
external-network, credential, paid-call, and local-agent capabilities separately;
require the user's request or an inline confirmation for each material escalation.

### Q-impeccable-network

May mandatory setup perform version checks and may concept selection send roll or
choice telemetry by default? Recommendation: make telemetry opt-in and disclose
the endpoint, fields, owner, retention, timeout, and offline fallback before any
network call; keep version checks separately disableable.

### Q-impeccable-paid-generation

May availability of `OPENAI_API_KEY` make a three-image generation round mandatory?
Recommendation: no. Require explicit cost/credential confirmation before the first
paid call and preserve a no-image/code-led route.

### Q-impeccable-live

Should `live` be promoted as part of ordinary design execution? Recommendation:
retain it only as an advanced explicit command with preflight/cleanup reporting,
bounded roots, and separate confirmation before spawning a coding agent or
committing staged copy edits to source.

### Q-impeccable-provider

Is the Claude `allowed-tools` and degraded-agent packaging contract verified for
this exact tree and portable to other harnesses? Recommendation: keep the variant
Claude-specific until provider fixtures prove matching command permissions,
subagent availability, invocation names, and metadata behavior.

### Q-impeccable-license

Is the Apache-2.0 declaration sufficient for redistribution of the full tree and
its bundled third-party code? Recommendation: require the authoritative license
file plus applicable third-party notices and provenance before promotion.

## Validation and limits

Executed checks are listed in `evaluations/HJ-736-impeccable.md` and
`review.json.validation`. They are limited to static metadata/contract checks,
baseline hashes, JavaScript parse checks, and repository fixtures. No candidate
workflow, server, hook, browser injection, detector against a user project,
external endpoint, model, image API, credential, install, apply, commit, or push
was invoked.

The five-file candidate-source diff is a preservation failure and was not
validated as an implementation. The six question tokens referenced by
`review.json` are carried by the additive `QUESTIONS.md` artifact, so the scoped
contract is independent of those excluded source edits.

The installed source is version 4.1.1 but upstream identity and update ownership
are unknown. The private concept catalog/service payload, provider build pipeline,
named subagent definitions, remote DESIGN.md spec, model-quality measurements,
live browser behavior, external-service privacy terms, and redistribution rights
were unavailable or deliberately not exercised. Authoring and verification were
performed by the same agent; no independent second-model review is claimed.

Promotion boundary: human approval must resolve the six questions, verify license
and provider packaging, split privileged capabilities from the default path, and
run isolated upstream-owned fixtures for the script application. Review readiness
is not approval, installation, deployment, or permission to run the candidate.
