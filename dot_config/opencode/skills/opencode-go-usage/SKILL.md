---
name: opencode-go-usage
description: Use when the user asks about their OpenCode Go usage, limits, or quota — how much of the Rolling/Weekly/Monthly window is left, when it resets, or why the agent monitor's Go figures look stale. Reads the real numbers off the workspace page and records them for the omarchy agent monitor.
---

# Real OpenCode Go limits

OpenCode exposes no quota endpoint. The agent monitor's `opencode` collector
reports raw token totals per provider, plus whatever ceilings are configured
in `OPENCODE_USAGE_LIMITS` — none of which is the Go plan's actual
Rolling/Weekly/Monthly usage. Those three meters live only in the workspace
UI.

`omarchy-opencode-go-usage-scrape` normally reads them on a 15-minute timer.
This skill is the path for when it can't: its saved browser session expired,
the timer isn't installed, or the user wants the numbers right now in chat.

## Steps

1. **Try the scraper first** — it needs no interaction and is authoritative:

   ```
   omarchy-opencode-go-usage-scrape
   ```

   If it succeeds it prints the recorded JSON and refreshes the panel. Report
   the three percentages and reset times, and stop.

   If it fails with "the saved session has likely expired", tell the user to
   run `omarchy-opencode-go-usage-login` once (it opens a visible window in
   the machine's default Chromium-based browser to sign in), then continue
   with the steps below for the numbers
   they need right now.

2. **Read the numbers.** Open `https://opencode.ai/workspace/wrk_01M0JWEHT6TBW13JZBZQVW1XVB/go` for the user — it
   redirects a signed-in browser to their workspace Go page. With a browser
   tool, navigate there and read the page directly. Otherwise open it
   (`xdg-open` on Linux) and ask the user to read off three pairs:

   - **Rolling Usage** — percent used, and its "Resets in" countdown
   - **Weekly Usage** — percent used, and its "Resets in" countdown
   - **Monthly Usage** — percent used, and its "Resets in" countdown

   Unlike Cline's dashboard, all three windows show a countdown here.

3. **Check the override script is installed:**
   `command -v omarchy-opencode-go-usage-override`

   If it's missing, report the three numbers in chat and stop — there's no
   local widget to update on this machine.

4. **Record them,** converting each countdown to the `DdHhMm` duration the
   script expects ("30 days 22 hours" → `30d22h`, "3 hours 52 minutes" →
   `3h52m`):

   ```
   omarchy-opencode-go-usage-override \
     --rolling <ROLLING_PCT> --rolling-resets <ROLLING_DURATION> \
     --weekly <WEEKLY_PCT> --weekly-resets <WEEKLY_DURATION> \
     --monthly <MONTHLY_PCT> --monthly-resets <MONTHLY_DURATION>
   ```

   This writes `~/.config/omarchy/agents/opencode-go-dashboard.json` and
   refreshes the agent monitor immediately. The collector prefers these
   figures over any configured quota for the next 24 hours, after which it
   quietly falls back to token-only reporting.

5. **Summarize:** the three percentages, when each window resets, and confirm
   the agent monitor now shows the real Go figures.
