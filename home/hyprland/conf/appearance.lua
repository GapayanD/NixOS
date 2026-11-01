-- General look and behavior. Edit this file for gaps, rounding, blur, etc.
hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    -- "scrolling" is the default tiling layout now. Switch a single workspace
    -- with Super+T, or set this back to "dwindle" to make dwindle the default.
    layout = "dwindle",
  },

  -- Built-in scrolling layout (a tape of columns, like niri/PaperWM).
  scrolling = {
    column_width = 0.5,
    -- Widths cycled by Super+[ and Super+] (colresize -conf / +conf).
    explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
    fullscreen_on_one_column = true,
  },

  -- Render the pointer in software. This avoids hardware-cursor flicker on
  -- GPUs/drivers that intermittently lose or blink the hardware cursor.
  cursor = {
    no_hardware_cursors = 1,
    sync_gsettings_theme = true,
  },

  decoration = {
    rounding = 12,
    rounding_power = 2,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },

    blur = {
      enabled = true,
      size = 8,
      passes = 3,
      new_optimizations = true,
      xray = false,

      vibrancy = 0.18,
      vibrancy_darkness = 0.8,

      special = true,
      popups = true,
      popups_ignorealpha = 0.2,
    },
  },
})
