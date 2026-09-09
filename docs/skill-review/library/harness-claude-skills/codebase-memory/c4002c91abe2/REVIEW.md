# Codebase Memory Candidate Review

Disposition: revise before promotion. Preserve the graph-first discovery,
evidence-tier, pagination, coverage-check and direct-source fallback discipline,
but correct volatile interface claims and remove the unmeasured efficiency claim.
Proposed pack: `codebase-intelligence`, optional and available only when the
codebase-memory MCP server advertises the required tools. Invocation:
task-triggered for structural code discovery, call/data-flow tracing,
architecture, impact and bounded quality analysis; not for ordinary literal or
non-code search.

## Full-Tree Evidence and Provenance

Read all 76 baseline lines of `SKILL.md`. The frozen inventory records one regular
file (5,137 bytes), SHA-256
`8efe4aa10efa92b52148cce5840abac552b92e5dc3af567e5d167a5e33624db1`,
and tree SHA-256
`c4002c91abe206c6bd76629d040cc4d5bca57b451a0ab50ef5bb06bf5d66d16a`.
There are no additional retained scripts, reference/example files, metadata files,
assets or licenses; the sole `SKILL.md` contains inline Cypher examples.
Bounded ancestry found no license, so redistribution permission remains unknown.

The identical frozen tree is recorded at 13 installed harness locations: Claude,
Cline, Codex, OpenCode, Copilot, Cursor, Factory, Kiro, Pi, Pochi, Qoder, Qwen and
Vibe. Every location is classified as a local installed tree with unknown upstream
and version. The candidate carries no provider-specific metadata, so automatic
discovery and frontmatter compatibility across those harnesses are not established.
The inventory also records broken/non-skill Gemini discovery paths for this
identity; that gap is not repaired here.

## Retained Expertise

Retain the quick mapping from question type to graph operation; graph-first symbol
discovery before call tracing and snippet retrieval; three evidence tiers; result
pagination; per-path and bounded-scope coverage checks; direct source fallback for
partial, skipped, excluded, stale, pending or unknown coverage; and explicit child
context handoff when delegation is warranted. The warning that coverage metadata
is best-effort and cannot prove completeness is particularly important.

The dead-code and fan-in/fan-out recipes are useful candidate generators, not
proof. A promoted version should label them heuristics and require relevant scope
coverage plus source/build/runtime evidence before declaring code unused or a
refactor necessary.

## Required Revisions

1. Lines 8 and 35-39 conflict in certainty. The fixed “~500 tokens vs ~80K for
   grep” comparison is unreferenced and unmeasured, while the later evidence tiers
   correctly describe graph results as best-effort. Remove the token comparison or
   replace it with a qualitative claim that graph queries can reduce broad source
   reads.
2. Lines 52-62 hard-code a tool count and edge taxonomy that can drift by server
   generation and project. The read-only interface advertised during this review
   still exposed 15 named tools, but the current project schema included edges such
   as `WRITES`, `TESTS`, `INHERITS`, `RAISES`, `DECORATES`, `LISTENS_ON` and
   `HAS_BRANCH`, while several candidate-listed edges were absent from that project.
   Teach `get_graph_schema` as the authority and treat any static list as examples,
   not an exhaustive contract.
3. Line 75 says outbound tracing misses cross-service callers and recommends
   `direction="both"`. Direction alone does not activate cross-service traversal;
   the advertised `trace_path` interface requires `mode="cross_service"`. Correct
   the example and distinguish caller direction from traversal mode.
4. Lines 18 and 47-50 present degree filters as dead-code and quality conclusions.
   The advertised `search_graph` schema has `min_degree`, `max_degree` and
   `relationship`, but no `direction` argument, so the two fan-in/fan-out calls are
   also invalid for this interface. Reframe these as bounded candidate searches,
   use a currently supported directional query where direction matters, state
   which relationship degree is measured, and carry the candidate's own
   negative/exhaustive coverage rule into the examples.
5. Lines 41-45 preserve valuable delegation context, but Hermes-specific
   `delegate_task` syntax should be conditional on that tool actually being
   available. The default execution path should remain in-session for a small
   read-only query; delegation is justified only for independent, bounded analysis.

`Q-codebase-memory-schema` asks whether promotion should permit pinned tool/edge
inventories. Recommendation: make live tool advertisement and `get_graph_schema`
authoritative, keeping only clearly labeled examples. This avoids turning a useful
operational guide into a version-specific false contract.

`Q-codebase-memory-efficiency` asks whether the numeric token comparison should be
retained. Recommendation: remove it unless a reproducible benchmark, workload and
measurement date are supplied. Installation and a plausible efficiency benefit do
not establish the quoted numbers.

## Execution Recommendation and Static Walkthroughs

Recommended execution is in-session and read-only: identify the active project and
generation, choose the evidence tier, discover symbols, trace only relevant
directions/modes, retrieve exact snippets for material claims, paginate, check
coverage for every evidence path and use direct source fallback for reported gaps.
For broad or independent review slices, bounded delegation is acceptable after the
parent supplies the project, generation, tier, qualified symbols, query pagination,
coverage findings and unresolved questions. No Herdr topology or separate worktree
is needed for ordinary read-only graph exploration. Index creation, deletion,
persistent ADR updates and trace ingestion are mutations and require explicit
authority; analysis or skill invocation alone does not grant it.

Static walkthroughs covered: positive symbol discovery at Scout tier; a bounded
caller audit with complete result pagination; a dead-code candidate search that
does not claim absence from degree alone; a partial-coverage result followed by
source inspection; cross-service tracing using the dedicated mode; a child without
MCP access receiving exact parent evidence; and a request to delete/reindex a
project being stopped for write authority. These are source-grounded scenarios,
not executed candidate tests or comparative performance measurements.

## Maintenance, Merge and Promotion Boundary

Maintenance ownership and upstream version are unknown. Because all 13 recorded
locations share the same frozen tree, maintain one reviewed shared variant rather
than separate harness rewrites if provider discovery/frontmatter checks succeed.
Do not retire the capability: its coverage and handoff discipline is distinct and
valuable. Do not merge it with a generic code-review skill unless graph evidence
tiers and mutation boundaries remain independently discoverable.

Promotion requires the corrections above, human resolution of both questions,
license/redistribution review, and per-target discovery/frontmatter verification.
It does not authorize installing or syncing the skill, indexing/deleting projects,
ingesting traces, updating ADRs, changing live configuration, or deploying an
optional pack. Current graph checks were read-only observations of one advertised
interface and one indexed project, not proof of behavior across providers or future
server versions.
