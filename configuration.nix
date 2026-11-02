{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/compositors.nix
    ./modules/nix.nix
    ./modules/hardware.nix
    ./modules/audio.nix
    ./modules/services.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/users.nix
    ./modules/fonts.nix
    ./modules/polkit.nix
    ./modules/sddm-theme.nix
    ./modules/zen-browser.nix
    ./modules/adb.nix
    ./modules/shell.nix
    ./modules/programs/java.nix
    ./modules/programs/dev.nix
  ];

  services.gvfs.enable = true;
  services.displayManager.sddm.enable = true;
  services.tumbler.enable = true;
  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # This is the polkit *daemon* (the thing that decides yes/no). It is NOT an
  # authentication agent; the agent is Noctalia's, enabled in home/noctalia.nix.
  security.polkit.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
