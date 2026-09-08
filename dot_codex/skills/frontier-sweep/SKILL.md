---
name: frontier-sweep
description: Orchestrates parallel autonomous coding agents across Linear frontier tickets, with human-selected model routing and visible Herdr worktrees. Queries Linear for unblocked, unclaimed tickets, dispatches one worker per worktree, and loops until the frontier is clear. Agents write code and PR descriptions but never commit or push — the human reviews and commits. Use when the user says "frontier sweep", "sweep tickets", "clear the frontier", or wants autonomous parallel ticket implementation.
disable-model-invocation: true
---

# Frontier Sweep

Orchestrate parallel subagents to clear the Linear dependency frontier — one ticket per worktree, no commits, human review at the end.

## Workflow

### 1. Confirm human routing and Herdr preflight

At the start of **every** sweep, ask the user/human which model and reasoning effort to use for each minimum ticket tier that will be dispatched. Do not infer, reuse from an earlier turn, or silently substitute a model, effort, provider, or agent kind. Record the explicit mapping before claiming tickets. If a requested model or effort is unavailable, stop and report the capacity/configuration blocker; never downgrade silently.

Before claiming or spawning anything, verify the visible Herdr session:

```bash
test "${HERDR_ENV:-}" = 1
herdr --help
herdr worktree --help
herdr status server
```

Use the user's current Herdr socket/session. Do not create an alternate temporary socket: the worktrees and agents must appear in the user's visible Herdr workspace. If the client/server protocol is incompatible, pause and ask the human before restarting or updating Herdr; a restart can stop existing pane processes.

### 2. Query Linear for frontier tickets

Find tickets that are **unblocked**, **unclaimed** (no assignee), and at the **dependency frontier** (all blocking tickets are resolved/done).

If available, use Linear MCP tools. Otherwise use the repository's configured Linear CLI or authorized API path. Never expose credentials in prompts, comments, files, or logs.

Collect: ticket key, title, description, priority, linked PRs/attachments.

### 3. Verify codebase sync

Run `codebase-memory` index status to confirm the knowledge graph is fresh:

```
index_status(project="<current-project>")
```

If the index is stale or absent, re-index first. Alert the human if the repo doesn't match Linear context.

### 4. Create and wire visible Herdr worktrees

Batch more than 5 tickets into rounds of 5. For each ticket, create or reuse exactly one Herdr worktree, then start exactly one worker in that worktree's visible pane. Keep write scopes disjoint.

From the parent repository, pass an explicit `--cwd` so Herdr cannot accidentally use a different focused workspace:

```bash
REPO_ROOT="$(pwd -P)"
BRANCH="ft/{TICKET_KEY}-{SHORT_SLUG}"
WORKTREE="$REPO_ROOT/../ft/{TICKET_KEY}-{SHORT_SLUG}"
HERDR_ENV=1 herdr worktree create \
  --cwd "$REPO_ROOT" --branch "$BRANCH" --base main \
  --path "$WORKTREE" --label "{TICKET_KEY}" --no-focus
```

If the worktree already exists, reuse it after checking its branch and status; do not create a duplicate or run two writers in it. Read the creation/list response, then use the returned workspace/pane IDs:

```bash
herdr worktree list
herdr workspace list
herdr pane list --workspace <WORKSPACE_ID>
herdr agent start <AGENT_NAME> --kind <AGENT_KIND> --pane <PANE_ID> -- \
  --model <HUMAN_SELECTED_MODEL> \
  -c 'model_reasoning_effort="<HUMAN_SELECTED_EFFORT>"'
```

Pass the model and effort exactly as selected by the human, and verify the returned `argv`/agent state. Use `herdr agent prompt <AGENT_NAME> ... --wait --timeout 30000`; if it times out, inspect `herdr agent get` and `herdr agent read` before retrying because the prompt may already have been delivered. Use `--no-focus` for background work unless the human asks to focus a pane.

**Tracker ownership is conditional on repository policy.** If the repository has a single-dispatcher rule, the orchestrator re-reads, claims, assigns and transitions each ticket before starting its Herdr agent; the worker only reads Linear and returns evidence. Otherwise the worker may claim its own ticket as the first action. Never mix both patterns or let two writers mutate the same ticket.

The generic `spawn_agent` tool is a fallback only when a visible Herdr agent cannot be started. If used, pass the exact existing worktree path and the human-selected model/effort, and do not also start a Herdr worker for that ticket.

### 5. Await and report

Wait for all subagents to complete. Report **minimally**:

```
## Frontier Sweep — Round N

| Ticket | Worktree | Linear Status | Result |
|--------|----------|---------------|--------|
| ENG-42 | ft/ENG-42-add-auth | In Review | ✅ PR_DESCRIPTION.md written |
| ENG-43 | ft/ENG-43-fix-login | In Review | ✅ PR_DESCRIPTION.md written |
```

### 6. Loop

Re-query Linear. Newly resolved tickets may have unblocked others.

- New frontier tickets exist → go to step 3
- None → report "Frontier clear. No more unblocked, unclaimed tickets."
- Human says stop → exit immediately

---

## Subagent System Prompt

For each ticket, start the visible Herdr worker with the human-selected routing, or use `spawn_agent` only as the documented fallback:

```
herdr agent start <AGENT_NAME> --kind <AGENT_KIND> --pane <PANE_ID> -- \
  --model <HUMAN_SELECTED_MODEL> \
  -c 'model_reasoning_effort="<HUMAN_SELECTED_EFFORT>"'
herdr agent prompt <AGENT_NAME> "Implement Linear ticket {TICKET_KEY}: {TICKET_TITLE}

Ticket description: {TICKET_DESCRIPTION}

Work only in the already-created Herdr worktree and write PR_DESCRIPTION.md. Never commit or push."
```

Replace all placeholders, including the human-selected model, effort and agent kind, with actual values. Do not proceed with placeholders or inferred routing.

---

## SUBAGENT_PROMPT template

```
You are a focused implementation agent. Your job is to implement exactly one Linear ticket.

## Routing and Herdr Rules (CRITICAL)

- Work INSIDE the already-created Herdr worktree (`{WORKTREE}`); the orchestrator owns worktree creation and visible-agent wiring.
- Use the exact human-selected model and reasoning effort supplied in the task. If either is missing or unsupported, stop and report instead of guessing.
- NEVER run `git commit`, `git push`, `gh pr create`, or any force-push
- The human reviews and commits — your job ends at writing code + PR description

## Workflow

1. Read the complete ticket description, comments, linked context and native relations. If the dispatcher owns tracker writes, do not mutate Linear.
2. Explore the codebase to understand the relevant code paths, patterns, and conventions
3. Implement the changes — follow existing conventions, use existing libraries, write tests where appropriate
4. Verify your work compiles and tests pass before finishing
5. Write PR_DESCRIPTION.md at the worktree root with:

```markdown
# {TICKET_KEY}: {TICKET_TITLE}

## Summary
[One paragraph of what was implemented and why]

## Changes
- [Bulleted list of files changed and what changed in each]

## Testing
- [How to test these changes]
- [Test results if available]

## Notes
- [Any edge cases, tradeoffs, or follow-ups the reviewer should know]
```

6. **Handoff to the dispatcher** — report the worktree path, changed files, checks and limitations. If repository policy delegates tracker updates to the worker, move the ticket to "In Review" (or the team's equivalent) and add a summary comment; otherwise leave shared tracker state to the dispatcher.

## Constraints

- Only touch files relevant to this ticket — stay scoped
- Follow existing code conventions and patterns exactly
- Use only libraries already in the project
- If the ticket is ambiguous or underspecified, note it in PR_DESCRIPTION.md, update the Linear ticket with a comment asking for clarification, and make your best reasonable call
- If blocked by something outside the ticket scope, move the ticket to "Blocked" in Linear, write what's blocking in PR_DESCRIPTION.md, and explain what partial work was done

## Completion

When done, report the worktree path and confirm PR_DESCRIPTION.md is written. The dispatcher owns the final Linear transition when a single-dispatcher policy applies. Do NOT commit or push.
```

---

## Git Constraints

| Allowed | Forbidden |
|---------|-----------|
| `herdr worktree create` | `git commit` |
| `git branch` | `git push` |
| `git checkout -b` | `gh pr create` |
| `git status`, `git diff` | `git push --force` / `--force-with-lease` |

Worktree naming: `ft/{TICKET_KEY}-{short-slug}` (lowercase, hyphens, max ~40 chars for slug portion).

---

## Output Format

Keep it minimal. After each round:

```
## Frontier Sweep — Round N
[table of ticket → worktree → status]

### To review
herdr worktree list
# then check each worktree's PR_DESCRIPTION.md

### Stalled / No Action
[any tickets skipped and why]
```

When the frontier is clear:

```
## Frontier Sweep — Complete

All unblocked, unclaimed frontier tickets have been implemented.
No new tickets were unblocked.

Worktrees ready for review:
  ft/ENG-42-add-auth
  ft/ENG-43-fix-login

Review worktrees with: herdr worktree list
```

---

## Edge Cases

- **No Linear MCP tools available**: Use the repository's configured Linear CLI/authentication path. If access is unavailable, report the blocker and ask the human to authenticate through the supported flow; never request, copy or log an API key.
- **Model or effort missing**: Stop before claiming or spawning and ask the human for an explicit model/reasoning-effort mapping for every tier in the round. Never infer from defaults, prior turns, ticket labels or cost.
- **Herdr client/server mismatch**: Stop before creating worktrees or agents, show `herdr status server`, and ask the human whether to update/restart. Never switch to an invisible alternate socket to bypass the problem.
- **Herdr worktree not visible**: Verify `--cwd`, `herdr worktree list`, `herdr workspace list`, and `herdr pane list`; open/reuse the existing worktree in the current visible server before starting a worker.
- **Worker prompt timeout**: Inspect `herdr agent get` and `herdr agent read` first; a timeout is not proof the prompt was lost. Retry only after confirming the agent is idle and the prompt was not delivered.
- **Subagent fails to claim ticket**: Subagent reports back immediately with the failure reason. The orchestrator skips that ticket for this round — it may have been claimed by another agent or a human. Do not retry in the same round.
- **Subagent fails mid-implementation**: The subagent should move the ticket back to "Todo" or "Backlog" in Linear so it's reclaimable. Report the ticket and failure reason. Do not retry unless the human asks. Continue with remaining tickets.
- **Ticket has no clear implementation path**: The subagent will note this in PR_DESCRIPTION.md and comment on the Linear ticket asking for clarification. Move the ticket to "Blocked" in Linear. Surface it in the round report as "⚠️ Needs clarification".
- **>5 frontier tickets**: Batch into rounds of 5 parallel subagents. Run each round to completion before starting the next.
- **Human interrupts**: Stop spawning new subagents immediately. Report what's done so far. Do not kill running subagents — report them as in-progress.
- **Ticket status transitions differ per team**: The subagent should use whatever status names the team's Linear workflow uses. Default mapping: `Todo → In Progress → In Review` (or `Done` if the team skips review). If unsure, ask the human before starting the first round.
