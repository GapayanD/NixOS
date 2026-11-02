{ ... }:
{
  programs.umbriel.settings = {
    general = {
      # Run once per session, not on config reload. Noctalia is started here
      # rather than by a systemd user service. If you later enable
      # programs.noctalia.systemd.enable, remove this entry or the shell
      # starts twice.
      autostart = [ "noctalia" ];

      # The cheatsheet is one keypress away (Mod+Slash), so skip it at login.
      show_cheatsheet = false;
    };

    # Drop-down terminal. Defining any named scratchpad removes the implicit
    # "default" one, so every scratchpad action in binds.nix names this pad.
    # Toggling it while empty launches the terminal straight into it.
    scratchpad = [
      {
        name = "terminal";
        spawn_when_empty = "wezterm start --class scratchpad-terminal";
        proportional_size = true;
      }
    ];
  };
}
