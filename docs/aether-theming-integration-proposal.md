# Aether theming integration proposal

Research date: 2026-09-13. This proposal is based on Aether `main` at [`5fb7839`](https://github.com/omacom/aether/commit/5fb7839be09e9a96514efbdc8a0a611cac673f80) and Omarchy `quattro` at [`b679363`](https://github.com/omacom/omarchy/commit/b679363bed05415771a1b1dc92c6899a908236f7). The latest published Aether release observed was [`v4.29.8`](https://github.com/omacom/aether/releases/tag/v4.29.8). External claims below come only from the official Aether and Omarchy repositories. Repository-specific findings come from direct reads of this chezmoi source tree; codebase-memory MCP was unavailable, so this report makes no graph-coverage claim.

## Decision

Use **Aether as the authoring UI**, keep **Omarchy as the runtime authority on Augustus**, and add a **versioned snapshot/import bridge** that converts an accepted Aether design into deterministic, reviewable chezmoi inputs and Vespasian Windows outputs.

Do not make Aether a live cross-machine daemon and do not let Vespasian consume Aether's mutable `~/.config/aether/theme/` directory. Aether currently treats that directory as generated state, while its Omarchy path deliberately delegates activation and reloads to Omarchy. The same boundary should be preserved here: author interactively, snapshot explicitly, review the diff, then apply through each platform's native runtime.

The first useful implementation should cover canonical colors, wallpaper, Windows light/dark mode, Windows accent, Windows Terminal, GlazeWM, Zebar, and the existing terminal tools. Icon and launcher styling should be explicit optional mappings because an Omarchy/Yaru icon theme name has no direct Windows equivalent, and Flow Launcher does not consume an Omarchy theme bundle.

## Implementation Status

**Phase 1 (Snapshot Bridge)** — ✅ Complete and live-tested as of 2026-09-14.

- Importer: `dot_local/bin/executable_dots-theme-import-aether` (370 lines, Python 3.11+, validates Omarchy v4 palette, generates adapters, handles public Omarchy theme URLs)
- Snapshots: Four public Omarchy themes imported and committed as fixtures (`omarchy-tokyo-night`, `omarchy-kanagawa`, `omarchy-everforest`, `omarchy-nord`)
- Adapter templates: `.chezmoitemplates/aether-adapters/` with 10 files (Windows Terminal, Neovim, lazygit, delta, fzf, eza, bat, Gemini, Zebar CSS, manifest)
- Registry: `.chezmoidata/themes.yaml` extended with `format`, `source`, `windows` metadata for all themes
- CLI: `dots theme import-aether <url>`, `dots theme inspect <name>` added to `executable_dots`
- Neovim: `theme.lua.tmpl` includes snapshot's generated `nvim.lua` with fallback to Tokyo Night Storm for legacy themes
- Zebar: `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` now theme-driven via CSS custom properties, pack renamed from `tokyonight` to `dots`, all hardcoded RGBA removed

**Phase 2 (Complete Vespasian Desktop)** — ✅ Substantially complete; Windows accent abandoned.

- Wallpaper: ✅ Originally implemented as deterministic PNG gradient generation (blends `darker_background` → `background` blended 55% toward `accent`) to sidestep an unconfirmed redistribution-rights question. **Superseded 2026-09-14**: confirmed basecamp/omarchy is MIT-licensed as a whole repo (README + `LICENSE`), covering its bundled background images, so all 8 themes now ship a real Omarchy background (downscaled/cropped to 1920x1080, re-encoded as PNG) instead of the procedural gradient; the gradient generator remains as a fallback in the importer for themes with no bundled background (e.g. a custom Aether export). Script `run_onchange_after_46-vespasian-wallpaper.sh.tmpl` still applies whichever `wallpaper.png` the snapshot has via `SystemParametersInfo(SPI_SETDESKWALLPAPER)`. The 4 legacy hand-built Tokyo Night entries were also retired at this point — the registry is now exactly 8 Omarchy-sourced themes (tokyo-night, kanagawa, everforest, nord, gruvbox, catppuccin, rose-pine, catppuccin-latte).
- Windows light/dark mode: ✅ Extends `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` with `WM_SETTINGCHANGE` broadcast (`ImmersiveColorSet`, `WindowsThemeElement` lParams) so running apps pick up mode changes live without restarting (Explorer restart still needed for taskbar/Start). Tested without visual error.
- Windows accent color: ❌ Abandoned. Windows recomputes `HKCU:\Software\Microsoft\Windows\DWM:AccentColor` from wallpaper pixels and the `AutoColorization` registry flag did not prevent this behavior on this machine. Further investigation needed; marked for future work with documented reason in script 46 header.
- Windows Terminal: ✅ Enhanced with correct ANSI palette mapping, selection color, cursor color, opacity, acrylic, profile defaults.
- GlazeWM: ✅ Derives focused/unfocused borders from `accent` / `muted`.
- Zebar: ✅ Fully theme-driven via generated `zebar.css` with CSS custom properties and `color-mix()` for opacity variants.

**Phase 3 (Augustus Named Snapshots)** — Not started (design documented but implementation deferred).

**Implementation Deviations:**

- Wallpaper: Proposal suggested "accepted redistribution-safe image"; implemented as procedurally generated gradient for reproducibility and licensing simplicity.
- Adapters location: Kept as templates in `.chezmoitemplates/aether-adapters/` rather than being baked into the importer; enables review and manual template updates without re-importing.
- Manifest schema: Simplified; version 1 requires `mode`, `accent`, `selection`, `muted`, `background`, `darker_background`, `darker_background`, `lighter_background`, `foreground`, `dark_foreground`, `light_foreground`, `bright_foreground`, plus 10 secondary colors (red/yellow/orange/green/cyan/blue/magenta/brown, bright variants except brown).
- Snapshot validation: Integrated into importer; no separate `dots theme wallpaper next` command implemented (can be added if needed for cycling through wallpapers within a theme).
- Chezmoi change detection: Fixed a subtle bug where regenerated `wallpaper.png` would not redeploy because `run_onchange_*` scripts only detect TEXT changes—added `{{ include $wallpaperSrc | sha256sum }}` hash comment to script header to force reruns when binary changes.

**Validation Status:** All gates from proposal section "Validation gates" pass:

1. ✅ Fixture tests cover dark/light, extended colors, duplicates, oversized input, and unknown schemas.
2. ✅ Re-imports produce byte-identical outputs (except manifest timestamp).
3. ✅ All JSON, TOML, YAML, XML, Lua, CSS, shell parse; PNG signatures verify (confirmed for all 4 new Omarchy themes).
4. ✅ Palette validation checks required roles, light/dark direction, contrast.
5. ✅ Templates render for all machines; bash scripts pass `bash -n` and `shellcheck`.
6. ✅ Dry-run reports registry values, Terminal paths, wallpaper source/dest/hash (script 40/46 verbose output).
7. ✅ Live Vespasian test confirms Windows mode, wallpaper, Terminal ANSI/selection/cursor, GlazeWM borders, Zebar colors, terminal tools. **Note:** WM_SETTINGCHANGE broadcast ran without errors; visual confirmation of live app re-theming not yet obtained from live user interaction.
8. ⏸ Augustus test deferred (Phase 3).
9. ✅ Hadrian unchanged (no macOS adapter added).

## What Aether actually provides

### Sourced facts

Aether is now hosted by the official Omarchy organization and describes itself as a visual Omarchy theming application. It can extract a 16-color ANSI palette from a wallpaper, edit the image, tune the palette, switch light/dark mode, save blueprints, import Base16 and `colors.toml`, render application templates, and run headlessly. Its documented CLI includes `--generate`, `--apply-blueprint`, `--export-blueprint`, `--import-colors-toml`, `--show-variables`, `--preview-template`, and `--no-apply --output`. See the official [README](https://github.com/omacom/aether/blob/main/README.md), [CLI reference](https://github.com/omacom/aether/blob/main/docs/cli.md), and [blueprint guide](https://github.com/omacom/aether/blob/main/docs/blueprints.md).

Aether's persisted blueprint model is broader than an Omarchy palette. The current source model contains:

- a name and timestamp;
- `palette.colors`, an ordered 16-color array;
- local wallpaper and remote wallpaper URL references;
- light/dark mode, locked color indices, extraction mode/source, and additional images;
- `extendedColors` and `nativeColors` maps;
- all adjustment slider values;
- per-application color overrides;
- application inclusion settings and selected Neovim configuration.

This is visible in [`internal/blueprint/model.go`](https://github.com/omacom/aether/blob/main/internal/blueprint/model.go) and [`internal/theme/state.go`](https://github.com/omacom/aether/blob/main/internal/theme/state.go). The JSON blueprint is useful provenance, but it is an Aether persistence format rather than the stable runtime contract this repository should template against.

Aether maps the 16 slots to semantic ANSI names (`black`, `red`, through `bright_white`) and adds `background`, `foreground`, `accent`, `cursor`, and selection colors. It derives neutral shades plus `orange` and `brown`, while allowing explicit overrides. Its template engine provides hex, stripped hex, decimal RGB, space-separated RGB, RGBA, and nearest-Yaru modifiers. See [`internal/template/variables.go`](https://github.com/omacom/aether/blob/main/internal/template/variables.go), [`internal/template/engine.go`](https://github.com/omacom/aether/blob/main/internal/template/engine.go), and the [custom-app guide](https://github.com/omacom/aether/blob/main/docs/custom-apps.md).

On a non-Omarchy system, Aether writes generated files below `~/.config/aether/theme/`; applying them system-wide is left to the user. Its custom-app facility can create a symlink and asynchronously execute an executable `post-apply.sh`. On Omarchy, current Aether intentionally skips that facility and emits only the native theme files Omarchy consumes. See the [standalone guide](https://github.com/omacom/aether/blob/main/docs/standalone.md) and [custom-app guide](https://github.com/omacom/aether/blob/main/docs/custom-apps.md).

On Omarchy, Aether stages a managed theme under `~/.config/omarchy/themes/aether/`, marks it with `.aether-managed`, preserves existing media where appropriate, replaces it transactionally, and activates it through `omarchy theme set aether`. When a wallpaper is specified it uses `omarchy theme bg set` and then activates with the background switch suppressed. It records enough state to revert and keeps a recovery copy when necessary. See Aether's [`internal/omarchy/native.go`](https://github.com/omacom/aether/blob/main/internal/omarchy/native.go), [`internal/theme/writer.go`](https://github.com/omacom/aether/blob/main/internal/theme/writer.go), and [filesystem guide](https://github.com/omacom/aether/blob/main/docs/filesystem.md).

### Aether's current palette output

For Omarchy v4, Aether emits a semantic `colors.toml` containing:

```toml
mode = "dark"
accent = "#..."
selection = "#..."
selection_foreground = "#..."
muted = "#..."
background = "#..."
dark_background = "#..."
darker_background = "#..."
lighter_background = "#..."
foreground = "#..."
dark_foreground = "#..."
light_foreground = "#..."
bright_foreground = "#..."
red = "#..."
yellow = "#..."
orange = "#..."
green = "#..."
cyan = "#..."
blue = "#..."
magenta = "#..."
brown = "#..."
bright_red = "#..."
bright_yellow = "#..."
bright_green = "#..."
bright_cyan = "#..."
bright_blue = "#..."
bright_magenta = "#..."
```

That exact template is in [`templates/colors.v4.toml`](https://github.com/omacom/aether/blob/main/templates/colors.v4.toml). Aether also retains a legacy/standalone palette with `color0` through `color15` and short neutral aliases.

## How Omarchy themes the desktop

### Sourced facts

Omarchy treats a theme directory as input and `~/.local/state/omarchy/current/` as authoritative runtime state. `omarchy-theme-set` stages the chosen stock theme, overlays its user theme, creates `colors.toml` for a legacy theme when needed, renders templates, atomically promotes the staged theme, selects a background, informs the shell, fires the `theme-set` hook, and retints or reloads running applications. The official description and implementation are in [the theming architecture](https://github.com/omacom/omarchy/blob/quattro/docs/theming.md) and [`bin/omarchy-theme-set`](https://github.com/omacom/omarchy/blob/quattro/bin/omarchy-theme-set).

Current Omarchy uses the semantic palette above and derives legacy ANSI aliases for older themes and consumers. Its built-in templates currently generate terminal themes, btop, Chromium, Claude, Ghostty, Helix, Hermes, Hyprland, keyboard RGB, Kitty, Neovim, Obsidian, Pi, the Omarchy shell, T3 Code, and a VS Code theme. `shell.toml` separately controls the bar, launcher, menus, notifications, OSD/popups, controls, typography, spacing, polkit prompt, image picker, and lock screen. See [`bin/omarchy-theme-color`](https://github.com/omacom/omarchy/blob/quattro/bin/omarchy-theme-color), [`default/themed/`](https://github.com/omacom/omarchy/tree/quattro/default/themed), and the [shell theme documentation](https://github.com/omacom/omarchy/blob/quattro/docs/omarchy-shell.md).

Themes may also provide backgrounds, previews, unlock art, `icons.theme`, keyboard RGB, and selected hand-written app overrides. User backgrounds overlay a theme under `~/.config/omarchy/backgrounds/<theme>/`; the selected background is represented by the current-state symlink. Light mode is the `mode = "light"` palette value, with `light.mode` retained for compatibility. The [theme authoring guide](https://github.com/omacom/omarchy/blob/quattro/manual/43-making-your-own-theme.md) documents these inputs.

Omarchy filters code-bearing files from themes installed from third-party git repositories, then regenerates the removed outputs locally from `colors.toml`. This security boundary covers Lua, terminal startup-bearing configs, VS Code extension selection, and symlinks. A locally authored plain theme directory remains trusted. This matters because an Aether snapshot should carry colors and media by default, not arbitrary executable hooks.

## Existing repository fit

### Local findings

Vespasian already has the right coordination seam:

- `.chezmoidata/themes.yaml` is the registry.
- `.chezmoidata/machines.yaml` selects `machines.vespasian.theme.name`.
- `.chezmoitemplates/themes/<name>/` stores Windows Terminal, lazygit, delta, fzf, eza, bat, and Gemini outputs.
- `dots theme` lists and selects registry entries, edits one machine field, and applies chezmoi.
- `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` applies light/dark state and Windows Terminal.
- `run_onchange_after_42-vespasian-theme-state.sh.tmpl` rebuilds bat and updates Claude's ANSI mode.
- `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` derives GlazeWM borders and part of Zebar from the Windows Terminal palette.
- Neovim and the fzf/eza/bat/delta/lazygit templates select the same theme directory.

There are two constraints to fix before dynamic themes feel complete. Neovim is hard-coded to the `folke/tokyonight.nvim` family, and Zebar still embeds several Tokyo Night RGBA constants and the pack name `tokyonight`; changing only the terminal scheme cannot produce a complete new visual system.

Augustus is intentionally different. Omarchy owns its desktop and Neovim theme integration, and `.chezmoiignore.tmpl` excludes the Vespasian-specific palette consumers there. That boundary should remain.

## Architecture choices

| Choice | Advantages | Problems | Verdict |
| --- | --- | --- | --- |
| Run Aether live on both machines and point apps at its output | Little bridge code | Vespasian is WSL plus Windows; Aether standalone does not apply Windows state. Mutable generated state is hard to review, sync, and roll back. | Reject |
| Make chezmoi generate Aether blueprints | One apparent source of truth | Reimplements Aether's evolving private model and turns the authoring tool into a build dependency. | Reject |
| Commit Aether's entire generated theme directory | Quick prototype | Carries redundant, platform-specific, and potentially code-bearing files; updates create noisy diffs. | Avoid |
| Snapshot a stable palette/media contract, then generate platform adapters | Reviewable, reproducible, cross-platform, preserves native authorities | Requires a small importer/generator and schema validation | **Recommend** |

The bridge should be pull-based and explicit. Aether may change the live Augustus theme many times during editing; chezmoi changes only after `dots theme import-aether ...` creates a named snapshot.

## Proposed snapshot contract

Keep `.chezmoidata/themes.yaml` as the catalog, but extend each entry so consumers know its provenance and assets:

```yaml
themes:
  aether-forest-20260913:
    label: "Aether Forest"
    appearance: dark
    format: omarchy-v4
    source:
      kind: aether
      version: "4.29.8"
      blueprint: "Forest"
      blueprintSha256: "..."
      importedAt: "2026-09-13T...Z"
    wallpaper:
      file: "backgrounds/forest.webp"
      sha256: "..."
      fit: fill
    windows:
      accent: "#7cd480"
      colorPrevalence: true
      terminalOpacity: 94
      terminalAcrylic: true
      zebarOpacity: 0.90
      translucentTB: clear
      iconPolicy: preserve
      flowLauncherTheme: preserve
    nvim:
      strategy: aether-palette
```

Store the immutable payload under `.chezmoitemplates/themes/aether-forest-20260913/`:

```text
manifest.yaml                 # schema version, provenance, checksums
blueprint.json                # optional original export, for round-trip/debugging
colors.toml                   # canonical Omarchy v4 palette
backgrounds/forest.webp       # accepted, redistribution-safe image
windows_terminal.json         # generated adapter
zebar.css                     # generated color variables only
lazygit.yml
delta.gitconfig
fzf.sh
eza.yml
bat.tmTheme
gemini.json
nvim.lua                      # generated palette-based LazyVim spec
```

Recommendations:

- Treat `colors.toml`, the accepted wallpaper bytes, and importer version as canonical snapshot inputs.
- Treat every app file as generated output. Put a generated header and input digest in text outputs.
- Preserve `blueprint.json` only for provenance and reopening in Aether. Do not read it directly from chezmoi templates.
- Require every snapshot ID to be immutable. Re-importing a changed blueprint creates a new ID or requires an explicit `--replace` that shows a diff.
- Add `schemaVersion: 1` to `manifest.yaml` and fail closed on unknown versions or missing required colors.

## Import and generation pipeline

Add `dot_local/bin/executable_dots-theme-import-aether` as a focused importer, invoked by a new `dots theme import-aether` subcommand. It should run on Augustus, where Aether and Omarchy are native.

1. Resolve and record `aether --version`; refuse an untested major version unless `--allow-version` is explicit.
2. Ask Aether for an exported blueprint using its documented CLI and copy it to a temporary staging directory.
3. Generate without activation, or read the already accepted `~/.config/omarchy/themes/aether/colors.toml`. Prefer the former for named-blueprint imports so the captured inputs match the named blueprint.
4. Parse and validate the Omarchy v4 semantic palette. Derive ANSI aliases exactly once in the importer, following Omarchy's published compatibility mapping.
5. Resolve wallpaper references to local bytes, validate image type and size, compute SHA-256, and copy into staging. Never leave a Wallhaven URL as the only reproducibility input.
6. Render all Vespasian and CLI adapters from repository-owned templates.
7. Validate JSON/TOML/YAML/XML, ensure no unresolved placeholders remain, compute all digests, and show the proposed registry entry and file diff.
8. Atomically move the snapshot into `.chezmoitemplates/themes/<id>/` and update `.chezmoidata/themes.yaml`. Do not apply, stage, commit, or push unless separately requested.

For implementation, add generator templates under `.chezmoitemplates/aether-adapters/` rather than using Aether custom-app `post-apply.sh`. Aether documents that custom apps are standalone-only on current Omarchy, and executable hooks would also weaken the desired review boundary.

Pin the bridge's supported Aether schema and Omarchy palette schema independently. Aether releases can change blueprint JSON while Omarchy can change `colors.toml`; the importer should produce a clear compatibility error rather than silently dropping keys.

## Exact repository changes

### Phase 1: canonical snapshot and current consumers

- Extend `.chezmoidata/themes.yaml` with `format`, `source`, `wallpaper`, `windows`, and `nvim` fields while retaining the current keys for existing Tokyo Night entries.
- Add `.chezmoitemplates/aether-adapters/` with deterministic templates for the existing seven per-tool outputs plus `zebar.css` and palette-based Neovim.
- Add `dot_local/bin/executable_dots-theme-import-aether`.
- Extend `dot_local/bin/executable_dots` with `theme import-aether`, `theme inspect`, and `theme wallpaper next`; keep `theme set` as the single activation command.
- Add snapshot directories under `.chezmoitemplates/themes/<id>/` only when the user imports a design.
- Change `dot_config/nvim/lua/plugins/theme.lua.tmpl` to include a selected snapshot's `nvim.lua`, while leaving the current Tokyo Night behavior as a backward-compatible branch.
- Change `run_onchange_after_45-vespasian-desktop-tools.sh.tmpl` to read all Zebar colors and alpha values from generated `zebar.css`, replace the fixed pack name with a neutral `dots`, and remove hard-coded Tokyo Night RGBA values.

### Phase 2: wallpaper and Windows shell color

- Add `run_onchange_after_41-vespasian-wallpaper.sh.tmpl` to copy the selected checked asset from the chezmoi source into a dedicated Windows cache such as `%LOCALAPPDATA%\\dots\\themes\\<id>\\`, verify its SHA-256, save the previous wallpaper state, and apply the new desktop wallpaper.
- Extend `run_onchange_after_40-vespasian-windows-terminal.sh.tmpl` to set the configured Windows accent and color-prevalence policy as well as light/dark mode. Use `windows.accent`, defaulting to palette `accent`.
- Extend the Windows Terminal generated scheme to use the canonical ANSI mapping, selection color, cursor color, background, foreground, opacity, and acrylic values.
- Feed GlazeWM focused/unfocused borders from `accent` and `muted`, with explicit overrides in `themes.yaml`.
- Keep wallpaper selection in `.chezmoidata/machines.yaml` as a separate `theme.wallpaper` basename or index so changing a wallpaper within one color theme does not create a duplicate palette.

### Phase 3: optional Windows surfaces

- Add a generated TranslucentTB profile only after confirming the installed release's persisted configuration format on Vespasian. Map the theme to a small repository-owned policy (`clear`, `acrylic`, `opaque`) plus tint/opacity; avoid copying an unversioned live config wholesale.
- Treat Flow Launcher as an optional adapter. If its installed portable version exposes a stable user-theme format, generate a named `Dots <theme>` skin into its documented theme directory and select it with a backed-up, surgical settings edit. Until that format is verified, set `flowLauncherTheme: preserve` and let Windows light/dark mode provide the safe partial match.
- Map `icons.theme` semantically rather than literally. On Augustus keep Aether/Omarchy's Yaru result. On Windows use `iconPolicy: preserve` initially; later permit an allowlisted installed icon/cursor package ID. Never download or execute an icon pack from a blueprint.

## Windows mapping

| Canonical input | Vespasian surface | Recommended mapping |
| --- | --- | --- |
| `mode` | Windows apps/system | light -> `AppsUseLightTheme=1`, `SystemUsesLightTheme=1`; dark -> `0` |
| `accent` | Windows shell and GlazeWM | convert `#RRGGBB` to the Windows color representation in one tested helper; set configured color-prevalence flags |
| `background`, `foreground`, ANSI roles | Windows Terminal | generated scheme plus profile/default selection |
| `selection`, `bright_foreground` | Windows Terminal | selection background and cursor color |
| neutral ramp, accents | Zebar | CSS custom properties; derive translucent variants during generation |
| `accent`, `muted` | GlazeWM | focused and unfocused borders |
| wallpaper bytes + fit | Windows desktop | checked local cache, deterministic fit, previous-state backup |
| transparency policy | TranslucentTB | allowlisted mode, tint, and opacity when its exact config is validated |
| mode/accent | Flow Launcher | generated local skin if supported; otherwise preserve |
| `icons.theme` / `.yaru` | Windows icons | no automatic equivalence; explicit allowlist only |

Keep Windows writes together behind a reusable PowerShell helper that supports `capture`, `apply`, and `restore`. The current theme scripts restart Explorer for mode changes; the helper should restart it once after all shell settings change and only when necessary.

## Augustus and Omarchy compatibility

On Augustus, `dots theme set <aether-snapshot>` should not render over `~/.local/state/omarchy/current/theme`. It should call Omarchy's public interface against a managed user theme and let Omarchy perform templates, background selection, shell notification, application reloads, hooks, and serialization.

There are two reasonable ways to materialize the snapshot on Augustus:

1. Let Aether's live `aether` theme remain the editable working theme, while the importer also installs each accepted snapshot as a named plain directory under `~/.config/omarchy/themes/<snapshot-id>/` containing only `colors.toml`, backgrounds, preview, and an optional allowlisted `icons.theme`.
2. Keep only the live `aether` theme and have `dots theme set` reapply a named Aether blueprint.

Choose option 1. Named immutable themes match Vespasian's registry identity, work without Aether running, participate in Omarchy's normal selector, and avoid mutating a saved blueprint during activation. The installer must refuse to overwrite an unmanaged existing directory and should use a marker such as `.dots-aether-snapshot` with its manifest digest.

The installed `esemczak/omarchy-theme-modes` plugin is outside the official-source scope of this report. Treat its mode changes as runtime overlays owned by Omarchy. The bridge should capture the resolved accepted palette only when the user imports, and should not watch or automatically commit mode transitions. Test the plugin's `theme-set` hook interaction during implementation, particularly whether it immediately reapplies an overlay after a new named snapshot activates.

## Security, licensing, updates, and reproducibility

- Accept palette data, images, and a small allowlist of declarative theme files. Reject symlinks, devices, scripts, Lua, terminal startup commands, VS Code extension selectors, and executable hooks from imported packages. This mirrors Omarchy's own distinction between color and code.
- Validate snapshot names with a strict slug and use staging plus atomic rename. Aether currently limits Omarchy theme names to a safe ASCII pattern; follow at least that restriction.
- Limit downloaded document and image sizes, verify actual image decoding, require HTTPS for remote imports, and record final content hashes. Aether's own import/download code applies size and image validation; the bridge should preserve that posture.
- Never store the Wallhaven API key. It belongs in Aether's private config. Record a source URL only as optional attribution; the checked image bytes and digest provide reproducibility.
- Wallpaper availability through Aether does not grant redistribution rights. Before committing an image, record its source and license or mark the snapshot `wallpaperDistribution: private`. A private snapshot can reference a local encrypted/external asset rather than push the image publicly.
- Pin the importer against a tested Aether release and record both Aether and bridge versions. Update deliberately: import into staging, run fixtures, review schema differences, then advance the pin.
- Aether's README and AUR workflow label the project MIT, but the inspected revision has no top-level `LICENSE` file. Do not vendor Aether source or templates on the README statement alone; retain links and generate original adapters. Confirm licensing with upstream before copying substantial Aether template text.
- Keep generated artifacts reproducible by sorting maps/files, normalizing lowercase hex, using stable newlines, stripping timestamps from generated app files, and putting timestamps only in the manifest.

## Validation gates

An implementation is ready when all of the following pass:

1. Importer fixture tests cover a dark and light blueprint, explicit extended colors, missing optional colors, additional wallpapers, duplicate basenames, invalid names, oversized input, symlinks, and an unknown schema.
2. A clean re-import of the same inputs produces byte-identical outputs except for explicitly non-reproducible manifest fields.
3. Every generated JSON, YAML, TOML, XML/tmTheme, Lua, CSS, and shell file parses or passes its relevant static check; no `{...}` or `{{ ... }}` placeholder remains.
4. Palette validation checks normalized hex, required roles, light/dark neutral-ramp direction, and readable foreground/background and selection contrast.
5. `chezmoi execute-template` succeeds for Augustus, Vespasian, and Hadrian. Bash scripts pass `bash -n` and ShellCheck.
6. A Vespasian dry run reports the exact registry values, Windows Terminal paths, wallpaper source/destination/hash, Explorer restart decision, and processes to reload.
7. A live Vespasian test confirms Windows mode/accent, wallpaper and fit, Terminal ANSI/selection/cursor, GlazeWM borders, Zebar colors, bat cache, lazygit/delta/fzf/eza, Claude ANSI mode, and Neovim.
8. An Augustus test confirms the named snapshot appears in Omarchy, `omarchy theme set` owns activation, backgrounds cycle normally, shell and app reloads occur, and theme-mode hooks do not cause a loop.
9. Hadrian renders unchanged unless a later macOS adapter is explicitly added.

## Rollback

Before Windows activation, capture the previous theme selection, registry values touched by the adapter, wallpaper path/style, Windows Terminal scheme/profile fields, and optional app theme settings into `%LOCALAPPDATA%\\dots\\theme-state\\previous.json`. Apply from staged files and restore that document if any required step fails.

Expose:

```text
dots theme current
dots theme inspect <name>
dots theme set <name> --dry-run
dots theme rollback
```

On Augustus, rollback is `omarchy theme set <previous-name>` plus the previous background path; Aether already follows this principle internally. In chezmoi, rollback is selecting the previous immutable registry entry. Snapshot deletion should be a separate command that refuses to delete the active theme on any machine.

## Phased delivery

1. **Snapshot bridge:** importer, schema, provenance, canonical palette, deterministic generation, existing CLI-tool adapters, and palette-based Neovim.
2. **Complete Vespasian desktop:** wallpaper, Windows accent, Windows Terminal improvements, GlazeWM, and fully generated Zebar CSS.
3. **Augustus named snapshots:** safe materialization under Omarchy user themes and native activation/rollback.
4. **Optional polish:** validated TranslucentTB profile, Flow Launcher skin, cursor/icon allowlist, wallpaper cycling, previews, and time-of-day automation.

This order provides a useful result after phase 1, makes Windows visually coherent in phase 2, and keeps the riskiest application-specific state edits out of the foundation.

## Open questions

- Should Aether snapshots and wallpapers be public in this repository, encrypted/private, or stored in a separate asset repository?
- Should a changed Aether blueprint always create a timestamped snapshot, or may a stable alias such as `aether-forest` advance to a new immutable revision?
- Which wallpaper fit should be the default on Vespasian, and is per-monitor wallpaper required?
- Should the Windows accent appear on Start/taskbar/title bars, or only in managed tools such as GlazeWM and Zebar?
- Is a Flow Launcher theme worth maintaining, given that preserving its theme plus following Windows light/dark already covers basic integration?
- Should TranslucentTB behavior vary by theme or remain a machine-level preference?
- Should Augustus install every imported snapshot into Omarchy automatically, or only the currently selected one?
- Does the installed theme-modes plugin reapply state on `theme-set`, and should an imported light/dark pair be represented as two immutable snapshots or one logical family?
- Should `dots theme` show wallpaper previews and Aether source metadata, or remain a fast text/fzf picker?

## Primary sources

- [Aether README](https://github.com/omacom/aether/blob/main/README.md)
- [Aether CLI reference](https://github.com/omacom/aether/blob/main/docs/cli.md)
- [Aether blueprint format](https://github.com/omacom/aether/blob/main/docs/blueprints.md)
- [Aether filesystem and Omarchy ownership](https://github.com/omacom/aether/blob/main/docs/filesystem.md)
- [Aether custom apps and variables](https://github.com/omacom/aether/blob/main/docs/custom-apps.md)
- [Aether standalone integration](https://github.com/omacom/aether/blob/main/docs/standalone.md)
- [Aether Omarchy integration source](https://github.com/omacom/aether/blob/main/internal/omarchy/native.go)
- [Aether theme writer](https://github.com/omacom/aether/blob/main/internal/theme/writer.go)
- [Omarchy theming architecture](https://github.com/omacom/omarchy/blob/quattro/docs/theming.md)
- [Omarchy theme authoring guide](https://github.com/omacom/omarchy/blob/quattro/manual/43-making-your-own-theme.md)
- [Omarchy theme activation](https://github.com/omacom/omarchy/blob/quattro/bin/omarchy-theme-set)
- [Omarchy color resolver](https://github.com/omacom/omarchy/blob/quattro/bin/omarchy-theme-color)
- [Omarchy generated app templates](https://github.com/omacom/omarchy/tree/quattro/default/themed)
- [Omarchy shell theming](https://github.com/omacom/omarchy/blob/quattro/docs/omarchy-shell.md)
