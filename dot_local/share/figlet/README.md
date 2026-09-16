# figlet fonts vendored for dots-identity

- `Roman.flf` — FIGlet font **Roman**, from
  [github.com/xero/figlet-fonts](https://github.com/xero/figlet-fonts)
  (font by Nick Miners, 1994, modified by patorjk in 2007; BSD-licensed
  distribution via that repo). Copied verbatim 2026-09. FIGlet's `.flf` format
  has no comment facility (the first line must be the `flf2a$` signature), so
  provenance lives here.

`dots-identity` renders the machine wordmark with
`figlet -f ~/.local/share/figlet/Roman.flf`; if `figlet` is missing or the
font can't be read it degrades to the embedded mini-font wordmark.
