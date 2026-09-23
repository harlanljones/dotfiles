-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Dismiss all live notifications and clear history (mirrors the bar widget's right-click).
o.bind("SUPER + ALT + N", "Clear notifications", "omarchy-shell notifications dismissAll && omarchy-shell notifications clear")

-- Theme modes: panel, automatic/manual switching, and manual light/dark toggle.
o.bind("SUPER + CTRL + ALT + L", "Theme modes", "omarchy-shell shell toggle esemczak.theme-modes")
o.bind("SUPER + ALT + SHIFT + L", "Theme modes: automatic/manual", [=[bash -lc 'status=$(omarchy-shell esemczak.theme-modes status) || exit; if jq -e ".manualOverride" >/dev/null <<<"$status"; then omarchy-shell esemczak.theme-modes followAutomatic; else omarchy-shell esemczak.theme-modes toggleMode; fi']=])
o.bind("SUPER + CTRL + ALT + SHIFT + L", "Theme modes: toggle light/dark", [=[bash -lc 'status=$(omarchy-shell esemczak.theme-modes status) || exit; if jq -e ".manualOverride" >/dev/null <<<"$status"; then omarchy-shell esemczak.theme-modes toggleMode; else notify-send --app-name="Theme modes" "Manual mode required" "Switch to manual mode before toggling light and dark."; fi']=])
o.bind("SUPER + CTRL + ALT + P", "Theme modes: next profile", "omarchy-shell esemczak.theme-modes nextProfile")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- X Native Client toggle override
-- Drop the Omarchy default (SUPER+SHIFT+X opened the x.com webapp) so the
-- native client owns the binding.
hl.unbind("SUPER + SHIFT + X")
o.bind("SUPER + SHIFT + X", "X Native", "qml-runtime " .. (os.getenv("HOME") or "") .. "/.config/omarchy/plugins/community.omarchy-x-native-bundle/native-app/main.qml --toggle")

-- Alt+Tab window switcher: omalt-tab (Omarchy Quickshell plugin) owns these
-- bindings. Its hypr/bindings.lua defines an "omalt-tab" submap (Tab cycle,
-- home-row workspace jump, Enter commit, Esc cancel) and unbinds the plain
-- Alt+Tab defaults itself. Load it when installed; otherwise the Omarchy
-- defaults (tiling.lua cycle_next/bring_to_top) stay in effect. The order
-- matters: omalt-tab's binds must register AFTER the Omarchy defaults it
-- overrides, and hypr/bindings.lua loads after default.hypr.omarchy.
hl.unbind("ALT + TAB")
hl.unbind("ALT + SHIFT + TAB")
do
  local omalt = os.getenv("HOME") .. "/.config/omarchy/plugins/io.github.codesmith28.omalt-tab/hypr/bindings.lua"
  local f = io.open(omalt, "r")
  if f then
    f:close()
    dofile(omalt)
  end
end

require("default.hypr.require_optional").module("hypr.omachord") -- Oma Chord managed loader

-- BEGIN tech.greyforge.reprieve
-- Managed by Reprieve (reprieve setup / reprieve remove-binds). Do not hand-edit.
hl.unbind("SUPER + W")
o.bind("SUPER + W", "Park window (Reprieve)", [=[/home/harlan/.config/omarchy/plugins/tech.greyforge.reprieve/bin/reprieve]=] .. " park")
o.bind("SUPER + ALT + W", "Close window permanently", [=[/home/harlan/.config/omarchy/plugins/tech.greyforge.reprieve/bin/reprieve]=] .. " close")
o.bind("SUPER + Z", "Restore parked window", hl.dsp.global("tech.greyforge.reprieve:undo"))
o.bind("SUPER + Y", "Redo park", hl.dsp.global("tech.greyforge.reprieve:redo"))
o.bind("SUPER + SHIFT + Z", "Reprieve timeline", hl.dsp.global("tech.greyforge.reprieve:timeline"))
hl.window_rule({ match = { workspace = "special:reprieve" }, no_anim = true })
hl.layer_rule({ match = { namespace = "reprieve" }, no_anim = true, animation = "none" })
hl.layer_rule({ match = { namespace = "reprieve-toast" }, no_anim = true, animation = "none" })
-- END tech.greyforge.reprieve

-- omaplug-shortcut-start: bobbynicholas.omaland
o.bind("SUPER + SHIFT + L", "Omaplug: bobbynicholas.omaland", "omarchy-shell shell toggle bobbynicholas.omaland")
-- omaplug-shortcut-end: bobbynicholas.omaland

-- Keychron knob: switch between the USB headphones and LG monitor speakers.
o.bind("F13", "Switch headphones and speakers", "keychron-audio-toggle --headphones alsa_output.usb-TTGK_Technology_Co._Ltd_KM-HIFI-384KHZ-00.analog-stereo --monitor alsa_output.pci-0000_01_00.1.playback.3.0", { locked = true })
