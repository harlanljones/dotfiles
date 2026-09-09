# HJ-737 Scoped Review Evidence

This is static review evidence for the frozen 93-file candidate. It is not
approval, installation, or evidence from a live Mixture-of-Agents run. The same
reviewer performed inspection and verification.

## Pass coverage

- Pass 1: read `README.md`, `SKILL.md`, `config.example.yaml`, and all four
  prompt files. The entrypoint correctly separates scouting, paid dispatch,
  refinement, recorded aggregation, and later implementation approval, but its
  trigger description still allows implicit activation for a costly workflow.
- Pass 2: inspected all 13 orchestration/configuration/adapter files, including
  provider dispatch, strict-schema validation, timeout teardown, config
  precedence, attachment containment, Git-visible workspace snapshots, report
  generation, and decision-map receipt handling.
- Pass 3: parsed all four JSON schemas and inspected all five test files. The
  offline suite covers schema strictness, malformed lineage, stale artifacts,
  sensitive locator handling, provider routing, timeout/error classification,
  workspace mutation, profile isolation, uploads, and UI rendering. Browser
  files are integration tests, not proof about production provider behavior.
- Pass 4: inspected all nine Web UI Python files, including every Flask route,
  SQLite ownership query, GitHub owner/ref validator, worker subprocess path,
  provider probe, prompt coach, Sentry boundary, and cancellation path.
- Pass 5: inspected the report template, both CSS files, all three JavaScript
  files, and both Jinja templates. Dynamic application markup consistently uses
  escaping or DOM text APIs in the reviewed sinks. `webui/static/css/app.css`
  was read directly; lines 2121 and 2131 are valid `@container agent-lanes`
  blocks. They are the graph parser's only candidate parse-partial ranges.
- Pass 6: decoded, dimension-checked, SHA-256-checked, and visually inspected all
  47 PNG/WebP assets. The coherent illustration set includes workflow scenes,
  state/context art, lab avatars/pixels, report art, mark, teacher, and favicon.
  No binary bytes were modified.

## Consequential findings

1. `SKILL.md:3-20` makes a 12-25 minute, quota-consuming workflow discoverable
   through broad natural-language/high-stakes triggers. `SKILL.md:123-220` does
   require a displayed scout brief and explicit dispatch approval, which should
   be retained. Promotion should make invocation explicit-only; see
   Q-mixture-agents-invocation.
2. `SKILL.md:25-32` exposes `Write`, `Edit`, and unrestricted `Bash` to the
   parent skill. The protocol narrows intended writes to `.moa/` until a later
   implementation approval (`SKILL.md:345-393`), but frontmatter does not
   enforce that path/authority boundary. A promoted version needs the smallest
   provider-supported tools and an explicit statement that planning approval
   authorizes session artifacts only.
3. `README.md:45-87` and `SKILL.md:114-121,399-423` extrapolate benchmark and
   wall-clock claims from an adapted chat-answer workflow. No live run was
   authorized here, and the candidate contains no benchmark comparing this
   planning system with a single model. Those statements must be framed as
   design rationale/hypotheses, not measured planning performance; see
   Q-mixture-agents-claims.
4. The adapter boundary has real retained value: Codex requests a read-only
   sandbox, Claude supplies a read-only tool allowlist, OpenCode writes a
   deny-policy config, and AGY uses plan/sandbox isolation. `run_moa.py:1172-1317`
   additionally fingerprints Git-visible workspace state and rejects a result
   when a provider mutates it. This detects and disqualifies mutation; it does
   not undo mutation or cover non-Git-visible state.
5. `webui/app.py:91-105` defaults workspace roots to the entire home directory.
   `webui/app.py:745-794` lets a browser create and claim a new profile token;
   that token isolates profiles but authenticates no human or host. A claimed
   profile can submit jobs (`webui/app.py:1075-1262`) that the worker launches
   with the server user's inherited provider environment
   (`webui/worker.py:124-232`). Binding beyond loopback is configurable at
   `webui/app.py:1602-1610`. The Web UI must remain localhost-only and outside
   the promoted skill until it has a real access-control and origin model; see
   Q-mixture-agents-webui.
6. Attachments are size/count bounded and copied into a per-session input
   directory before extraction. OCR/PDF processing is still attacker-controlled
   parser work and can consume CPU; the current browser profile boundary is not
   sufficient authorization for a remotely reachable server.
7. Inventory records one local Claude harness location, unknown upstream/version
   provenance, no discovered license, and an unchanged baseline tree hash
   `b6883206a8b5a4743192f3ed4af13329f050d586a42d86291ba674e185bedb57`.
   Redistribution/promotion is blocked until permission is established.

## Indexed questions

### Q-mixture-agents-invocation

Should a high-stakes task implicitly activate a multi-provider run?

Recommendation: no. Discovery may suggest the skill, but only an explicit user
request followed by the existing roster/cost/time approval should dispatch it.

### Q-mixture-agents-claims

Should the paper citation support claims that this implementation improves
repo-grounded plans or has equal broadcast/cross-pair wall-clock cost?

Recommendation: no. Preserve the paper as provenance and label implementation
claims as hypotheses until candidate-specific evaluation exists.

### Q-mixture-agents-webui

Should the Flask control room ship in the same optional skill candidate?

Recommendation: not yet. Split or disable it for promotion; retain only after
localhost enforcement, real access control for any non-loopback use, CSRF/origin
controls, narrower workspace roots, and explicit paid-dispatch authorization.

## Evidence limits

- The candidate's offline suite passed 139/139 tests during resumption. The
  repository inventory, review-contract, and local-candidate fixture suites
  separately passed 13/13, 34/34, and 2/2 tests. These tests use fixtures and
  synthetic credentials; they do not authenticate providers or prove live
  provider behavior.
- Graph project `home-harlan-.local-share-ft-HJ-737-claude-mixture-of-agents`
  generation `2026-09-08T16:26:06Z` was used for Tier 2 structural support.
  Scope coverage reported 47 deliberately unindexed image files and only the
  two CSS parse-partial lines above; direct inspection covered every reported
  gap. Graph cleanliness is not proof of completeness.
- No provider call, web research, candidate installer, candidate workflow,
  network service, or live browser/provider evaluation was run.
- Provider model names, flags, permission enforcement, authentication behavior,
  and availability are time-sensitive and require current upstream verification
  before promotion.
