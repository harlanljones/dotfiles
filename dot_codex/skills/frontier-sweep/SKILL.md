---
name: frontier-sweep
description: Orchestrates parallel autonomous coding agents across Linear frontier tickets. Queries Linear for unblocked, unclaimed tickets at the dependency frontier, spawns subagents into git worktrees to implement each ticket, and loops until the frontier is clear. Agents write code and PR descriptions but never commit or push — the human reviews and commits. Use when the user says "frontier sweep", "sweep tickets", "clear the frontier", or wants autonomous parallel ticket implementation.
disable-model-invocation: true
---

# Frontier Sweep

Orchestrate parallel subagents to clear the Linear dependency frontier — one ticket per worktree, no commits, human review at the end.

## Workflow

### 1. Query Linear for frontier tickets

Find tickets that are **unblocked**, **unclaimed** (no assignee), and at the **dependency frontier** (all blocking tickets are resolved/done).

If available, use Linear MCP tools. Otherwise use the Linear API directly.

Collect: ticket key, title, description, priority, linked PRs/attachments.

### 2. Verify codebase sync

Run `codebase-memory` index status to confirm the knowledge graph is fresh:

```
index_status(project="<current-project>")
```

If the index is stale or absent, re-index first. Alert the human if the repo doesn't match Linear context.

### 3. Spawn parallel subagents

For **each** frontier ticket, spawn a subagent using the template below. All subagents run in parallel (async).

**Each subagent claims its own ticket** — the first thing it does is assign itself and move the ticket to "In Progress" in Linear. The orchestrator does NOT pre-claim tickets; claiming is the subagent's responsibility so no two agents ever race for the same ticket.

If there are more than 5 frontier tickets, batch them into rounds of 5 to avoid resource contention.

### 4. Await and report

Wait for all subagents to complete. Report **minimally**:

```
## Frontier Sweep — Round N

| Ticket | Worktree | Linear Status | Result |
|--------|----------|---------------|--------|
| ENG-42 | ft/ENG-42-add-auth | In Review | ✅ PR_DESCRIPTION.md written |
| ENG-43 | ft/ENG-43-fix-login | In Review | ✅ PR_DESCRIPTION.md written |
```

### 5. Loop

Re-query Linear. Newly resolved tickets may have unblocked others.

- New frontier tickets exist → go to step 3
- None → report "Frontier clear. No more unblocked, unclaimed tickets."
- Human says stop → exit immediately

---

## Subagent System Prompt

For each ticket, spawn with:

```
spawn_agent(
  systemPrompt="<SUBAGENT_PROMPT>",
  task="Implement Linear ticket {TICKET_KEY}: {TICKET_TITLE}\n\nTicket description: {TICKET_DESCRIPTION}\n\nCreate worktree ft/{TICKET_KEY}-{SHORT_SLUG}, implement the changes, and write PR_DESCRIPTION.md at the worktree root. Never commit or push."
)
```

Replace `{TICKET_KEY}`, `{TICKET_TITLE}`, `{TICKET_DESCRIPTION}`, and `{SHORT_SLUG}` with actual values.

---

## SUBAGENT_PROMPT template

```
You are a focused implementation agent. Your job is to implement exactly one Linear ticket.

## Git Rules (CRITICAL)

- CREATE a git worktree: `git worktree add ../ft/{TICKET_KEY}-{SHORT_SLUG} main`
- Work INSIDE that worktree directory for all changes
- NEVER run `git commit`, `git push`, `gh pr create`, or any force-push
- The human reviews and commits — your job ends at writing code + PR description

## Workflow

1. **Claim the ticket in Linear** — assign it to yourself and move status to "In Progress". Use Linear MCP tools if available, otherwise the Linear API directly. If claiming fails (e.g. ticket was already claimed), report back immediately and stop — do not proceed.
2. Read the ticket description and any linked context thoroughly
3. Explore the codebase to understand the relevant code paths, patterns, and conventions
4. Implement the changes — follow existing conventions, use existing libraries, write tests where appropriate
5. Verify your work compiles and tests pass before finishing
6. Write PR_DESCRIPTION.md at the worktree root with:

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

7. **Update Linear status** — move the ticket to "In Review" (or the team's equivalent review column). Add a comment with a summary and the worktree path so the reviewer knows where to look.

## Constraints

- Only touch files relevant to this ticket — stay scoped
- Follow existing code conventions and patterns exactly
- Use only libraries already in the project
- If the ticket is ambiguous or underspecified, note it in PR_DESCRIPTION.md, update the Linear ticket with a comment asking for clarification, and make your best reasonable call
- If blocked by something outside the ticket scope, move the ticket to "Blocked" in Linear, write what's blocking in PR_DESCRIPTION.md, and explain what partial work was done

## Completion

When done, report the worktree path and confirm PR_DESCRIPTION.md is written. The ticket should be "In Review" in Linear. Do NOT commit or push.
```

---

## Git Constraints

| Allowed | Forbidden |
|---------|-----------|
| `git worktree add` | `git commit` |
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
git worktree list
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

Review worktrees with: git worktree list
```

---

## Edge Cases

- **No Linear MCP tools available**: Fall back to Linear API via `curl` or `req`. Ask the human for their Linear API key if not in environment.
- **Subagent fails to claim ticket**: Subagent reports back immediately with the failure reason. The orchestrator skips that ticket for this round — it may have been claimed by another agent or a human. Do not retry in the same round.
- **Subagent fails mid-implementation**: The subagent should move the ticket back to "Todo" or "Backlog" in Linear so it's reclaimable. Report the ticket and failure reason. Do not retry unless the human asks. Continue with remaining tickets.
- **Ticket has no clear implementation path**: The subagent will note this in PR_DESCRIPTION.md and comment on the Linear ticket asking for clarification. Move the ticket to "Blocked" in Linear. Surface it in the round report as "⚠️ Needs clarification".
- **>5 frontier tickets**: Batch into rounds of 5 parallel subagents. Run each round to completion before starting the next.
- **Human interrupts**: Stop spawning new subagents immediately. Report what's done so far. Do not kill running subagents — report them as in-progress.
- **Ticket status transitions differ per team**: The subagent should use whatever status names the team's Linear workflow uses. Default mapping: `Todo → In Progress → In Review` (or `Done` if the team skips review). If unsure, ask the human before starting the first round.