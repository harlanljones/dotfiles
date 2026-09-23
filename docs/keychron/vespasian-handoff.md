# Keychron Q3 HE 8K: Vespasian handoff

## Goal
Finish the knob-press audio switch on Vespasian (Windows host with Ubuntu WSL). The Keychron knob sends **F13** on all four keymap layers. F13 should toggle only between the USB headphones and the LG monitor output connected to speakers, moving active audio streams as well as changing the default output.

## Already completed

- In Keychron Launcher, HE Profile 1 is **Prod-Dev**, active by default, with rapid trigger off. HE Profile 2 is the gaming profile with rapid trigger on.
- Windows/Linux base keymap layer 2 has normal Q/E/R/T. Gaming layer 1 has **R=M0** and **T=M1**; M0/M1 are the existing left/right peek macros.
- Fn layer 3 maps **F7–F12** to Previous, Play, Next, Mute, Volume Down, Volume Up. **Fn+G** selects gaming base layer 1, **Fn+H** selects productivity base layer 2. The HE profile is a separate switch: **Fn+P+X** for Profile 2, **Fn+P+Z** for Profile 1.
- Knob press is mapped to **F13** on keymap layers 0, 1, 2, and 3.
- Augustus (Omarchy, hostname `omarchy`) has a working F13 Hyprland binding to `~/.local/bin/keychron-audio-toggle`. It toggles exact PipeWire sinks `alsa_output.usb-TTGK_Technology_Co._Ltd_KM-HIFI-384KHZ-00.analog-stereo` and `alsa_output.pci-0000_01_00.1.playback.3.0` (LG ULTRAGEAR DP-1). The script was tested in both directions; original default restored.
- Augustus managed source: `~/.local/share/chezmoi/dot_config/hypr/bindings.lua` and `dot_local/bin/executable_keychron-audio-toggle`. `INDEX.json`, `INDEX.md`, and `README.md` regenerated. There is other unrelated existing repo drift, so **do not run `dots push` blindly**.

## Work to do on Vespasian

1. Use the `dots` skill and read `~/.local/share/chezmoi/AGENTS.md` before modifying settings. Vespasian's Windows desktop setup lives in `~/.local/share/chezmoi/run_onchange_after_45-vespasian-desktop-tools.sh.tmpl`. This hook installs/configures AutoHotkey v2 and writes `super-mask.ahk` to `%LOCALAPPDATA%\Programs\glazewm\`; the logon launcher starts it. Vespasian has no Hyprland session.
2. First sync the dots repository from Augustus if the changes above are not present. Avoid overwriting uncommitted changes on either machine. The Augustus work is currently uncommitted; coordinate a targeted commit/transfer if necessary.
3. On Windows, enumerate playback endpoints and record their exact names and stable IDs. Identify the USB headphones and the LG monitor. Do not assume the Linux PipeWire sink names match Windows device names.
4. Implement a Windows-side F13 hotkey, preferably in the managed AutoHotkey v2 script (or a dedicated managed AHK script started by the existing launcher). Its handler should switch the default Windows playback endpoint between that exact pair, and if needed move existing application audio sessions. Use a reliable Core Audio API or an installed, pinned utility; verify behavior on the machine before choosing device selectors. Avoid toggling to unrelated monitors.
5. Apply through `dots`/chezmoi. Because hook 45 is `run_onchange`, inspect its whole rendered diff before reapplying: a change reruns desktop-tool setup. Preserve unrelated local drift. Confirm AHK starts/reloads, F13 is received from the knob on both Keychron profiles, and each press switches to the other output. Also verify Fn+F7–F12 media controls on Vespasian.
6. Run the repository's required `chezmoi apply --dry-run` and generated-index checks after source edits. Regenerate `INDEX.*` and README tree if files are added. Report exact success or any device/hotkey limitation.

## Important constraint

The Keychron HE profile and QMK keymap layer switch independently. Gaming requires Profile 2 plus Fn+G; returning to productivity requires Profile 1 plus Fn+H. The keyboard-side configuration was set in Launcher and persists in the keyboard, but actual hardware Fn/media behavior should be tested directly on Vespasian.
