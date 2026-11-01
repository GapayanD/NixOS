{ ... }:

{
  services.power-profiles-daemon.enable = true;
  services.accounts-daemon.enable = true;
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.blueman.enable = true;
  services.upower.enable = true;

  programs.dconf.enable = true;
}
