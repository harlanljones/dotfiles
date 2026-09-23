# Keychron Q3 HE 8K configuration

`q3-he-8k-keymap-2026-09-22.json` is the Keychron Launcher 1.5.0 **Keymap > Export** backup from Augustus. It contains all four keymap layers and the knob rotation mapping. Restore it through Launcher **Keymap > Import**.

The export does **not** contain Hall-effect profiles or macro definitions. These settings are stored on the keyboard and must be checked or recreated separately in Launcher:

- HE Profile 1: `Prod-Dev`, active default, rapid trigger off.
- HE Profile 2: gaming, rapid trigger on. Switch with Fn+P+X; return to Profile 1 with Fn+P+Z.
- Gaming base keymap layer 1: R=M0 and T=M1, where M0/M1 are existing left/right peek macros. Fn+G selects layer 1; Fn+H selects productivity base layer 2. HE profile and keymap layer switch independently.
- Productivity base keymap layer 2: Q/E/R/T type normally. Fn layer 3 has F7-F12 mapped to Previous, Play, Next, Mute, Volume Down, Volume Up.
- Knob press: F13 on keymap layers 0, 1, 2, and 3. On Augustus this triggers a Hyprland binding to `keychron-audio-toggle`; Vespasian needs the Windows-side binding described in `vespasian-handoff.md`.

Test Fn+F7-F12 and actual knob presses on both machines. The Keymap export alone is not a full device backup.
