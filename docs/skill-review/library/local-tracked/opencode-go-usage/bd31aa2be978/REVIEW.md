# OpenCode Go Usage Candidate Review

Disposition: retain provider-local quota workflow, correct authority and evidence.
Proposed pack: `opencode-usage`, provider-local rather than shared core.
Invocation: questions about Go quota or stale Go monitor values, not generic
OpenCode configuration. Execution: in-session account/browser observation;
neither delegated credential handling nor Herdr adds value to this task.

## Read and Findings

Read the full 69-line baseline `SKILL.md`, the only retained file. Provenance and
mirrors are recorded by its inventory entry; no license file was discovered.
Supporting source inspected read-only: all of
`dot_local/bin/executable_omarchy-opencode-go-usage-override.tmpl` and
`dot_local/bin/executable_omarchy-opencode-go-usage-scrape.tmpl`.

Preserve the distinction between raw provider token totals and Go plan meters,
rolling/weekly/monthly windows, scraper/login/manual fallback, compact reset
durations, override command and local dashboard integration.

Baseline calls the scraper authoritative, assumes a fixed URL selects the user's
workspace, and promises the monitor displays current values after success. Source
shows a hardcoded workspace URL, a parser that can miss reset values, and an
override writer that suppresses refresh failure (`os.system(... || true)`). The
candidate verifies workspace identity, distinguishes used percentages from JSON
fractions, permits unknown reset flags, labels observation age, and separates
recorded payload from verified panel display. It qualifies the unverified global
claim that no quota API exists and the documented 24-hour retention behavior.

## Validation and Decision

Static cases: stale snapshot is not current quota; a usage-only question does not
refresh state; fixed URL needs account confirmation; missing payload need not mean
expired login; unknown countdown is not zero; successful write cannot prove panel
refresh. No scraper, browser, override or authenticated dashboard was executed.

`Q-opencode-go-usage-refresh` asks whether quota questions imply monitor writes.
Recommend explicit refresh authority because the helper mutates saved state and
attempts a refresh. These recommendations are not activation settings.

## Maintenance and Promotion

The local scripts remain external dependencies, not copied into the skill tree.
Before promotion, validate current dashboard payload, configured workspace,
installed collector lifetime/fallback and provider discovery. Keep provider-local
ownership unless the user chooses broader distribution. No live script changes,
credential reads for this candidate, paid requests or monitor writes occurred.
