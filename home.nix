{ inputs, username, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
    ./home/fastfetch.nix
    ./home/packages.nix
    ./home/theming.nix
    ./home/wezterm.nix
    ./home/hyprland
    ./home/fish.nix
    ./home/git.nix
    ./home/xdg.nix
    ./home/mpd.nix
    ./home/direnv.nix
    ./home/helix.nix
    ./modules/programs/konsole.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };
}
