# Vespasian Theming and Windows Integration

Vespasian is a Windows 11 workstation running Ubuntu 24.04 on WSL2. The theming system synchronizes colors, wallpaper, and dark/light mode across Windows, WezTerm, Windows Terminal, Neovim, and terminal tools.

## Theme Selection

Set the active theme for Vespasian:

```bash
dots theme set <theme-name>
```

Available themes are all imported from Omarchy (see below) — there are no
hand-built themes on this box:

```bash
dots theme         # List all themes
dots theme inspect <name>  # Show theme details and palette
```

Current machine theme is stored in `.chezmoidata/machines.yaml` under `machines.vespasian.theme.name` and applied on next `dots sync`.

## Aether Integration

The Aether importer bridges Omarchy v4 themes into Vespasian's native Windows environment. Public Omarchy themes can be tested without Aether or Omarchy installed on this machine.

The importer creates immutable theme snapshots in `.chezmoitemplates/themes/<theme-name>/`, capturing:

- `colors.toml` — canonical Omarchy v4 semantic palette
- `manifest.yaml` — provenance, checksums, import timestamp
- Platform adapters: `windows_terminal.json`, `zebar.css`, `nvim.lua`, `lazygit.yml`, `delta.gitconfig`, `fzf.sh`, `eza.yml`, `bat.tmTheme`, `gemini.json`
- `wallpaper.png` — the theme's real Omarchy background (see below), downscaled/cropped to 1920x1080 and re-encoded as PNG

The importer runs on Augustus (where Aether and Omarchy are native); Vespasian simply consumes the committed snapshots.

### The 8 themes

Eight Omarchy themes make up the full roster:

- `omarchy-tokyo-night` — Tokyo Night v4 from basecamp/omarchy
- `omarchy-kanagawa` — Kanagawa from basecamp/omarchy
- `omarchy-everforest` — Everforest from basecamp/omarchy
- `omarchy-nord` — Nord from basecamp/omarchy
- `omarchy-gruvbox` — Gruvbox from basecamp/omarchy
- `omarchy-catppuccin` — Catppuccin (Mocha) from basecamp/omarchy
- `omarchy-rose-pine` — Rosé Pine from basecamp/omarchy (Omarchy ships this variant as `mode = "light"`)
- `omarchy-catppuccin-latte` — Catppuccin Latte from basecamp/omarchy (light)

These are immutable snapshots; they do not receive updates if the upstream Omarchy theme changes. Each snapshot's `manifest.yaml` records both the palette source (`source:`) and the wallpaper source (`wallpaper:` — original filename, repo path, license).

## Windows Integration

### Dark/light mode synchronization

Script `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` synchronizes the theme's light/dark mode:

1. Sets `HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize` registry keys (`AppsUseLightTheme`, `SystemUsesLightTheme`, `EnableTransparency`).
2. Restarts Windows Explorer so the taskbar, Start menu, and File Explorer refresh.
3. Broadcasts `WM_SETTINGCHANGE` messages to running applications so they pick up the mode change live, without requiring a restart. This targets both `ImmersiveColorSet` and `WindowsThemeElement` to cover Settings, Notepad, Windows Terminal, VS Code, and other managed apps.

### Wallpaper

Script `run_onchange_after_46-vespasian-wallpaper.sh.tmpl` applies the theme's wallpaper:

1. Reads `wallpaper.png` from the active theme snapshot.
2. Copies it to `%LOCALAPPDATA%\dots\themes\<theme-name>\wallpaper.png` for persistence across theme changes.
3. Uses `SystemParametersInfo(SPI_SETDESKWALLPAPER)` to apply the wallpaper to the Windows desktop.
4. Sets wallpaper style to "fill" (stretch to fill, preserving aspect ratio).

The wallpaper is the theme's **real Omarchy background image** — one file
picked from that theme's `themes/<name>/backgrounds/` directory in
basecamp/omarchy, downscaled/cropped to 1920x1080 and re-encoded as PNG.
basecamp/omarchy is MIT-licensed as a whole repository (confirmed via its
README and `LICENSE` file), which covers the bundled background images, so
there's no redistribution-rights concern importing them verbatim into this
repo. Earlier versions of this pipeline generated a procedural gradient
instead specifically to sidestep that question before the license had been
checked; `dot_local/bin/executable_dots-theme-import-aether` still has a
`generate_wallpaper_png` fallback for a theme that ships no real
background of its own (e.g. an Aether export from a custom, unpublished
theme).

### Windows Terminal

Script `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` applies the color scheme and profile settings:

1. Generates a Windows Terminal color scheme fragment from the theme's palette (with correct ANSI color mapping, selection, cursor, and background).
2. Writes fragments to both standard and packaged Windows Terminal directories.
3. Updates `settings.json` to apply the scheme to the Ubuntu profile and set defaults (font, padding, opacity, acrylic, cursor style).
4. Sets the Ubuntu profile as the default so new tabs launch into it.

### GlazeWM and Zebar

Script `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` configures the tiling window manager and status bar:

1. Reads the Windows Terminal color scheme to extract the active theme's palette.
2. Generates `zebar.css` with CSS custom properties for all palette colors and opacity variants.
3. Configures Zebar's widget pack and GlazeWM window borders using theme `accent` (focused) and `muted` (unfocused).
4. Registers GlazeWM, Zebar (`Zebar.lnk`), AutoHotkey, Flow Launcher, and QuickLook in the Windows Startup folder so they launch on logon as detached native Windows processes.
5. Configures GlazeWM keybindings matching Omarchy (Hyprland) defaults from Augustus (terminal, Chrome browser with incognito, Explorer, VS Code, 1Password, calculator, and webapps); see [`docs/vespasian-boot.md`](vespasian-boot.md) for the full keymap.
6. Moves stale theme directories to prevent configuration cruft.

## Terminal Tools

All terminal tools share the same color palette and are configured through theme adapters:

| Tool | Adapter | Notes |
| :--- | :--- | :--- |
| WezTerm | `.wezterm.lua` | Applied by script 45; generates config from Windows Terminal theme palette with WSL domain, font, opacity, acrylic. |
| Windows Terminal | `windows_terminal.json` | Applied by script 40; includes ANSI palette, selection, cursor, opacity, acrylic. |
| Neovim | `nvim.lua` | Generated palette-based plugin spec; includes theme selection for `folke/tokyonight.nvim` (legacy themes) or a fallback dark mode (Omarchy imports). |
| lazygit | `lazygit.yml` | ANSI color mapping for lazygit UI. |
| delta | `delta.gitconfig` | Syntax highlighting colors for `git diff`. |
| fzf | `fzf.sh` | Fuzzy finder color scheme. |
| eza | `eza.yml` | File listing colors and icons. |
| bat | `bat.tmTheme` | Syntax highlighting for file preview and `cat`. |
| Gemini | `gemini.json` | JSON-formatted palette for Google Gemini agent integration. |

## Architecture

### Registry structure

Theme metadata lives in `.chezmoidata/themes.yaml`:

```yaml
themes:
  omarchy-tokyo-night:
    label: "Omarchy Tokyo Night"
    appearance: dark
    format: omarchy-v4
    source:
      kind: omarchy-public-theme
      name: "tokyo-night"
      repo: "https://github.com/basecamp/omarchy/tree/master/themes/tokyo-night"
      colorsSha256: "8b5f53ba35b9305aafa72776dd56ea2029faaf29015e2e42db5e19ef698a8e0e"
      importedAt: "2026-09-14T00:21:57Z"
    windows:
      accent: "#7aa2f7"
      colorPrevalence: true
```

Machine-specific selection is in `.chezmoidata/machines.yaml`:

```yaml
machines:
  vespasian:
    theme:
      name: omarchy-tokyo-night
```

### Generation and caching

Theme adapters (palette-derived text files) are generated when a snapshot is imported, then cached in `.chezmoitemplates/themes/<name>/`. Wallpapers are binary and live separately in `theme-assets/<name>/wallpaper.png` — see "Binary assets live outside .chezmoitemplates" below. The `run_onchange_*` scripts read both and apply them to Windows.

The wallpaper script's rerun trigger doesn't depend on the wallpaper being deterministic: the script header includes a SHA-256 hash comment of the wallpaper file's actual bytes, so chezmoi reruns the script whenever those bytes change (a new real image, a re-generated gradient, or a switch to a different theme) — avoiding a silent skip when only the image content changes at the same cache path. The script itself always calls `SystemParametersInfo` when it runs, rather than gating that call on whether the registry's wallpaper *path* changed, since a real image swap keeps the same path (`theme-assets/<name>/wallpaper.png`) with new content.

### Binary assets live outside .chezmoitemplates

chezmoi eagerly parses every file under `.chezmoitemplates/` as one combined Go template set — regardless of file extension — because that directory exists specifically to hold `template`/`include` sources. A real photographic PNG's bytes are effectively certain to contain a byte sequence that looks like a Go template action delimiter pair somewhere in several hundred KB of image data, which corrupts that combined parse; which file trips it is non-deterministic (depends on Go's randomized map iteration order), so the same repo state can fail on a different file each run. Wallpaper PNGs therefore live in `theme-assets/<name>/wallpaper.png` — a plain directory, excluded from deployment via `.chezmoiignore.tmpl`, read only through `{{ include }}` by `run_onchange_after_46-vespasian-wallpaper.sh.tmpl`. The palette-derived text adapters (`colors.toml`, `manifest.yaml`, `windows_terminal.json`, etc.) stay in `.chezmoitemplates/themes/<name>/` since plain-text hex colors and YAML/JSON never coincidentally contain that byte sequence.

### Validation

All generated JSON, TOML, YAML, XML, Lua, CSS, and shell files are validated before commit:

- JSON/TOML/YAML parsers check syntax and structure.
- Lua files pass `nvim --headless -u NONE -c luafile`.
- Shell scripts pass `bash -n` and `shellcheck`.
- PNG files verify the correct magic bytes (`89 50 4E 47`).

## Rollback

To restore a previous theme:

```bash
dots theme set <previous-theme-name>
```

This reapplies all Windows registry, Terminal, wallpaper, and tool settings atomically through `dots sync`. There is no undo within a theme application; select a different theme to change state.

## Troubleshooting

**Colors don't appear live in running apps:**
Ensure the `WM_SETTINGCHANGE` broadcast in script 40 ran without errors. Re-run:

```bash
dots sync
```

If Windows Terminal doesn't refresh, close all Terminal windows and re-open; the profile/scheme change requires Terminal to reload its settings file.

**Wallpaper doesn't change even though the script reports success:**
Confirm the fix described above landed: the script must call `SystemParametersInfo` unconditionally, not only when the registry's wallpaper path differs from the new one. A theme's wallpaper path is stable (`theme-assets/<name>/wallpaper.png`), so replacing that file's content while keeping the same theme active previously left Windows showing its already-loaded bitmap.

**Wallpaper appears black or blank (only relevant for the generated-gradient fallback):**
A theme with no bundled Omarchy background falls back to a generated gradient blending palette colors. Check that the theme's `darker_background`, `background`, and `accent` are sufficiently distinct. A near-black palette will produce a subtle gradient; lighter themes produce more visible transitions.

**Windows light/dark mode toggle in Settings doesn't sync:**
If manually toggling Settings > Personalization > Colors does not update the registry, check the current values:

```powershell
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
```

If `AppsUseLightTheme` and `SystemUsesLightTheme` are correct but apps don't change, the issue is likely that the apps were already open when the mode changed. Restart them individually, or run `dots sync` again to re-broadcast the notification.

### Flow Launcher

Script `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` generates a custom
Flow Launcher theme (`UserData/Themes/Dots.xaml`) from the same `$scheme` palette
as WezTerm and Zebar, and sets it active in `UserData/Settings/Settings.json`
(merged in, preserving any other settings Flow Launcher has already written).
`BorderThickness`/`CornerRadius` on the launcher window match GlazeWM's
`border_size`/`corner_style` so the two feel like the same system.

### Desktop icons

Script `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` hides desktop
icons so the themed wallpaper is the whole visible desktop surface, and apps
are launched via Flow Launcher (`Win+Space` / `Alt+Space`) instead of
desktop shortcuts. There's no plain registry setting for "Show desktop
icons" — it's a `Progman` `WM_COMMAND` toggle (`0x7402`) — so the script
sends that message directly, matching what the context-menu item does. It
first checks `HKCU\...\Explorer\Advanced\HideIcons` (the value Windows
persists after the toggle) so re-running is a no-op when icons are already
hidden. No elevation needed, and it never touches `explorer.exe`'s process,
so it can't disturb Zebar's `dockToEdge` reservation.

### System UI font

Script `run_onchange_after_41-vespasian-nerd-font.sh.tmpl` also substitutes
`JetBrainsMono Nerd Font` for `Segoe UI` system-wide via the HKLM
`FontSubstitutes` registry key, after installing the font. Because that key is
under HKLM, the write needs a one-time UAC-elevated PowerShell prompt (approve
it when `dots sync` asks); the current value is read first so re-applying is a
no-op and doesn't re-prompt. This covers File Explorer, dialog boxes, title
bars, and most classic Win32 UI. Windows 11's Fluent surfaces (Settings, Start
menu, some Store apps) render with `Segoe UI Variable` instead and are not
covered. FontSubstitutes is read into a per-session win32k font-mapper cache,
not re-read when an individual process restarts — confirmed by testing:
killing and relaunching `explorer.exe` left desktop icon labels on the old
font. So the script does not restart `explorer.exe` (that would only add
risk, since killing it also drops Zebar's `dockToEdge` work-area reservation
with nothing to re-register it); a full sign-out/sign-in is the only way to
make every surface — including desktop icon labels, the taskbar, File
Explorer, and any other already-running app — pick up the new font.

## Future enhancements

- **Windows accent color:** Attempted but found to be unreliable on this machine (Windows appears to auto-recompute it from the wallpaper, and the `AutoColorization` registry key did not prevent that behavior).
- **TranslucentTB profile:** Not yet integrated due to uncertainty about its persisted configuration format on packaged vs. portable releases.
- **Icon and cursor packs:** Omarchy has icon themes, but Windows icon/cursor packs are installed via Settings and have no direct programmatic API. Explicit allowlisting could be added if a specific set of icon packs is identified.

## See also

- [`docs/aether-theming-integration-proposal.md`](aether-theming-integration-proposal.md) — Design rationale and architecture
- `.chezmoidata/themes.yaml` — Complete theme registry
- `.chezmoidata/machines.yaml` — Machine-specific theme selection
- `.chezmoitemplates/themes/*/` — Immutable theme snapshots
- `dot_local/bin/executable_dots-theme-import-aether` — Aether importer (runs on Augustus)
