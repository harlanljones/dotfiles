# Local Batch Verification

Date: 2026-09-06. Scope: HJ-729, the six `local-tracked` candidate trees.
Driver authored and then re-read the candidate changes against the baseline
sources. This is a separate verification pass, not an independent second model.
No candidate workflow was run against live services.

## Executed Checks

From `docs/skill-review` with `PYTHONDONTWRITEBYTECODE=1`:

- `python3 review.py check --source local-tracked`: six contract-valid candidates,
  no missing files, invalid reviews or layout errors. This verifies declared
  coverage and preservation, not semantic reading by itself.
- `python3 evaluations/test_local.py -v`: two tests pass. The metadata check parses
  all six entrypoints, agent YAML and local references, and verifies eight unique
  question IDs. The Bash loader fixture tests valid, empty, unmatched, duplicate
  and missing synthetic credentials in `/tmp/opencode`, without CLI/network calls.
- `python3 test_review.py -v`: 34 fixture tests pass; `python3 test_inventory.py -v`:
  13 fixture tests pass. Tooling was inspected before execution.
- `python3 review.py index`: generates the four central reports; 6 contract-valid,
  476 unreviewed, 16 frozen inventory gaps. No blanket completion claim.

Repository root checks: `git diff --check`, `python3 docs/generate_index.py --check`
and `python3 docs/generate_readme_tree.py --check` all exit zero. The git diff check
does not cover untracked candidate files; metadata and text checks cover this
batch separately. Root generated indexes remain based on 225 tracked entries;
candidate documentation is deliberately untracked and has not been staged.

## Static Composition Scenarios

| Scenario | Expected Candidate Behavior | Source |
| --- | --- | --- |
| Ask to review dotfiles | Findings, no absorb/apply/publication | dots: Authority and Scope; Review or Source Edit |
| Ask to edit a source template | Scoped edit and relevant dry-run; apply remains separately authorized | dots: Review or Source Edit |
| Ask to publish with unrelated dirty work | Inspect capture and `git add -A` scope; resolve unrelated publication first | dots: Requested Apply or Publication |
| Two ticket workers share `self` | One dispatcher, scoped ownership, no atomic-lock claim | frontier-sweep: Establish the Frontier; tracking: Claim |
| Tracker prerequisite complete but absent from base | Verify code presence before dispatch | frontier-sweep: Choose Execution |
| Implementation has untracked files | Include them in verification; triple-dot alone is insufficient | frontier-sweep: Verify and Continue |
| Worker stops with partial changes | Preserve work and record unmet criteria; no automatic reclaim/close | frontier-sweep: Verify and Continue |
| Grilling frontier empty because evidence is pending | Report blocked prerequisites, not exhaustive completion | grilling: final paragraph |
| User confirms the design | Confirmed understanding does not authorize implementation | grilling: final paragraph |
| Plan requested, writable repository | Return proposal unless guidance-file writes requested | project-doc-planner: Establish the working set |
| Small planning task with no agents | Two direct analytical passes, no artificial failed-delegation claim | project-doc-planner: Critic and Planner Passes |
| Usage question with stale saved figures | Label age, separate current observation from refresh | opencode-go-usage: Choose Read or Refresh |
| Override exits zero but panel refresh fails | Report recorded data separately from unverified display | opencode-go-usage: Authorized Manual Refresh |

These are source-grounded static walkthroughs, not live model evaluations or
measured quality gains. All eight questions remain human decisions. The scripts
outside the candidates were inspected, not changed or executed.

## Remaining Boundaries

Local batch readiness is not approval, redistribution permission or deployment.
No license files were discovered for these six variants. Provider metadata behavior,
related-skill merge decisions, final core membership and current quota payload
require later evidence. `verify-preservation` reports worktree preserved but live
drift at the Cursor sync manifest and Redis plugin-cache path; neither is waived.
