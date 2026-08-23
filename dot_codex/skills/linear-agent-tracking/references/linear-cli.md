# Linear CLI operations

These commands target `@schpet/linear-cli` 2.5.0. Replace `linear` with the repository's configured wrapper when applicable, and re-check `--help` because later versions may differ.

## Preflight

```bash
linear --version
linear auth list
linear auth whoami
linear team list
linear label list
```

Authentication is configured with `linear auth login`; repository defaults with `linear config`. Do not print `linear auth token` into agent output or logs.

## Read and query

```bash
linear issue view ENG-123 --json --no-download
linear issue query --team ENG --all-states --all-assignees --json --limit 0
linear issue query --team ENG --label wayfinder:map --all-states --json --limit 0
linear issue query --team ENG --label ready-for-agent --state unstarted --all-assignees --json --limit 0
linear issue relation list ENG-123
linear issue comment list ENG-123 --json
linear issue url ENG-123
```

`issue query` does not provide a parent filter in version 2.5.0. Query a bounded team/project/label set, then retain only children whose JSON parent matches the requested parent. Inspect `issue relation list` for each candidate before calling it frontier work.

## Create maps and tickets

Ensure required labels exist before creating work:

```bash
linear label create --name wayfinder:map --description "Wayfinder decision map"
linear label create --name wayfinder:research --description "Wayfinder research decision"
linear label create --name wayfinder:prototype --description "Wayfinder prototype decision"
linear label create --name wayfinder:grilling --description "Wayfinder human decision"
linear label create --name wayfinder:task --description "Wayfinder prerequisite task"
```

List first and create only missing labels. Label creation is not idempotent.

Create every issue before wiring dependencies so all identifiers exist:

```bash
linear issue create --no-interactive --team ENG --title "Map title" --description-file /tmp/map.md --label wayfinder:map
linear issue create --no-interactive --team ENG --title "Ticket title" --description-file /tmp/ticket.md --parent ENG-100 --label wayfinder:grilling
```

For `to-tickets`, use `--parent` when there is a real parent issue and apply the configured label that represents `ready-for-agent`.

## Native dependencies

```bash
linear issue relation add ENG-102 blocked-by ENG-101
linear issue relation add ENG-101 blocks ENG-102
linear issue relation list ENG-102
linear issue relation delete ENG-102 blocked-by ENG-101
```

The first two add commands express the same direction; use one, then verify from the blocked issue. Never add both as separate operations unless `relation list` proves the first did not create the inverse view automatically.

## Claim, update, and resolve

```bash
linear issue update ENG-123 --assignee self
linear issue comment add ENG-123 --body-file /tmp/resolution.md
linear issue update ENG-123 --state completed
```

State names are team-specific. The CLI accepts a workflow state by name or type; prefer the type `completed` only after `issue view` confirms this is a normal completion rather than cancellation. To release an abandoned claim without changing other fields:

```bash
linear issue update ENG-123 --unassign
```

Do not use `--label` on update unless replacing the entire label set is intended. Use `--add-label` and `--remove-label` for incremental changes.

## Update Markdown bodies

`linear issue update ENG-123 --description-file <path>` replaces the description. Before changing a shared map:

1. fetch the current issue as JSON;
2. preserve concurrent edits outside the exact section being changed;
3. write the merged Markdown to a temporary file;
4. re-fetch immediately before the update if other sessions may be active;
5. update and verify the resulting issue.

There is no compare-and-swap flag in CLI 2.5.0. If the map changed during the merge window, stop and reconcile instead of overwriting it.

## Failure handling

- Missing command: report the attempted resolution paths; do not switch trackers.
- Missing credentials: ask the user to run `linear auth login` in an interactive terminal.
- Missing repo config: ask the user to run `linear config` or follow the repo tracker doc.
- Ambiguous team, project, state, assignee, or label: list the available values and resolve by stable identifier or exact name.
- Partial multi-issue write: report exactly which issues and edges were created. Resume from observed Linear state; do not blindly replay the batch.
