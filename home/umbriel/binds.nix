{ lib, ... }:
let
  # Mod+1..9 switches workspace, Mod+Shift+1..9 moves the window and follows it.
  workspaceBinds = lib.listToAttrs (
    lib.concatMap (
      n:
      let
        s = toString n;
      in
      [
        {
          name = "Mod+${s}";
          value = "workspace-switch ${s}";
        }
        {
          name = "Mod+Shift+${s}";
          value = "window-move-to-workspace ${s}";
        }
      ]
    ) (lib.range 1 9)
  );

  # Run a noctalia IPC command.
  noctalia = cmd: "spawn noctalia msg ${cmd}";

  # Fire once per press instead of auto-repeating while the key is held.
  once = action: {
    inherit action;
    repeat = false;
  };

  # Held volume and brightness keys keep stepping, and all of these still work
  # on the lock screen.
  locked = action: {
    inherit action;
    allow_when_locked = true;
  };
  lockedOnce = action: {
    inherit action;
    allow_when_locked = true;
    repeat = false;
  };
in
{
  # Defining [keybinds] replaces Umbriel's built-in bind set entirely, so
  # everything wanted must be listed here. Mod is Super on a real session.
  programs.umbriel.settings.keybinds = workspaceBinds // {
    # --- apps ---
    "Mod+Return" = once "spawn wezterm";
    "Mod+B" = once "spawn zen";
    "Mod+E" = once "spawn krusader";

    # --- session / window ---
    "Mod+Q" = once "window-close";
    "Mod+Shift+Q" = once "window-kill";
    "Mod+Shift+E" = "session-quit";
    "Mod+Shift+C" = once "config-reload";
    "Mod+F" = once "window-toggle-fullscreen";
    "Mod+T" = once "window-toggle-floating";
    "Mod+M" = once "window-toggle-maximize";
    "Mod+Ctrl+M" = once "window-toggle-maximize-to-edges";
    "Mod+P" = once "window-toggle-pinned";
    "Mod+C" = once "window-center";
    "Mod+Shift+W" = once "column-toggle-tabbed";
    "Mod+Tab" = once "overview-toggle";
    "Mod+Slash" = once "cheatsheet-toggle";
    # Escape hatch for games and VMs that grab the keyboard.
    "Mod+Shift+Escape" = {
      action = "shortcuts-inhibit-toggle";
      allow_when_inhibited = true;
      repeat = false;
    };

    # --- focus / move ---
    "Mod+Left" = "window-focus-left";
    "Mod+Right" = "window-focus-right";
    "Mod+Up" = "window-focus-up";
    "Mod+Down" = "window-focus-down";
    "Mod+J" = "window-focus-next";
    "Mod+K" = "window-focus-previous";
    "Mod+Grave" = once "window-focus-last";
    "Mod+Shift+Left" = "column-move-left";
    "Mod+Shift+Right" = "column-move-right";
    "Mod+Shift+Up" = "window-move-up";
    "Mod+Shift+Down" = "window-move-down";

    # Pull a window into the neighbouring column, or push it back out into its
    # own column.
    "Mod+Comma" = "window-consume-left";
    "Mod+Period" = "window-consume-right";
    "Mod+BracketLeft" = "window-consume-or-expel-left";
    "Mod+BracketRight" = "window-consume-or-expel-right";

    # --- layout / sizing ---
    "Mod+R" = "window-cycle-primary-extent";
    "Mod+Shift+R" = "window-cycle-primary-extent-back";
    "Mod+Minus" = "window-modify-primary-extent -0.05";
    "Mod+Equal" = "window-modify-primary-extent 0.05";
    "Mod+Ctrl+Minus" = "window-modify-secondary-extent -0.05";
    "Mod+Ctrl+Equal" = "window-modify-secondary-extent 0.05";
    "Ctrl+Alt+N" = "workspace-set-layout toggle scrolling dwindle master";

    # --- workspaces ---
    "Mod+Page_Up" = "workspace-previous";
    "Mod+Page_Down" = "workspace-next";
    "Mod+Shift+Page_Up" = "window-move-to-workspace-previous";
    "Mod+Shift+Page_Down" = "window-move-to-workspace-next";

    # --- monitors (no-ops on a single display) ---
    "Mod+Alt+Left" = "output-focus-left";
    "Mod+Alt+Right" = "output-focus-right";
    "Mod+Alt+Shift+Left" = "window-move-to-output-left";
    "Mod+Alt+Shift+Right" = "window-move-to-output-right";

    # --- scratchpad (terminal drop-down, defined in general.nix) ---
    # Store the focused window in the pad, or send it back if it is already there.
    "Mod+Shift+Space" = once "window-toggle-scratchpad terminal";
    # Show or hide the pad. Opening it while empty launches the terminal.
    "Mod+Ctrl+Space" = once "scratchpad-toggle terminal";

    # --- mouse ---
    "Mod+MouseMiddle" = "layout-scroll-drag";
    "Mod+WheelUp" = {
      action = "workspace-previous";
      cooldown_ms = 150;
    };
    "Mod+WheelDown" = {
      action = "workspace-next";
      cooldown_ms = 150;
    };
    "Mod+Ctrl+WheelUp" = "window-focus-left";
    "Mod+Ctrl+WheelDown" = "window-focus-right";

    # --- screenshots ---
    "Print" = noctalia "screenshot-region";
    "Mod+Print" = noctalia "screenshot-fullscreen";

    # --- Noctalia panels ---
    # A bare Mod runs on release, and only if no other key or button was
    # pressed while it was held.
    "Mod" = noctalia "panel-toggle launcher";
    "Mod+Space" = noctalia "panel-toggle launcher";
    "Mod+Escape" = noctalia "panel-toggle session";
    "Mod+I" = noctalia "settings-toggle";
    "Mod+S" = noctalia "panel-toggle control-center";
    "Mod+V" = noctalia "panel-toggle clipboard";
    "Mod+W" = noctalia "panel-toggle ashur-d/wallpaper-widget:hub";
    "Mod+N" = noctalia "notification-dnd-toggle";
    "Mod+Shift+N" = noctalia "nightlight-toggle";
    "Mod+L" = noctalia "session lock";
    # Needs the Umbriel companion plugin; does nothing if it is not installed.
    "Mod+Alt+N" = noctalia "panel-toggle noctalia/umbriel-companion:panel";

    # Hold Alt and tap Tab to step through windows, release to pick. A quick
    # tap goes back to the previous window.
    "Alt+Tab" = noctalia "window-switcher hold";
    "Alt+Shift+Tab" = noctalia "window-switcher hold reverse";

    # --- media / brightness ---
    "XF86MonBrightnessUp" = locked (noctalia "brightness-up");
    "XF86MonBrightnessDown" = locked (noctalia "brightness-down");
    "XF86AudioRaiseVolume" = locked (noctalia "volume-up");
    "XF86AudioLowerVolume" = locked (noctalia "volume-down");
    "XF86AudioMute" = lockedOnce (noctalia "volume-mute");
    "XF86AudioPlay" = lockedOnce (noctalia "media toggle");
    "XF86AudioNext" = locked (noctalia "media next");
    "XF86AudioPrev" = locked (noctalia "media previous");
  };
}
