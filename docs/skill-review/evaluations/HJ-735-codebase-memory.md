# HJ-735 — Codebase Memory Review Evidence

Date: 2026-09-08. Scope: one frozen candidate at
`library/harness-claude-skills/codebase-memory/c4002c91abe2`. This is review
readiness evidence, not human approval, installation or deployment. The same agent
authored and verified the artifacts; no independent second-model review is claimed.

## Retained-Tree and Provenance Evidence

- Read the complete 76-line, 5,137-byte `SKILL.md`; the directory contained no
  other baseline file.
- Pre-review and post-review SHA-256 of `SKILL.md`:
  `8efe4aa10efa92b52148cce5840abac552b92e5dc3af567e5d167a5e33624db1`.
  The frozen source bytes were not edited.
- Directly read the exact `inventory.json` entry with `jq` after the initial graph
  extraction reported that file skipped on parse timeout. It records tree SHA-256
  `c4002c91abe206c6bd76629d040cc4d5bca57b451a0ab50ef5bb06bf5d66d16a`,
  one regular file, 13 identical installed locations, unknown upstream/version,
  and no discovered license.
- Initial scoped `review.py status` selected exactly one variant: 0 valid,
  1 unreviewed, 0 invalid and 0 missing before the review artifacts were added.

## Graph and Interface Evidence

The repository graph project
`home-harlan-.local-share-ft-HJ-735-claude-codebase-memory` was ready on branch
`HJ-735-claude-codebase-memory`. The initial evidence used full-index generation
`2026-09-08T16:26:05Z`. Continuation verification used full-index generation
`2026-09-08T21:18:08Z`; `check_index_coverage` reported `metadata_match` and no
recorded issue for the candidate tree, review artifacts, review protocol,
validators, evidence file, PR description and `inventory.json`. The earlier
generation's parse-timeout report for `inventory.json` remains the reason its exact
entry was read directly; the later clean result does not retroactively turn graph
extraction into the provenance source. Both coverage results are best-effort
signals, not proof of completeness.

Read-only inspection of the advertised codebase-memory schemas established:

- 15 tools were currently advertised, matching the candidate's numeric count at
  this point in time but not making that count a stable contract.
- `trace_path` separates `direction` from `mode`; cross-service traversal requires
  `mode="cross_service"`, so `direction="both"` alone does not implement the
  candidate's line-75 advice.
- The advertised `search_graph` schema exposes `min_degree`, `max_degree` and
  `relationship`, but not `direction`; the candidate's two directional fan-degree
  examples therefore are not valid calls against this interface. The undirected
  zero-degree search is at most a candidate generator, not dead-code proof.
- The current project schema advertised 24 edge types. It included nine omitted
  from the candidate's fixed list (`WRITES`, `TESTS`, `RAISES`, `DECORATES`,
  `INHERITS`, `THROWS`, `LISTENS_ON`, `TESTS_FILE`, `HAS_BRANCH`) and did not
  contain four candidate-listed types (`ASYNC_CALLS`, `DATA_FLOWS`, `OVERRIDE`,
  `CONTAINS_PACKAGE`). Because graph schemas are project-specific, this supports
  dynamic schema discovery rather than substituting a different exhaustive list.

No copied candidate workflow was executed. These were repository-required,
read-only graph and interface checks against the active project.

## Static Scenario Record

1. Positive symbol discovery: select Scout, search, retrieve the exact snippet,
   check candidate-path coverage and label the conclusion provisional.
2. Caller audit: select Verify, resolve the qualified symbol, trace inbound,
   paginate every relevant response, retrieve material snippets and check all
   evidence paths.
3. Dead-code search: treat zero selected degree as a candidate only; add bounded
   scope coverage and direct build/runtime/source evidence before any absence claim.
4. Coverage gap: inspect every reported range or excluded scope directly and carry
   the limitation into the result.
5. Cross-service question: choose `mode="cross_service"` and the relevant
   direction; do not assume `direction="both"` changes the traversal graph.
6. Delegation: keep a small query in-session; for an independent slice pass the
   exact tier, project/generation, qualified symbols, pagination and coverage record
   to the child. A child without MCP access uses supplied evidence and direct source.
7. Mutation request: project deletion/reindexing, ADR update and trace ingestion
   require explicit authority beyond analysis or invocation.

## Safe Checks

The first scoped contract run correctly rejected question references to
`REVIEW.md`, which is a reserved review artifact rather than a supporting file.
The question evidence was moved to candidate-scoped `QUESTIONS.md`; the final
scoped rerun is recorded in `PR_DESCRIPTION.md`.

The 34 review-tool fixtures and 13 inventory fixtures passed. JSON parsing,
frozen-source hashing and `git diff --check` passed. Both root generated-document
checks reported staleness because this ticket adds tracked review/evidence paths.
Those generated roots belong to the integration writer and are outside HJ-735's
exact ownership, so they were not regenerated here. Global preservation and
full-library completion are not claimed; the repository's known live-baseline
drift and unreviewed candidates remain outside HJ-735.
