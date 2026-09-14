# Vespasian Theming and Windows Integration

Vespasian is a Windows 11 workstation running Ubuntu 24.04 on WSL2. The theming system synchronizes colors, wallpaper, and dark/light mode across Windows, WezTerm, Windows Terminal, Neovim, and terminal tools.

## Theme Selection

Set the active theme for Vespasian:

```bash
dots theme set <theme-name>
```

Available themes include the built-in Tokyo Night variants and imported Omarchy themes:

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
- `wallpaper.png` — generated gradient (procedurally blended from palette colors)

The importer runs on Augustus (where Aether and Omarchy are native); Vespasian simply consumes the committed snapshots.

### Testing public Omarchy themes

Four public Omarchy themes are included as fixtures for validation:

- `omarchy-tokyo-night` — Tokyo Night v4 from basecamp/omarchy
- `omarchy-kanagawa` — Kanagawa from basecamp/omarchy
- `omarchy-everforest` — Everforest from basecamp/omarchy  
- `omarchy-nord` — Nord from basecamp/omarchy

These are immutable snapshots; they do not receive updates if the upstream Omarchy theme changes.

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

The wallpaper is **procedurally generated** from the theme's palette using a vertical gradient:

- Top: `darker_background` (near-black base)
- Bottom: `background` blended 55% toward `accent` (visible color transition)

This approach avoids redistribution rights questions and ensures reproducibility—the same palette always generates the same gradient bytes.

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

Theme adapters are generated when a snapshot is imported, then cached in `.chezmoitemplates/themes/<name>/`. The `run_onchange_*` scripts read these cached files and apply them to Windows.

Wallpaper generation is deterministic: the same palette always produces the same gradient PNG (same byte sequence). The script header includes a SHA-256 hash comment of the wallpaper source file, so chezmoi reruns the script if the wallpaper bytes change—avoiding a silent skip when the image is regenerated in place.

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

**Wallpaper appears black or blank:**
The gradient generation blends palette colors. Check that the theme's `darker_background`, `background`, and `accent` are sufficiently distinct. A near-black palette (e.g., Gruvbox) will produce a subtle gradient; lighter themes produce more visible transitions.

**Windows light/dark mode toggle in Settings doesn't sync:**
If manually toggling Settings > Personalization > Colors does not update the registry, check the current values:

```powershell
Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
```

If `AppsUseLightTheme` and `SystemUsesLightTheme` are correct but apps don't change, the issue is likely that the apps were already open when the mode changed. Restart them individually, or run `dots sync` again to re-broadcast the notification.

## Future enhancements

- **Windows accent color:** Attempted but found to be unreliable on this machine (Windows appears to auto-recompute it from the wallpaper, and the `AutoColorization` registry key did not prevent that behavior).
- **TranslucentTB profile:** Not yet integrated due to uncertainty about its persisted configuration format on packaged vs. portable releases.
- **Flow Launcher theme:** Currently unimplemented; the launcher picks up Windows dark/light mode automatically, providing basic theming without custom integration.
- **Icon and cursor packs:** Omarchy has icon themes, but Windows icon/cursor packs are installed via Settings and have no direct programmatic API. Explicit allowlisting could be added if a specific set of icon packs is identified.

## See also

- [`docs/aether-theming-integration-proposal.md`](aether-theming-integration-proposal.md) — Design rationale and architecture
- `.chezmoidata/themes.yaml` — Complete theme registry
- `.chezmoidata/machines.yaml` — Machine-specific theme selection
- `.chezmoitemplates/themes/*/` — Immutable theme snapshots
- `dot_local/bin/executable_dots-theme-import-aether` — Aether importer (runs on Augustus)
