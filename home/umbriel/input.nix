{ config, lib, ... }:
let
  # Reuse the cursor from home/theming.nix so the compositor and the apps
  # always agree. Skipped if home.pointerCursor is ever disabled.
  cursor = config.home.pointerCursor;
in
{
  programs.umbriel.settings.input = {
    keyboard = {
      layout = "us";
      repeat_rate = 25;
      repeat_delay = 600;
      numlock_toggle = true;
    };

    # Libinput keeps its own defaults for anything not listed here.
    touchpad = {
      tap = true;
      natural_scroll = false;
      disable_while_typing = true;
    };

    mouse.natural_scroll = false;

    # Focus follows the pointer is off by default. To enable it:
    #   focus = { follows_mouse = true; hover_raises = false; };
  }
  // lib.optionalAttrs (cursor != null) {
    cursor = {
      theme = cursor.name;
      inherit (cursor) size;
    };
  };
}
