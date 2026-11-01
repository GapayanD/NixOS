{ ... }:

{
  programs.wezterm = {
    enable = true;
    # Keep the lua config as its own file (home/wezterm.lua) rather than
    # inlining it here, same as the rest of the terminal configs.
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
