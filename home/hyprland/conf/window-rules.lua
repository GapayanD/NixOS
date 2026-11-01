-- Optional Noctalia settings-window behavior. Adjust or remove if desired.
-- size is a string of two numbers separated by a space (width height),
-- not a Lua table and not "1080x920".
hl.window_rule({
  name = "noctalia-settings",
  match = { class = "dev.noctalia.Noctalia" },
  float = true,
  size = "1080 920",
})

hl.window_rule({
  name = "obsidian-glass-konsole",
  match = { class = "^(org\\.kde\\.konsole)$" },
               opacity = "0.92 0.88",
})
