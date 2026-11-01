-- Hyprland Lua entry point. Keep this file small and put settings in conf/.
local configDir = os.getenv("HOME") .. "/.config/hypr/conf"

-- Load each file separately so one broken file cannot stop the rest from
-- loading (a plain dofile error aborts everything after it, which used to
-- leave you with no keybinds at all). Keybinds load first on purpose.
local errors = {}

local function load(name)
  local ok, err = pcall(dofile, configDir .. "/" .. name .. ".lua")
  if not ok then
    errors[#errors + 1] = name .. ".lua: " .. tostring(err)
  end
end

load("keybinds")
load("appearance")
load("workspaces")
load("window-rules")
load("plugins")

-- Re-raise after everything has loaded so Hyprland still shows its error bar
-- and `hyprctl configerrors` lists what is wrong.
if #errors > 0 then
  error(table.concat(errors, "\n"), 0)
end
