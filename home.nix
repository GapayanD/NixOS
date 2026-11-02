{ username, ... }:
{
  imports = [
    ./home/mango
    ./home/umbriel
    ./home/fastfetch.nix
    ./home/packages.nix
    ./home/theming.nix
    ./home/wezterm.nix
    ./home/fish.nix
    ./home/git.nix
    ./home/xdg.nix
    ./home/mpd.nix
    ./home/direnv.nix
    ./home/helix.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
