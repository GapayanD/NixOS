-- Persistent workspaces keep Noctalia's workspace indicator useful even when empty.
-- Hyprland supports workspace IDs beyond 10; this setup pre-creates 1-10.
local workspaceNames = {
  "web",
  "code",
  "chat",
  "media",
  "misc",
  "files",
  "terminal",
  "docs",
  "game",
  "extra",
}

for i = 1, 10 do
  hl.workspace_rule({
    workspace = tostring(i),
    persistent = true,
    default_name = workspaceNames[i],
  })
end
