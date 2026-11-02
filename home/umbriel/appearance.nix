{ ... }:
let
  # Same warm accent the Mango setup uses for its focus border (0xc9b890ff).
  accent = "#C9B890FF";
in
{
  # Colors are #RRGGBB or #RRGGBBAA. Umbriel draws only borders, tab bars, the
  # overview and the cheatsheet; Noctalia themes the shell on its own.
  programs.umbriel.settings = {
    appearance = {
      prefer_no_csd = true;
      border_width = 1;
      corner_radius = 6;

      # Blur only shows where a surface is transparent, and each surface opts
      # in through a window or layer rule (see rules.nix).
      blur = {
        enabled = true;
        optimized = true;
        passes = 2;
        radius = 5;
      };

      # Shadow geometry is global. rules.nix turns shadows off for tiled
      # windows so only floating ones cast one, as in the Mango setup.
      shadow = {
        enabled = true;
        softness = 15;
        offset_x = 0;
        offset_y = 0;
      };
    };

    colors = {
      accent_primary = accent;

      border = {
        focused = accent;
        unfocused = "#3A3A3AFF";
      };

      overview.badge = accent;

      tab_bar = {
        active = accent;
        active_text = "#141419FF";
      };
    };
  };
}
