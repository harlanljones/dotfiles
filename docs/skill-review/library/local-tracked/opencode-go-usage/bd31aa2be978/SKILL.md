---
name: opencode-go-usage
description: Read OpenCode Go rolling, weekly and monthly usage or diagnose stale Go figures in the local Omarchy monitor. Provider-local workflow; raw provider token totals are not Go plan quota usage.
---

# OpenCode Go Usage

The local collector's token totals and `OPENCODE_USAGE_LIMITS` ceilings are not
the Go plan's actual usage meters. This integration reads the workspace dashboard;
it does not establish that the provider has no quota API now or in the future.
Work in-session using the user's authorized account. Do not delegate browser
credentials, install tools, change the plan, or purchase quota for this task.

## Choose Read or Refresh

For a question about usage, read the authorized dashboard or an existing saved
snapshot and label its capture time. Report rolling, weekly and monthly **used**
percentages, remaining percentages (`100 - used`), and reset times/countdowns
with observation time and timezone. Treat missing resets as unknown, not zero.

The installed `omarchy-opencode-go-usage-scrape` is a refresh operation, not a
read-only query: it uses a saved browser profile and invokes the override writer.
Use it when the user requested or authorized updating the local monitor. Its
successful output is a captured observation, not proof the dashboard parser or
panel display remains correct. Check the three labels, ranges and freshness.

> Q-opencode-go-usage-refresh: Should a usage question implicitly refresh the
> monitor? Recommendation: no; use a read-only observation by default and run the
> writer only when refresh is requested. This makes the local side effect visible.

## Dashboard Fallback

Check tool availability before execution. The local scraper and override use a
fixed workspace URL in their installed configuration. Confirm it is the user's
intended workspace before using those tools; a fixed workspace URL does not
automatically select the right account. Navigate through the user's signed-in
OpenCode workspace with an authorized browser, or ask for the three visible
percent/countdown pairs if browser access is unavailable. Never ask for cookies
or account tokens in chat.

On expired/missing browser sessions, offer the installed
`omarchy-opencode-go-usage-login` for interactive sign-in. Missing payload fields
can also indicate a dashboard change, not just expired authentication. Report
the actual error and continue with manual observation if possible; do not
repeatedly rerun a failing scraper or invent current figures from cached tokens.

## Authorized Manual Refresh

Check `command -v omarchy-opencode-go-usage-override`. If absent, report observed
usage and the unavailable integration; do not install it as part of answering.
Read current help before recording observations from the confirmed workspace:

```bash
omarchy-opencode-go-usage-override \
  --rolling <ROLLING_USED_PCT> --rolling-resets <ROLLING_DURATION> \
  --weekly <WEEKLY_USED_PCT> --weekly-resets <WEEKLY_DURATION> \
  --monthly <MONTHLY_USED_PCT> --monthly-resets <MONTHLY_DURATION> \
  --source <OBSERVED_WORKSPACE_URL>
```

Inputs are 0-100 percentages; output JSON stores fractions (0-1). Convert
countdowns to durations such as `30d22h` or `3h52m`. Omit a reset flag when its
countdown is unknown; never fabricate it. Record promptly because relative
durations are interpreted at write time. Do not overwrite all three meters
with a mixture of fresh and unknown percentages.

The writer saves `opencode-go-dashboard.json` under the Omarchy agents config
directory (`$XDG_CONFIG_HOME/omarchy/agents`, default `~/.config/omarchy/agents`).
Its current implementation attempts a monitor refresh but suppresses that
command's errors. Verify the saved payload separately from the panel: report
"recorded; panel not verified" unless the updated display was actually observed.
The integration documents a 24-hour override lifetime; check the installed
collector before relying on that duration or its fallback behavior.

Finish with figures, source and observation time, missing evidence, and whether
anything was recorded. Keep this skill provider-local unless the user chooses
a cross-harness distribution policy; no generic OpenCode configuration task
should invoke it.
