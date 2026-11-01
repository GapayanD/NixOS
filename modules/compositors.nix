{ inputs, pkgs, ... }:
{
  imports = [
    inputs.mangowm.nixosModules.mango
    inputs.umbriel.nixosModules.default
  ];

  # Each module installs its compositor, adds its SDDM session entry, enables
  # graphics support and sets up xdg-desktop-portal:
  #   mango   -> portals wlr + gtk, Secret via gnome-keyring, polkit, Xwayland
  #   umbriel -> xdg-desktop-portal-umbriel (screen capture/sharing)
  # Pick the session at the SDDM login screen.
  programs.mango.enable = true;
  programs.umbriel.enable = true;

  # Electron/Chromium apps (vesktop, vscode, obsidian, brave, ...) on native Wayland.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Needed for Helix/Neovim system clipboard and `wl-copy` / `wl-paste` in scripts.
  environment.systemPackages = [ pkgs.wl-clipboard ];
}
