-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Layout (logical 2048x1152 each): DP-3 bottom left, DP-2 bottom right, DP-1 top left (upside down)
hl.monitor({ output = "DP-3", mode = "preferred", position = "0x1152", scale = 1.25 })
hl.monitor({ output = "DP-2", mode = "preferred", position = "2048x1152", scale = 1.875 })
hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1.25, transform = 2 })

-- Workspace assignments: 1 = LG (DP-3), 2 = 32" Lenovo (DP-2), 3 = 27" Acer (DP-1).
-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
hl.workspace_rule({ workspace = "1", monitor = "DP-3", persistent = true, default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", persistent = true, default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true, default = true })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
