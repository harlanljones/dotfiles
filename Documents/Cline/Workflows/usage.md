# /usage — real Cline Pass limits

Cline has no API for rate-limit usage, so the local usage panel (the
omarchy agent monitor / Agent Leaderboard bar widget) can only *estimate*
your Session/Weekly/Monthly ClinePass usage by pricing local transcripts
against reference rates. This workflow gets the real numbers from the
dashboard and pushes them into both this chat and that widget.

Run these steps:

1. Open `https://app.cline.bot/dashboard/subscription` for the user. If you have a
   browser tool, navigate there and read the page directly. Otherwise, run
   a terminal command to open it (`xdg-open` on Linux, `open` on macOS), and
   ask the user to read off three numbers from the page:
   - **Session** percent used (no reset countdown shown — it's a rolling
     5-hour window)
   - **Weekly** percent used, and the "Resets in" countdown (e.g. `2d 13h`)
   - **Monthly** percent used, and the "Resets in" countdown (e.g. `10d 13h`)

   If you navigated there yourself, read these values straight off the page
   instead of asking.

2. Check whether the override script is installed:
   `command -v omarchy-cline-usage-override`

   - If it's missing, just report the three numbers back to the user in
     chat and stop here — there's no local widget to update on this
     machine.

3. If it's installed, record the real numbers with it, converting each
   "Resets in" countdown to the `DdHhMm` duration format the script expects
   (e.g. "2d 13h" → `2d13h`):

   ```
   omarchy-cline-usage-override \
     --session <SESSION_PCT> \
     --weekly <WEEKLY_PCT> --weekly-resets <WEEKLY_DURATION> \
     --monthly <MONTHLY_PCT> --monthly-resets <MONTHLY_DURATION>
   ```

   This writes `~/.config/omarchy/agents/cline-dashboard.json` and refreshes
   the agent monitor immediately, so the panel shows these real figures
   (instead of its estimate) for the next 24 hours.

4. Summarize the result back to the user: the three percentages, when each
   window resets, and confirm the omarchy agent monitor now reflects the
   real dashboard numbers.
