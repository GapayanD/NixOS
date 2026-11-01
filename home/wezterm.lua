local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ============================================================
-- Frosted glass
-- ============================================================
-- WezTerm only has native compositor blur on macOS/Windows. On
-- Linux (X11 or Wayland) it just punches a transparent hole —
-- the actual blur has to come from your compositor, same as
-- you're already doing with Ghostty + Hyprland window rules.
config.window_background_opacity = 0.82
config.text_background_opacity = 1.0

-- macOS: native blur radius (no-op on Linux/Windows)
config.macos_window_background_blur = 20

-- Windows 11: Acrylic backdrop (no-op elsewhere)
config.win32_system_backdrop = "Acrylic"

-- MangoWC: WezTerm's Wayland app_id is org.wezfurlong.wezterm.
-- In ~/.config/mango/config.conf, turn blur on globally (it's off
-- by default) and scope the actual transparency to WezTerm only,
-- rather than setting focused_opacity/unfocused_opacity globally:
--
--   blur=1
--   blur_optimized=1
--   blur_params_radius=5
--   blur_params_num_passes=2
--
--   windowrule=focused_opacity:0.85,unfocused_opacity:0.72,appid:org.wezfurlong.wezterm
--
-- blur=1 makes mango blur behind any window whose opacity < 1;
-- noblur:1 in a windowrule opts a specific window back out.

-- ============================================================
-- Color scheme
-- ============================================================
-- You've rotated through Rose Pine, Gruvbox and Tokyo Night on
-- fastfetch — Rose Pine (Moon) reads well with transparency since
-- it isn't pure black/white. Swap the string for any of:
--   "Gruvbox Dark (Gogh)", "Tokyo Night", "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"

-- ============================================================
-- Font
-- ============================================================
config.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Symbols Nerd Font Mono",
})
config.font_size = 11.5
config.line_height = 1.05
config.freetype_load_target = "Light"

-- ============================================================
-- Window / tab bar
-- ============================================================
config.window_decorations = "RESIZE" -- no OS titlebar, keep resize border
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.window_padding = {
	left = 14,
	right = 14,
	top = 10,
	bottom = 10,
}
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false

-- Keep the tab bar itself from painting an opaque bar over the glass
config.colors = {
	tab_bar = {
		background = "rgba(0, 0, 0, 0.0)",
	},
}

-- ============================================================
-- Cursor / misc
-- ============================================================
config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 0
config.scrollback_lines = 10000
config.audible_bell = "Disabled"

-- ============================================================
-- Keys (minimal, tmux-free multiplexing via WezTerm panes)
-- ============================================================
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "\\", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "-",  mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h",  mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "l",  mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "k",  mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j",  mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "x",  mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
}

return config
