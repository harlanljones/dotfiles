-- Quiet-ops snacks.nvim dashboard (Phase 7.12 Task 2).
--
-- Header comes from ~/.local/bin/dots-identity (the dots repo's machine-identity
-- generator: FIGlet/mini-font wordmark + role line + stat chips). Output
-- contract is FROZEN — we only consume it here.
--
-- ANSI handling: dots-identity colorizes for TTYs only. We run it with
-- NO_COLOR=1 so the header text arrives clean, and strip any stray escape
-- sequences defensively. The rendered header then inherits nvim's
-- `SnacksDashboardHeader` highlight group, so it always matches the active
-- colorscheme — no ANSI passthrough, no hardcoded colors.
--
-- Quiet ops: wordmark only (no ASCII art), no key-menu section, just recent
-- files, projects and a drift footer.

local IDENTITY_BIN = vim.fn.expand("~/.local/bin/dots-identity")

--- Strip ANSI escape sequences (CSI/SGR) from a string.
---@param s string
---@return string
local function strip_ansi(s)
  return (s:gsub("\27%[[0-9;?]*[a-zA-Z]", ""):gsub("\r", ""))
end

--- Shell out with a timeout, returning nil on any failure.
---@param cmd string[]
---@param timeout_s? number
---@return string? output
local function sys(cmd, timeout_s)
  local out = vim.fn.system(vim.list_extend({ "timeout", tostring(timeout_s or 2) }, cmd))
  if vim.v.shell_error ~= 0 then
    return nil
  end
  return out
end

--- Render the machine-identity wordmark.
--- Falls back to the plain machine displayName when dots-identity is missing.
---@return string
local function identity_header()
  if vim.fn.executable(IDENTITY_BIN) == 1 then
    local out = sys({ "env", "NO_COLOR=1", IDENTITY_BIN })
    if out and #vim.trim(out) > 0 then
      return vim.trim(strip_ansi(out))
    end
  end
  -- Fallback: machine displayName via chezmoi, else hostname.
  local name = sys({
    "chezmoi",
    "execute-template",
    "{{ $m := index .machines .machine }}{{ $m.displayName }}",
  }) or vim.fn.hostname()
  return vim.trim(name or "nvim")
end

--- Count dots drift via `dots status`; nil when the command fails or stalls.
--- The 1s timeout mirrors the dots-identity contract: never block startup.
---@return string? footer
local function drift_footer()
  local out = sys({ "dots", "status" }, 1)
  if not out then
    return nil
  end
  local n = 0
  for line in out:gmatch("[^\n]+") do
    -- chezmoi state codes ("MM path") and human-labeled drift lines
    if line:match("^%s*[MADRU?]+%s") or line:match("^%s*[Mm]odified:") or line:match("^%s*[Aa]dded:")
      or line:match("^%s*[Rr]emoved:") or line:match("^%s*[Dd]eleted:") or line:match("^%s*[Rr]enamed:") then
      n = n + 1
    end
  end
  if n == 0 then
    return "dots: clean"
  end
  return ("dots: %d file%s drifted"):format(n, n == 1 and "" or "s")
end

--- Discover local git repos as selectable projects. Roots are scanned once
--- per dashboard open: ~/dev/* (repo dirs) plus the dots repo. Deterministic
--- and personal — replaces snacks' `projects` section, which depends on
--- shada oldfiles and rendered empty/broken here.
---@return { [1]: string, [2]: string }[]
local function discover_projects()
  local projects = {}
  local seen = {}
  local roots = { vim.fn.expand("~/dev"), vim.fn.expand("~/src") }
  for _, root in ipairs(roots) do
    if vim.fn.isdirectory(root) ~= 1 then goto continue end
    local dirs = vim.fn.readdir(root) or {}
    for _, name in ipairs(dirs) do
      local dir = root .. "/" .. name
      if vim.fn.isdirectory(dir .. "/.git") == 1 and not seen[dir] then
        seen[dir] = true
        projects[#projects + 1] = { name, dir }
      end
    end
    ::continue::
  end
  local dots = vim.fn.expand("~/.local/share/chezmoi")
  if vim.fn.isdirectory(dots) == 1 and not seen[dots] then
    projects[#projects + 1] = { "dots", dots }
  end
  -- Most-recently-active first (activity = .git/HEAD mtime), capped at 8 so
  -- the selector stays a quick-pick, not a wall of 80+ repos.
  table.sort(projects, function(a, b)
    local ma = vim.fn.getftime(a[2] .. "/.git/HEAD") or 0
    local mb = vim.fn.getftime(b[2] .. "/.git/HEAD") or 0
    return ma > mb
  end)
  local cap = {}
  for i, p in ipairs(projects) do
    if i > 8 then break end
    cap[#cap + 1] = p
  end
  return cap
end

--- Build the Projects dashboard section: selecting a project chdirs into it
--- and re-renders the dashboard, so the identity header picks up that
--- project's context (dots-identity runs in the new cwd).
local function projects_section()
  local projects = discover_projects()
  if #projects == 0 then
    return nil
  end
  local items = {}
  for i, proj in ipairs(projects) do
    items[#items + 1] = {
      key = tostring(i),
      label = proj[1],
      desc = proj[2],
      action = function()
        vim.fn.chdir(proj[2])
        Snacks.dashboard.open()
      end,
    }
  end
  -- Snacks requires `section` to be a built-in string name; custom entries
  -- are child items in the array part (item[1]), resolved recursively.
  return {
    icon = " ",
    title = "Projects",
    indent = 2,
    padding = 1,
    items,
  }
end

return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          -- Custom Gen section: wordmark from dots-identity, centered.
          function()
            return { header = identity_header(), padding = 2 }
          end,
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
          },
          -- Curated Projects selector (custom, deterministic): chdir + re-render.
          projects_section,
          { section = "startup", padding = 1 },
          -- Dots drift footer; silently omitted on failure/timeout.
          function()
            local footer = drift_footer()
            return footer and { footer = footer, indent = 2 } or nil
          end,
        },
      },
    },
  },
}
