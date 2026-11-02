{ ... }:
{
  # Rules apply in order and a later rule overrides an earlier one for the same
  # field. Selectors are regular expressions that match any part of the value,
  # so anchor them with ^ and $. Find ids with `umbriel windows` and layer
  # namespaces with `umbriel layers`.
  programs.umbriel.settings = {
    window_rule = [
      # Blur every window (only visible where a window is transparent).
      { blur = true; }

      # Shadows only on floating windows, matching the Mango setup.
      {
        match.is_floating = false;
        shadow = false;
      }

      # Small utilities that should float instead of tiling.
      {
        match.app_id = [
          "^(org[.]pulseaudio[.])?pavucontrol$"
          "^blueman-manager$"
          "^qalculate-gtk$"
          "^(org[.]gnome[.]FileRoller|file-roller)$"
        ];
        default_floating = true;
      }

      # Noctalia's settings window and Umbriel's screen share picker.
      {
        match.app_id = "^dev[.]noctalia[.]Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1020;
          height = 900;
        };
      }
      {
        match.app_id = "^dev[.]noctalia[.]UmbrielSharePicker$";
        default_floating = true;
        default_floating_size_px = {
          width = 800;
          height = 600;
        };
      }

      # Browser picture-in-picture: small, floating, bottom right.
      {
        match.title = "^(Picture-in-Picture|Picture in picture)$";
        default_floating = true;
        default_maximize = false;
        default_position = {
          x = 20;
          y = 20;
          anchor = "bottom_right";
        };
      }

      # Toast popups from KDE apps such as Krusader: pinned, never steal focus.
      {
        match.title = "^notificationtoasts_.+_desktop";
        default_position = {
          x = 0;
          y = 0;
          anchor = "bottom_right";
        };
        default_focused = false;
        default_pinned = true;
      }

      # Drop-down terminal from general.nix. Opens in the pad at 70 percent of
      # the output and is shown straight away.
      {
        match.app_id = "^scratchpad-terminal$";
        default_scratchpad = "terminal";
        default_floating_size = {
          width = 0.7;
          height = 0.7;
        };
        default_focused = true;
      }
    ];

    # Noctalia surfaces. Panels, the dock, notifications and OSDs open over
    # windows, so they blur the live content behind them. The bar and desktop
    # widgets sit on the wallpaper and keep the cheaper cached blur.
    layer_rule = [
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_popups = true;
      }
      {
        match.namespace = "^noctalia-(notification|dock|panel|attached-panel|osd)$";
        blur_optimized = false;
      }
    ];
  };
}
