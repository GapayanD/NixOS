{ ... }:
{
  programs.umbriel.settings.layout = {
    # "scrolling", "dwindle", "master" or "stacking". Ctrl+Alt+N cycles the
    # first three per workspace at runtime (binds.nix).
    mode = "scrolling";
    gap = 5;

    # Widths that Mod+R steps through.
    extent_presets = [
      0.333
      0.5
      0.667
    ];

    # New columns open at half the output width instead of each application
    # picking its own.
    scrolling.default_extent_fraction = 0.5;
  };

  # Outputs are machine-specific, so none are declared and Umbriel uses each
  # monitor's preferred mode. Run `umbriel outputs` for connector names, then
  # for example:
  #
  #   programs.umbriel.settings.output.DP-1 = {
  #     mode = "2560x1440@144";
  #     position = [ 0 0 ];
  #     scale = 1.0;
  #     vrr = "fullscreen";
  #   };
  #
  # Workspaces are dynamic (an empty one is always kept at the end), so
  # Mod+1..9 beyond the current count lands on the last workspace. For a fixed
  # set, add `workspaces = 9;` to the output above.
}
