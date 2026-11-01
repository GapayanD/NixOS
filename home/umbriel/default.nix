{ inputs, lib, ... }:
let
  workspaceBinds = lib.listToAttrs (lib.concatMap (n:
    let s = toString n; in [
      { name = "Mod+${s}"; value = "workspace-switch ${s}"; }
      { name = "Mod+Shift+${s}"; value = "window-move-to-workspace ${s}"; }
    ]) (lib.range 1 9));

  # Held volume/brightness/media keys keep stepping and still work on the lock screen.
  locked = action: { inherit action; allow_when_locked = true; };
  lockedOnce = action: { inherit action; allow_when_locked = true; repeat = false; };
in
{
  imports = [ inputs.umbriel.homeModules.default ];

  # Run `umbriel config validate` after a rebuild to check the generated TOML,
  # and `umbriel config schema` to list every key this build accepts.
  programs.umbriel = {
    enable = true;

    settings = {
      # Noctalia is started by its systemd user service (home/noctalia.nix).
      # If the shell does not appear, add: general.autostart = [ "noctalia" ];
      # and set programs.noctalia.systemd.enable = false.
      layout.gap = 5;
      input.keyboard.layout = "us";

      keybinds = workspaceBinds // {
        # --- apps ---
        "Mod+Return" = "spawn wezterm";
        "Mod+B" = "spawn zen";
        "Mod+E" = "spawn krusader";

        # --- session / window ---
        "Mod+Q" = "window-close";
        "Mod+Shift+Q" = { action = "window-kill"; repeat = false; };
        "Mod+Shift+E" = "session-quit";
        "Mod+F" = "window-toggle-fullscreen";
        "Mod+T" = "window-toggle-floating";
        "Mod+M" = "window-toggle-maximize";
        "Mod+P" = "window-toggle-pinned";
        "Mod+Shift+W" = "column-toggle-tabbed";
        "Mod+Tab" = "overview-toggle";
        "Mod+Slash" = "cheatsheet-toggle";
        # Escape hatch for games / VMs that grab the keyboard.
        "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle"; allow_when_inhibited = true; repeat = false; };

        # --- focus / move ---
        "Mod+Left" = "window-focus-left";
        "Mod+Right" = "window-focus-right";
        "Mod+Up" = "window-focus-up";
        "Mod+Down" = "window-focus-down";
        "Mod+J" = "window-focus-next";
        "Mod+K" = "window-focus-previous";
        "Mod+Shift+Left" = "column-move-left";
        "Mod+Shift+Right" = "column-move-right";
        "Mod+Shift+Up" = "window-move-up";
        "Mod+Shift+Down" = "window-move-down";
        "Mod+Comma" = "window-consume-left";
        "Mod+Period" = "window-consume-right";

        # --- layout ---
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Shift+R" = "window-cycle-primary-extent-back";
        "Ctrl+Alt+N" = "workspace-set-layout toggle scrolling dwindle master";
        "Mod+Alt+Left" = "output-focus-left";
        "Mod+Alt+Right" = "output-focus-right";
        "Mod+Alt+Shift+Left" = "window-move-to-output-left";
        "Mod+Alt+Shift+Right" = "window-move-to-output-right";

        # --- scratchpad ---
        "Mod+Shift+Space" = "window-move-to-scratchpad";
        "Mod+Ctrl+Space" = "scratchpad-toggle";

        # --- mouse ---
        "Mod+MouseMiddle" = "layout-scroll-drag";
        "Mod+WheelUp" = { action = "workspace-previous"; cooldown_ms = 150; };
        "Mod+WheelDown" = { action = "workspace-next"; cooldown_ms = 150; };

        # --- screenshots ---
        "Print" = "spawn noctalia msg screenshot-region";
        "Mod+Print" = "spawn noctalia msg screenshot-fullscreen";

        # --- Noctalia panels ---
        "Mod" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Space" = "spawn noctalia msg panel-toggle launcher";
        "Mod+Escape" = "spawn noctalia msg panel-toggle session";
        "Mod+I" = "spawn noctalia msg settings-toggle";
        "Mod+S" = "spawn noctalia msg panel-toggle control-center";
        "Mod+V" = "spawn noctalia msg panel-toggle clipboard";
        "Mod+W" = "spawn noctalia msg panel-toggle ashur-d/wallpaper-widget:hub";
        "Mod+N" = "spawn noctalia msg notification-dnd-toggle";
        "Mod+Shift+N" = "spawn noctalia msg nightlight-toggle";
        "Mod+L" = "spawn noctalia msg session lock";
        "Alt+Tab" = "spawn noctalia msg window-switcher";

        # --- media / brightness ---
        "XF86MonBrightnessUp" = locked "spawn noctalia msg brightness-up";
        "XF86MonBrightnessDown" = locked "spawn noctalia msg brightness-down";
        "XF86AudioRaiseVolume" = locked "spawn noctalia msg volume-up";
        "XF86AudioLowerVolume" = locked "spawn noctalia msg volume-down";
        "XF86AudioMute" = lockedOnce "spawn noctalia msg volume-mute";
        "XF86AudioPlay" = lockedOnce "spawn noctalia msg media toggle";
        "XF86AudioNext" = locked "spawn noctalia msg media next";
        "XF86AudioPrev" = locked "spawn noctalia msg media previous";
      };
    };
  };
}
