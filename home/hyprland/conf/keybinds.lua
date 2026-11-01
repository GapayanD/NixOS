-- Core application and window-management shortcuts.
-- Hyprland's Lua config uses hl.dsp.* dispatchers directly. The old
-- "hyprctl dispatch killactive" style commands do not work in Lua mode.
local mod = "SUPER"
local ipc = "noctalia msg "

hl.bind(mod .. " + Return", hl.dsp.exec_cmd("wezterm"))
hl.bind(mod .. " + B", hl.dsp.exec_cmd("brave"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("krusader"))

hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle"
}))
hl.bind(mod .. " + V", hl.dsp.window.float({
    action = "toggle"
}))
hl.bind(mod .. " + M", hl.dsp.exit())

-- Focus movement (works in every layout, including scrolling).
hl.bind(mod .. " + H", hl.dsp.focus({
    direction = "left"
}))
hl.bind(mod .. " + J", hl.dsp.focus({
    direction = "down"
}))
hl.bind(mod .. " + K", hl.dsp.focus({
    direction = "up"
}))
hl.bind(mod .. " + L", hl.dsp.focus({
    direction = "right"
}))

-- Move the focused window in a direction (swaps in dwindle, moves between
-- columns in scrolling, snaps to the screen edge when floating).
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Workspaces 1-10: Super+number switches; Super+Alt+number moves the window.
-- Key 0 maps to workspace 10 (there is no single key named "10").
for i = 1, 10 do
    local key = i % 10
    hl.bind(mod .. " + " .. key, hl.dsp.focus({
        workspace = i
    }))
    hl.bind(mod .. " + ALT + " .. key, hl.dsp.window.move({
        workspace = i
    }))
end

-- Previous / next workspace: keys and Super + mouse wheel.
hl.bind(mod .. " + CTRL + H", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + CTRL + L", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Scratchpad (special workspace): Super+` toggles it, Super+Alt+` sends the
-- focused window to it.
hl.bind(mod .. " + grave", hl.dsp.workspace.toggle_special("scratch"))
hl.bind(mod .. " + ALT + grave", hl.dsp.window.move({ workspace = "special:scratch" }))

-- Mouse: hold Super, then left-drag to move a window and right-drag to resize
-- it. Floating windows move/resize freely; tiled windows are dragged out into
-- floating (move) or have their split resized (resize).
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Keyboard move/resize mode: Super+R enters it, Escape or Enter leaves it.
--   h/j/k/l or arrows        -> resize the window (hold to repeat)
--   Shift + h/j/k/l or arrows -> move the window (floating windows)
-- Tiled windows in the scrolling layout resize by column instead; see the
-- Super+[ and Super+] binds below.
local step = 40
local function resize(x, y)
    return hl.dsp.window.resize({ x = x, y = y, relative = true })
end
local function nudge(x, y)
    return hl.dsp.window.move({ x = x, y = y, relative = true })
end

hl.bind(mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("H", resize(-step, 0), { repeating = true })
    hl.bind("J", resize(0, step), { repeating = true })
    hl.bind("K", resize(0, -step), { repeating = true })
    hl.bind("L", resize(step, 0), { repeating = true })
    hl.bind("left", resize(-step, 0), { repeating = true })
    hl.bind("down", resize(0, step), { repeating = true })
    hl.bind("up", resize(0, -step), { repeating = true })
    hl.bind("right", resize(step, 0), { repeating = true })

    hl.bind("SHIFT + H", nudge(-step, 0), { repeating = true })
    hl.bind("SHIFT + J", nudge(0, step), { repeating = true })
    hl.bind("SHIFT + K", nudge(0, -step), { repeating = true })
    hl.bind("SHIFT + L", nudge(step, 0), { repeating = true })
    hl.bind("SHIFT + left", nudge(-step, 0), { repeating = true })
    hl.bind("SHIFT + down", nudge(0, step), { repeating = true })
    hl.bind("SHIFT + up", nudge(0, -step), { repeating = true })
    hl.bind("SHIFT + right", nudge(step, 0), { repeating = true })

    hl.bind("Escape", hl.dsp.submap("reset"))
    hl.bind("Return", hl.dsp.submap("reset"))
end)

-- Center the focused floating window.
hl.bind(mod .. " + SHIFT + C", hl.dsp.window.center())

-- Hyprspace workspace overview (plugin loaded in conf/plugins.lua). Must be
-- wrapped in a function so it resolves after the plugin has been loaded.
hl.bind(mod .. " + Tab", function()
    hl.plugin.overview.toggle()
end, { description = "Toggle Hyprspace overview" })

-- Layout: Super+T flips the current workspace between scrolling and dwindle.
hl.bind(mod .. " + T", function()
    local ws = hl.get_active_workspace()
    if not ws then
        return
    end
    local next_layout = (ws.tiled_layout == "scrolling") and "dwindle" or "scrolling"
    hl.workspace_rule({ workspace = tostring(ws.id), layout = next_layout })
end, { description = "Toggle scrolling/dwindle on this workspace" })

-- Scrolling layout controls (ignored on dwindle workspaces).
--   Super+[ / Super+]              narrower / wider column (cycles widths)
--   Super+Shift+, / Super+Shift+.  swap column left / right  (< and >)
--   Super+P                        pop the window into its own column
--   Super+Shift+[ / Super+Shift+]  consume into / expel from the neighbor column
hl.bind(mod .. " + bracketleft", hl.dsp.layout("colresize -conf"))
hl.bind(mod .. " + bracketright", hl.dsp.layout("colresize +conf"))
hl.bind(mod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mod .. " + P", hl.dsp.layout("promote"))
hl.bind(mod .. " + SHIFT + bracketleft", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mod .. " + SHIFT + bracketright", hl.dsp.layout("consume_or_expel next"))

-- Noctalia v5+ IPC. These commands are the documented `noctalia msg` form.
hl.bind(mod .. " + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mod .. " + comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))
hl.bind("ALT + Tab", hl.dsp.exec_cmd(ipc .. "window-switcher hold"))
hl.bind(mod .. " + Print", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
hl.bind("Print", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mod .. " + C", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))


-- Media and brightness keys. "locked" keeps them working on the lock screen,
-- "repeating" lets you hold the key to keep changing the level.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), {
    locked = true,
    repeating = true
})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), {
    locked = true,
    repeating = true
})
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), {
    locked = true
})
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), {
    locked = true,
    repeating = true
})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), {
    locked = true,
    repeating = true
})
