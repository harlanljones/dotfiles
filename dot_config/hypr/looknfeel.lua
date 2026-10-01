-- Change the default Omarchy look'n'feel.

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
  general = {
    -- gaps between windows or borders.
    gaps_in = 2,
    gaps_out = 5,
    border_size = 2,
    --
    --     -- Change to niri-like side-scrolling layout.
    --     layout = "scrolling",
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
  decoration = {
    --     -- Use round window corners.
    rounding = 8,
    --
    -- Dim unfocused windows (0.0 = no dim, 1.0 = fully dimmed).
    -- dim_inactive = true,
    -- dim_strength = 0.10,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
-- hl.config({
--   animations = {
--     -- Disable all animations.
--     enabled = false,
--   },
-- })

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })

-- >>> omaland managed block >>>
-- Written by Omaland. Safe to hand-edit: Omaland re-reads this block
-- every time it opens, and only ever rewrites what's between the fences.
hl.config({
  animations = {
    workspace_wraparound = true,
  },

  decoration = {
    active_opacity = 0.9,
    inactive_opacity = 0.7,
    rounding = 0,

    blur = {
      brightness = 1.5,
      contrast = 1,
      enabled = true,
      passes = 3,
      vibrancy = 0,
      vibrancy_darkness = 0,
    },

    shadow = {
      enabled = false,
      range = 6,
    },
  },

  general = {
    border_size = 2,
    gaps_out = 4,
  },
})

hl.animation({ leaf = "global", enabled = true, speed = 4.55, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 2.45, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 1.72, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.86, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.68, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.66, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 1.38, bezier = "quick" })
hl.animation({ leaf = "fadeSwitch", enabled = false })
hl.animation({ leaf = "layers", enabled = true, speed = 1.73, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 1.82, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 0.68, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 0.81, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 0.63, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = false })
-- <<< omaland managed block <<<
