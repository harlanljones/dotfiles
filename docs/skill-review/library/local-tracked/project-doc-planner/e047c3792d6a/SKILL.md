---
name: project-doc-planner
description: Critique a project-defining document against repository evidence and turn it into a measurable execution plan. Use for project assessment and roadmap or agent-guidance planning; not ordinary prose editing or implementation.
---

# Project Doc Planner

Turn project intent into a critical assessment and agent-executable plan. Keep claims traceable to the input or repository, make uncertainty explicit, and favor outcome and delivery metrics over unsupported precision.

## Establish the working set

1. Resolve the project root and every input document. Read each input in full, plus existing `AGENTS.md`, `ROADMAP.md`, `CLAUDE.md`, and the minimum repository metadata needed to verify commands, architecture, and current state.
2. Follow all existing scoped instructions. Treat the submitted document as a proposal to test, not as proof that its assumptions are true.
3. Record the requested scope, constraints, deadlines, and explicit non-goals. Distinguish facts, document claims, inferences, proposals, and unknowns.
4. Resolve write authority from the request, not filesystem permissions or invocation alone. A request to assess or plan returns proposed content without writing. A request to create or update repository guidance permits focused changes only to the named files (normally `AGENTS.md` and `ROADMAP.md`). Preserve source documents and implementation files unless separately authorized.

> Q-project-doc-planner-write: Should explicit invocation alone permit writing
> `AGENTS.md` and `ROADMAP.md`? Recommendation: require a request to produce those
> files; a writable directory does not imply permission to change agent policy.

## Critic and Planner Passes

For a small document, perform both passes in-session. For a substantial document
or repository, delegate independent critic and planner passes when capacity makes
that useful. Give both the same project root, inputs, applicable instructions,
constraints and write-mode decision. Keep user decisions with the driver. Use
one writer for shared guidance files; read-only parallel inspection needs no
Herdr topology or worktree. Concurrent overlapping implementation is outside
this planning workflow.

> Q-project-doc-planner-delegation: Require two agents for every assessment?
> Recommendation: no; retain the two analytical roles, with bounded delegation
> for substantial independent work and direct passes for smaller inputs.

### Agent 1: project critic

This agent is read-only. Ask it to return:

- an executive verdict and a 0–4 scorecard for goals and value, scope and requirements, technical feasibility, delivery readiness, dependencies and resources, risk and security, and validation and operations;
- findings ordered by consequence, each with source evidence by file and line or document section, impact, confidence, and a concrete remedy;
- contradictions, hidden assumptions, missing decisions, and questions that could materially change cost, schedule, architecture, or success;
- an audit of proposed metrics, identifying absent baselines, targets, instruments, owners, and review cadence.

Use this scoring anchor consistently: `0` absent, `1` asserted but not actionable, `2` partial, `3` actionable, `4` measurable and supported. Do not average away a critical gap or manufacture numeric confidence.

### Agent 2: execution planner

This is the sole initial writer when writing is authorized; otherwise it returns
proposed content. Inspect the repository and make focused updates to the named
guidance files only when necessary. Preserve useful existing guidance; do not
rewrite an adequate file merely for stylistic uniformity. If a file needs no
change, explain why.

`AGENTS.md` should contain durable, imperative instructions for development agents:

- project intent, boundaries, instruction precedence, and architectural ownership;
- verified setup, build, test, lint, type-check, security, and release commands where the repository supports them;
- quality gates, prohibited shortcuts, evidence expectations, and escalation conditions;
- a coordination protocol that decomposes work by dependency, assigns one writer per file or component, runs independent tasks concurrently, integrates in dependency order, and revalidates after merges;
- required progress reporting against the project's outcome, quality, reliability, performance, security, cost, and delivery measures that actually apply.

Keep temporary milestones and speculative design out of `AGENTS.md`; put them in the roadmap.

`ROADMAP.md` should be an executable plan rather than a feature wish list. Include:

- current state, objective, scope, non-goals, assumptions, and unresolved decisions;
- a metric table with metric, baseline, target or threshold, measurement method, owner, and review cadence;
- milestone exit gates and a requirement/critique-to-work traceability map;
- a dependency graph or explicit predecessor list, critical path, and concurrency waves;
- work items with stable IDs, dependencies, suggested agent or role, exclusive file/component ownership, deliverable, validation method, and measurable exit criterion;
- integration checkpoints, risks with triggers and mitigations, and decision gates.

Use context-specific measures. Never invent a baseline, command, owner, budget, date, or target. Mark it `TBD`, say why it matters, and add an early task to establish it. Prefer measurable outcomes and leading indicators over activity counts. Maximize safe parallel work only where dependencies and write ownership are independent; make serial constraints visible.

### Additional delegation

Either agent may delegate a bounded, independent evidence-gathering slice when the document or repository is large and capacity permits. Do not delegate shared-file writing, duplicate the two primary roles, or create agents for work that is faster to do directly.

If delegation is unavailable or uneconomical, perform separate critic and planner
passes directly. State the execution mode without portraying solo work as failed
verification. Evidence and reconciliation standards remain the same.

## Reconcile and verify

After both passes, inspect the material evidence and reconcile their conclusions:

1. Review all edits and evidence rather than accepting either report at face value.
2. Map each high-consequence finding to a roadmap task, decision gate, accepted risk, or explicit non-goal. Resolve contradictions between the critique and plan.
3. Ensure every milestone has measurable exit criteria and every parallel wave has non-overlapping ownership plus an integration gate. Remove fabricated facts and vanity metrics.
4. Correct authorized guidance edits or returned proposals if needed. Do not implement roadmap tasks, publish tickets, commit or deploy during this workflow without a separate request.
5. Run the repository's documentation checks when available and `git diff --check`. Report any validation that could not be performed.

## Deliver the result

Lead with the project verdict. Then provide the scorecard, highest-consequence gaps, files created or changed, key metrics and baseline gaps, the critical path and parallel execution waves, unresolved decisions, and validation performed. Cite repository evidence with clickable file references when possible. Clearly label proposed targets and inferred conclusions.

Completion means every material finding has an evidence-linked remedy, decision,
accepted risk or non-goal and every proposed milestone has a checkable exit gate.
Unresolved human decisions can remain visible; missing assessment coverage cannot
be called an approved or implementation-ready plan.
