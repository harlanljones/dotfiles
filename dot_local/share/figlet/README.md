# figlet fonts vendored for dots-identity

- `Roman.flf` — FIGlet font **Roman**, from
  [github.com/xero/figlet-fonts](https://github.com/xero/figlet-fonts)
  (font by Nick Miners, 1994, modified by patorjk in 2007; BSD-licensed
  distribution via that repo). Copied verbatim 2026-09. FIGlet's `.flf` format
  has no comment facility (the first line must be the `flf2a$` signature), so
  provenance lives here.
- `small.flf` — FIGlet font **Small**, by Glenn Chappell 4/93, part of the
  official figlet 2.1 release (free distribution). Copied verbatim from the
  Homebrew figlet package 2026-09. Its 4-5-row art is the short-window wordmark
  tier for `dots-identity`.

`dots-identity` renders the machine wordmark with
`figlet -f ~/.local/share/figlet/Roman.flf` on tall windows (>= 26 rows),
`small.flf` on short ones (>= 22 rows, also much narrower, so it fits narrow
splits); if `figlet` is missing or no font fits it degrades to the embedded
mini-font wordmark.
