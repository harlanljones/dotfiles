---
name: project-doc-planner
description: Analyze a project-defining document and operationalize it into an evidence-based critique plus measurable, parallelizable repository guidance in AGENTS.md and ROADMAP.md. Use for a prospectus, business case, statement of work, project management plan, technical design, AGENTS.md, ROADMAP.md, CLAUDE.md, or equivalent when the user wants the project assessed and turned into an executable development plan; not for ordinary prose editing.
---

# Project Doc Planner

Turn project intent into a critical assessment and agent-executable plan. Keep claims traceable to the input or repository, make uncertainty explicit, and favor outcome and delivery metrics over unsupported precision.

## Establish the working set

1. Resolve the project root and every input document. Read each input in full, plus existing `AGENTS.md`, `ROADMAP.md`, `CLAUDE.md`, and the minimum repository metadata needed to verify commands, architecture, and current state.
2. Follow all existing scoped instructions. Treat the submitted document as a proposal to test, not as proof that its assumptions are true.
3. Record the requested scope, constraints, deadlines, and explicit non-goals. Distinguish facts, document claims, inferences, proposals, and unknowns.
4. An explicit invocation of this skill for a writable project includes permission to create or update only `AGENTS.md` and `ROADMAP.md`, unless the user requests a read-only review. If invocation was implicit, the user asked only for analysis, or the project root is uncertain, have the planning agent return proposed content without writing it. Do not change source documents or implementation files without separate authorization.

## Dispatch two agents in parallel

When delegation is available, issue both spawn calls back-to-back before waiting. Give both agents the same project root, input paths or text, applicable instructions, user constraints, and write-mode decision.

### Agent 1: project critic

This agent is read-only. Ask it to return:

- an executive verdict and a 0–4 scorecard for goals and value, scope and requirements, technical feasibility, delivery readiness, dependencies and resources, risk and security, and validation and operations;
- findings ordered by consequence, each with source evidence by file and line or document section, impact, confidence, and a concrete remedy;
- contradictions, hidden assumptions, missing decisions, and questions that could materially change cost, schedule, architecture, or success;
- an audit of proposed metrics, identifying absent baselines, targets, instruments, owners, and review cadence.

Use this scoring anchor consistently: `0` absent, `1` asserted but not actionable, `2` partial, `3` actionable, `4` measurable and supported. Do not average away a critical gap or manufacture numeric confidence.

### Agent 2: execution planner

This is the sole initial writer. Ask it to inspect the repository and create or make focused updates to root `AGENTS.md` and `ROADMAP.md` when authorized and necessary. Preserve useful existing guidance; do not rewrite an adequate file merely for stylistic uniformity. If a file needs no change, explain why.

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

If delegation is unavailable, perform the critic and planner passes separately and disclose that the required parallel execution could not be used.

## Reconcile and verify

While the agents work, independently inspect the inputs and repository enough to validate their conclusions. After both return:

1. Review all edits and evidence rather than accepting either report at face value.
2. Map each high-consequence finding to a roadmap task, decision gate, accepted risk, or explicit non-goal. Resolve contradictions between the critique and plan.
3. Ensure every milestone has measurable exit criteria and every parallel wave has non-overlapping ownership plus an integration gate. Remove fabricated facts and vanity metrics.
4. Correct `AGENTS.md` or `ROADMAP.md` directly if needed. Do not implement roadmap tasks during this workflow.
5. Run the repository's documentation checks when available and `git diff --check`. Report any validation that could not be performed.

## Deliver the result

Lead with the project verdict. Then provide the scorecard, highest-consequence gaps, files created or changed, key metrics and baseline gaps, the critical path and parallel execution waves, unresolved decisions, and validation performed. Cite repository evidence with clickable file references when possible. Clearly label proposed targets and inferred conclusions.
